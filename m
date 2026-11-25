Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599299;
	b=ju5IOjnKzEe2byUAmE1uczFhC1cgjNAUU4R7uDYB6tmm09bbMph5esIQHnLFBMcyTuhR
	 KxJEYVTYLAVpryUNOP/WXJ7ay75z3t9AgcjFuD5C8mxtFkbjF45UuHwhfljbz12O/vh9e
	 r0YnsCHSF1SebpQklXp092zHAyuBlOaVLKBGfREjKYDj4yfIRSax719PZaZ1JxYzl+kfz
	 0XpvW88cQ/HIpdjts5zR88NCIfOjrH0OZOZJXEFnoZIv14Va7e55O9LZz0qq08Leje0UI
	 qsz9oFOmYSTFFYYLk1QF1cKX9KLwBMnWzqvTaDLbEU1g4WynV0GJ/KsvRGbWyAe1Tag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599299;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OizX0GEGMtRj2zTT93NEvb3rPCNKl/7VelBBlD1SYwU=;
	b=Use87t//Gp2oWQyniRBNcUhH/lbZK877Xi5xbkyy8mnvAyxSjSw4U/cjt4BlXO0m8sid
	 WtsULj0nY+KzWyY2rtbpcMmjxXU5l+iqDG0QH4VZXr7IK1Xcymzxc0bPu+NcFYvnfhLX2
	 rDBaU21btUEl0UUTS0fmnuWc+fAW8gcX7WTDaSMs9CSjW08wxYr5hecGJlx4vg/HuDLtr
	 grZOWVbyZg5HvwUL96wQjzFq6X7m2qUAzXw6Pr/CCl6YlcH4F3EIdShut4+HXFo1dve2N
	 YdwoBs6ZIPzhCqFEbzk79QrQ+Hs45pnul0V1M6GYK20zXY2xAI8oFYjx+EnlnhOigiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yoj3lmM9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027C760A2613;
	Wed, 25 Nov 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yoj3lmM9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599298;
	b=OkK9Tix9ovUFL0vOht156TFa1kDSucyMfyj8XedGIfzImY1/lEiPQCQ1c+Azdia8u4Xm
	 aS5A/tK8jVwfnoG46dumcHv8wxfc5Rj9HLjIQJ/CEXLqyfdSwavmBeKoZmgoiyOpUsjmw
	 RhyQLi+n+qVJpWw+jL6FSl7NNRX5beoKdOvAu5Gzu5lZgBX1qAATK+jq5SB+aJjA898on
	 EmMYAJkZhicowY1+Vk8SAo+qrwHS9d8lmZcs6Iuw+p+SochodPt+gIB975VsM+Q4PQOAR
	 +6oQmmTFPY7wTmZmNIbcf5MtOeIvrgmFkWHuhk0N3wZjzEIPMiA6ZMntfMJV9owAA8w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599298;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OizX0GEGMtRj2zTT93NEvb3rPCNKl/7VelBBlD1SYwU=;
	b=hcPEPbFw1jV3AkVoOfgOG5DGCUpZ15biaIWzygkRTs8rmnNtKexRb/Fb37gJOhDSPJLS
	 SC9d2bZM2vuoGgbwMocH04aa+nOmL2X2GtSaOOWKpZQGlv6DRzCBZ9051aKKpYPG5RGr5
	 E3WOIEM7kRy3rgrcO+U5QUzTrQoh7HKJyoLFkV8SVIqKfFqFXpB5DFXRgzeoDCeX4rWns
	 bGnJgUCXQwMTNf4SQCCwaV8cthpClEydE4fFtk+rUsqDkJGhYa/rMVNeEOq8FtjighOBF
	 ZxAV8TIQxvLsfrH8GL/WNav2mFT62PkgS8LoJhaSL+iGwm5BBTO+1XLWMynU0LBMaIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A7551F000EC;
	Wed, 25 Nov 2026 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599298;
	bh=OizX0GEGMtRj2zTT93NEvb3rPCNKl/7VelBBlD1SYwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Yoj3lmM9lcF7WN+6xOpKoE4qN3JZa2mFI/S6OuaHPPnwKCIWUEoV6kEbo+m5EvHzE
	 7KECvUSjLLuTT/g0t/m5jh1lHqoAgu9jyz3bkuIHzDAIhfXdhVy6yrIpLE87MuZhQX
	 TVASuT8PT0OAEHGoWJb55nhSJ7TfUx+Zxn3dIiRB8BqWsOZZXxCSfCCoMkeAyp2fwY
	 x2XuniuRyXwUf3hQltQ8kvSHMiQtJ6xA5OSurP+ies+1Mk0NYAt4qOehMpYYmKk9jV
	 zdwAnMbOe7oIkV9gRDkwVGUEdMN4fBk4GRYLf8jgyEXovf5lFD4llO4o1LZBO57ncE
	 LhHa42on8pViQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 24E864CE0A;
	Wed, 25 Nov 2026 09:34:37 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 25 Nov 2026 10:33:49 +0100
