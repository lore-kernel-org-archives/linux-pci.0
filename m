Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628953603E0;
	Sun, 20 Sep 2026 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887297; cv=none; b=enriF7bPTssN2Ry2y12GQTjC8B5B4Izbt/ZFZuZRFYXj/cLIGszKK3xsgf+k6TEPK3PIEeQca4rgx2HIUzNL70GVHkfaYH35HlYxgMtlkq163K3ariqwwpU5lpuUnH+gPpu8CaSb2Z3a1eLrf3V4hVPiJCJn8BLNl2slK5rRAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887297; c=relaxed/simple;
	bh=LkGasw2ZyriVo0O80A9rOXfEstYKHH14k0eLsagSqi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kHS5gKeaWx4GC3v3+HAUQuOYQ6u8AzhlDKjH/77m1cpOyLHfq2FAIuRoCu02/wapV5QDX90528q2/tSv1/z55+nDBkLOoRroeAJvqdBdNpdyhK9yXwx+E2IZTXooeSknUlNGh0XwaRhZjYs1Xh8Z7h6TxvQkhNPb/WSKAU2Ntmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho38eIH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho38eIH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D9F1F00893;
	Sun, 20 Sep 2026 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887296;
	bh=icjHCxhRYLZvp6aUGXetxGSkNHFCNbL9PoVkPWL+05Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ho38eIH210FDDOEiwWHatCZluRudE33Tl0L1ZVC0AJAVYU5jOxAXlV8fUZDDMu65x
	 NkTO6DdJNiuiLfY9R9uzrxSDFiUbPmNt6zSs8odPvcykGfbUKIrnJx2cq8ynfUsheG
	 2hDJM2o8vmxfSc9b59NJ1NQGzSvyQTU/OeeXPmJSK0rz4OM6kDm+VC6+FOK1mX0em7
	 eguOurwUuzoOy1gSqC1euwdP+LqfIgfRfZoCdGwWLHJ0XZVTQt3wvBe/eEvV/hrDi4
	 CmlhRPuKruAqmD/IvETnYs96WYhtp0TdWcczXD4aIyDdgHQR/XR+w63WTJhpXA4/YG
	 qnXIGrhtogzkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 01/12] dt-bindings: phy: Add NXP S32G SerDes
 subsystem
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, linux-phy@lists.infradead.org, olteanv@gmail.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20260919-s32g_serdes-v3-1-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-1-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:55 +0000
Message-Id: <20260920065455.72D9F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing required enforcement for phy@0 and phy@1 no=
des
--

commit 9e2cce806a48312a639c54029d5a8b84871dace7
Author: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

dt-bindings: phy: Add NXP S32G SerDes subsystem

This commit introduces the device tree binding for the NXP S32G2/S32G3 SerD=
es
subsystem. It defines the hardware constraints for the combo PHY shared
between PCIe and DesignWare XPCS instances, and specifies that both lanes
must always be described in the device tree.

> diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b=
/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> new file mode 100644
> index 0000000000000..6343d01bfde45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml

[ ... ]

> +patternProperties:
> +  '^phy@[01]$':
> +    description: One SerDes lane. The unit address is the physical lane =
index.
> +    type: object
> +    additionalProperties: false
> +
> +    properties:

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - '#address-cells'
> +  - '#size-cells'

[Severity: Medium]
The commit message explicitly states "Both lanes must always be described, =
even
a lane the board does not wire out to a connector", but is the schema actua=
lly=20
enforcing this?

The patternProperties block defines the schema for the lane child nodes, bu=
t it
only applies validation if those nodes are present. Because the phy@0 and p=
hy@1
node names are missing from the top-level required list, it looks like a
device tree omitting them would silently pass dt_binding_check validation.

Since the driver will fail the probe with -EINVAL if the lanes are missing,
could these nodes be explicitly required in the schema to fully enforce the
stated hardware constraints?

> +
> +additionalProperties: false

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D1
