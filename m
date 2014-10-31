Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v5 6/8] usb: dwc3: add support for AMD Nolan platform
Date: Fri, 31 Oct 2014 11:11:17 +0800
Message-ID: <1414725079-11490-7-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414725079-11490-1-git-send-email-ray.huang@amd.com>
References: <1414725079-11490-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for AMD Nolan (NL) FPGA and SoC platform.

Cc: Jason Chang <jason.chang@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index ada975f..7c4faf7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -145,6 +145,31 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 	res[1].name	= "dwc_usb3";
 	res[1].flags	= IORESOURCE_IRQ;
 
+	if (pci->vendor == PCI_VENDOR_ID_AMD &&
+			pci->device == PCI_DEVICE_ID_AMD_NL_USB) {
+		dwc3_pdata.has_lpm_erratum = true;
+		dwc3_pdata.lpm_nyet_threshold = 0xf;
+
+		dwc3_pdata.u2exit_lfps_quirk = true;
+		dwc3_pdata.u2ss_inp3_quirk = true;
+		dwc3_pdata.req_p1p2p3_quirk = true;
+		dwc3_pdata.del_p1p2p3_quirk = true;
+		dwc3_pdata.del_phy_power_chg_quirk = true;
+		dwc3_pdata.lfps_filter_quirk = true;
+		dwc3_pdata.rx_detect_poll_quirk = true;
+
+		dwc3_pdata.tx_de_emphasis_quirk = true;
+		dwc3_pdata.tx_de_emphasis = 1;
+
+		/*
+		 * FIXME these quirks should be removed when AMD NL
+		 * taps out
+		 */
+		dwc3_pdata.disable_scramble_quirk = true;
+		dwc3_pdata.dis_u3_susphy_quirk = true;
+		dwc3_pdata.dis_u2_susphy_quirk = true;
+	}
+
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(dev, "couldn't add resources to dwc3 device\n");
@@ -194,6 +219,7 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BSW), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRFLD), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB), },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
-- 
1.9.1

