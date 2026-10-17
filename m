Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7854CF47C;
	Sat, 17 Oct 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239475; cv=none; b=Zs/qPy15QO4mh9TBa6Ngh4neQTVeoODtuanIeT+yEFTQ3/VD+Va/hWL6EyiCVrOzIK3bGbzGmOIVnzq4n9IsWq7M8y9aYxqMQZfw4EiJUn6Ui68BAaNHiFc5baZqukaSO3fgsDpKtEt2egbbLHmLvR8MrQZh85voBLV9c9uBdXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239475; c=relaxed/simple;
	bh=ltUFJHuUt8xxihxeGW7JXWQvpY6Far+jwebWB6Wgo6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALFoDTf7Vo+1F5aVou9pk9G6keGV0C4ta4dAAKitWidLpMMupHfBzI4mA/0dKEqKhizpWtQTLxCjmiH+XwYmlXWerLHEAU23ePGaDv2WtkZkPoIvptOO8H/Xw58+VQGHEhIKefPXdEW1kfkogn3jqR0CWGqSd6my0RmjAna6VUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hQwPcZf3; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hQwPcZf3"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j6LRW5n7zz8sYP;
	Sat, 17 Oct 2026 14:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792239463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rk5Lh21RnQJCZHlWuL13QYUUtzk8xkysSYr1XB0Phdo=;
	b=hQwPcZf3n1ch7VoaUcFqBl1U/UWXmfSsF5DxVsYNWkHSqiyaA9KKGNdZlDoki89vAjudm2
	nODfBX5+iiYpNVancfgD2JBBzGf1uFLFYZC6WSRcN2r/f7oYZygNlZLQSx270IbEwpjbqk
	8abqVq9b4HiwXW0aio5fZWhMJgFptMBD0lj05SPiq691WfbXpcpSKnlojIkz/J96iOr7ga
	mwDshAEfcj+BoA1daHuQjrAUuP/39l77af0iGUVRI31dvOqRsWiiz/0uds4u4hFwP38X2P
	HEgX1jfpfE6ctv9veQweQOq8OY88kslrO0O+hyWuHmxJuVVseximiy/NkaM7KA==
Message-ID: <814043dc-d194-4afd-8317-03b55cc9e913@mailbox.org>
Date: Sat, 17 Oct 2026 14:17:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt for R-Car Gen4 SoCs
To: Koichiro Den <den@valinux.co.jp>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-5-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rjej7x87b81ytdg5xf5xxb7s3wh5rtxc
X-MBO-RS-ID: 3315d6597cf075cc723

On 10/15/26 5:30 AM, Koichiro Den wrote:
> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
> 
> Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
> trees remain valid. Extend the example accordingly.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v3:
>    - Rebase on Marek's Gen5 AER binding fix:
>      https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/
>      This requires "aer" for the Gen5 SoC PCIe4 controller from the
>      beginning. Update the subject to clarify that it is optional only
>      on Gen4 SoCs, for compatibility with existing DTs.
>    - Drop R-b tags due to the changes.
> 
> v3: https://lore.kernel.org/r/20261006084638.3821710-5-den@valinux.co.jp/
> 
>   .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index 083b77d4de8f..a86c06701fa9 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -26,7 +26,8 @@ properties:
>             - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
>   
>     interrupts:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 5

Wouldn't it be easier/cleaner keep only maxItems: 4 here and set ...

>     clocks:
>       maxItems: 2
> @@ -93,11 +94,13 @@ allOf:
>               - const: config
>   
>           interrupt-names:
> +          minItems: 4

... minItems/maxItems here ^ for R-Car Gen4 (because Gen4 is the only 
SoC family which has optional non-mandatorily-described AER interrupt) ...

>             items:
>               - const: msi
>               - const: dma
>               - const: sft_ce
>               - const: app
> +            - const: aer
>     - if:
>         properties:
>           compatible:
> @@ -117,6 +120,9 @@ allOf:
>               - const: app
>               - const: config
>   
> +        interrupts:
> +          maxItems: 4

... and drop this interrupts: hunk here entirely (because Gen5 always 
has mandatorily described AER interrupt) ?

>           interrupt-names:
>             items:
>               - const: msi
> @@ -146,8 +152,9 @@ examples:
>               interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
>                            <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
>                            <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> -            interrupt-names = "msi", "dma", "sft_ce", "app";
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
>               clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
>               clock-names = "core", "ref";
>               power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;

What do you think ?
