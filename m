Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410A2BD02;
	Wed,  8 Jul 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501868; cv=none; b=BbDgmzUCbAFwRFKSv88KxlYf+e9vnovxjml8JX9BzhTN5ulhHWpUH7QIAwxxBf5aZS/AH2xDUQ1oN+GgO53oTjryc5xlkhjF4jC9VjpwgA8Ax/4psxpmK9259sVPqQaqLJau+PerUSFPbRycFmLGgLO6b8CfgK9eCc1ozRAFYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501868; c=relaxed/simple;
	bh=F7j7Z9dKGLN8GOTn+WnQgSGTt/ULQrejMAKGq+nNZ98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rh1KyoYLJmpqCqUAbAa/umIiO8kS3/FaJtuwcL5zMTz6vheSWNGF4Tq9SvpBF7YGUW7BvZ1AE8s2tSahxg/HLr7YKzMlu9cRe2fD518/lDD8koFRumszh6zta/GYDM4gUGTUl8CYeikCcMZhaV5+lC6jaKZOxpO3RKJ5cdQuoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuCt3G7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuCt3G7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8821F000E9;
	Wed,  8 Jul 2026 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783501867;
	bh=Xa7O3iS2Ue65K4cXLANqX+1+nOCrkolQ7ve8ag0Rf5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SuCt3G7yyWxLYXN8CEmZI8a0bJ5gw8X1MGNqi3d+K7WAq38rL872EfjlEwub4wX0V
	 b1WR3pe8qPVojNXDQZIlUehYva27TY80vhC11fGU2y1f/ZUSc55Pg1+p4UaaLqkOWq
	 qJyJ1ZrDYVP05p9hn9jl4Kez4HE5BZNxRvpoCYK1zHCGmqNxMRipOk4rij5w5p3X3i
	 boRuvtUdx9B2EP+bceT3LYh3aYixm5dkr4EWpWv+DYGDAEsWtZwJqeGAyP1TMwpksK
	 6lF2inZn8Lr3z2m/hR/YP/g5bwl7Ts+T5MDB3HMxa7CGD6XB+KE0ryDX6Ih3hsTHNU
	 of2YqQO/bwZcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek: Add support for
 optional perstout reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260708090533.19734-1-ansuelsmth@gmail.com>
References: <20260708090533.19734-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:11:06 +0000
Message-Id: <20260708091107.2A8821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a typo `resets-names:` instead of `reset-na=
mes:` in the `airoha,an7583-pcie` conditional block.
--

--- Patch [1]: [PATCH 1/2] dt-bindings: PCI: mediatek: Add support for opti=
onal perstout reset ---
commit 940c7b8d9eadf01ceca0b3e3526e890e946e92a5
Author: Christian Marangi <ansuelsmth@gmail.com>

dt-bindings: PCI: mediatek: Add support for optional perstout reset

This commit adds optional schema support for a dedicated PCIe PERSTOUT reset
on Airoha AN7583 devices. It bumps the maximum items for resets and
reset-names, and adds specific name constraints in the conditional block.

> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/mediatek-pcie.yaml
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
[ ... ]
> @@ -127,6 +129,12 @@ allOf:
>          phy-names:
>            const: pcie-phy1
> =20
> +        resets-names:

[Severity: Medium]
This isn't a runtime bug, but there appears to be a typo in this property
name (resets-names instead of reset-names). Will this cause the DT binding
schema validation to ignore these constraints and silently allow incorrectly
ordered values for the reset-names property?

> +          minItems: 1
> +          items:
> +            - const: pcie-rst1
> +            - const: pcie-perstout1
> +
>          power-domain: false
> =20
>        required:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708090533.1973=
4-1-ansuelsmth@gmail.com?part=3D1
