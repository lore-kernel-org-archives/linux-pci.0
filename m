Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598D48BD5B;
	Mon, 18 May 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120757; cv=none; b=SiuXccqyJX9YlDvTloKlib2k5tl2ppOcDO3LxzhK3pgxf28w5TAn1/ibRudzWmFCSPhXH+aEwmsEChGCkaxjJ0vMBynKiwaEclEEjhSxN978ylmtr8W4YUGi8MMP/Ya8Es5m5FGGJyI0PwfYeKwq5aQZLU371FChgtcrcXGnz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120757; c=relaxed/simple;
	bh=3bBrs7mGRW350IS29w5MjBEpH7kFoVKDOCVdn0zMrgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kagTRQvQoVQ9B4F/kEv5bF4rGEStS+FiGlLYpkc/4ZyKMqjNafVSVdKvvTAbfRHSZYf2JapEuaA1pGYkQA5SNtvwJwcxfbfH6rLCa78pEt8HGrcip9LdKOe9mqi7Pi79YAGnV/jng+lUgsEMwZpETIxBoAdCwMFL/j31Gx9TcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4GvXNNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4GvXNNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146AEC2BCB7;
	Mon, 18 May 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120756;
	bh=3bBrs7mGRW350IS29w5MjBEpH7kFoVKDOCVdn0zMrgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n4GvXNNTLDRPKdDUuTDOqA6d+VcvH4IVk+HWxsByWKShb+KY+r3yBvPjQDkmaQ3vu
	 vXqP5EGV/2SwVzCx2GJrtoofvq7r0Db/Oz0Xx7BzrxnVEZYxWDzVS1T0dlyShfAWxN
	 NOXgCFHjMIW5NYQYzVoreEmijWJt5c1Yr0uqmAkxHVqnz0mM9a8hbx+ew2gIYfxZJu
	 tLZUk5lB6iTJdk4O32FTCZngNrqkHyGyMM2VBWIUgN96lroOR9Fdk3N5+MDiSYLpPY
	 xvBv+t8drksaqX84E3SWF887NWPqez0u+AJotgBDb6iHhjG6BkdKyFbdz52gEpPoxr
	 SaqhAlIYRDuJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add
 RZ/V2H(P) support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260518155324.168948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260518155324.168948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:12:33 +0000
Message-Id: <20260518161236.146AEC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch mandates `linux,pci-domain` to identify the hardware con=
troller instance and determine system controller register offsets, which is=
 a Device Tree architectural violation.
--

commit ed13e82a06909d08d89ba9cf97e57413bb3dc6c8
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
   =20
This commit adds support for the PCIe controller found on the Renesas
RZ/V2H(P) SoC. It makes the linux,pci-domain and num-lanes properties
mandatory for identifying the controller instance and mapping system
controller registers.

>     Unlike earlier SoCs supported by this driver which only feature a sin=
gle
>     PCIe controller, the RZ/V2H(P) SoC implements two controllers. Both
>     controllers rely on the system controller (`sysc`) for configuration,
>     but the required registers reside at different offsets for each insta=
nce.
>     To correctly identify the controller instance and map the correspondi=
ng
>     system controller registers, make the "linux,pci-domain" and "num-lan=
es"
>     properties mandatory for this SoC and restrict their values according=
 to
>     the hardware capabilities.

Is it appropriate to use linux,pci-domain to identify the hardware
controller instance?

Device Tree is designed to describe hardware rather than software policy
or configuration. The linux,pci-domain property is an OS-specific hint
used to assign logical PCI domain numbers.

Using it to identify hardware instances strictly couples the hardware
register mapping to an OS numbering scheme.

> diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie=
.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> index 90086909e9210..149a2973b16eb 100644
> --- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
[ ... ]
> @@ -235,6 +238,20 @@ allOf:
>            maxItems: 1
>          reset-names:
>            maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g057-pcie
> +    then:
> +      properties:
> +        linux,pci-domain:
> +          enum: [0, 1]

Does limiting this to [0, 1] cause a regression for valid software
configurations?

For example, if a board with multiple PCIe controllers assigns domains 2
and 3 to these instances to avoid conflicts, the binding will fail
validation and the driver will fail to probe.

Could the hardware instances instead be identified via standard hardware
descriptive mechanisms, such as their physical base address (reg),
standard aliases, or by adding a phandle specifier argument to
renesas,sysc?

> +        num-lanes:
> +          enum: [2, 4]
> +      required:
> +        - linux,pci-domain
> +        - num-lanes
> =20
>  unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518155324.1689=
48-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
