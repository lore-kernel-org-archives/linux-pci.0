Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D03F0AAD
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113148; cv=none; b=GA3DIz7XK5TQTmt4b+n62ToRuG5r0vb7MZhFXVJ4gl/iG7LqKPLrT5gz00cASEJYyV0d3P9M1nRfeey0okM/IFw7EFlLYV9Aa8h72YjhqDj/ZB9TDY7J57nPKpj7iaUFx0HF2iDa+n/nDtn2u69Z17nhUKKd5OgXuuEWDWP/F9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113148; c=relaxed/simple;
	bh=kGBHg/x91YrlUYZ8NvNHjnI+0TJkHMTVSD3QBTYn0L4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDfkq0vq2YJAM8nPrWj2n/1ZWEjR/ahEGy+//WKwQle3lE9XjYIM4bOUprXxaLURSnphUDjvpSvMdPTTNzWFXgSrDoAqb2pZ5ZGlj2lrEj8oqADkPnSVtfyAeux1SigVHVggP3xGfBNe3tAZvbSwr4OkYnvWuWFmjvq8j5q1mn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdWbZKo5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdWbZKo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92351F008A2
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113146;
	bh=4OecTWo/Y8Np5+0axosfwjg63A8XkkZPfbCZcvmBsZs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=RdWbZKo5vzMG2G8ITBAMmjuSAOEtRGQ+Oe7Cz8j9SuE2hj0mV5WcJXbnJQb0t7CwM
	 Xa/+/ZmsCgIrxT9VhtNXlOkJ14XMVBPNiAUDSfV1QTjC+a97SBov+l800uXzIFbaz7
	 NgrVAgFEJuq41awaugDPFsNDgLI7JH6EWdsmLlkLzSv9Xq6e0kvG5/pwtZjb3wv+62
	 BWa43n4HM4+iZmdquC9zHlxGUz7L1MbnWYh7oqrEgSEIvXzcuoAwFTUBuPATIUMhVF
	 sM+cobtTGPtxSLias/stMmGQL2UWE6e3LNNJ/0o/hRCNlVJwa6jUG6snfd1fD1Sz8Z
	 fO7tAbcc3DlKw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b5607bd3b5so682570e87.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 00:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByI5CAKAagqCVrDz5P4HUA2FsgfpiZtdHiD4qar9sY9Zkmzw5t5A0TrSfkBVkUC0KpOvcgv6GBrsoA=@vger.kernel.org
X-Gm-Message-State: AFuF++maoQC+e+wtVtq7MmqRih6Ttz7qTTjMjS1NjJkEHQXwVR961/yw
	z8y9mQo+kuijdkPolsnPGxEe9Ui0SREIycRAcqiFTgHBjaMBQ29gbfVFqfEGmxN3sr5O/fHK3Xl
	lzBRcL89ce/phwgrFusq/HbeednW2Ie4FNR1nU9qOLA==
X-Received: by 2002:a05:6512:3985:b0:5b6:184c:7da8 with SMTP id
 2adb3069b0e04-5b8a0319cbemr545468e87.49.1789113145366; Fri, 11 Sep 2026
 00:52:25 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:52:24 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:52:24 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com> <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 00:52:24 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mcn-N57xLjvSMDpCvMi2j0XfwWYnxS9F5n+_byhU2-GDQ@mail.gmail.com>
X-Gm-Features: AcwNN1XSGbuzsnev8U3uj75mzaFR2wp_Z_cABLAQ8sbelqvtbOt3aXcPWZLiJTw
Message-ID: <CAMRc=Mcn-N57xLjvSMDpCvMi2j0XfwWYnxS9F5n+_byhU2-GDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: sc8280xp-qmp-pcie: Document
 Shikra PCIe phy
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 09:26:01 +0200, Sushrut Shree Trivedi
<sushrut.trivedi@oss.qualcomm.com> said:
> Document the compatible of the Shikra PCIe phy which supports
> Gen2x1.
>
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 108cf9dc86ea..b9b0fa26347b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -34,6 +34,7 @@ properties:
>        - qcom,sdm845-qmp-pcie-phy
>        - qcom,sdx55-qmp-pcie-phy
>        - qcom,sdx65-qmp-gen4x2-pcie-phy
> +      - qcom,shikra-qmp-gen2x1-pcie-phy
>        - qcom,sm8150-qmp-gen3x1-pcie-phy
>        - qcom,sm8150-qmp-gen3x2-pcie-phy
>        - qcom,sm8250-qmp-gen3x1-pcie-phy
> @@ -166,6 +167,7 @@ allOf:
>                - qcom,sdm845-qhp-pcie-phy
>                - qcom,sdm845-qmp-pcie-phy
>                - qcom,sdx55-qmp-pcie-phy
> +              - qcom,shikra-qmp-gen2x1-pcie-phy
>                - qcom,sm8150-qmp-gen3x1-pcie-phy
>                - qcom,sm8150-qmp-gen3x2-pcie-phy
>                - qcom,sm8250-qmp-gen3x1-pcie-phy
>
> --
> 2.43.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
