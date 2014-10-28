Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0118.outbound.protection.outlook.com ([157.56.111.118]:59760
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755505AbaJ1L4x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:56:53 -0400
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
Subject: [PATCH v3 13/19] usb: dwc3: add tx demphasis quirk
Date: Tue, 28 Oct 2014 19:54:34 +0800
Message-ID: <1414497280-3126-14-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds Tx demphasis quirk, and the Tx demphasis value is
configurable according to PIPE3 specification.

Value		Description
0		-6dB de-emphasis
1		-3.5dB de-emphasis
2		No de-emphasis
3		Reserved

It can be configured on DT or platform data.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 17 +++++++++++++++++
 drivers/usb/dwc3/core.h          | 11 +++++++++++
 drivers/usb/dwc3/platform_data.h |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 19019dc..e36fcd0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -392,6 +392,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->rx_detect_poll_quirk)
 		reg |= DWC3_GUSB3PIPECTL_RX_DETOPOLL;
 
+	if (dwc->tx_deemph_quirk)
+		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_deemph);
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -691,6 +694,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	struct resource		*res;
 	struct dwc3		*dwc;
 	u8			lpm_nyet_thres;
+	u8			tx_deemph;
 
 	int			ret;
 
@@ -749,6 +753,9 @@ static int dwc3_probe(struct platform_device *pdev)
 	/* default to highest possible threshold */
 	lpm_nyet_thres = 0xff;
 
+	/* default to -3.5dB de-emphasis */
+	tx_deemph = 1;
+
 	if (node) {
 		dwc->maximum_speed = of_usb_get_maximum_speed(node);
 		dwc->has_lpm_erratum = of_property_read_bool(node,
@@ -776,6 +783,11 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,lfps_filter_quirk");
 		dwc->rx_detect_poll_quirk = of_property_read_bool(node,
 				"snps,rx_detect_poll_quirk");
+
+		dwc->tx_deemph_quirk = of_property_read_bool(node,
+				"snps,tx_deemph_quirk");
+		of_property_read_u8(node, "snps,tx_deemph",
+				&tx_deemph);
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -793,6 +805,10 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
 		dwc->lfps_filter_quirk = pdata->lfps_filter_quirk;
 		dwc->rx_detect_poll_quirk = pdata->rx_detect_poll_quirk;
+
+		dwc->tx_deemph_quirk = pdata->tx_deemph_quirk;
+		if (pdata->tx_deemph)
+			tx_deemph = pdata->tx_deemph;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
@@ -800,6 +816,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->maximum_speed = USB_SPEED_SUPER;
 
 	dwc->lpm_nyet_thres = lpm_nyet_thres;
+	dwc->tx_deemph = tx_deemph;
 
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 57a203a..1277dcf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -185,6 +185,8 @@
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 #define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
 #define DWC3_GUSB3PIPECTL_RX_DETOPOLL	(1 << 8)
+#define DWC3_GUSB3PIPECTL_TX_DEEPH_MASK	DWC3_GUSB3PIPECTL_TX_DEEPH(3)
+#define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
 /* Global TX Fifo Size Register */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
@@ -695,6 +697,12 @@ struct dwc3_scratchpad_array {
  * @del_phy_power_chg_quirk: set if we enable delay phy power change quirk
  * @lfps_filter_quirk: set if we enable LFPS filter quirk
  * @rx_detect_poll_quirk: set if we enable rx_detect to polling lfps quirk
+ * @tx_deemph_quirk: set if we enable Tx deemphasis quirk
+ * @tx_deemph: Tx deemphasis value
+ *	0	- -6dB de-emphasis
+ *	1	- -3.5dB de-emphasis
+ *	2	- No de-emphasis
+ *	3	- Reserved
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -810,6 +818,9 @@ struct dwc3 {
 	unsigned		del_phy_power_chg_quirk:1;
 	unsigned		lfps_filter_quirk:1;
 	unsigned		rx_detect_poll_quirk:1;
+
+	unsigned		tx_deemph_quirk:1;
+	unsigned		tx_deemph:2;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 9776764..ea631dc 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -35,4 +35,7 @@ struct dwc3_platform_data {
 	unsigned del_phy_power_chg_quirk:1;
 	unsigned lfps_filter_quirk:1;
 	unsigned rx_detect_poll_quirk:1;
+
+	unsigned tx_deemph_quirk:1;
+	unsigned tx_deemph:2;
 };
-- 
1.9.1

