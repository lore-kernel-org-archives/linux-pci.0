Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0127.outbound.protection.outlook.com ([207.46.100.127]:14592
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932936AbaJ3KLF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:11:05 -0400
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
Subject: [PATCH v4 11/20] usb: dwc3: add LFPS filter quirk
Date: Thu, 30 Oct 2014 18:08:36 +0800
Message-ID: <1414663725-2195-12-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds LFPS filter quirk, and some special platforms can configure
that if it is needed.

[ balbi@ti.com : added DeviceTree binding documentation ]

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 1 +
 drivers/usb/dwc3/core.c                        | 6 ++++++
 drivers/usb/dwc3/core.h                        | 3 +++
 drivers/usb/dwc3/platform_data.h               | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 216cc35..0647100 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -26,6 +26,7 @@ Optional properties:
 			amount of 8B10B errors occur.
  - snps,del_phy_power_chg_quirk: when set core will delay PHY power change
 			from P0 to P1/P2/P3.
+ - snps,lfps_filter_quirk: when set core will filter LFPS reception.
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index deceb7c..ae7ff8f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -386,6 +386,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->del_phy_power_chg_quirk)
 		reg |= DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
+	if (dwc->lfps_filter_quirk)
+		reg |= DWC3_GUSB3PIPECTL_LFPSFILT;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -768,6 +771,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,del_p1p2p3_quirk");
 		dwc->del_phy_power_chg_quirk = of_property_read_bool(node,
 				"snps,del_phy_power_chg_quirk");
+		dwc->lfps_filter_quirk = of_property_read_bool(node,
+				"snps,lfps_filter_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -783,6 +788,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
 		dwc->del_p1p2p3_quirk = pdata->del_p1p2p3_quirk;
 		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
+		dwc->lfps_filter_quirk = pdata->lfps_filter_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 176f3f1..cf9dd73 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -183,6 +183,7 @@
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
 #define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
+#define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
 
 /* Global TX Fifo Size Register */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
@@ -691,6 +692,7 @@ struct dwc3_scratchpad_array {
  * @req_p1p2p3_quirk: set if we enable request P1/P2/P3 quirk
  * @del_p1p2p3_quirk: set if we enable delay P1/P2/P3 quirk
  * @del_phy_power_chg_quirk: set if we enable delay phy power change quirk
+ * @lfps_filter_quirk: set if we enable LFPS filter quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -804,6 +806,7 @@ struct dwc3 {
 	unsigned		req_p1p2p3_quirk:1;
 	unsigned                del_p1p2p3_quirk:1;
 	unsigned		del_phy_power_chg_quirk:1;
+	unsigned		lfps_filter_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index ae67151..dad0211 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -34,4 +34,5 @@ struct dwc3_platform_data {
 	unsigned req_p1p2p3_quirk:1;
 	unsigned del_p1p2p3_quirk:1;
 	unsigned del_phy_power_chg_quirk:1;
+	unsigned lfps_filter_quirk:1;
 };
-- 
1.9.1

