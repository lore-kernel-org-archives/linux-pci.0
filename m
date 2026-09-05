Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6572F2910;
	Sat,  5 Sep 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644200; cv=none; b=Jkjz8T+AOsaqaOMaT0E0YMFOT2bpk4wtP0bukOk0xV5JP6BnJo83DOhb4UFjDs/s3cBA2lmBM1SYK7sgbLSGI9vnIiAKi8C2E4Fj7DGUdtpcO62khnHg2Q3qwDf4QuovFlx0CU/FNcnU1/vaO0QQuF6U6c5Er7SCU3xQTr8qecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644200; c=relaxed/simple;
	bh=HmLeaQgVcwCjY4VamAtCeYmdr8wku+kHLp3rA4pBo44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yx2+Bh1vHk/WaQTFGOLpRmznNc5nVURYxkGBWU+IWKyVeVxQyTDW4fTRmFy0Xei98p7b/eogy5MtpDevEhCmtGeTvpnjxCIk8wK1UDbgdQG+BaytcSuteBv0Pd0gkK5PQcAkHNub1eDrrjXKMAGj5RAiRBjaxRzHfrP0aXYD+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnoNi2i9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnoNi2i9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0341F00A3D;
	Sat,  5 Sep 2026 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644198;
	bh=Erl1Ell2rcf7NOLJ6CkmoAupzJjINB+wQOHxfqPWPMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnoNi2i9VikvHFHuFZ7uD/TPkGlHnhSEGas+72wvsNNtTNCw2bPqSRBpJtOudLgHb
	 Ke03dsW60LSzW+tsj5/6EEczN24IP+Vu8K3e3CRB0YaByyOCYzk6VvC29xNx6b0Bm2
	 re8sAvRKbe55QBpAtfBnfnNqrYDOmKTB1HF7Nq6cKEF6sQoH5aBtINpoEK7x5r5bNC
	 e/Fz4Pr9JPtf9ewzxNYM42nHXyh/zNutT9vmY6eyu19aFZKy1WAu073ul7mZ8lvIgy
	 I14GB3kYDrZ+f/O1B1YGvOrYWQT1huva4Qf5CX+rHEdHkRmCOk+jJ8j3GveN3SnU6N
	 7beMVuJ4nJURw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car
 X5H PCIe4 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260905212649.360498-2-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 21:36:37 +0000
Message-Id: <20260905213638.5F0341F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing required `phys` property in device tree schema for R-Car=
 Gen5 PCIe4, and incorrect property name referenced in commit message.
--

commit c9ec2af02aea699681c72cca90dd0320653d84c0
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible

Document bindings for R-Car X5H (R8A78000) PCIe4 host module.
The R-Car X5H PCIe4 controller no longer includes the PHY register range,
and the PHY is now a separate IP referenced via the 'phy' DT property.

> The R-Car X5H PCIe4 controller does no longer include PHY register
> range, the PHY is now a separate IP and referenced via the 'phy' DT
> property.

[Severity: Medium]
Is the property name in the commit message correct?

The standard property name for PHY references is phys, not phy. A property
named phy would be rejected by unevaluatedProperties: false during schema
validation if actually used.

> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yam=
l b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index 64f456c6a75a1..9767a52f3904e 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
[ ... ]
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,rcar-gen5-pcie4
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 6
> +
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: dbi2
> +            - const: atu
> +            - const: dma
> +            - const: app
> +            - const: config

[Severity: Medium]
Since the Gen5 PCIe4 controller removes the internal phy register region and
mandates an external PHY, should this conditional block also add the standa=
rd
phys property to a required list?

Without enforcing this requirement in the schema, incomplete device trees
missing the phys property will pass validation but cause runtime failures
when the driver attempts to retrieve the PHY using devm_phy_get(dev, NULL).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905212649.3604=
98-1-marek.vasut+renesas@mailbox.org?part=3D1
