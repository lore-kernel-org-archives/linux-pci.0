Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [157.56.110.143] ([157.56.110.143]:46112 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751360AbaJQJP1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Oct 2014 05:15:27 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 16/16] usb: dwc3: enable usb suspend phy
Date: Fri, 17 Oct 2014 16:53:41 +0800
Message-ID: <1413536021-4886-17-git-send-email-ray.huang@amd.com>
In-Reply-To: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AMD NL needs to suspend usb3 ss phy, but this doesn't enable on simulation
board.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 7 ++++++-
 drivers/usb/dwc3/dwc3-pci.c      | 3 ++-
 drivers/usb/dwc3/platform_data.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3ccfe41..4a98696 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -395,6 +395,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->quirks & DWC3_QUIRK_TX_DEEPH)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(1);
 
+	if (dwc->quirks & DWC3_QUIRK_SUSPHY)
+		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -496,8 +499,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->is_fpga = true;
 	}
 
-	if ((dwc->quirks & DWC3_QUIRK_AMD_NL) && dwc->is_fpga)
+	if ((dwc->quirks & DWC3_QUIRK_AMD_NL) && dwc->is_fpga) {
 		dwc->quirks |= DWC3_QUIRK_DISSCRAMBLE;
+		dwc->quirks &= ~DWC3_QUIRK_SUSPHY;
+	}
 
 	if (dwc->quirks & DWC3_QUIRK_DISSCRAMBLE)
 		reg |= DWC3_GCTL_DISSCRAMBLE;
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 146eb2f..71401a3 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -157,7 +157,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 			| DWC3_QUIRK_DEPOCHANGE
 			| DWC3_QUIRK_LFPSFILT
 			| DWC3_QUIRK_RX_DETOPOLL
-			| DWC3_QUIRK_TX_DEEPH;
+			| DWC3_QUIRK_TX_DEEPH
+			| DWC3_QUIRK_SUSPHY;
 	}
 
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 54f0e45..f68cd97 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -38,5 +38,6 @@ struct dwc3_platform_data {
 #define DWC3_QUIRK_LFPSFILT		(1 << 7)
 #define DWC3_QUIRK_RX_DETOPOLL		(1 << 8)
 #define DWC3_QUIRK_TX_DEEPH		(1 << 9)
+#define DWC3_QUIRK_SUSPHY		(1 << 10)
 
 };
-- 
1.9.1

