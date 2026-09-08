Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAB54EED1
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880206; cv=none; b=pemlMf112fjNGoT/Pc53C/0wau8a4wZHIvfUtLhuYROI+BaZDKEntUHBCjglur3zrMaWW/YoZ5yOupZSUcF+frSqPij9IB9iCUItTQLz5WoYBsb0+H6mos4XrUYBtsfVz52INap4fsIUacgzqQUrngvdHOz/ouR29gwvFzckoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880206; c=relaxed/simple;
	bh=5Yc2sfjgYGsaGxjV4BUmh5b4X/TKwaYongXsKu/4b94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KAl8JmYW4uFk6OKX8VrvA848oFTjolkER67VBTWoqtH0IwDbD78APWR2/UErvpJJFpNMNiqyQZmE6kmMqXJzGrSzo5bktHm8Q6FpdG6PEIehrya22dO1XL5Qb7O6EqlNG2/Oou+q2kmLa02vyq3rXiEHHMcgsEWGiUoAndNhx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESfYl/bz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESfYl/bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337E81F00A3D;
	Tue,  8 Sep 2026 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788880198;
	bh=Q62rKSlLRSWxRlm78SMRyuJTDOdkNgXlrAmWgPf4NXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESfYl/bzFB1XZeXnua5L2crbuSA0GGibtVBJOz2rOBPYiuBwKaFG4XkWSRHs5GH75
	 c6VDjMaylaG7hUTMYNrERoUqpnlTpfrBQoxTORt+d1H5/5Ug6h28++FicJ9NYf8Mah
	 7mWJ+ypbS6jjb796ycpAjwcBgcseeYMh7NqqD8Pw0b7HE5xiYap9jAi19tzH+cYsoU
	 YjwAD9MTnngOEZCKr4Bm5dsIve35d0YFaZ9jPYO3e//VS/eIL9Y8tzY2uY91LgqFgZ
	 wZkYZqmHlyCRH+XahVkNzECcCSISRuJmm6HmPZcczJ2Dkt16rX0f4FMLEtXqfpv29r
	 lmPCCtsBpK+Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] PCI: dw-rockchip: Add pme_turn_off support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-7-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-7-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:09:57 +0000
Message-Id: <20260908150958.337E81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect use of FIELD_PREP_WM16() on a Write-1-to-Clear (W1C) i=
nterrupt status register, causing unintended clearing of bit 25.
- [Low] Redundant macro definition for the Power Management Control Registe=
r.
--

commit 10a270e398b67f78bf174b063ed14cff0ce4e43b
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

    PCI: dw-rockchip: Add pme_turn_off support

This commit prepares the Rockchip PCIe controller for system suspend support
by adding the PME turn off operation.

> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
[ ... ]
> @@ -64,6 +65,11 @@
> =20
>  /* Interrupt Mask Register Related to Miscellaneous Operation */
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> +#define PCIE_CLIENT_POWER		0x2c

[Severity: Low]
Does this code introduce a redundant macro definition? It appears that
PCIE_CLIENT_POWER_CON is already defined as 0x2c immediately below
this addition.

> +#define PCIE_CLIENT_MSG_GEN		0x34
> +#define PME_READY_ENTER_L23		BIT(3)
> +#define PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
> +#define PME_TO_ACK			FIELD_PREP_WM16(BIT(9), 1)
> =20
>  /* Power Management Control Register */
>  #define PCIE_CLIENT_POWER_CON		0x2c
[ ... ]
> @@ -452,8 +458,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp=
 *pp)
>  	return 0;
>  }
> =20
> +static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
[ ... ]
> +	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
> +	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_=
MSG_RX);

[Severity: Medium]
Since PME_TO_ACK uses FIELD_PREP_WM16(), it sets the write mask in the
upper 16 bits (asserting bit 25). If PCIE_CLIENT_INTR_STATUS_MSG_RX is
a Write-1-to-Clear interrupt status register, will writing this WM16
formatted value unintentionally clear the interrupt status for bit 25?
If bit 25 corresponds to an active interrupt, it could be silently lost.

> +	ret =3D readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER,
> +				 status, status & PME_READY_ENTER_L23,
> +				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret)
> +		dev_err(dev, "Failed to get ready to enter L23 message\n");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D7
