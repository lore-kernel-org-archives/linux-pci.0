Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932976AbcIBP4R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:56:17 -0400
Subject: [PATCH v2 15/15] Move msleeps to address Guenter's comments.
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Sep 2016 10:56:02 -0500
Message-ID: <20160902155602.8650.82778.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |   35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e33d2f7..d293a62 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -481,24 +481,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			break;
 		}
 
-		msleep(20);
-
-		if (!time_before(jiffies, timeout)) {
-			err = -ETIMEDOUT;
-			break;
-		}
-	}
-
-	/* Double check gen1 training */
-	if (err) {
-		status = rockchip_pcie_read(rockchip,
-					    PCIE_CLIENT_BASIC_STATUS1);
-		err = ((status & PCIE_CLIENT_LINK_STATUS_MASK) ==
-		       PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
-		if (err) {
+		if (time_after(jiffies, timeout)) {
 			dev_err(dev, "PCIe link training gen1 timeout!\n");
-			return err;
+			return -ETIMEDOUT;
 		}
+
+		msleep(20);
 	}
 
 	/*
@@ -518,21 +506,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			break;
 		}
 
-		msleep(20);
-
-		if (!time_before(jiffies, timeout)) {
-			err = -ETIMEDOUT;
+		if (time_after(jiffies, timeout)) {
+			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
 			break;
 		}
-	}
 
-	/* Double check gen2 training */
-	if (err) {
-		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
-		err = ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
-		       PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
-		if (err)
-			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
+		msleep(20);
 	}
 
 	/* Check the final link width from negotiated lane counter from MGMT */

