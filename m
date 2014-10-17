Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0104.outbound.protection.outlook.com ([65.55.169.104]:18464
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752148AbaJQJO1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Oct 2014 05:14:27 -0400
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
Subject: [PATCH v2 10/16] usb: dwc3: add request p1p2p3 quirk
Date: Fri, 17 Oct 2014 16:53:35 +0800
Message-ID: <1413536021-4886-11-git-send-email-ray.huang@amd.com>
In-Reply-To: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AMD NL needs to enable always request P1/P2/P3 for U1/U2/U3 for AMD own phy.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 3 +++
 drivers/usb/dwc3/core.h          | 1 +
 drivers/usb/dwc3/dwc3-pci.c      | 3 ++-
 drivers/usb/dwc3/platform_data.h | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9d0a249..ec8b667 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -377,6 +377,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->quirks & DWC3_QUIRK_U2SSINP3OK)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
+	if (dwc->quirks & DWC3_QUIRK_REQP1P2P3)
+		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 71cb255..8f47ade18 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -177,6 +177,7 @@
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
+#define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 1235eb3..7154d18 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -151,7 +151,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 		dwc3_pdata.has_lpm_erratum = true;
 		dwc3_pdata.quirks |= DWC3_QUIRK_AMD_NL
 			| DWC3_QUIRK_U2EXIT_LFPS
-			| DWC3_QUIRK_U2SSINP3OK;
+			| DWC3_QUIRK_U2SSINP3OK
+			| DWC3_QUIRK_REQP1P2P3;
 	}
 
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index ad03563..850883f 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -32,5 +32,6 @@ struct dwc3_platform_data {
 #define DWC3_QUIRK_DISSCRAMBLE		(1 << 1)
 #define DWC3_QUIRK_U2EXIT_LFPS		(1 << 2)
 #define DWC3_QUIRK_U2SSINP3OK		(1 << 3)
+#define DWC3_QUIRK_REQP1P2P3		(1 << 4)
 
 };
-- 
1.9.1

