Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0106.outbound.protection.outlook.com ([157.56.110.106]:2848
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933546AbaJ3KLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:11:09 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Huang Rui <ray.huang@amd.com>
Subject: [PATCH v4 12/20] usb: dwc3: add rx_detect to polling LFPS quirk
Date: Thu, 30 Oct 2014 18:08:37 +0800
Message-ID: <1414663725-2195-13-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds RX_DETECT to Polling.LFPS control quirk, and some special
platforms can configure that if it is needed.

[ balbi@ti.com : added DeviceTree binding documentation ]

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 drivers/usb/dwc3/core.c                        | 6 ++++++
 drivers/usb/dwc3/core.h                        | 3 +++
 drivers/usb/dwc3/platform_data.h               | 1 +
 4 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 0647100..38bac28 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -27,6 +27,8 @@ Optional properties:
  - snps,del_phy_power_chg_quirk: when set core will delay PHY power change
 			from P0 to P1/P2/P3.
  - snps,lfps_filter_quirk: when set core will filter LFPS reception.
+ - snps,rx_detect_poll_quirk: when set core will disable a 400us delay to start
+			Polling LFPS after RX.Detect.
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ae7ff8f..11b0ab08 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -389,6 +389,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->lfps_filter_quirk)
 		reg |= DWC3_GUSB3PIPECTL_LFPSFILT;
 
+	if (dwc->rx_detect_poll_quirk)
+		reg |= DWC3_GUSB3PIPECTL_RX_DETOPOLL;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -773,6 +776,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,del_phy_power_chg_quirk");
 		dwc->lfps_filter_quirk = of_property_read_bool(node,
 				"snps,lfps_filter_quirk");
+		dwc->rx_detect_poll_quirk = of_property_read_bool(node,
+				"snps,rx_detect_poll_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -789,6 +794,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->del_p1p2p3_quirk = pdata->del_p1p2p3_quirk;
 		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
 		dwc->lfps_filter_quirk = pdata->lfps_filter_quirk;
+		dwc->rx_detect_poll_quirk = pdata->rx_detect_poll_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index cf9dd73..eeef976 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -184,6 +184,7 @@
 #define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 #define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
+#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	(1 << 8)
 
 /* Global TX Fifo Size Register */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
@@ -693,6 +694,7 @@ struct dwc3_scratchpad_array {
  * @del_p1p2p3_quirk: set if we enable delay P1/P2/P3 quirk
  * @del_phy_power_chg_quirk: set if we enable delay phy power change quirk
  * @lfps_filter_quirk: set if we enable LFPS filter quirk
+ * @rx_detect_poll_quirk: set if we enable rx_detect to polling LFPS quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -807,6 +809,7 @@ struct dwc3 {
 	unsigned                del_p1p2p3_quirk:1;
 	unsigned		del_phy_power_chg_quirk:1;
 	unsigned		lfps_filter_quirk:1;
+	unsigned		rx_detect_poll_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index dad0211..4a0f06b 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -35,4 +35,5 @@ struct dwc3_platform_data {
 	unsigned del_p1p2p3_quirk:1;
 	unsigned del_phy_power_chg_quirk:1;
 	unsigned lfps_filter_quirk:1;
+	unsigned rx_detect_poll_quirk:1;
 };
-- 
1.9.1

