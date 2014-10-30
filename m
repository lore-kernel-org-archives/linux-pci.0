Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0137.outbound.protection.outlook.com ([157.56.111.137]:16304
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932936AbaJ3KKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:10:45 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Huang Rui <ray.huang@amd.com>
Subject: [PATCH v4 07/20] usb: dwc3: add P3 in U2 SS Inactive quirk
Date: Thu, 30 Oct 2014 18:08:32 +0800
Message-ID: <1414663725-2195-8-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds P3 in U2 SS Inactive quirk, and some special platforms can
configure that if it is needed.

[ balbi@ti.com : added DeviceTree binding documentation ]

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |  1 +
 drivers/usb/dwc3/core.c                        | 23 +++++++++++++++++++++++
 drivers/usb/dwc3/core.h                        |  3 +++
 drivers/usb/dwc3/platform_data.h               |  1 +
 4 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 79ed37c..f714357 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -19,6 +19,7 @@ Optional properties:
  - snps,has-lpm-erratum: true when DWC3 was configured with LPM Erratum enabled
  - snps,lpm-nyet-threshold: LPM NYET threshold
  - snps,u2exit_lfps_quirk: set if we want to enable U2Exit LFPS quirk
+ - snps,u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6d1f09f..0a935cb 100644
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
@@ -486,6 +504,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
+	dwc3_phy_setup(dwc);
+
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
 		goto err1;
@@ -731,6 +751,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,disable_scramble_quirk");
 		dwc->u2exit_lfps_quirk = of_property_read_bool(node,
 				"snps,u2exit_lfps_quirk");
+		dwc->u2ss_inp3_quirk = of_property_read_bool(node,
+				"snps,u2ss_inp3_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -742,6 +764,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
 		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
+		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 45130a1..3843511 100644
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
  * @u2exit_lfps_quirk: set if we enable U2Exit LFPS quirk
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
index 3f21591..cf92c81 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -30,4 +30,5 @@ struct dwc3_platform_data {
 	unsigned disable_scramble_quirk:1;
 	unsigned has_lpm_erratum:1;
 	unsigned u2exit_lfps_quirk:1;
+	unsigned u2ss_inp3_quirk:1;
 };
-- 
1.9.1

