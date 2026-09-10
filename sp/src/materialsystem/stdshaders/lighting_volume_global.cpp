#include "deferred_includes.h"

#include "defconstruct_vs30.inc"
#include "volumglobal_ps30.inc"

BEGIN_VS_SHADER( LIGHTING_VOLUME_GLOBAL, "" )
	BEGIN_SHADER_PARAMS

	END_SHADER_PARAMS

	SHADER_INIT_PARAMS()
	{
	}

	SHADER_INIT
	{
	}

	SHADER_FALLBACK
	{
		return 0;
	}

	SHADER_DRAW
	{
		SHADOW_STATE
		{
			pShaderShadow->SetDefaultState();
			pShaderShadow->EnableDepthTest( false );
			pShaderShadow->EnableDepthWrites( false );
			pShaderShadow->EnableAlphaWrites( false );

			EnableAlphaBlending( SHADER_BLEND_ONE, SHADER_BLEND_ONE );

			pShaderShadow->EnableTexture( SHADER_SAMPLER1, true );
			pShaderShadow->EnableTexture( SHADER_SAMPLER2, true );

			pShaderShadow->VertexShaderVertexFormat( VERTEX_POSITION, 1, NULL, 0 );

			DECLARE_STATIC_VERTEX_SHADER( defconstruct_vs30 );
			SET_STATIC_VERTEX_SHADER_COMBO( USEWORLDTRANSFORM, 0 );
			SET_STATIC_VERTEX_SHADER_COMBO( SENDWORLDPOS, 0 );
			SET_STATIC_VERTEX_SHADER( defconstruct_vs30 );

			DECLARE_STATIC_PIXEL_SHADER( volumglobal_ps30 );
			SET_STATIC_PIXEL_SHADER( volumglobal_ps30 );
		}
		DYNAMIC_STATE
		{
			pShaderAPI->SetDefaultState();

			const lightData_Global_t& data = GetDeferredExt()->GetLightData_Global();

			AssertMsg( data.bEnabled, "I shouldn't be drawn at all." );

			DECLARE_DYNAMIC_VERTEX_SHADER( defconstruct_vs30 );
			SET_DYNAMIC_VERTEX_SHADER( defconstruct_vs30 );

			DECLARE_DYNAMIC_PIXEL_SHADER( volumglobal_ps30 );
			SET_DYNAMIC_PIXEL_SHADER_COMBO( HAS_SHADOW, data.bShadow );
			SET_DYNAMIC_PIXEL_SHADER( volumglobal_ps30 );

			BindTexture( SHADER_SAMPLER1, GetDeferredExt()->GetTexture_Depth() );

			if ( data.bShadow )
			{
				BindTexture( SHADER_SAMPLER2, GetDeferredExt()->GetTexture_ShadowDepth_Ortho( 0 ) );

				COMPILE_TIME_ASSERT( CSM_USE_COMPOSITED_TARGET == 1 );
				COMPILE_TIME_ASSERT( SHADOW_NUM_CASCADES == 2 );

				CommitShadowProjectionConstants_Ortho_Composite( pShaderAPI, 2, 2 );
			}

			CommitGlobalLightForward( pShaderAPI, 1 );

			CommitBaseDeferredConstants_Frustum( pShaderAPI, VERTEX_SHADER_SHADER_SPECIFIC_CONST_0 );
			CommitBaseDeferredConstants_Origin( pShaderAPI, 0 );

			pShaderAPI->SetPixelShaderConstant( 16, data.diff.Base() );

			float flVolumParams[4] = { data.flVolumetrics, 1.0f, 0, 0 };
			pShaderAPI->SetPixelShaderConstant( 19, flVolumParams );
		}

		Draw();
	}

END_SHADER
