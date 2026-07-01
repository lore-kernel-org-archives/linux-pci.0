Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0F3C81B5
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899444; cv=none; b=Ol9qd3aE0bkpADMp+d4HjVrZ6FJOKHa0H/hzZDso8+ckYoA/rzvPxMBHkYbv7dqdWtqbDGDSRjyqimH2uH4jz7Ru5zd+iAdZdk7IFbNUGjs7iftk9ioD1VdOQj5mshT+sfACeIkW5KKHw22xMGW0l+3Nudn5OtBeWflqVMplC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899444; c=relaxed/simple;
	bh=dYYh9cE3305jsTNSwHjTFgDi5DODHJI+GKtgWf9EeY0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvwb457o5YKNeELJskBx//ixKZyvrWfXOOMXGHt1NlC7nZYZY+Uqbd83/z3hVhppIe18CzfiERsFZ3EVSwNY02i/n6yeSJph0z1m4nKQdreGCthMSh7oBn7ecIvMx+oR6O2ypYmxTaBROa5tFQPIo7FMCTjMADyZ0yttjzWVLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovsz+Yel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovsz+Yel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9941F01558
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 09:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899443;
	bh=CYGZFzyPZ+A2YYB3ropIX8iebOcV3V3VZwIWp6S8JQM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ovsz+YelOrq+1skD75xSG5EORRjD0cTTOcWfjmNL1AE9OSsCsfZjJp8XxxnkiUAcg
	 P+abid/4QGDt7gX6rEmPOu/VcNzmUDeaCsph0bEI5G2ZBM756c+SPKBHfxhAfNqZVw
	 mElrkhKwEzEm8A6sScqGt9rfi2+uIc2CPoQ5vo4bi69uMhjvNM7S+laUTGgzHzhx+h
	 R38HmKICmEJs1YdCuGnRmbrznzgZczz/T7WE4l0mpNrxhJred0aed7bjS24lYbyHiI
	 1PmPdRZXOUVe38kyHbGRHLtz9q+GicbDgaldjuYPzchLjKtzQM/Em7bqSFFTRjfkQW
	 5xc/tFJrhG/sg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b1eb7bde5so3781051fa.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 02:50:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpXYIbou6zYwyywETs70IHx5C5hH3lUvXNqEYVuRblYyMefebSnkp33N23QP2DlkAbK7ZwLfh6WjaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClAUq1Bu6z/oZZWgFmokAd5m4oKAKwZJcNOG8pOvZLV99LS4q
	BgYsf3j6GLEe8gfG0aUIXxc8fdpm4kUzXcccHyrarf3ChLH15B1MWrLrDQx3KVk/0FizYBYNqKp
	eLabskMEABQ0UqwByDKTAxTuKDLVGJ6LyCvveHafcyA==
X-Received: by 2002:a2e:9a0e:0:b0:396:9966:50e4 with SMTP id
 38308e7fff4ca-39b33fcfac5mr2066541fa.14.1782899442056; Wed, 01 Jul 2026
 02:50:42 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:50:40 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:50:40 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260701-shikra-upstream-v1-1-e1a721eb8943@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com> <20260701-shikra-upstream-v1-1-e1a721eb8943@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 04:50:40 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mey1em0BBUUuyLTpVfq8u4Xn8jZMhE4g+HpdrojZ8MXEQ@mail.gmail.com>
X-Gm-Features: AVVi8CflDzWyc0cIuHDaH0TTpmlFBQDWQvxDBA8MQsFXpL6lUrYdBoN6qFDa_4c
Message-ID: <CAMRc=Mey1em0BBUUuyLTpVfq8u4Xn8jZMhE4g+HpdrojZ8MXEQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: phy: sc8280xp-qmp-pcie: Document Shikra
 PCIe phy
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

On Tue, 30 Jun 2026 21:02:43 +0200, Sushrut Shree Trivedi
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
