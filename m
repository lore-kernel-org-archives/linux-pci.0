Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA148246788
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455203; cv=none; b=Vwe/9d/fg4edhuPcUCEIkhOpDaKjZ6cYGvTJqJXip1jsHZKwFoPqhm9TqTnIk5MgvRN7iD0EEELdWEKxu7RhAoLy4gDMc8cNzqI1TSiw9T5s5IlLC2+kAUqQDDWP3yRchSYCW8tci1pPLwCQ7VNPFCGzDnZrMzrDcg6e6LR43aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455203; c=relaxed/simple;
	bh=rJcfznlwUl0dvda3bi94q6+F4JYjZny7SKPX+GghNnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecrvTp9HVdclY2L1AfaN2EpiK/4qPs+4xmekrXV3f1Z3oF3rJO2H0HQjXG1rH756hN/zIFFAiwgy3633o9S7y8H84WkLITx/Fzw992JQwB4OnD5Kt2X6BJ2mWEn9HEjKEQkIz8B8K1xqv/iLRFyZgYZGqzVEXfOyNerqLU9btkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNFJkX8G; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNFJkX8G"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-894703956b8so75678666d6.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 11:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769455200; x=1770060000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OLbmqCfusVEOdH7Z7byMAhR5EgQmc/WQb/FESRAfspo=;
        b=iNFJkX8GNECMdZ1alkTWzMuXLekBNiznWsdmfoOcgLH6ePIRPIAIFJrLBQmk3QkFgP
         4iOyKuYoNICYkPLdumUJUpu7i+MSvqyKlRjtlGNBFAsEV60mj++ry67H/JB6I8a4I8a9
         9T0gSHz35m0GBw/FUHCeIHmGxdwIjGCKr+p1qV/G8T5Y6x2R0GNnuJvot/t43RvD0yF8
         +BOrmq4ai7of6SZC35GdGBKzstlcQ5EGaA9uSAwwOJxtI+K3rb5WFy2huT1AkQEp+VeH
         fgg7VT1PI8UYJbfFIJpAUj6J7YPB67X24UPcbRfCXWIiycdOk0b+1W+QjR/cZgfY8BWg
         uWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769455200; x=1770060000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLbmqCfusVEOdH7Z7byMAhR5EgQmc/WQb/FESRAfspo=;
        b=JNX9XBBmqozU/P+6vcIrnOauVTfPiygXc5ayCNjLqjuARac5m5DItR4UnNzyz+7IlG
         MTJRxjhvP+aWlggEIT3nm1o4tE4h1KG7FP8VSsZu9yhJrFhtDul7q84ZYHo0npZPxf0S
         Ifki1reUH4wptm0/Qf/ZC9nAdTikxVcedDH8AvX24olgW+Tu83vklIyTcUYa5txjzEFY
         UPSqPQ6SHeM/tlK19E/yo8/1YQzo27KczUjzH9F2ZwIXvsWEgpkdVFgu7u/J6vUcr8+l
         x3KFOKmGlvMuq6HhsFANsGID/kN7z2ttChPcUarxdaGcepzWgQ/6SMYUf27vOlYb+x2v
         dcRg==
X-Forwarded-Encrypted: i=1; AJvYcCWbg6eQBqNRJSRgFLTjuL2eppN1ZzxDwRM6RwEvs2YOROR20wRetHke5+IU6pNUlDTFgA2mnr+TbPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99RWb8yYH0i4QsHMQ7XDY1j9ix1Ds/uR5o8rwgUfp3ELouP3b
	EpA4fu4D9wx1elGEHKX35Zjs7NLzfFFC7KhpF7Rm6d/4w/kIiVYBjSqc/OLT1X21
