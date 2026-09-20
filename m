Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53E3603E0;
	Sun, 20 Sep 2026 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887301; cv=none; b=f76jLZILFkGMeaDlO2byEqMVnsT45Hbig3lOVGaJqEC3aWjq8Pm9uw5LAIj0TvUFoLlB/jGPRNN3KMeixSBQTN86FMrbWCJcfqwZbpQ0tNb6RbEo/q8sP9Dh+Ixtkmvnxe82OUfZlKceWWg7NTtjxvozuTy81x57o5hmLvmPBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887301; c=relaxed/simple;
	bh=H65Glu12Vs7KTkNjjFjsKTEEaH8yp9daOs2Lw+VQmRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kxo/iNR0tu/8xQY6JH0Y8w7wxhJeC2CKNhHv1mf1XLgvHyZxoqIDfpqbb6ZDh9Im/+z6oXGvL2ESTc9dW5CJvUQd69TGJX/yUAnWDcnBNuODrzt+RIvUIxfXbHKKdcAA9GrTBpq5IG+NxTKWMcGkFQbRJPO7j+9Oxdi2nYuN5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoDptU1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoDptU1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD91F00893;
	Sun, 20 Sep 2026 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887300;
	bh=655IFjbDDUE7r+JE6d1nbjGwqaM3WBT/xigYQS4/SVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RoDptU1U/ldvzcLIpPpHP36/bMZ5tZjJHhoMD7qrabAkCRKyYu+XGgwi4paBdAW7c
	 uIH9fmIZUAV/AeEXBXgbUQOAubBaQv/NcQ+t98de7ebaIxuNXKiPO9Z3jRQ05ni/T3
	 MZpB/SJ+NxpdAMpLSr78VkwU51q9TT8ccvouxjPAvN702Y297onMdpsdzhegRDv2A7
	 WsbUVbq+IfRtYrjL6KF8Tq4X/IqVwqf7OQkDXsAZdoLDSliE8ZDXPUIb7UnRbL7Kp1
	 K5ysBgOUvsrGB4X9pWxX7OaXe/6foYcZc6VWO1NwLsaNtt2vo4wllq/u7Qt5/XrIuS
	 cD+/lj0K7CjBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 02/12] dt-bindings: net: nxp,s32-dwmac: Document
 pcs-handle
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, olteanv@gmail.com, robh@kernel.org, linux-phy@lists.infradead.org, Frank.Li@kernel.org, neil.armstrong@linaro.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260919-s32g_serdes-v3-2-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-2-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:59 +0000
Message-Id: <20260920065500.09BD91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: redundant type definition in pcs-handle contradicts=
 commit message
--

commit 83228aa7bd3f939d2363db1fc38174d3181bfd69
Author: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

dt-bindings: net: nxp,s32-dwmac: Document pcs-handle

This commit documents the pcs-handle property for the S32 DWMAC when
routed to the embedded SerDes for SGMII. The commit message indicates
that the type is inherited from ethernet-controller.yaml and does not
need to be redefined.

> diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/D=
ocumentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> index 753a04941659b..b168decb540c6 100644
> --- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml

[ ... ]

> @@ -81,6 +82,14 @@ properties:
>        - const: rx
>        - const: ptp_ref
> =20
> +  pcs-handle:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1

[Severity: Medium]
The commit message states "The type already comes from the
ethernet-controller.yaml reference in the schema chain; this only records
the intent".=20

Is it necessary to redefine the $ref to phandle-array and set maxItems to 1
here, or does this contradict the commit message's claim that the type
definition is omitted because it is already handled by the schema chain?

> +    description:
> +      phandle pointing to the SerDes XPCS lane child node that provides
> +      the SGMII PCS for this MAC. See
> +      Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml.
> +
>  required:
>    - clocks
>    - clock-names

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D2
