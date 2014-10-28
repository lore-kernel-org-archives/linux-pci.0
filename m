Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0129.outbound.protection.outlook.com ([65.55.169.129]:48576
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755031AbaJ1L4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:56:25 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>,
	"Vincent Wan" <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v3 07/19] usb: dwc3: add P3 in U2 SS inactive quirk
Date: Tue, 28 Oct 2014 19:54:28 +0800
Message-ID: <1414497280-3126-8-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds P3 in U2 SS inactive quirk, and some special platforms can
configure that if it is needed.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 23 +++++++++++++++++++++++
 drivers/usb/dwc3/core.h          |  3 +++
 drivers/usb/dwc3/platform_data.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6abf4e9..ccc54df 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -365,6 +365,24 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 }
 
 /**
+ * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ */
+static void dwc3_phy_setup(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+
+	if (dwc->u2ss_inp3_quirk)
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
@@ -729,6 +749,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,disable_scramble_quirk");
 		dwc->u2exit_lfps_quirk = of_property_read_bool(node,
 				"snps,u2exit_lfps_quirk");
+		dwc->u2ss_inp3_quirk = of_property_read_bool(node,
+				"snps,u2ss_inp3_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -740,6 +762,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
 		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
+		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 03e0505..f230668 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -176,6 +176,7 @@
 
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
+#define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
@@ -681,6 +682,7 @@ struct dwc3_scratchpad_array {
  * @three_stage_setup: set if we perform a three phase setup
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
+ * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -790,6 +792,7 @@ struct dwc3 {
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
+	unsigned		u2ss_inp3_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 4e91e09..b5906a3 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -29,4 +29,5 @@ struct dwc3_platform_data {
 	unsigned has_lpm_erratum:1;
 	unsigned lpm_nyet_thres:4;
 	unsigned u2exit_lfps_quirk:1;
+	unsigned u2ss_inp3_quirk:1;
 };
-- 
1.9.1

