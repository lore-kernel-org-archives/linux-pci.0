Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51658 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbaJBBOo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 21:14:44 -0400
Message-ID: <1412210052.10667.0.camel@pasglop>
Subject: [PATCH v2 1/4] pci/msi: Move "no_64bit_msi" flag from powerpc to
 generic pci_dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 02 Oct 2014 10:34:12 +1000
In-Reply-To: <1412112324.4285.160.camel@pasglop>
References: <1412048401.4285.128.camel@pasglop>
	 <CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
	 <CADnq5_PT+dX=KA4epGNRaoraco2z1pe5K7UgqLmTUhWMnvtWkw@mail.gmail.com>
	 <1412108504.4285.155.camel@pasglop>
	 <CADnq5_O_iLAZUKLL4nph8VwuP2NOkWXhBZC2XTSkFm5P42WZ+g@mail.gmail.com>
	 <1412110946.4285.158.camel@pasglop>
	 <CADnq5_OXBax1+TKPsR2RDYTWijQKDVw34ECfWzcwN2SibCGYTg@mail.gmail.com>
	 <1412112324.4285.160.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Some devices have broken 64-bit MSI support which only support some
address bits (40 to 48 typically). This doesn't work on some platforms
such as POWER servers, so we need a quirk.

Currently we keep a flag in a powerpc specific data structure which we
have per PCI device. However this is impractical as we really want the
driver to set that flag appropriately (and the driver shouldn't touch
that arch specific data structure).

It's also not unlikely that this limitation will affect other architectures
in the long run.

So this moves the flag to struct pci_dev instead and adjusts the
corresponding arch/powerpc code to look for it there. At this point,
there is no attempt at making other architectures honor it just yet,
though it appears that x86 doesn't care and always generates 32-bit
MSI addresses.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---

v2: Rename flag to "no_64bit_msi" as suggested by Bjorn

 arch/powerpc/include/asm/pci-bridge.h     | 2 --
 arch/powerpc/kernel/pci_64.c              | 5 +----
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 +--
 arch/powerpc/platforms/powernv/pci.c      | 3 +--
 arch/powerpc/platforms/pseries/msi.c      | 2 +-
 include/linux/pci.h                       | 1 +
 6 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 4ca90a3..725247b 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -159,8 +159,6 @@ struct pci_dn {
 
 	int	pci_ext_config_space;	/* for pci devices */
 
-	bool	force_32bit_msi;
-
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 155013d..d41a831 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -269,10 +269,7 @@ EXPORT_SYMBOL(pcibus_to_node);
 
 static void quirk_radeon_32bit_msi(struct pci_dev *dev)
 {
-	struct pci_dn *pdn = pci_get_pdn(dev);
-
-	if (pdn)
-		pdn->force_32bit_msi = true;
+	dev->no_64bit_msi = true;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index df241b1..a188bb8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1311,7 +1311,6 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int is_64, struct msi_msg *msg)
 {
 	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
-	struct pci_dn *pdn = pci_get_pdn(dev);
 	struct irq_data *idata;
 	struct irq_chip *ichip;
 	unsigned int xive_num = hwirq - phb->msi_base;
@@ -1327,7 +1326,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 		return -ENXIO;
 
 	/* Force 32-bit MSI on some broken devices */
-	if (pdn && pdn->force_32bit_msi)
+	if (dev->no_64bit_msi)
 		is_64 = 0;
 
 	/* Assign XIVE to PE */
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b854b57..89c6608 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -50,9 +50,8 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pci_get_pdn(pdev);
 
-	if (pdn && pdn->force_32bit_msi && !phb->msi32_support)
+	if (pdev->no_64bit_msi && !phb->msi32_support)
 		return -ENODEV;
 
 	return (phb && phb->msi_bmp.bitmap) ? 0 : -ENODEV;
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 18ff462..6fd96d8 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -429,7 +429,7 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 	 */
 again:
 	if (type == PCI_CAP_ID_MSI) {
-		if (pdn->force_32bit_msi) {
+		if (pdev->no_64bit_msi) {
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
 			if (rc < 0) {
 				/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 96453f9..fc938003 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -331,6 +331,7 @@ struct pci_dev {
 	unsigned int	is_added:1;
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
+	unsigned int    no_64bit_msi:1;	/* Device has broken 64-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* config space access is blocked */
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 	unsigned int	irq_reroute_variant:2;	/* device needs IRQ rerouting variant */



