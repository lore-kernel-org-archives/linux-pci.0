Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8ED3537F7;
	Sat, 17 Oct 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248418; cv=none; b=tWDccKVeAB3FcM55feqe5unypSLboRTvmNaiMlBjgtqeE4Evhz5kbU2nCWgq36Y48AKCQGzOrMtZW8n5E31VakAzLPAKmUNscSYTM4lzhVODCClPvM3j+ZX1hzGDXEOmNHlUMiKwrVVkFplHnREjZnTnNXqGby8RRZFzCqfEPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248418; c=relaxed/simple;
	bh=HwsrOXMhbox2Mt7rrPvhtHc3LdN1Y2OwIiaYBnI2izo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtPn7da21dXTd/Pc4eHLGoUWMOAITwnG0JzSLcE2SoRij6Zr/RjMqeQygTsMjLou2WLFgQHgZQqwTzeTD4/IrGYP40UdPmfciMMqb7Ekt6C2293h8OyGEkIxOjiHBc060HMCQbJUXP16HLyRy3kN65yqsiNMbGrFumPj9nXCsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=L2lW7FNN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L2lW7FNN"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6PlT6pVczMlQf;
	Sat, 17 Oct 2026 16:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792248406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyIpv1DH78bERhuonFyBzHAzXGjwnH87oDm0djKYOjQ=;
	b=L2lW7FNNKcA0nxzjhLgLyi0yJe4Ip5D0OTMZh5Q3zdB4hTALCv+mT+jBZWeJMQx6btp9+z
	Gm0LkGPztXJb1+qRqojom7Vzx/CGcG9rtlIGKXateITIKq55k/phZGyjEY+wn5h6HzWpPS
	/W2D77qxP24KEreFhdw59OZF/k2Syng5E0PiRheHLrPM1EdGdiENe67V/t2dns57B2gmpB
	AtxCBzbkRfesWZLuqf8bP88ef0z+LD23es8SuFZ4Zhso+RbTk3g/eia9szSfgploUnUxav
	DDhp77KjFRmRDQ3QIEf5fesIz2jmTAHiEnWmthTaFnDxA4sQz75VsSZnk0gXtQ==
Message-ID: <f5697305-2f25-4a56-85e6-ebc3c8745fe7@mailbox.org>
Date: Sat, 17 Oct 2026 16:46:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ
 with AER IRQ on R-Car Gen5
To: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uzxigruue3873izzkzceeuc6ubig8rkt
X-MBO-RS-ID: d83845d60e5241af131

On 10/3/26 11:57 PM, Marek Vasut wrote:
> The R-Car Gen5 SoC PCIe4 controller does not have dedicated sft_ce IRQ.
> Make that interrupt conditionally available only on R-Car Gen4 SoC PCIe
> controller.
> 
> The R-Car Gen5 SoC PCIe4 controller does have dedicated AER interrupt,
> include it from the beginning. R-Car Gen4 SoC PCIe controller also has
> an AER interrupt, but to retain binding backward compatibility, this
> interrupt is kept optional and added in a separate patchset.
> 
> Fixes: 5b555a496160 ("dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> NOTE: Gen4 AER is added in https://lore.kernel.org/all/20260928165230.3397664-1-den@valinux.co.jp/

This would be good to apply since it is a fix, however, I think this 
needs review from DT maintainers first.

Thank you for your help!

> ---
>   .../bindings/pci/rcar-gen4-pci-host.yaml      | 21 ++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index 362c43a1a15d0..083b77d4de8f7 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -28,13 +28,6 @@ properties:
>     interrupts:
>       maxItems: 4
>   
> -  interrupt-names:
> -    items:
> -      - const: msi
> -      - const: dma
> -      - const: sft_ce
> -      - const: app
> -
>     clocks:
>       maxItems: 2
>   
> @@ -98,6 +91,13 @@ allOf:
>               - const: app
>               - const: phy
>               - const: config
> +
> +        interrupt-names:
> +          items:
> +            - const: msi
> +            - const: dma
> +            - const: sft_ce
> +            - const: app
>     - if:
>         properties:
>           compatible:
> @@ -117,6 +117,13 @@ allOf:
>               - const: app
>               - const: config
>   
> +        interrupt-names:
> +          items:
> +            - const: msi
> +            - const: dma
> +            - const: app
> +            - const: aer
> +
>   unevaluatedProperties: false
>   
>   examples:


-- 
Best regards,
Marek Vasut
