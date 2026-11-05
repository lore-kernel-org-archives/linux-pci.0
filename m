Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885596;
	b=VszDtG8QN0dfKUnR4oiukoa65T7r2ILe/gD+vhlp2CgrPfchOdudbEHtAe6wzn/XlPtw
	 lPQmKgvFLcuKzuzz6+6u1S5zLmyGbeVpp2IguBLtNVItDxpwofOM6/1dDZkYQgrH2F7Lq
	 0GyHN9H1QSAcHpofOz7LOsLYLfBxkuF2d6dilZ4MnTasilbjCriMe9Evg2GOu3AIA/WI6
	 DL8QIZNoNpsC2v71aZ39DDQQeGCCKt95mCKFIJ+dgn2yyogf1Ws1RQ4xORqaV/p5CoyLH
	 vqDBkUp2CrACgoblpgRv+UG/YG+fTNT3Sn6ktPQFXlobEkKUcIJla7TU4GnOMM8HGyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885596;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XA2MACvdwjYjMWDGZCzFIel+dC9w9QelP0SCpke7IM8=;
	b=K3UvYPpyWueraovRtzG9ZLaLtpspdxaRVWPuvZ5Sc4ZAodPlvAL+eopmfSsz1xs8aQdt
	 xpOk0uo8qoxrI2WOSSwYWSHUgMc89jA8RGYS/z25/UvMXMva2ueUllke28ljd650wUOoJ
	 m2NWyeDDeQkpht15B8pzTVy9FAKSsquR1+MnC7ajloiwhT7wJVL/kqkSaKd24+W2puVtx
	 0A+JNJ175dSXoi6RtcJ0XdIRe8bTrGBiOSeOdHL7bROOhTm1Bd2xPz02sOtApsYzQFfGS
	 mmiHIntEwNPBzeebLqyF0mZTti3rF8ieDfTwblVqAaRyJbZS5FS+paC9tLhfl9qW9XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=IsEmX5RW;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6107606D816;
	Thu,  5 Nov 2026 13:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6107606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=IsEmX5RW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=Zuu47c5Rl5LpijQfd0h428pfqqmH6gW6BuU2h4/pz4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IsEmX5RWnl7+GxAeuG6RfWFlhJGJixQLnvJjaMlith2w1fRs0oNX5loFOvk0Hl73K
	 MUvmskG19d6qT0qS5lDKbkmnBlq2oj4Ei34CZNOuHXg90rYPL2Yxjt9rX9iYgkFzWj
	 5GRckTZPDgn2QrKzhLnrPLODy6zNVypPBO3HyxSY8Glka+MAsCp2I4i6QI8MkZjm7J
	 A109Sr24KpWwUgv17inikvIeI/wY1pR0cf21z1FSJy3f7GzMfivGAz4VLhbUOkaCX1
	 N9sbxJLap+yH8Dem5uKuqxSQmd9VKv8APeGIvU1RzFKo0T6NnW8l4kDWNN7cq0d0ub
	 462cdJHOvw29Q==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9897D17E0C18;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EC97648003A; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:15 +0100
Subject: [PATCH v9 7/9] PCI: dw-rockchip: Add pme_turn_off support
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-7-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Zuu47c5Rl5LpijQfd0h428pfqqmH6gW6BuU2h4/pz4A=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZYw8YNoXWbCm5k9W3bBXqoP1EG7nVnn0
 UthRW0K3YPCtokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qaAnAP/RTmEXV+YSygiU4hYFEqUXwXbIfHoHC5JgBBrDccFfAsKgXPPGJuyz/NyzCwZhFPGVl
 DkdSK2tPwmhRVaQ7OhYSRukbHQ77g0OAU0U+BppXMVKnfFxcZVAEfo0yf7mDwtaLULskpBpJnh9
 w7glBFZ/QmLDAkF2InaEp48NPsYLcBH5fYnal2cb7yDSUbZx+DljSe1eZk4i/y+/nbU7Lr8vq59
 PZMRrOcOjTmsfhHObdmNLRy9VrKYot4/hTPmFswNEqe12TCkL56WdBADZuydX5PjSYsFVBHaxSF
 /EtdENvvRYSXgPpBhRnBkhRxLu3S+ZVjuIN9nTymajeRJarF64xDd/TayEV7HFq+NYS9m844NMd
 paCUXQrWKHrN4qUVYZAp8XfCHVHcuQBoo2+JewfrvZxzG5WcBC30eZZSNYZ0holpnjMqUNh6Xst
 N+5b24SH8zzKPPo3zpPvINQ+K1CkLYCvLcet7b1t3I5psFgNyahPa0gfcJMCyhbqmSVli2NcKiT
 AWkpPAKoxsVYBhOWvRJ+zKmjV3xZ2eniKDd3lqGwQe+uwBmOfFOpF5fwSYiuchMCyHbiwDd2zfH
 4nD50o/4DrWPktiTs69y2gMgj/CEmBW5Ont8SCOFBCrizWcKsYrKT5Q4R588u+4trM+0M+Nua4z
 wNQ6AJ0BWU9meVX17Dyou8g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Prepare Rockchip PCIe controller for system suspend support by
adding the PME turn off operation.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index b4f53ce86079..d8968743732c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -47,6 +47,10 @@
 #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
 #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
 
+/* Interrupt Status Register for Received Messages */
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
+#define  PME_TO_ACK			BIT(9)
+
 /* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
 
@@ -71,6 +75,11 @@
 #define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
 #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
 #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
+#define  PME_READY_ENTER_L23		BIT(3)
+
+/* Message Request Register */
+#define PCIE_CLIENT_MSG_GEN		0x34
+#define  PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
 
 /* RASDES TBA information */
 #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
@@ -439,8 +448,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct device *dev = rockchip->pci.dev;
+	u32 status;
+	int ret;
+
+	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
+	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
+				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret) {
+		dev_warn(dev, "Failed to send PME_Turn_Off\n");
+		return;
+	}
+
+	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
+				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret) {
+		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
+		return;
+	}
+
+	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
+	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER_CON,
+				 status, status & PME_READY_ENTER_L23,
+				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret)
+		dev_err(dev, "Failed to get ready to enter L23 message\n");
+}
+
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
 	.init = rockchip_pcie_host_init,
+	.pme_turn_off = rockchip_pcie_pme_turn_off,
 };
 
 /*

-- 
2.53.0

