Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE972F7EF6;
	Fri, 14 Aug 2026 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671915; cv=none; b=RicYtrnJubfbsVXK0VHCTOQ+d2KB8yuII8AzT0jmo0mWybRNoprOUNtQ61AjMW3mvdqhOTKi0uPMtxuOSDQOzvePWln1ny4vm+3vbr5m8Ru+xOcRiBPwVJEErHW/rzGES1hzdxkOs2WxpmBmO1V+bBYkFsKZVrA+cqmsMn+aLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671915; c=relaxed/simple;
	bh=eAFigvV+VC6GKm+rhwyN+U8sCZSgz2fT1o0C1cCTKP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=csvkGWDJbypsIT3SaT/9ywPrZdyblByLqxvMx+A3cOdUwoaUAjdiSo8MliIZSPwXZl20HKP8OmO1I5wBX3oI+mqIkxFLL25CJPbtMA5P55diVaxmVfRpypjYHzO0alD6eWfSvDt5V+6mZjEZ8eg81qfIqyZmkP/FL2M5Q8U3VF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVZ7feW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVZ7feW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF1A1F000E9;
	Fri, 14 Aug 2026 01:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671913;
	bh=dLrWIY4rV/mBdgkmGy2NuZDTPYuQHCcbEI84bWaPAe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVZ7feW7D1hscC3uqbQvXVuoUUVQZCnXE0nXw5p0hgMe8FN2EDL86ZTbZ+68WmIV2
	 KcygSyVwuPC+2+g7IWVaNcquwZAgNusW2Mu5DB0faJn13RiGyQcDNCnRCYy4RQoATC
	 Iem4Jq0AAvimENud/njmhGSDiM369Fma+CXhovS5NE7WYZY7qoDJmcCPU4GnBydn9P
	 mrX07rXqPJZt9I1EgLVSBi5LZgi9q+zo5+CwLQ27lZ/hTSK5TVIJqN7yaqz6FvLtru
	 P00YLGbamE2PFH8SA6KXJixN+55J2d1N9wgInZ70ZEeTtJXAOldDSJ3aOMPKdsU4iP
	 OXiX3ernRd13g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260813222943.1655453-2-elder@riscstar.com>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:45:12 +0000
Message-Id: <20260814014513.5CF1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The example DT nodes map multiple PCI BARs to the exact same parent=
 physical address, and define unused BARs that contradict the hardware diag=
ram.
- [Low] Typographical error in the compatible string comment.
--

--- Patch [1]: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml -=
--
commit ee5f64080011b047dd81e1bbdc568f784c09b77f
Author: Alex Elder <elder@riscstar.com>

dt-bindings: misc: introduce pci1179,0220.yaml

Define the binding for the Toshiba TC9564 PCI endpoint function device.
The third downstream PCIe switch port within this chip has an embedded
PCIe controller, and that implements two of these PCIe functions.

> diff --git a/Documentation/devicetree/bindings/misc/pci1179,0220.yaml b/D=
ocumentation/devicetree/bindings/misc/pci1179,0220.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
[ ... ]
> +properties:
> +  compatible:
> +    const: pci1179,0220 # Toshiba TC96564 (a.k.a. Qualcomm QPS615)

[Severity: Low]
This isn't a bug, but there's a typo in this comment. It says TC96564 inste=
ad
of TC9564.

[ ... ]
> +        pci@0,0 {
> +            compatible =3D "pci1179,0220";
> +            reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            /* Ranges will be updated dynamically */
> +            ranges =3D <0x0 0x0 0x0  0x83000000 0x0 0x0  0x0 0x4000>,
> +                     <0x2 0x0 0x0  0x83000000 0x0 0x0  0x0 0x80000>,
> +                     <0x4 0x0 0x0  0x83000000 0x0 0x0  0x0 0x200000>;

[Severity: Low]
Are these example ranges accurate for the hardware? The mappings configure
BAR 0, BAR 2, and BAR 4 to use the identical parent physical address=20
(0x83000000), which would result in overlapping memory regions.

Additionally, the hardware diagram in the binding description indicates
BAR 2 is not present, but it is configured in this example.

[ ... ]
> +        pci@0,1 {
> +            compatible =3D "pci1179,0220";
> +            reg =3D <0x100 0x0 0x0 0x0 0x0>;
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            /* Ranges will be updated dynamically */
> +            ranges =3D <0x0 0x0 0x0  0x83000100 0x0 0x0  0x0 0x4000>,
> +                     <0x2 0x0 0x0  0x83000100 0x0 0x0  0x0 0x80000>,
> +                     <0x4 0x0 0x0  0x83000100 0x0 0x0  0x0 0x200000>;

[Severity: Low]
Do these ranges match the hardware design for Function 1? The example maps
BAR 0 and BAR 2 here, but the hardware diagram indicates Function 1 only
uses BAR 4.

These mappings also map to the same parent physical address (0x83000100),
causing overlapping memory regions similar to the previous node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813222943.1655=
453-1-elder@riscstar.com?part=3D1
