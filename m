Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0142.outbound.protection.outlook.com ([65.55.169.142]:21051
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754613AbaJ1L5D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:57:03 -0400
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
Subject: [PATCH v3 15/19] usb: dwc3: add disable usb3 suspend phy quirk
Date: Tue, 28 Oct 2014 19:54:36 +0800
Message-ID: <1414497280-3126-16-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds disable usb3 suspend phy quirk, and some special platforms
can configure that if it is needed.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 6 ++++++
 drivers/usb/dwc3/core.h          | 2 ++
 drivers/usb/dwc3/platform_data.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7b5cd76..aec393b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -404,6 +404,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_deemph_quirk)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_deemph);
 
+	if (dwc->dis_u3_susphy_quirk)
+		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -807,6 +810,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,lfps_filter_quirk");
 		dwc->rx_detect_poll_quirk = of_property_read_bool(node,
 				"snps,rx_detect_poll_quirk");
+		dwc->dis_u3_susphy_quirk = of_property_read_bool(node,
+				"snps,dis_u3_susphy_quirk");
 
 		dwc->tx_deemph_quirk = of_property_read_bool(node,
 				"snps,tx_deemph_quirk");
@@ -829,6 +834,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
 		dwc->lfps_filter_quirk = pdata->lfps_filter_quirk;
 		dwc->rx_detect_poll_quirk = pdata->rx_detect_poll_quirk;
+		dwc->dis_u3_susphy_quirk = pdata->dis_u3_susphy_quirk;
 
 		dwc->tx_deemph_quirk = pdata->tx_deemph_quirk;
 		if (pdata->tx_deemph)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1277dcf..686d3b9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -697,6 +697,7 @@ struct dwc3_scratchpad_array {
  * @del_phy_power_chg_quirk: set if we enable delay phy power change quirk
  * @lfps_filter_quirk: set if we enable LFPS filter quirk
  * @rx_detect_poll_quirk: set if we enable rx_detect to polling lfps quirk
+ * @dis_u3_susphy_quirk: set if we disable usb3 suspend phy
  * @tx_deemph_quirk: set if we enable Tx deemphasis quirk
  * @tx_deemph: Tx deemphasis value
  *	0	- -6dB de-emphasis
@@ -818,6 +819,7 @@ struct dwc3 {
 	unsigned		del_phy_power_chg_quirk:1;
 	unsigned		lfps_filter_quirk:1;
 	unsigned		rx_detect_poll_quirk:1;
+	unsigned		dis_u3_susphy_quirk:1;
 
 	unsigned		tx_deemph_quirk:1;
 	unsigned		tx_deemph:2;
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index ea631dc..c8115c7 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -35,6 +35,7 @@ struct dwc3_platform_data {
 	unsigned del_phy_power_chg_quirk:1;
 	unsigned lfps_filter_quirk:1;
 	unsigned rx_detect_poll_quirk:1;
+	unsigned dis_u3_susphy_quirk:1;
 
 	unsigned tx_deemph_quirk:1;
 	unsigned tx_deemph:2;
-- 
1.9.1

