Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241628;
	b=A7xUn2kBRI2h6HFZsaxocP/Gfkv+gXM7Lckd5LKAQPw1rN6uK4EgaVyMDDdQoriFb34V
	 ELTLcQmEGYGO4txjeGLSpxtG3i3UbAHZLLgeCKh1P2a9pqlB2CAUe/7lJFy6J3ZGjWqyv
	 U1xkftrnFYS13mP7ugir+Pr1yZ8pqOf3ewJW/oNCvH4N4OXLzLYoB2WL9deOlGI3s5SLT
	 e5j4f1EX1CoQjW5okqPtRRBwqKu2ufqMF1N4nCLB1mBuGIC2utOTNkqswgbycwQPa9QG/
	 Ksqfh1pqDRtfEPreecGfLuOYZ6DQcd/WZ2t6dFPM2pQCpYHq+fgkmvEGf0H0W0KCtng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241628;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Nx1W1WCJnn1r84yYmREPvC6NMpW3HrcJCRQOWdP2Gds=;
	b=MV5+JX74bPqzPNKgAV+lJGOV89dJ5x+qni569F1fFMGxaUwQUtgwQkDjTfzCbPx9GHLL
	 +BLy6st/pi+WbFqDWu2hppK+gPOjFeSlHtyu1+sNKDHr1TvaC2YHR0osRdL5Vw0qrCpB1
	 aqp/FY6B0EzJS6kKmZFSzbU+geyqtIcoZ9r0WsnzuYe6LdjQEdthoJuEO+2+iGwps8blT
	 4I7J021gmLiP1XKN7YwJQMtNKW5A7ie3o3c2JgppNbtJYnDudAwxLQYJpul4fZgeQxhnd
	 OVI20lKAD968cDGJ0Yu1COOKnc6pnT8peffibMQubwXEemNv5FggKn/HhkpwvOmTppQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VN1oU6iK;
	arc=none smtp.remote-ip=45.254.49.238
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com [45.254.49.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D93606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D93606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VN1oU6iK
Received: from localhost.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52bb2513c;
	Thu, 29 Oct 2026 10:40:17 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] PCI: dw-rockchip: Power on devices below the RC using pwrctrl
Date: Thu, 29 Oct 2026 10:40:05 +0800
Message-Id: <20261029024006.3483210-2-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261029024006.3483210-1-shawn.lin@rock-chips.com>
References: <20261029024006.3483210-1-shawn.lin@rock-chips.com>
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
X-HM-Tid: 0aa1858793bd03a4kunmf51ad3a01124d2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBkfVkJJHkhCGR5MSEIYQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VN1oU6iK8ExnJzaXpKNclErgWY8/2GrG98DPt5Hy52g/OsM3iVuEIHfv0vCtxOIuom/NlJ4Y9yvL9TLngiMLr1CYnXZOAzBiver+KN9fvawcSmeVIboApFit62IkZAmPFLyUVT81O3KU7jRn876JPK+enPqP97J62LY894TeZwQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Nx1W1WCJnn1r84yYmREPvC6NMpW3HrcJCRQOWdP2Gds=;
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

Changes in v2:
- Select PCI_PWRCTRL_GENERIC from PCIE_ROCKCHIP_DW, so that the
  built-in controller driver cannot end up with undefined
  pci_pwrctrl_* references when the pwrctrl core is a module(sashiko)
- Do not destroy the pwrctrl devices on -EPROBE_DEFER, so that the
  deferred child devices can still bind and retrigger the
  probe(sashiko)

 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 32 ++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0a0d56fcf0ac..8e74a756271a 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -368,6 +368,7 @@ config PCIE_RCAR_GEN4_EP
 
 config PCIE_ROCKCHIP_DW
 	bool
+	select PCI_PWRCTRL_GENERIC
 
 config PCIE_ROCKCHIP_DW_HOST
 	bool "Rockchip DesignWare PCIe controller (host mode)"
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bd86e32cc2b1..4263181f63f5 100644
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
@@ -841,16 +842,33 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
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
+			if (ret != -EPROBE_DEFER)
+				pci_pwrctrl_destroy_devices(dev);
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
@@ -883,6 +901,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
+err_pwrctrl_off:
+	if (data->mode == DW_PCIE_RC_TYPE) {
+		pci_pwrctrl_power_off_devices(dev);
+		if (ret != -EPROBE_DEFER)
+			pci_pwrctrl_destroy_devices(dev);
+	}
 
 	return ret;
 }
-- 
2.25.1

