Return-Path: <SRS0=LihV=K5=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=LihV=K5=netronome.com=jakub.kicinski@kernel.org>
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	oss-drivers@netronome.com,
	Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] PCI: limit config space size for Netronome NFP5000
Date: Tue, 14 Aug 2018 16:48:50 -0700
Message-Id: <20180814234850.27447-1-jakub.kicinski@netronome.com>
List-ID: <linux-pci.vger.kernel.org>

Like the NFP4000 and NFP6000, the NFP5000 as an erratum where reading/
writing to PCI config space addresses above 0x600 can cause the NFP
to generate PCIe completion timeouts.

Limit the NFP5000's PF's config space size to 0x600 bytes as is already
done for the NFP4000 and NFP6000.

The NFP5000's VF is 0x6003 (PCI_DEVICE_ID_NETRONOME_NFP6000_VF), the same
device ID as the NFP6000's VF.  Thus, its config space is already limited
by the existing use of quirk_nfp6000().

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Tony Egan <tony.egan@netronome.com>
---
 drivers/pci/quirks.c    | 1 +
 include/linux/pci_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de848658..bf899184d07c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -460,6 +460,7 @@ static void quirk_nfp6000(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP4000,	quirk_nfp6000);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000,	quirk_nfp6000);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP5000,	quirk_nfp6000);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000_VF,	quirk_nfp6000);
 
 /*  On IBM Crocodile ipr SAS adapters, expand BAR to system page size */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 29502238e510..381fc009551d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2541,6 +2541,7 @@
 #define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
 #define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240
 #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
+#define PCI_DEVICE_ID_NETRONOME_NFP5000	0x5000
 #define PCI_DEVICE_ID_NETRONOME_NFP6000	0x6000
 #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
 
-- 
2.17.1
