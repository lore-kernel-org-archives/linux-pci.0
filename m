Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0102.outbound.protection.outlook.com ([207.46.100.102]:19968
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755390AbaJ1L4n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:56:43 -0400
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
Subject: [PATCH v3 11/19] usb: dwc3: add lfps filter quirk
Date: Tue, 28 Oct 2014 19:54:32 +0800
Message-ID: <1414497280-3126-12-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds LFPS filter quirk, and some special platforms can configure
that if it is needed.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 6 ++++++
 drivers/usb/dwc3/core.h          | 3 +++
 drivers/usb/dwc3/platform_data.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 97796d7..86ed064 100644
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
@@ -766,6 +769,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,del_p1p2p3_quirk");
 		dwc->del_phy_power_chg_quirk = of_property_read_bool(node,
 				"snps,del_phy_power_chg_quirk");
+		dwc->lfps_filter_quirk = of_property_read_bool(node,
+				"snps,lfps_filter_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -781,6 +786,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
 		dwc->del_p1p2p3_quirk = pdata->del_p1p2p3_quirk;
 		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
+		dwc->lfps_filter_quirk = pdata->lfps_filter_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 13bc46b..23b48a0 100644
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
  * @req_p1p2p3_quirk: set if we enable request p1p2p3 quirk
  * @del_p1p2p3_quirk: set if we enable delay p1p2p3 quirk
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
index 1dea0c0..89918e5 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -33,4 +33,5 @@ struct dwc3_platform_data {
 	unsigned req_p1p2p3_quirk:1;
 	unsigned del_p1p2p3_quirk:1;
 	unsigned del_phy_power_chg_quirk:1;
+	unsigned lfps_filter_quirk:1;
 };
-- 
1.9.1

