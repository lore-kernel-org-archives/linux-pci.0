Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663733EDABE;
	Mon, 16 Mar 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688265; cv=none; b=fKJSXgabR0KfJ6rFwxxqU9ygtkYEqNVOkYuVaRjgGqUM8pYPl28afZRb3m/al2eFxxAfI96r1w6fk/O9jbTjLUmbd5+oHllDIy0Dq/kkDdI2W4P0N10k98pGWqU+ZvaS20x0bi392vRuxPhyY/qSY/42UUkfAYfj3KAk+lko/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688265; c=relaxed/simple;
	bh=cc8ocOs4WP7lCWUMJwF/hXBI0/GUSTf6xdSHBRSav84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTukqMS/KuEuRQg7KNOGtCvsy8KcKWizhvqHt38J+uRjdl50T8wqqWIPnoZZEvNGuklD7wKHhNK1sRH8qiYfzS5WItb/YWFAoJiPMWwJh8eQF15i9ZphV0E3ksRCWZu/pkXWogcbJVxBHoN0PBmb694OjqlzffPMQfjqUGgdCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iPAkY3Fb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iPAkY3Fb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773688259;
	bh=cc8ocOs4WP7lCWUMJwF/hXBI0/GUSTf6xdSHBRSav84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iPAkY3Fb7jl92zzJPZwPA7QM4y+eA5et60E9A6TWfwtAillBqsvCWHdY4/OAaU1wH
	 3LjOREheyE0uEr1NX1qPCPNmE0qrvIfn9nhV2XBtwEqdM1rdFwU34xEDQdeDG7XSmq
	 Z2iSobr0bPZCsmmycqCSTgCybfy2Cl3c+ht2HpiWesn3poPiCdwqs5CsOd1oEfNQcg
	 5eaYcC+ZBDTUMxoKmb4ihUUPwLlXJ0x8jdZ0JF3DyZH3EC/quIF11xZzSE6DOdQvnI
	 j9qdawDm7YezrbBEJgEE+Kzu/1SIMZJ+4CP3nh8dGZfssGdyN/l1TaBDI6WXwiV4Y8
	 wCGr87DvtwkjQ==
Received: from jupiter.universe (dyndsl-091-248-189-119.ewe-ip-backbone.de [91.248.189.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3992617E1513;
	Mon, 16 Mar 2026 20:10:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A090C480030; Mon, 16 Mar 2026 20:10:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 16 Mar 2026 20:10:50 +0100
Subject: [PATCH v5 6/8] PCI: dw-rockchip: Add pme_turn_off support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-rockchip-pcie-system-suspend-v5-6-5bb5ad37d643@collabora.com>
References: <20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com>
In-Reply-To: <20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=cc8ocOs4WP7lCWUMJwF/hXBI0/GUSTf6xdSHBRSav84=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGm4VcI/Q/Cle+MYuTYA1G+cbzOBb6T4b+953
 +du9qpYYfH0/4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpuFXCAAoJENju1/PI
 O/qaofoP/jUXEx0aC9VDXf+iOx9ONBxh6HwSYnMnLLtbTGDtEcBBuGm2xKy6zBB0jfpmwEEzm4c
 4+43KJz8N0psbeIAdpxzhJnUNZXknNgwrtKZ0k1g8eBN0boeFzErKKgJtNrOZrF2TQZY9yh8TDw
 dY75MxKvvZh/8T9/cTBkYH00s2Z9IHBxDcmqbA7Zt8uLLhcnWXp6GdBIwc+iozESBmDLaMT8el0
 M+AvWK743B0X64+Ozj7Jaoco1UQgypw9Ywepcuvd1N0qrpz8auV41TVQHEsCywRlu52NbLJwnuW
 v4pLpoGl3JfIG9CuVZVlcHZLd15TYEpWuDFV2CCjjRlgHrVtZOHE8kwzBN4rm3WP0dh3EQ01EUL
 ikU0TM4/6m9tkWkoB8FsmyeLiYJv1pwUc2j2sDhcoZRgSPy30bpcSmB+0rvVIpvNoFF11OyjwVl
 Kn7Gpdpg69eqXGYLLHICilscFbpqp9sVcFC2eORMKdmIwUETfFcXiVz5HJIoIsEeZn+Pd3+3z9Y
 Kp8O6Yg3JP7RjiNRrojlkNXdYokc8NS1p/zSK7wBFsDs36BxeNxzFNLwJuNntHSpgdxEKwO3Uhi
 fpq5ifKIYx3puPXOydYJJ/4KQtCQ6XHG8B+DXY/QptUJOS8muwbsa1Rx53TLb4i94o7jIcDI5uh
 +E94+RVZx6+xZ+RivoM4rgw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Prepare Rockchip PCIe controller for system suspend support by
adding the PME turn off operation.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 8cb0040b4ae1..147add66db15 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -42,6 +42,7 @@
 #define  PCIE_CLIENT_LD_RQ_RST_GRT	FIELD_PREP_WM16(BIT(3), 1)
 #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
 #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
 
 /* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
@@ -61,6 +62,11 @@
 
 /* Interrupt Mask Register Related to Miscellaneous Operation */
 #define PCIE_CLIENT_INTR_MASK_MISC	0x24
+#define PCIE_CLIENT_POWER		0x2c
+#define PCIE_CLIENT_MSG_GEN		0x34
+#define PME_READY_ENTER_L23		BIT(3)
+#define PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
+#define PME_TO_ACK			FIELD_PREP_WM16(BIT(9), 1)
 
 /* Power Management Control Register */
 #define PCIE_CLIENT_POWER_CON		0x2c
@@ -334,8 +340,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
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
2.51.0

