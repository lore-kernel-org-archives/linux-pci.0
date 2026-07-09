Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AC2CCB9;
	Thu,  9 Jul 2026 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570196; cv=none; b=K+ksfEXI63dfWktLok6Q80vTiTNUGvn3X5Nhp+uXLD/nwBKTMrJzHsgzZdsp+G8msoRIwxEIZgPkZwyWo8ZNQ12NBBzFqxH3Hi6fwdUjRhJIGq/5xkfdeYHZ8EVwF1pYgacOky/LDeofd+rJwSt0D3UAb5Io/7N5CP8UDzSVk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570196; c=relaxed/simple;
	bh=t/NrPsa5K0cfJtGIFf7D7XERQbuIETO0nSmZbdaNkb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kt+7GJS/Pr8OfEn2v4IXEDTtsmgACI4ZWohS9mhOc9HWkQZfPOoPZcc/HkIC5g7DYOQ51DB1nrS3PEaVfacrGof8mDwMEQ2ZFs6bPAjiznF6Gdxd2/AqMpz1OiaOOYioCdF2ez5mufktAnNJZbnwsh+k8Y9f5wW2zrijZSgQkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCgoN6tk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCgoN6tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60671F000E9;
	Thu,  9 Jul 2026 04:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783570195;
	bh=pFozXB1vNIiBcH6Z3FaOBIh5JneHtcUyOkksu/sDUfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCgoN6tkS+o23N2+iRkvfDnoi6+0dvGWu8m6p+HLuF8g0woFfHA/2OH/UG6BlgRAN
	 XzNp4SwQU3K4BVrJWlfOrpCW9v207P8CBhBMeKIZu1GUshQgxM6c3ytY5XXUfKhHBW
	 QZfhsxCSusqVjxpM1QCYw+EJiv4CVDIHcHQqL7HGrdG4cRhmcJJ1n+gcVzvDdGA5a0
	 NQrLAQZ1fsPLdBMd+z//OOz9D8J4k2wMPVwzM5bw0QvG1ZzbmxElyZCcGEt7dE36bM
	 5cGB86a1qgKepmBEAOzBJ9xrAZSWuIJAPXHgvIasFhFa4jKD1hD9AfwEil4GdRHlxB
	 yu/YryhvHffsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit
 K3 PCIe host controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260709040027.958400-6-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 04:09:54 +0000
Message-Id: <20260709040954.B60671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `spacemit,k3-pcie` variant drops the requirement for `interr=
upts` without enforcing an alternative like `msi-parent` or `msi-map`, allo=
wing incomplete device tree nodes to silently pass validation.
--

--- Patch [5]: [PATCH v4 5/6] dt-bindings: PCI: spacemit: Introduce Spacemi=
t K3 PCIe host controller ---
commit 2fd5f19d10e79ab1400e6aaebad38037440b1cb4
Author: Inochi Amaoto <inochiama@gmail.com>

dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller

This commit adds device tree binding support for the PCIe controller on the
SpacemiT K3 SoC. It introduces a new compatible string and modifies the
schema constraints to accommodate differing register counts and interrupt
configurations between the K1 and K3 variants.

> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.=
yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> index c4c00b5fcdc0c..54817d6fd9afe 100644
> --- a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml

[ ... ]

> @@ -102,13 +102,43 @@ patternProperties:
> =20
>      unevaluatedProperties: false
> =20
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k1-pcie
> +    then:

[ ... ]

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

[Severity: Medium]
Since interrupts and interrupt-names were removed from the global required
list below, should this else block enforce an alternative interrupt
requirement for the spacemit,k3-pcie controller, such as msi-parent or
msi-map?

Does this regression allow device tree nodes for spacemit,k3-pcie that are
missing both interrupts and msi-parent to silently pass schema validation,
potentially failing at runtime due to lacking an MSI domain or interrupt
line?

>  required:
>    - clocks
>    - clock-names
>    - resets
>    - reset-names
> -  - interrupts
> -  - interrupt-names
>    - spacemit,apmu
> =20
>  unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709040027.9584=
00-1-inochiama@gmail.com?part=3D5
