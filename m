Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0117.outbound.protection.outlook.com ([157.56.111.117]:1484
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752972AbaJQJPl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Oct 2014 05:15:41 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 09/16] usb: dwc3: add P3 in U2 SS inactive quirk
Date: Fri, 17 Oct 2014 16:53:34 +0800
Message-ID: <1413536021-4886-10-git-send-email-ray.huang@amd.com>
In-Reply-To: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AMD NL needs to enable P3 OK for U2/SSInactive on USB3PIPE register.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 20 ++++++++++++++++++++
 drivers/usb/dwc3/core.h          |  1 +
 drivers/usb/dwc3/dwc3-pci.c      |  3 ++-
 drivers/usb/dwc3/platform_data.h |  1 +
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7322d85..9d0a249 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -365,6 +365,24 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 }
 
 /**
+ * dwc3_phy_setup - Configure USB3 PHY Interface of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ */
+static void dwc3_phy_setup(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+
+	if (dwc->quirks & DWC3_QUIRK_U2SSINP3OK)
+		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
+	mdelay(100);
+}
+
+/**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
  *
@@ -484,6 +502,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
+	dwc3_phy_setup(dwc);
+
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
 		goto err1;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3d27f10..71cb255 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -176,6 +176,7 @@
 
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
+#define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index cdb9b04..1235eb3 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -150,7 +150,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 			PCI_DEVICE_ID_AMD_NL) {
 		dwc3_pdata.has_lpm_erratum = true;
 		dwc3_pdata.quirks |= DWC3_QUIRK_AMD_NL
-			| DWC3_QUIRK_U2EXIT_LFPS;
+			| DWC3_QUIRK_U2EXIT_LFPS
+			| DWC3_QUIRK_U2SSINP3OK;
 	}
 
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index a6463c0..ad03563 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -31,5 +31,6 @@ struct dwc3_platform_data {
 #define DWC3_QUIRK_AMD_NL		(1 << 0)
 #define DWC3_QUIRK_DISSCRAMBLE		(1 << 1)
 #define DWC3_QUIRK_U2EXIT_LFPS		(1 << 2)
+#define DWC3_QUIRK_U2SSINP3OK		(1 << 3)
 
 };
-- 
1.9.1

