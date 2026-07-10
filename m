Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B043B4BB
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699309; cv=none; b=KhGl/oMLVO135170TGD48mrRgOvELnFtraqr02oUIgollvaQnXF3ABX0yP4tnG99c1Oab9tByXIi/fNhHvDd4IfzHlwzb+Lj98IQwpLYzK/zDtlazw8HMZtNyFSGSHwnTtnOkg8e4nHfcHOK7ntOX+RUVUEeRVBXw7jdp4gPb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699309; c=relaxed/simple;
	bh=FpvBMFOBjGbtex0F2E85sDkJ0mHA1kFz8fwtEFKL9Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqa87Z1JnRBVT0QnvT0TPe/FEUhqis2hGtGpJDVRRAlb6Vzg+X3dJEihe9Re0G/Bd3Xh++yp12a3qPOWs829aAuhkwXlnu6ou7m/BO5zHPdEf+R8dSRjP0M7sWuQd6f/HCIDhZX/1pdWU3FX4F+owY0nfBoTuomusZh9ZNFgJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=YMqYFWBH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="YMqYFWBH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c21495722so5123281cf.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783699302; x=1784304102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xplki/WjnUaATCo6uGj8PBglmca7aRIHrcSArfmWE/8=;
        b=YMqYFWBHH3a37kqe/Jc/56EqUtfRQqBlg6YZmh6HajWWXHheWFEfPvkYeQoN6OABTH
         9K+nAf/FI7lNo+1rMbGACesyTcZnBJ3iaa9bVTWWiXI9aqhprCw66xzOEiHH0t4pHUDm
         9F0TiiPv/Sh0RjbyctyPl5i4uwkWWTIhAfXLdgQ8XzS1ZR5u7jre2hlq604XreguIz7B
         Hs35lVokfrCXvgZNSHXfLfFHYB6BMAAuAhQO3NmXzeagV+lUwqPOLs/a1YeUMjuxuetD
         bgILXOUIFUv6/mTcwZ3caimiuO06QnaeAR0CQDPTdlZtwXkyuejmBUMKp/PgC+uw5sYH
         pGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699302; x=1784304102;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xplki/WjnUaATCo6uGj8PBglmca7aRIHrcSArfmWE/8=;
        b=VBcIzg6LfrV/2EezCpTqbfERzO0tl2rkoaRrL429sfg3Ih9MTpzyaotazkJdkoX0Df
         Z0/63pbUW9Se4QFZH+y9jzgeUSa/x5ifGE8KrjmitsUzVfMk2EGnXH06Tj95Fp7hntpM
         +YW3AoEbxMQhdYlClwuMItutP67E6DkOSl1C8PJjVp2ys3YN4o00sI6B0daoGF3k2d6M
         q7Qomqfphr2cNHS6kl3Y77e7EwDyAk8LeEiYA6euovqN5kmsMfgFHpCzuYF3tby0vRT0
         wE1gB4zANGoXfmKs8OyrEvt92ZiFSNrbtdGd+nwyloax44ZA1NyfjT90pug8mMoF0SZs
         JrsQ==
X-Gm-Message-State: AOJu0YwAFvIJ/1JP5oQO7uDWhcTtEkC9mq4DqzUKzVAuu72xAwJTi6ot
	+Ni3bEvQSnpBSpaHB/TKjICyfv33EvFU52jFqG/ZDYnbPxhm5h1NDAbgeK8jbG7reb0=
X-Gm-Gg: AfdE7cnPs6vM8Dp2XJTRIxm8lSLd3ZDfXHkt4rkG0t8WrQCCHr1mfxKa/ZQmyL3m2Xl
	SUfxlVQp/8i17t5xLWhENU8P1053iseTc2mUD+kaC0X5g8Xrsulu2UrZ/t9tenBC6bsgMHx3Uvp
	HMt8ClwlgLzDvvPHFdDqmtjqxfxQr/Xf2OfavFQ9LcwcWAazmdrbNIv2hn4xeOSrPDZ4l3uz4s+
	/eYJymhKLYGJlcb4BsJ4rVWdkiwZPaO+/H5tXKmjhSAnS5QCAuQ1jMyA4NQNi/5+4Bil5jlrpSj
	IJkeqwVAF7uLUZh+Cd9KM0mP/n7IvYCqxAFcTV67KyxQkgKjWt5KWl86rP3xubiJhgucxPWzcru
	GR0peWKBZRtYrp5tE1P1Fh0p6RrWfwZluoOZszEXOzfxJpvyQiXH27pMY6rARkXuPHr5mVvHw3f
	z9WhynT4d1FKn9