Subject: [PATCH RFC v4 07/15] net: pcs: xpcs: wait for SGMII AN to complete
 in-band
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-s32g_serdes-v4-7-3bfe0589be8d@oss.nxp.com>
References: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
In-Reply-To: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, 
 Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795599274; l=2657;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=/xyLv2QCrquyhEtexeBz8mg+SBUqNG1P5gZP4XIM2r4=;
 b=erl2TTTSecbJtEkEGUMEMricIBexirLTsD7OwLnWEjO8pXSKjC8hxqv0KmBe/qhRnG4Ip/J7k
 DsP0e/gxl52Acql2yks2XJ/rpswNxCSV2gIa1tzkf6Pa5k+FLFiszGP
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
Content-Transfer-Encoding: 7bit

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

With in-band SGMII, the S32G XPCS keeps the previous SGMII link word in
VR_MII_AN_INTR_STS until the next negotiation completes, so phylink can
latch a stale speed after the link partner changes speed.

Add DW_XPCS_QUIRK_SGMII_WAIT_AN: with in-band negotiation enabled,
report the link down until BMSR reports AN complete. Set it for S32G
only.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/pcs/pcs-xpcs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 71e5882f4b0b..65597c2d7a89 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -166,6 +166,11 @@ struct dw_xpcs_compat {
 #define DW_XPCS_QUIRK_NO_SOFT_RESET	BIT(0)
 /* VR_MII_EEE_MCTRL0/1 are not implemented */
 #define DW_XPCS_QUIRK_NO_EEE		BIT(1)
+/*
+ * With in-band SGMII, VR_MII_AN_INTR_STS keeps the previous SGMII word until
+ * the next negotiation completes; only trust it once BMSR reports AN complete
+ */
+#define DW_XPCS_QUIRK_SGMII_WAIT_AN	BIT(2)
 
 struct dw_xpcs_desc {
 	u32 id;
@@ -1081,6 +1086,7 @@ static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
 }
 
 static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
+				    unsigned int neg_mode,
 				    struct phylink_link_state *state)
 {
 	int ret;
@@ -1092,6 +1098,16 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	state->duplex = DUPLEX_UNKNOWN;
 	state->pause = 0;
 
+	if (xpcs->desc->quirks & DW_XPCS_QUIRK_SGMII_WAIT_AN &&
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMSR);
+		if (ret < 0)
+			return ret;
+
+		if (!(ret & BMSR_ANEGCOMPLETE))
+			return 0;
+	}
+
 	/* For C37 SGMII mode, we check DW_VR_MII_AN_INTR_STS for link
 	 * status, speed and duplex.
 	 */
@@ -1218,7 +1234,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				"xpcs_get_state_c73", ERR_PTR(ret));
 		break;
 	case DW_AN_C37_SGMII:
-		ret = xpcs_get_state_c37_sgmii(xpcs, state);
+		ret = xpcs_get_state_c37_sgmii(xpcs, neg_mode, state);
 		if (ret)
 			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
 				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));
@@ -1535,7 +1551,8 @@ static const struct dw_xpcs_desc xpcs_desc_list[] = {
 		.mask = DW_XPCS_ID_MASK,
 		.pma = NXP_S32G_XPCS_PMA_ID,
 		.compat = nxp_s32g_xpcs_compat,
-		.quirks = DW_XPCS_QUIRK_NO_SOFT_RESET | DW_XPCS_QUIRK_NO_EEE,
+		.quirks = DW_XPCS_QUIRK_NO_SOFT_RESET | DW_XPCS_QUIRK_NO_EEE |
+			  DW_XPCS_QUIRK_SGMII_WAIT_AN,
 	},
 };
 

-- 
2.55.0