X-Gm-Gg: AZuq6aLMcOIUAOxqVK4STiC5TKb3oaNeGNL2Ki/rUdeeVHIuhGudOzUsGZDOMpU/pPd
	PTBQb98MZWg6DomulqgAFlFpk/yb9m4AbiP02Uf3WnPp+WmPgsQrjr1JxXKSWpbU0Zu0nMAY8Up
	NLb9R15264sri0OsgQCXfMyBz8zMUez4/FpEyr+QHu0wpAQWxqgUxQ3L0XQ70W6vXZxjXr3/gDl
	nEDoFY1PmlI0mt4cig/GI55Cd5+SlaTH7fMfgWY44wdPqNYO1o2cJg6UtSvFlJ0+nCznQgyuA6A
	Xdjza3oz/xb1vxPUSIwnI32M8io2Y3vlwd7ED3Zsk2+hfFmBdXiDoL3lgVuqGns8ju2sa14kN5S
	iS6Jm0of/GWECoO8cd/tdW1ALloI642MFnu2S1oFv0b/oNR8JZRrb4ngAVFbfgux0VaTGFjS3Hz
	WXz/WrbeaglIHk4JDbyCnvwZqY4RDu+9KJDNRtoCdaw5Yzo0FRcizD63SVPlHV
X-Received: by 2002:a17:902:e84f:b0:2a2:f0cb:df9e with SMTP id d9443c01a7336-2a84523fb39mr48636325ad.1.1769448078463;
        Mon, 26 Jan 2026 09:21:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fd929asm94552325ad.90.2026.01.26.09.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 09:21:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9a3d4ae8-b57e-450e-971b-d09fc923eee1@roeck-us.net>
Date: Mon, 26 Jan 2026 09:21:15 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Fix emails with spaces or missing brackets
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christopher Ruehl <chris.ruehl@gtsys.com.hk>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Vincent Huang <vincent.huang@tw.synaptics.com>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260126164724.2832009-1-robh@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260126164724.2832009-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/26 08:47, Rob Herring (Arm) wrote:
> Fix email addresses with spaces or missing brackets. A pending
> dtschema meta-schema change will check for these.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml    | 2 +-
>   Documentation/devicetree/bindings/input/syna,rmi4.yaml          | 2 +-
>   .../devicetree/bindings/media/samsung,exynos5250-gsc.yaml       | 2 +-
>   Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> index 3d14d5fc96c5..7b38f2182ffa 100644
> --- a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Sensirion SHTC1 Humidity and Temperature Sensor IC
>   
>   maintainers:
> -  - Christopher Ruehl chris.ruehl@gtsys.com.hk
> +  - Christopher Ruehl <chris.ruehl@gtsys.com.hk>
>   
>   description: |
>     The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensors
> diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> index f369385ffaf0..8685ef4481f4 100644
> --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> @@ -8,7 +8,7 @@ title: Synaptics RMI4 compliant devices
>   
>   maintainers:
>     - Jason A. Donenfeld <Jason@zx2c4.com>
> -  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> +  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>     - Vincent Huang <vincent.huang@tw.synaptics.com>
>   
>   description: |
> diff --git a/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> index 878397830a4d..9196cf5dac0f 100644
> --- a/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> +++ b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> @@ -9,7 +9,7 @@ title: Samsung Exynos SoC G-Scaler
>   maintainers:
>     - Inki Dae <inki.dae@samsung.com>
>     - Krzysztof Kozlowski <krzk@kernel.org>
> -  - Seung-Woo Kim <sw0312.kim@samsung.com
> +  - Seung-Woo Kim <sw0312.kim@samsung.com>
>   
>   description:
>     G-Scaler is used for scaling and color space conversion on Samsung Exynos
> diff --git a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> index d286b77921e0..8f5d33050348 100644
> --- a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Mobiveil AXI PCIe Host Bridge
>   
>   maintainers:
> -  - Frank Li <Frank Li@nxp.com>
> +  - Frank Li <Frank.Li@nxp.com>
>   
>   description:
>     Mobiveil's GPEX 4.0 is a PCIe Gen4 host bridge IP. This configurable IP

