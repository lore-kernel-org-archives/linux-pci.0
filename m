Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FAD5519A4;
	Tue,  8 Sep 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879130; cv=none; b=ndtSfQH17oQmfIJNkyA1k6oCGnUkJP45DttfeozrjU42nRVtL9DxiKtpJU8NfO26uVFMjAOhNGdAOpGp7J2QVY5jNDXf1H7r/BGj+CGqfW+iD1Hl6uON9YcWFsYmVJpaMlXumdM3DXAAWVRajpHZvDyX1hNP6QKe6kj8lOoINl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879130; c=relaxed/simple;
	bh=L4M7hLiRxDRX1JjACPykw3mztl3t/GK4QMLCwWFrxIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMGReHmp2SEm0IzBirOYecUd0/+vYI5ANyT0rYDGBRFOORDM/m41DErJTagP2NUntkDXpvOSIdJaTC5LUHdNJ8rv4oQFq/7V9FOJaM7K5q5kMlaw1zwJSrww9/wHpQciN7a60kY/T4oum/7yr1TtTmZGA5nEeMkDlCQg10cw0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kW0ee1qC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kW0ee1qC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=L4M7hLiRxDRX1JjACPykw3mztl3t/GK4QMLCwWFrxIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kW0ee1qC0mWQjAr1zWej6iBHaL/pedHxs0MoPFbMbpp7UHet1M/me8w/7ikqnvwio
	 OfFPrVq+Eb7Bce+wUGuP6RlreC5vX7HV/Hxazj4uin98eiYsZelg+EAGSdSMGG19kv
	 MCEBdfZmGusea7/XGt7YQKccST+LYlBcWfbPOmJG1fuGvih8yf10Bll8Wd4hxEuHWG
	 8P6AfXMxKDZ5LD5xymYcGdszsoMH0CU7gNdH+S1L5LVVWJjQ75CmAFxK5gacYkJoTz
	 wL+gOEHyuDaS+42xwy77K5QK2UoOCz/3BsE7N1pi1nmbTp2Nhh3Lo4yr8F5ZD1SeIr
	 PN9XAbud11iyw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C67E17E0D81;
	Tue, 08 Sep 2026 16:51:41 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 979CA48003A; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:25 +0200
Subject: [PATCH v6 07/10] PCI: dw-rockchip: Add pme_turn_off support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-7-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=L4M7hLiRxDRX1JjACPykw3mztl3t/GK4QMLCwWFrxIo=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPwONPLCUoy4DvvoogqBm9II90BbJz5ht
 eejLik2EOCWKYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qaGZQP+gOurxzOFdXPQH/FppuFVPfAZBUWPfQAUq/RHhR7nlu/RavTNBh/+wmJnox+7OcVRm4
 IpCPBVCl6o0sXgL5myrdgqw8EyUIwyvcX9PSAQ0tBM+F2bdW9FOB4tDwtwI+kt/4w7j97QZdWlB
 O6Nf6na/zPD4q4V93PqLTQC07pczGYcXRo08398LQU8kTFETitEm/X3KTLl2mZSbAMsZAjKTyvA
 ZaTVaL/KBXEWLlsbC9UzhCPquLIjvhO/epJCiUc3LPNOJN1g6PFBz5llnyEIn+g+u9+j1hiLjXx
 JSV92CfOxYxiODNfSY3ZqTiPBgTwVj6BV/jlwkEXzJ+Spxi1yFnLcXi8RNfvNzYhuOaqxbsZwLI
 FiB9366KJiii4d4KNdP25wgnWhRt7ZRJAVME3Tt1RMzXSq462vWVb8c/yM4rhTITMc3abgYfjfi
 I6834iZKidFeqelUf3Z/LeYEbnzNWtM4FcJyxC8ShTvSyso+VgJir8+SHfdk5QJvhSocyNzt0RX
 AiewwJfk7FyPrGdkr13fNqRcfldOTP9TddhpnZ9aUrpCvqWVNqaOzwvH+zNtz4Ekfld7t2XtZLP
 LLRUrKEl91b2pqck+Xdh8R0W8SCTb68aGa4CwgjyqrHQQ6Qjf34PZ2kF2jGwuUpN9r7ZYKFjqlE
 WZCE/bMJ/ugNr3eB9PV4zcg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Prepare Rockchip PCIe controller for system suspend support by
adding the PME turn off operation.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1e48099e36e4..17530507e41b 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -45,6 +45,7 @@
 #define  PCIE_CLIENT_LD_RQ_RST_GRT	FIELD_PREP_WM16(BIT(3), 1)
 #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
 #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
 
 /* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
@@ -64,6 +65,11 @@
 
 /* Interrupt Mask Register Related to Miscellaneous Operation */
 #define PCIE_CLIENT_INTR_MASK_MISC	0x24
+#define PCIE_CLIENT_POWER		0x2c
+#define PCIE_CLIENT_MSG_GEN		0x34
+#define PME_READY_ENTER_L23		BIT(3)
+#define PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
+#define PME_TO_ACK			FIELD_PREP_WM16(BIT(9), 1)
 
 /* Power Management Control Register */
 #define PCIE_CLIENT_POWER_CON		0x2c
@@ -452,8 +458,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
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
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER,
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

