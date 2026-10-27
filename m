Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.131.191.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087749;
	b=YA8uKlpLCLR+p0RSmTD3qPQDd8JiDgWVhum7y/HUrnCdklOD5Lm2+XY61W8r5YeIBmWp
	 Vh1sHM/0XbqlZpLmXbu6ce4Y3JE/nkru8LSR5gWpjAkzvyMbSKcL/SOvcRUb/vGTYvqPL
	 i0N47d5TA/JF2KF1k+vp5Dc2qVz8V9tZ9nf1F8I7abI1fygofbT/8PYMxOJ2RlHkn+fUf
	 8nWwrwTzHidD7JL48CJsdqRKv25vgvQ5uWro55bZjrJKuRpQpvRxq0c5bEF3nxeOcxTJ+
	 EwyyEiIjdJsKgkw4XIoevdygLxZlHorm2Q8rkQwPTyBPe4Axl+GD4pXcWrFSldxmKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087749;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=mNQ1WjZEAeSXGXCl7Be8gGrg5RDOiHSk+NlohDHDsdo=;
	b=S7Z+sp4as58sNwbv3JqidCzmKOxXh5G6FZGMQVXXJ2DhHCQmJ4sbIG5TqiGJavi7lWOl
	 I3L1ancOhBQcZJJGwBTalE5ua+39Mo1tNVdDiG2Sp8DW8mUaZZtco2RyKx6eIEAthn54X
	 CAD2USnKjDkVLKMRo/QYGKlvU+wEeTlNKAVagB5Np9yGbxeC2st2CvWuMQER8IbkS/kFX
	 CxR7/avbfnTkxJB/t7PcYvis3TaHs34pO6/mPh8PZ93g5QKgJ1c3nFyx1hAvjscpzGcGt
	 wVQHNEjnK4CBmWop4LZ670wKwaGM/ICkcmW12S4I2lGMjEsIYkrXdu27YifBCr1aJvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=BLUzfvVE;
	arc=none smtp.remote-ip=103.131.191.58
Received: from mail-m10313119158.xmail.ntesmail.com (mail-m10313119158.xmail.ntesmail.com [103.131.191.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4B606A321
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 07:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD4B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=BLUzfvVE
Received: from localhost.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 527d681e8;
	Tue, 27 Oct 2026 15:55:36 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: dw-rockchip: Power on devices below the RC using pwrctrl
Date: Tue, 27 Oct 2026 15:55:19 +0800
Message-Id: <20261027075520.3591049-2-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261027075520.3591049-1-shawn.lin@rock-chips.com>
References: <20261027075520.3591049-1-shawn.lin@rock-chips.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17c5b8a3e03a4kunmefbf004c4b829f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUIeVkIZGU9PSx1JHxodQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BLUzfvVERZkOuAuadGQs/tf1RfnceYz5oc17HpQO5mMrOEY9oDptqOr0ZSAKLMlUTI4CLD18EdrYqZGp7/akBQyTQorBbwXCxRiOO0ps/Wcr6U0ILDiLH5+1uDGvcrS0ww9OSjU893ANevtS0saoYCUgHHBupEu7vxg/F6028Ig=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=mNQ1WjZEAeSXGXCl7Be8gGrg5RDOiHSk+NlohDHDsdo=;
	h=date:mime-version:subject:message-id:from;

Devices below the Rockchip PCIe host controller may need resources
(regulators, clocks) enabled before they can be detected on the bus. So
far the driver only enabled a single vpcie3v3 supply described by the
controller node itself, which cannot express per-device or per-slot
supplies.

Use the PCI pwrctrl framework: before initializing the PHY, create the
pwrctrl devices for the DT nodes below the controller and power them on.
The supplies of the slot must be up before PHY init, so this has to run
ahead of rockchip_pcie_phy_init().

The controller node supply is kept for backward compatibility: boards
that still describe vpcie3v3 on the controller keep working, and boards
that move the supply into a child node get it enabled by pwrctrl.

Only the RC mode is affected, the endpoint does not own the supplies of
the devices below it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bd86e32cc2b1..952b4c6cc4bf 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/phy/phy.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -841,16 +842,32 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Power on the devices described below this controller before the PHY
+	 * is initialized: the slot supplies must be up before PHY init.
+	 */
+	if (data->mode == DW_PCIE_RC_TYPE) {
+		ret = pci_pwrctrl_create_devices(dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to create pwrctrl devices\n");
+
+		ret = pci_pwrctrl_power_on_devices(dev);
+		if (ret) {
+			pci_pwrctrl_destroy_devices(dev);
+			return dev_err_probe(dev, ret,
+					     "failed to power on pwrctrl devices\n");
+		}
+	}
+
 	/* DON'T MOVE ME: must be enable before PHY init */
 	ret = devm_regulator_get_enable_optional(dev, "vpcie3v3");
 	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "failed to enable vpcie3v3 regulator\n");
+		goto err_pwrctrl_off;
 
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to initialize the phy\n");
+		goto err_pwrctrl_off;
 
 	ret = reset_control_deassert(rockchip->rst);
 	if (ret)
@@ -883,6 +900,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
+err_pwrctrl_off:
+	if (data->mode == DW_PCIE_RC_TYPE) {
+		pci_pwrctrl_power_off_devices(dev);
+		pci_pwrctrl_destroy_devices(dev);
+	}
 
 	return ret;
 }
-- 
2.25.1

