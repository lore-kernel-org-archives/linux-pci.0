Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0113.outbound.protection.outlook.com ([157.56.110.113]:44640
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752407AbaJ1L43 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:56:29 -0400
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
Subject: [PATCH v3 08/19] usb: dwc3: add request p1p2p3 quirk
Date: Tue, 28 Oct 2014 19:54:29 +0800
Message-ID: <1414497280-3126-9-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds request P1/P2/P3 quirk for U2/U2/U3, and some special
platforms can configure that if it is needed.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 6 ++++++
 drivers/usb/dwc3/core.h          | 3 +++
 drivers/usb/dwc3/platform_data.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ccc54df..021ebf3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -377,6 +377,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
+	if (dwc->req_p1p2p3_quirk)
+		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -751,6 +754,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,u2exit_lfps_quirk");
 		dwc->u2ss_inp3_quirk = of_property_read_bool(node,
 				"snps,u2ss_inp3_quirk");
+		dwc->req_p1p2p3_quirk = of_property_read_bool(node,
+				"snps,req_p1p2p3_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -763,6 +768,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
 		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
 		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
+		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f230668..e1aca71 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -177,6 +177,7 @@
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
+#define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
@@ -683,6 +684,7 @@ struct dwc3_scratchpad_array {
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
+ * @req_p1p2p3_quirk: set if we enable request p1p2p3 quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -793,6 +795,7 @@ struct dwc3 {
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
 	unsigned		u2ss_inp3_quirk:1;
+	unsigned		req_p1p2p3_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index b5906a3..457ee9c 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -30,4 +30,5 @@ struct dwc3_platform_data {
 	unsigned lpm_nyet_thres:4;
 	unsigned u2exit_lfps_quirk:1;
 	unsigned u2ss_inp3_quirk:1;
+	unsigned req_p1p2p3_quirk:1;
 };
-- 
1.9.1

