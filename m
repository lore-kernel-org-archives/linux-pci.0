Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 08/16] usb: dwc3: add u2exit lfps quirk
Date: Fri, 17 Oct 2014 16:53:33 +0800
Message-ID: <1413536021-4886-9-git-send-email-ray.huang@amd.com>
In-Reply-To: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AMD NL needs to enable u2exit lfps quirk.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 4 ++++
 drivers/usb/dwc3/core.h          | 1 +
 drivers/usb/dwc3/dwc3-pci.c      | 3 ++-
 drivers/usb/dwc3/platform_data.h | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25db533..7322d85 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -467,6 +467,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		reg |= DWC3_GCTL_DISSCRAMBLE;
 	else
 		reg &= ~DWC3_GCTL_DISSCRAMBLE;
+
+	if (dwc->quirks & DWC3_QUIRK_U2EXIT_LFPS)
+		reg |= DWC3_GCTL_U2EXIT_LFPS;
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.90a have a bug
 	 * where the device can fail to connect at SuperSpeed
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d58479e..3d27f10 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -166,6 +166,7 @@
 #define DWC3_GCTL_SCALEDOWN(n)		((n) << 4)
 #define DWC3_GCTL_SCALEDOWN_MASK	DWC3_GCTL_SCALEDOWN(3)
 #define DWC3_GCTL_DISSCRAMBLE		(1 << 3)
+#define DWC3_GCTL_U2EXIT_LFPS		(1 << 2)
 #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
 #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
 
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index bbe946c..cdb9b04 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -149,7 +149,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 	if (pci->vendor == PCI_VENDOR_ID_AMD && pci->device ==
 			PCI_DEVICE_ID_AMD_NL) {
 		dwc3_pdata.has_lpm_erratum = true;
-		dwc3_pdata.quirks |= DWC3_QUIRK_AMD_NL;
+		dwc3_pdata.quirks |= DWC3_QUIRK_AMD_NL
+			| DWC3_QUIRK_U2EXIT_LFPS;
 	}
 
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 098ab04..a6463c0 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -30,5 +30,6 @@ struct dwc3_platform_data {
 
 #define DWC3_QUIRK_AMD_NL		(1 << 0)
 #define DWC3_QUIRK_DISSCRAMBLE		(1 << 1)
+#define DWC3_QUIRK_U2EXIT_LFPS		(1 << 2)
 
 };
-- 
1.9.1

