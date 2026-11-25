Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599289;
	b=lh5lEkG5frun31XRL25/izJVSvmQ4SgdZGiBqMukp+HNZfZ7bHidW2G0+BmN1radvN44
	 PNnWnxjTpaCdpVc3zsYfSKsHxeWJ8VmpLSWibCdegw31rVDGLiF6qOCF3VKyUuUJZq9Gy
	 ZJJoon03Aco2QlpmU8BNP7kfUDsZEL2onYasRvhr7mRV4ResikfvwiXU1e9ivMb5utZRg
	 Er8q04XKTWsN8lkZJ6s3NvhMhHg9G2BuOlIL1+TkZt8aNQeHqg41hQ+iA53PoPAe/uLbN
	 Dx5Go4YfhZ0fEtN5IQwQfmZIHNLk6xYH/HUpazni8wweVit76jBg0xjyd4R291OazHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599289;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FPW2O/CZksG07s1KEeo2I5JR2fFDL0AqSEPRwnJ+rAw=;
	b=kG9GVb6x8JxoNrmqw28iCMhFZeZNXfADe9lvzQMJGxqrvvJTCjSJdSyQNQJtSC9lELFB
	 p0Mqo7QYsGi4b3Xynkb8aD6mjNZtpWkT977Fm/CAm3SRjD47RyDh7pTpns5klm9TzCw2J
	 GfhfcLz2dTR87sPXymN979DIxnfEfJEyPjoXNXxSBwVZ9EkSWeWMX8j6/S3d3yIYiSHzF
	 BJzCiitUNv/lIyMdyME7wJotG4fdca2ke0FD9qVRhhugHh3XV3lyHqquInutjIiIgEoYc
	 +4uPOORgg1FSHYalXbSi2Yr/KvxyYs2naeJ/+zAW3B6JLEBQK1g+5sCaB3PGFSCMIgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WClvNEeu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F65606A339;
	Wed, 25 Nov 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WClvNEeu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599288;
	b=F6sSTVMoPwAuetQzUHUeTV1YZHKOkTB4OZvHvoAAuJ65SfY71FtGcLN/0E1mxBXjFzsd
	 6TP2gy1SVNV/bsUVWTgApXdswjc8sSkc/BzExp5dD+pRZgg2gJ1lyHPfvP0Y4KRjcweww
	 RGk4QHJlfhjyPwxOjNC+K4N3IYMvXgwI/3GUNvIwTqyVmAY6yyhaFAfVVwY5gb8R1reKo
	 Djuf3lBOShUxEqfK+BNf1/GQ42+x6M35zvd1F1uMnESnQWndWczjfV0QZEisna895DjOJ
	 6EyNZvSrsQk5AucqvzBXwnNG7sxjjzKOV2zc4qsI1uFIvynVmyTqfDs0ArF59gJQykg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599288;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FPW2O/CZksG07s1KEeo2I5JR2fFDL0AqSEPRwnJ+rAw=;
	b=ABAyZ3YxknMTPTz+QL+MCbNcVh3oAlzL54tM8Vng7oFr73MTPAG6iQxDCyJmlSQX1yAj
	 GefpdTSelpfpngIEGIw/N8FJ7QKdDwZZlQJ28CsPTNcc43y5OxokvFKIvSibv2GhD7qQ2
	 qz7rwXEv4HuYufYIzZzjstnXAJ6V5aEBgJM9aOSrGvOYs6/SsD5yh08cH5lEXLnfHe3tO
	 U11AHC3q/lDT0sffH1ZBHucqH5SBthfDkYCB65sFW0sIdTztTYP5qDXK08wGCzG5ZubUu
	 sj4ju0BjvbvT4FX2/Zn2PcCjOYiX+vdNcOUAy70IpCkZSj6bzjC/iZgaOcMevVUqFgA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 369111F000D1;
	Wed, 25 Nov 2026 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599288;
	bh=FPW2O/CZksG07s1KEeo2I5JR2fFDL0AqSEPRwnJ+rAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WClvNEeu4R4e79Exo+1TmvDr1NaEyRokfzKKYRko5BeGZjUKilF2+PWME/pL2QO7a
	 nFBc/8fjkeemYy+Yvmuo5FNPX6Nz9f7vM39XsjGL6jGtwKfLLWeKnQxblHnFFj718P
	 6vhA8WZk0S42AVOVYfoDZzKoJEFcQFwqRsgaoeUzNL6m9bicI0KEVsh3JK3Q1nQG+2
	 bhsUwBnNx91euH+WHS2E+812zGXTGqAxsR0weY/tRiBycwSRBwNU8wVzfAne5e7C0O
	 fXdvPj+9NZyypAvkNbWlA8hvXIJAa60gq7Gn4xzWhn8XcHFYVjTHikYaM3UCRed9FP
	 ufJR9/aOwKwVQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B4BFD4CDFE;
	Wed, 25 Nov 2026 09:34:36 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 25 Nov 2026 10:33:46 +0100
