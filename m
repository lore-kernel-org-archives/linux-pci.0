Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84145476682;
	Mon, 21 Sep 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023185; cv=none; b=QS5rjn0oqihy5gMc+MENZpoPu40qn7qbxyliyATJdjKALRQcD4YN7+a5VS+NlLQH9lt457CFZXu7IBX54qvAoK6+dGIJT0nQFApPJtWBG942svGhzsHjdFQbVnBp2v9Y4Biulz4iqv+TlDy3IhB7YGV1aSeejUlEjpnvZNk4ZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023185; c=relaxed/simple;
	bh=qT04uTaurPQCwegVxclAb4cTisTzk38I9pdbRBeW/D0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AKRf6ry4EgpY2MdfWs3Kc4wF+ZxQadToGb+Krl4O5i2CfIWGHltR8tv7NC74WtxyegLubR31xZf01wD4N+J4GleoNL1lXNoqKCSgfdwVF5obdiJlTy8btBn8+5W4eIBqdxcsohIKxsch2Nbwi4XUhJeyt//l1djkHRzR9eIrJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIcp8P8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIcp8P8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7E51F000FF;
	Mon, 21 Sep 2026 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023183;
	bh=tWGl7BiS8nBuHbK7FGgbRbZWhiO7S9O9bhvxRVSTAVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIcp8P8ZyH55CpTB6kvuKUvOQJVVOWqGplqeFYQyUylZynfHhT4+HdjCOzQ50ge89
	 L73MF6xd2g6VbllcuV1O+1B38Oc+64RFjNg7j/KajhNTNuimK+xnsYuNBNz5fVfasN
	 sqqsRfJ+pr4wN5hzAXMIFXHb+q6hj4/Ia9jZX1r8IDBdE/Lo8uGev4p+z4Wl5luIt7
	 g5mp1n3g4yTIuhkOBeL7tAgmKuahHQK8zWzjlFfPsIWy7b+TWd1q5+/N628kxlz1gp
	 kFaArI8Q0UtGvGWDJ/D/6iL/gnzhKCLfx6t6wtkfhIbnrIxsbKUH852HU0h4t+/MAF
	 DSG1bgZfzgwVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car
 X5H PCIe4 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260921202823.72620-2-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
 <20260921202823.72620-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:39:42 +0000
Message-Id: <20260921203942.CF7E51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: pci: missing phys requirement for Gen5 PCIe
- [Medium] dt-bindings: pci: missing minItems allows incomplete reg arrays =
to pass validation
--

commit 514029652899ad708ecb1a48b34db8779da18327
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible

Document bindings for R-Car X5H (R8A78000) PCIe4 host module. The commit
introduces the "renesas,rcar-gen5-pcie4" compatible string and adjusts the
"reg" and "reg-names" constraints, as the PHY is now a separate IP for Gen5.

> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yam=
l b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index 64f456c6a75a1..9767a52f3904e 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml

[ ... ]

> @@ -84,6 +74,46 @@ required:
>    - resets
>    - reset-names
> =20
> +allOf:
> +  - $ref: snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,rcar-gen4-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 7

[Severity: Medium]
By moving the "reg" and "reg-names" properties into this allOf conditional
block, does this bypass the automatic array length constraint inference from
dt-schema?

Without an explicit "minItems: 7" constraint here, it looks like the schema
will fall back to inheriting "minItems: 2" from the base schema in
snps,dw-pcie.yaml#. Could this allow a device tree node with only two
registers (like "dbi" and "config") to incorrectly pass validation?

> +
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: dbi2
> +            - const: atu
> +            - const: dma
> +            - const: app
> +            - const: phy
> +            - const: config
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,rcar-gen5-pcie4
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 6

[Severity: Medium]
Similarly to the Gen4 conditional above, does this Gen5 block need an
explicit "minItems: 6" constraint to prevent truncated register arrays from
passing validation?

Also, the commit message mentions that the R-Car X5H PCIe4 controller no
longer includes the PHY register range and that the PHY is now referenced
via the "phys" DT property. Since the driver requires this external PHY to
be present, should "phys" be added to a "required" list within this Gen5
conditional block so that incomplete device tree nodes fail validation?

> +
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: dbi2
> +            - const: atu
> +            - const: dma
> +            - const: app
> +            - const: config

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921202823.7262=
0-1-marek.vasut+renesas@mailbox.org?part=3D1
