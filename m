Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F1370AD4;
	Mon, 31 Aug 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158038; cv=none; b=fQ3iYteHOvxxYzWEusRvRIVq3Zf5qoXMAOjUnkHyLOnyKhTXtfHOEuN7vPjsEbOwXM2t3HoOg1dXr69VCMhXq1cYS3aTvRmsSHZmpZDhZHiy97uXyNAB+WWcWrnobjqyHQu0Sty0oIOmuxwmho5sdLl8KYPkHLhbY+CsNdqJKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158038; c=relaxed/simple;
	bh=K342pN9R5l9Amf3yIne5jhRsFkAPNtSws5F1C1XTfYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRLZo2H4oylf9thYGKqHGeaK26qxp6bkEX5i4c2oU3THSg4Y/hX9kqydYvCCKuBr7jzu9nX87doO+tlFzyehQK44Z4i7npbI4OvuX3PX1QxEf5sDucrCT7jm/3gGRtyvDB98Dn/zEvlscQ0svjSnpshDjzjSE20z9EwdOyXNzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXBHbr8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXBHbr8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F3E1F000E9;
	Mon, 31 Aug 2026 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788158037;
	bh=GP2C2mZreAalLgcgv4kH52hh++chyCXbyU5k8g3nVAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HXBHbr8QuA/1GL+lcq09OgnCqRhxC7HarHVZt/raxamgMrw2e/zqzfkIlcy3bv+KJ
	 +Or0czqXZnS5CX2a+GUc4ML5WTnln7D6oxSskL07rpWlvKSUa3b2QEnLSIY692Eiz9
	 88tPzxGya7NYZsPMYjSH9BH0rsmGEO3HvO+RbLn+lYbRhMmLkhVrFw9ra3u/KX7NHX
	 WGxSwq9U+JOgXwI6X5NEV9ZTUyuieBsY8O5DAQkoJ8BLYv7yqiL1jmWi00MqBz/P8w
	 sly7jgqAaZqlTiKeHwrKGk+Fg2Ob8XqO3aQE3B3at+5xDUbKLI8tlVXz6trPZh7KSt
	 B+9Lg9jsuKpfw==
Date: Mon, 31 Aug 2026 08:33:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3L SoC
Message-ID: <20260831-neon-responsible-ape-e0cd02@quoll>
References: <20260825095047.9971-1-biju.das.jz@bp.renesas.com>
 <20260825095047.9971-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825095047.9971-2-biju.das.jz@bp.renesas.com>

On Tue, Aug 25, 2026 at 10:50:40AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3L (renesas,r9a08g046-pcie)
> PCIe controller. The RZ/G3L PCIe controller is similar to RZ/G3S but has
> some key differences:
>      - Has 3 clocks compared to 2 on other SoCs.
>      - Has a different set of reset signals
> 
> Add device tree bindings for renesas,r9a08g046-pcie compatible IPs.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 33 ++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> index 09d78bd1a577..911b1976bf53 100644
> --- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> @@ -13,7 +13,7 @@ description: |
>    PCIe host controller found in Renesas RZ/G3S and similar SoCs complies
>    with PCIe Base Specification 4.0 and supports different link speeds
>    depending on the SoC variant:
> -    - Gen2 (5 GT/s): RZ/G3S
> +    - Gen2 (5 GT/s): RZ/G3{L,S}
>      - Gen3 (8 GT/s): RZ/G3E, RZ/V2H(P), RZ/V2N
>  
>  properties:
> @@ -21,6 +21,7 @@ properties:
>      oneOf:
>        - enum:
>            - renesas,r9a08g045-pcie # RZ/G3S
> +          - renesas,r9a08g046-pcie # RZ/G3L
>            - renesas,r9a09g047-pcie # RZ/G3E
>            - renesas,r9a09g057-pcie # RZ/V2H(P)
>        - items:
> @@ -87,14 +88,18 @@ properties:
>    interrupt-controller: true
>  
>    clocks:
> +    minItems: 2
>      items:
>        - description: System clock
>        - description: PM control clock or clock for L1 substate handling
> +      - description: PM control clock or clock for L1 substate handling

PMU? You list both clocks, but is there any different between them?

>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: aclk
>        - enum: [pm, pmu]
> +      - enum: [pm, pmu]

This should be "const: pmu" in such case.

Best regards,
Krzysztof

