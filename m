Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B583DAAC0;
	Sun, 20 Sep 2026 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887300; cv=none; b=IypszZhLJfiAPt9u/rlE76s8CVB5mUTP2ZajZEm7kLt7ihklvGhu6ypSbjbiYwCXyeIox2j/Tv0yjrUct/RfM1UGmEJNifDRq950ZwPW2GT1OVsdVZ7FOyWyCUPuDVffabv2sKMIkdHkitYumUuROAARHvbPxY7aUxkedkD0MZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887300; c=relaxed/simple;
	bh=vlQV4moENea9d6CLDNDz9aYqSkbU30plOIvFrHh/NVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LOc9bHsROV0jiPkS/xMcZwvy523yS9G3gB5OrwBm2k6CVBM7M/1I5LCMc/WN/pnSQ5l7HMvIA7xMj6/qu0iyeEurR/JGXDChnqnvIO4+WfPMM/6M+rmy1KZ8/+Wm+xu9JMqZ0E5WW520FkguDNjLLYfdSNxE0A5WtUjblDC8EE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRjFD8+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRjFD8+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16661F000FF;
	Sun, 20 Sep 2026 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887299;
	bh=ybM0945rSh88HsdCn75C00Rf9SSOVXNSxqOyfr5cKhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRjFD8+sRHAaxgSPYg2O5c1x3orua8FyeVf1VIDpO7GEyUP5VFfy1AAJAetMQ4xAi
	 qF3ayjJKDqSMHmfpjiDYl6wj2iVKO1J5vTWZmWM0Q1gl95ZNnf5RYO+fHc7isRpZ+J
	 Phu1xp4sxH59a08lpUofnM6IZZ78wFarzG9Q2Bbgue5IKbjn7K7ZtaZrYHrUb2aI76
	 awhrqUtfwEi77fFZH9uMQY5HDtOorIHEZh1nP4VO+pwr2m+0B2NHJaYpMb1Gjrv3AW
	 a14HJIO1hEUkl6mVjM9+3Gmj5ZbIZXtsP/4mLpPYNtXj05n8pSyEL4yS+XbE+rln2E
	 2VGJ/Ipa8T1mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 04/12] net: pcs: add NXP SerDes XPCS shared core
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, olteanv@gmail.com, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260919-s32g_serdes-v3-4-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-4-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:58 +0000
Message-Id: <20260920065458.E16661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: pcs: Link flap and incorrect speed/duplex resolution in SGMII=
 AN
- [High] net: pcs: USXGMII full-duplex configuration dropped by regmap mask
- [Medium] net: pcs: Kernel panic on NULL pointer in nxp_serdes_xpcs_destroy
--

commit fefa07f062a827745ea578ec9b3b8e4d9a1e9739
Author: Clark Wang <xiaoning.wang@nxp.com>

net: pcs: add NXP SerDes XPCS shared core

This commit adds a transport agnostic phylink PCS core for the Synopsys
DesignWare Ethernet XPCS and Ethernet PHY found on NXP S32G and i.MX SoCs.
It provides configuration and link state handling, operating on regmaps
supplied by platform-specific glue drivers.

> diff --git a/drivers/net/pcs/pcs-nxp-serdes-xpcs.c b/drivers/net/pcs/pcs-=
nxp-serdes-xpcs.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-nxp-serdes-xpcs.c
[ ... ]
> +static int nxp_serdes_xpcs_get_state_c37_sgmii(struct nxp_serdes_xpcs *x=
pcs,
> +					       unsigned int neg_mode,
> +					       struct phylink_link_state *state)
> +{
[ ... ]
> +	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
[ ... ]
> +	} else if (ret =3D=3D DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
> +		int speed, duplex;
> +
> +		state->link =3D true;
> +
> +		speed =3D nxp_serdes_xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
> +		if (speed < 0)
> +			return speed;
> +
> +		speed &=3D BMCR_SPEED100 | BMCR_SPEED1000;
> +		if (speed =3D=3D BMCR_SPEED1000)
> +			state->speed =3D SPEED_1000;
> +		else if (speed =3D=3D BMCR_SPEED100)
> +			state->speed =3D SPEED_100;
> +		else if (speed =3D=3D 0)
> +			state->speed =3D SPEED_10;
> +
> +		duplex =3D nxp_serdes_xpcs_read(xpcs, MDIO_MMD_VEND2,
> +					      MII_ADVERTISE);
> +		if (duplex < 0)
> +			return duplex;
> +
> +		if (duplex & ADVERTISE_1000XFULL)
> +			state->duplex =3D DUPLEX_FULL;
> +		else if (duplex & ADVERTISE_1000XHALF)
> +			state->duplex =3D DUPLEX_HALF;
> +
> +		nxp_serdes_xpcs_write(xpcs, MDIO_MMD_VEND2,
> +				      DW_VR_MII_AN_INTR_STS, 0);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does this code override a valid link-down status and clear the interrupt,
which could cause persistent link flaps?

In nxp_serdes_xpcs_get_state_c37_sgmii(), if the link is actually down=20
(DW_VR_MII_C37_ANSGM_SP_LNKSTS is clear) but AN completed=20
(DW_VR_MII_AN_STS_C37_ANCMPLT_INTR is set), this block forces state->link
to true and writes 0 to DW_VR_MII_AN_INTR_STS. The next poll might read 0
and report the link as down, creating an endless link flap.

Additionally, can the auto-negotiated duplex be resolved incorrectly here
by reading the local advertisement (MII_ADVERTISE) rather than the link
partner's ability?

[ ... ]
> +static void nxp_serdes_xpcs_link_up_usxgmii(struct nxp_serdes_xpcs *xpcs,
> +					    int speed)
> +{
[ ... ]
> +	ret =3D nxp_serdes_xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR,
> +				     DW_USXGMII_SS_MASK,
> +				     speed_sel | DW_USXGMII_FULL);

[Severity: High]
Does this regmap modification drop the DW_USXGMII_FULL configuration?

Looking at nxp_serdes_xpcs_link_up_usxgmii(), the code attempts to set the
duplex by passing DW_USXGMII_FULL to nxp_serdes_xpcs_modify().

However, DW_USXGMII_FULL is not included in DW_USXGMII_SS_MASK. Because
nxp_serdes_xpcs_modify() masks the target value with the provided mask,
the full-duplex configuration will be filtered out and never written to
the hardware.

[ ... ]
> +void nxp_serdes_xpcs_destroy(struct phylink_pcs *pcs)
> +{
> +	struct nxp_serdes_xpcs *xpcs =3D phylink_pcs_to_nxp_serdes_xpcs(pcs);
> +
> +	if (!xpcs)
> +		return;
> +
> +	kfree(xpcs);
> +}

[Severity: Medium]
Can this regression cause a panic due to evaluating container_of() before
checking for NULL?

In nxp_serdes_xpcs_destroy(), xpcs is extracted from pcs using
phylink_pcs_to_nxp_serdes_xpcs() which is a container_of() wrapper. If a
caller passes a NULL pcs pointer, container_of() will yield a negative
offset. This bypasses the if (!xpcs) check, resulting in kfree() being
called with an invalid pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D4
