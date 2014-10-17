Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [65.55.169.139] ([65.55.169.139]:51385 "EHLO
	na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751289AbaJQJPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Oct 2014 05:15:33 -0400
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
Subject: [PATCH v2 11/16] usb: dwc3: add delay p1p2p3 quirk
Date: Fri, 17 Oct 2014 16:53:36 +0800
Message-ID: <1413536021-4886-12-git-send-email-ray.huang@amd.com>
In-Reply-To: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AMD NL needs to delay P0 to P1/P2/P3 request when entering U1/U2/U3.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 3 +++
 drivers/usb/dwc3/core.h          | 2 ++
 drivers/usb/dwc3/dwc3-pci.c      | 3 ++-
 drivers/usb/dwc3/platform_data.h | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ec8b667..a9f1d4c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -380,6 +380,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->quirks & DWC3_QUIRK_REQP1P2P3)
 		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
 
+	if (dwc->quirks & DWC3_QUIRK_DEPP1P2P3)
+		reg |= DWC3_GUSB3PIPECTL_DEP1P2P3(1);
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f47ade18..cf70fa6 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -178,6 +178,8 @@
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
 #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
+#define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
+#define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 7154d18..23ae6a7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -152,7 +152,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 		dwc3_pdata.quirks |= DWC3_QUIRK_AMD_NL
 			| DWC3_QUIRK_U2EXIT_LFPS
 			| DWC3_QUIRK_U2SSINP3OK
-			| DWC3_QUIRK_REQP1P2P3;
+			| DWC3_QUIRK_REQP1P2P3
+			| DWC3_QUIRK_DEPP1P2P3;
 	}
 
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 850883f..e668c1f 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -33,5 +33,6 @@ struct dwc3_platform_data {
 #define DWC3_QUIRK_U2EXIT_LFPS		(1 << 2)
 #define DWC3_QUIRK_U2SSINP3OK		(1 << 3)
 #define DWC3_QUIRK_REQP1P2P3		(1 << 4)
+#define DWC3_QUIRK_DEPP1P2P3		(1 << 5)
 
 };
-- 
1.9.1

