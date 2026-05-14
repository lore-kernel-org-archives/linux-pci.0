Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F52F9D89;
	Thu, 14 May 2026 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720688; cv=none; b=TXwmRz8gtc2rm304CsgP6nmxfTVMR3cDxl32kjgext2Rs9hL90o0d+PVha5Q7NwC7LLs2VwzfMgUN7JhPR/EukXq2uRa/oE3Eoh3JKZQQC70FeOdzX3EPSlUu8vHJKh1fz5uxjwW6MZlk3HfoWmS2vVU4R4LqEiSLFxnyKk3yrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720688; c=relaxed/simple;
	bh=Os8M03cI/bIK97UliIlzT2ruhXSS3WfDehObzml7PFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKTaC92K8M/CLMqUs5zO7LVBRS48en99Mh6w6p8zAmM94uBTZOQXfkYpn1IzaUbc+nQoSUXd/yoVwfdMygOrjbE1mkXY6+nGHEtY6qDhp1C0TvvmrZLXHJU9Fi62HeWchi6slic0fG1+E9F9YG2J1ANinbWHcahW4qG17hW9y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKrtDHjd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKrtDHjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A329CC19425;
	Thu, 14 May 2026 01:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720688;
	bh=Os8M03cI/bIK97UliIlzT2ruhXSS3WfDehObzml7PFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pKrtDHjdS/8B/H4GKH0JtL2Lhv1p/9oevkUvp9K+dKgMbQSfJ1vSq0y+Bz8HNJWtV
	 b7Z6yEidcnWeBfr94Bg8kDsy1EyBmGqhCfQLsMGOqTi7J863Fwcaj39dPo0VXXsZHM
	 EgcHRbWOuTUkJ/hRgcyjrgQf4zQoR1y0uC3RrnerRh9kC9CgWMMDWezh+PhUCfmT7Q
	 BxrgbvHocfoocTcC5L8uMh16kHVG0tfNmdxyHk8CM5s/J/tDUJZnddMiUYdkHKGh77
	 qvdPbRRk+ta5KFaGQoS+VzangwppvM5BD6ejiP6qwd56LhZsHxcRZH5VR+3M4BsfeN
	 mUFQfb1tx01Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Zhu" <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, krzk+dt@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260513025101.1498104-2-hongxing.zhu@nxp.com>
References: <20260513025101.1498104-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:04:47 +0000
Message-Id: <20260514010447.A329CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Strictly ordered `items` array prevents omitting intermediate op=
tional interrupts.
- [Medium] Global addition of optional interrupts loosens schema validation=
 for older hardware generations.
--

commit c716cc823581eb06c45ae0ee7c1441e2e4b80ec3
Author: Richard Zhu <hongxing.zhu@nxp.com>

dt-bindings: PCI: imx6q-pcie: Add intr, aer and pme interrupts

This commit adds optional interrupt entries (intr, aer, pme) to the i.MX6Q
PCIe binding to support event-based interrupt handling.

> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 9d1349855b422..cf709132ff1e2 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,12 +58,18 @@ properties:
>      items:
>        - description: builtin MSI controller.
>        - description: builtin DMA controller.
> +      - description: PCIe event interrupt.
> +      - description: builtin AER SPI standalone interrupt line.
> +      - description: builtin PME SPI standalone interrupt line.

By adding these optional interrupts at the top level, the maximum number
of interrupts implicitly increases from 2 to 5 for all compatible strings
in this binding.

Will this allow older hardware generations that physically only support
2 interrupts to silently pass validation if they incorrectly specify up to =
5?

Should the existing allOf conditional blocks explicitly restrict maxItems
for the interrupts property on variants lacking these new capabilities?

> =20
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: msi
>        - const: dma
> +      - const: intr
> +      - const: aer
> +      - const: pme

If a hardware variant supports the msi and intr interrupts but lacks the
optional dma interrupt, won't this strict array validation fail?

Since dt-schema enforces exact positional matching for items arrays, a devi=
ce
tree specifying interrupt-names =3D "msi", "intr" would have the "intr" ent=
ry
evaluated against the second constraint (- const: dma).

Does this need an enum/anyOf structure with minItems/maxItems, or specific
allOf conditionals per SoC to correctly handle omitting intermediate entrie=
s?

> =20
>    reset-gpio:
>      description: Should specify the GPIO for controlling the PCI bus dev=
ice

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513025101.1498=
104-1-hongxing.zhu@nxp.com?part=3D1