X-Received: by 2002:a05:622a:2c6:b0:516:df62:bdd2 with SMTP id d75a77b69052e-51c8b3c65f5mr122904381cf.55.1783699301497;
        Fri, 10 Jul 2026 09:01:41 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf5f61csm18644921cf.22.2026.07.10.09.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 09:01:40 -0700 (PDT)
Message-ID: <58948c74-0990-449e-8eee-88cbb38db7e7@riscstar.com>
Date: Fri, 10 Jul 2026 11:01:38 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
To: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Christian Bruel <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>,
 Nam Cao <namcao@linutronix.de>, Qiang Yu <qiang.yu@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-6-inochiama@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260709040027.958400-6-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 11:00 PM, Inochi Amaoto wrote:
> Add binding support for the PCIe controller on the SpacemiT K3 SoC.
> This controller is almost a standard Synopsys DesignWare PCIe IP,
> with some extra link and reset state control.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

This looks OK to me.  What I see is that K3 does not require
the interrupts and interrupt-names properties, allows up to
six PHYs (not just one), and adds a dbi2 register that is not
used by K1.

I might have missed it, but I don't see where the dbi2 register
is used by the K3 code you have added.  In pcie-designware.c,
I see that if no "dbi2" resource is found, memory at offset
4096 from the "dbi" base is used.  Does that apply for K3?
If so, maybe there's no need to define dbi2.

					-Alex

> ---
>   .../bindings/pci/spacemit,k1-pcie-host.yaml   | 50 ++++++++++++++++---
>   1 file changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> index c4c00b5fcdc0..54817d6fd9af 100644
> --- a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> @@ -14,26 +14,29 @@ description: >
>     PCIe IP.  The controller uses the DesignWare built-in MSI interrupt
>     controller, and supports 256 MSIs.
>   
> -allOf:
> -  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> -
>   properties:
>     compatible:
> -    const: spacemit,k1-pcie
> +    enum:
> +      - spacemit,k1-pcie
> +      - spacemit,k3-pcie
>   
>     reg:
> +    minItems: 4
>       items:
>         - description: DesignWare PCIe registers
>         - description: ATU address space
>         - description: PCIe configuration space
>         - description: Link control registers
> +      - description: Data Bus Interface (DBI) shadow registers.
>   
>     reg-names:
> +    minItems: 4
>       items:
>         - const: dbi
>         - const: atu
>         - const: config
>         - const: link
> +      - const: dbi2
>   
>     clocks:
>       items:
> @@ -66,6 +69,8 @@ properties:
>     interrupt-names:
>       const: msi
>   
> +  msi-parent: true
> +
>     spacemit,apmu:
>       $ref: /schemas/types.yaml#/definitions/phandle-array
>       description:
> @@ -84,7 +89,8 @@ patternProperties:
>   
>       properties:
>         phys:
> -        maxItems: 1
> +        minItems: 1
> +        maxItems: 6
>   
>         vpcie3v3-supply:
>           description:
> @@ -96,13 +102,43 @@ patternProperties:
>   
>       unevaluatedProperties: false
>   
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k1-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 4
> +
> +        reg-names:
> +          maxItems: 4
> +
> +      patternProperties:
> +        '^pcie@':
> +          properties:
> +            phys:
> +              maxItems: 1
> +
> +      required:
> +        - interrupts
> +        - interrupt-names
> +    else:
> +      properties:
> +        reg:
> +          minItems: 5
> +
> +        reg-names:
> +          minItems: 5
> +
>   required:
>     - clocks
>     - clock-names
>     - resets
>     - reset-names
> -  - interrupts
> -  - interrupt-names
>     - spacemit,apmu
>   
>   unevaluatedProperties: false

