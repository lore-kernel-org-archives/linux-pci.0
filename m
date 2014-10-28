Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v3 10/19] usb: dwc3: add delay phy power change quirk
Date: Tue, 28 Oct 2014 19:54:31 +0800
Message-ID: <1414497280-3126-11-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds delay PHY power change from P0 to P1/P2/P3 when link state
changing from U0 to U1/U2/U3 respectively, and some special platforms can
configure that if it is needed.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 6 ++++++
 drivers/usb/dwc3/core.h          | 3 +++
 drivers/usb/dwc3/platform_data.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 244c71a..97796d7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -383,6 +383,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->del_p1p2p3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_DEP1P2P3_EN;
 
+	if (dwc->del_phy_power_chg_quirk)
+		reg |= DWC3_GUSB3PIPECTL_DEPOCHANGE;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -761,6 +764,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,req_p1p2p3_quirk");
 		dwc->del_p1p2p3_quirk = of_property_read_bool(node,
 				"snps,del_p1p2p3_quirk");
+		dwc->del_phy_power_chg_quirk = of_property_read_bool(node,
+				"snps,del_phy_power_chg_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -775,6 +780,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
 		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
 		dwc->del_p1p2p3_quirk = pdata->del_p1p2p3_quirk;
+		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a91f42d..13bc46b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -181,6 +181,7 @@
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
+#define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
@@ -689,6 +690,7 @@ struct dwc3_scratchpad_array {
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
  * @req_p1p2p3_quirk: set if we enable request p1p2p3 quirk
  * @del_p1p2p3_quirk: set if we enable delay p1p2p3 quirk
+ * @del_phy_power_chg_quirk: set if we enable delay phy power change quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -801,6 +803,7 @@ struct dwc3 {
 	unsigned		u2ss_inp3_quirk:1;
 	unsigned		req_p1p2p3_quirk:1;
 	unsigned                del_p1p2p3_quirk:1;
+	unsigned		del_phy_power_chg_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 6dca665..1dea0c0 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -32,4 +32,5 @@ struct dwc3_platform_data {
 	unsigned u2ss_inp3_quirk:1;
 	unsigned req_p1p2p3_quirk:1;
 	unsigned del_p1p2p3_quirk:1;
+	unsigned del_phy_power_chg_quirk:1;
 };
-- 
1.9.1