Subject: [PATCH RFC v4 04/15] net: pcs: xpcs: allow a PCS to opt out of
 soft reset and EEE
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
Message-Id: <20261125-s32g_serdes-v4-4-3bfe0589be8d@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795599274; l=2142;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=XscJymCuOoPX6VkV4O1nIKYSBnUzCtjWiHRRdPqdbMk=;
 b=iE2FYHKkZBcU6n24n7zNpgnccWxNcvMAikDlY+jLN6198179BHbRw1XeT2teHMY9FSK6wFUv8
 dIL2U1KySspC9q2iEtKQHhV1fidG8GKop8Oba4PFSWj7J2idWFs6aFx
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
Content-Transfer-Encoding: 7bit

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Add a quirks mask to struct dw_xpcs_desc, with two flags:

 - DW_XPCS_QUIRK_NO_SOFT_RESET: no soft reset in pcs_pre_config(). When
   the XPCS shares its PMA with another controller, the reset belongs
   to a bring-up sequence owned by the platform.

 - DW_XPCS_QUIRK_NO_EEE: VR_MII_EEE_MCTRL0/1 are not implemented and
   must not be written.

No entry sets a quirk yet, so there is no functional change.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/pcs/pcs-xpcs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 6466e0ff2a98..442c64a731b7 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -158,10 +158,20 @@ struct dw_xpcs_compat {
 	int (*pma_config)(struct dw_xpcs *xpcs);
 };
 
+/*
+ * The integration owns the PCS reset sequence: skip the soft reset in
+ * pcs_pre_config(). Only for PCS without Clause 73, whose fault recovery
+ * still resets.
+ */
+#define DW_XPCS_QUIRK_NO_SOFT_RESET	BIT(0)
+/* VR_MII_EEE_MCTRL0/1 are not implemented */
+#define DW_XPCS_QUIRK_NO_EEE		BIT(1)
+
 struct dw_xpcs_desc {
 	u32 id;
 	u32 mask;
 	const struct dw_xpcs_compat *compat;
+	unsigned int quirks;
 };
 
 static const struct dw_xpcs_compat *
@@ -729,6 +739,9 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
 			ERR_PTR(ret));
 
+	if (xpcs->desc->quirks & DW_XPCS_QUIRK_NO_SOFT_RESET)
+		xpcs->need_reset = false;
+
 	if (!xpcs->need_reset)
 		return;
 
@@ -1318,6 +1331,9 @@ static void xpcs_disable_eee(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
+	if (xpcs->desc->quirks & DW_XPCS_QUIRK_NO_EEE)
+		return;
+
 	xpcs_config_eee(xpcs, false);
 }
 
@@ -1325,6 +1341,9 @@ static void xpcs_enable_eee(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
+	if (xpcs->desc->quirks & DW_XPCS_QUIRK_NO_EEE)
+		return;
+
 	xpcs_config_eee(xpcs, true);
 }
 

-- 
2.55.0


