Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818612;
	b=hIpJnSFrZw/ZtqPmTS76KVj5eNs3h6fo/nLKGcKMhdqSEoxb8IhpAmbveh2Xd/g6vvPp
	 DkVsox0j272U7qm9CpvxedUSKyWv2DfkyPquWMpx0z/GiXSu+sJoNWFf5vX2heHxvWTp/
	 dmtP3NKsn4a7Wh3KuJsI4RoM2dH8DPjBYIyB6p/3tdq+2P13AOLWYCJtNgMiHFOsYCQqF
	 IU6saS+E6sJXWGO2GMUUAXr6b2u5NaxjiTHbjVwxz1RqcmUotul5I/lSHAMJ2PEzNeda5
	 KdWflIyndSM+w2gJpiHSWWRD2whFXklja8Ybji2iCTqsgRKMwpVCbLaW6DyN3eyImSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818612;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=m+vlvrL2rWoCh47HTFHu8BLuoyQYkI1t1nnv7ELVH80=;
	b=KyBD9f3EfnAvpKyOhRgZ+AZXe+yYdN68KjsWmmp7Kpua4nFpNJTmffw1CZMkrTjksYVq
	 tikDK1Jj8gAfOvTceH8BeNlu1FXqfMBvvg1Rv7DFSMMXxTsSKjyNUflkO0hYnX1V6t7Jt
	 +dAu0nYBaaFf216zonFd+HQW9fZLyD5lTFbVUb3N6lwZVhvek3HtbR4mLsPn4cJcJJswF
	 2XeZ8uL0LIK1fM+EXM7jWM52lDrJ3urG6MefjIfKifDQGD+s+4gbH5y8xdfXJCz+JiLUT
	 q9SEyjON/sUwGcAzEVTVTHeAF+ciMfOYhxqJxp9x4XpivRZ5C4TauqXY79+556x4m3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=SFrBic4t;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C57606EEAC;
	Wed,  4 Nov 2026 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C57606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=SFrBic4t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=GczlrlSFkHiqrrX9Y3QEUwY7ZHJWrJRujiffW61qc0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SFrBic4t1eXyGx+5C6OuUWS0cTNtTdxhuMiuef0fPcrf/A4aBCjSo7ohuNJHV5Oi7
	 9PZ2VM51CgjZSd6BZ/RmMhnCDqLgjZdZOOUl75sVNaun7OJl8nH0LdzJAfime8ryQ8
	 UMQX1RWSvTpsKSXAn2/DjnzlPqxATQVf7khhbcyzJeJZw7EHE0mwSP30KlJMrlMNpr
	 N6QeTMXbIE82/2c6CfCxE/spYc0mZD+nd8DcxN9wtI9r9Wg90+wFXB6Qsg2LHj4SkW
	 SG7eg4qgKZhj8EprrOdPxqA7th/Wsqsc5FYQ/PGhOVgVnvtAimQ8Ji1gNrhUp0tuSt
	 F7dXL9Pgde7fg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 800C317E0D5D;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DE14E48003A; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:45 +0100
Subject: [PATCH v7 07/10] PCI: dw-rockchip: Add pme_turn_off support
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-7-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3089;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=GczlrlSFkHiqrrX9Y3QEUwY7ZHJWrJRujiffW61qc0U=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+gDBSftcDt0P5H30RR+S7GTqENWYtMho
 ys28ohmI673VYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qaUjQP/A+Vxv1HvRzfFOQK4QrH+eydQJky/u71WFdEcC43tVCwZ34gtuqzeGKRKUijzBqYDzg
 QaEXuQ1LNhGLxH4FbS31EgeQVp//+hjQjX8IBfq6PncFTCI2uM2ttY9SxujYDQQkeYBr2IQaTdJ
 z6/uw6DcX4nbpifW8ZT1tBJO4pAtvy4soTiZJ4qXKGc1PDNdgrMtXfGKffstrtu9gf9iIZXGmsL
 xtaj7PJ7wm9xyvKkwJAtBlBN2iODpMB4bvHO4PYvD4GrKtOuPM1cfVXp7YoGCeb2QUY04oMAAQr
 6efMCb3JqJyMlAWUQ87cUfIIkhZcx5YjJ3SNVKuA1O8AJJhx3sosEqYcE4ymJdxGAb7VPKrzFMx
 xcvk6/h9uCLAqhxR5UoGTxzosYbwgTWJyaFbvqf3iuPM30PZIiBd4sytgUHH2tVP66WSStV4Abl
 4wL1tkph1DkhikKuV7OvJu8JFqe9o6nS42CTzq9tIerzcfc4wXidIeh5F9/T1yg4WkjBU3DWGeI
 aCy0cFsMdrXQCVdoSStp4ZmUZPUgoDJTKJsIODYxdUVjizR3TUx1Y7EagL5UWAmYt9/naprvY5I
 Y23Q6v6rnMd3sYR1T2iedxWAr25V8m/L2Z0qkf0LIlR3QMhWiMRNkPclxvUC3IOU/NvMtvimlqW
 +xLo1T8ZZcZLV3pwxy0Aujg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Prepare Rockchip PCIe controller for system suspend support by
adding the PME turn off operation.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f089dab4acf0..417e6fbbfe09 100644
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

