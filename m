Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbeF3S52 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 30 Jun 2018 14:57:28 -0400
Date: Sat, 30 Jun 2018 13:57:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dmeyer@gigaio.com
Cc: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
        bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI Quirk Patchset for Microsemi Switchtec NTB
Message-ID: <20180630185726.GA9547@bhelgaas-glaptop.roam.corp.google.com>
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
 <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 29, 2018 at 08:50:02PM -0500, Bjorn Helgaas wrote:
> On Wed, May 23, 2018 at 01:18:04PM -0700, dmeyer@gigaio.com wrote:
> > From: Doug Meyer <dmeyer@gigaio.com>
> > 
> > This is a resend of the patch series to enable Microsemi Switchtec
> > NTB configurations to run with the IOMMU in the hosts turned on.
> > Because of the nature PCI Quirk implementation, it was preferable
> > to migrate the Microsemi PCI vendor and device definitions to the
> > Linux canonical location. Logan Gunthorpe requested that this
> > migration be done as a separate patch in a set, and so this patch
> > series was created as shown here.
> > 
> > The first patch encapsulates the movement of constants from
> > switchtec.h to pci_ids.h, with commensurate changes to the source
> > files. This patch is not dependent on any other work.
> > 
> > The second patch is the PCI quirk implementation itself, and is
> > completely dependent upon the first patch in this series.
> > 
> > Testing of the quirk was done on with a 2-host x86-64 system
> > with all combinations of IOMMU off/on. The ntb_perf module was
> > used as test stimulus. 
> > 
> > Blessings,
> > Doug Meyer
> > 
> > Changes since v1:
> > - Call pci_device_disable() at return points to clean up properly.
> > - Changed all dev_* print macros to pci_* macros.
> > - Removed superfluous variable initializations.
> > 
> > Doug Meyer (2):
> >   NTB: Migrate PCI Constants to Cannonical PCI Header
> >   NTB: PCI Quirk to Enable Switchtec NT Functionality with IOMMU On
> > 
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |   3 +-
> >  drivers/pci/quirks.c                   | 197 +++++++++++++++++++++++++++++++++
> >  drivers/pci/switch/switchtec.c         |  15 ++-
> >  include/linux/pci_ids.h                |  32 ++++++
> >  include/linux/switchtec.h              |   4 -
> >  5 files changed, 238 insertions(+), 13 deletions(-)
> 
> I applied these with Logan's reviewed-by to my pci/switchtec branch for
> v4.19 with the following updates:
> 
>   - You removed the SPDX tag from drivers/pci/switch/switchtec.c.  I assume
>     that was a mistake, so I restored it.
> 
>   - I moved the PCI_VENDOR_ID_MICROSEMI definition to keep the file sorted.
> 
>   - I dropped the Device ID definitions per the policy at the top of the
>     file (which I mentioned on your v1 posting).
> 
>   - I converted all the Device ID definition uses to raw hex constants.  I
>     noticed that the following were defined by your patch, but not used:
> 
>       PCI_DEVICE_ID_MICROSEMI_PSX24XG3
>       PCI_DEVICE_ID_MICROSEMI_PSX32XG3
> 
>     I can't tell whether the quirk is supposed to apply to them or not.
> 
> Please review and holler if I broke something.
> 
> This touches drivers/ntb/hw/..., which isn't my area.  Let me know if you'd
> rather take these through a different tree.

I also:

  - Fixed the sparse warnings reported by the kbuild test robot.

  - Removed some (void * __iomem) casts in the ioread32() parameters and
    the (u64) cast on the return value.  I noticed that
    switchtec_ntb_init_sndev() does an ioread64() of ep_map instead of two
    ioread32() calls.  I suspect both places could and should do it the
    same way.

  - Used %02x.%d instead of %02d.%d when printing the DMA alias, so it
    matches the other places that print PCI device addresses.

  - Replaced DECLARE_PCI_FIXUP_CLASS_FINAL with DECLARE_PCI_FIXUP_FINAL,
    since it should be sufficient to filter on Vendor and Device ID,
    without worrying about the class.

Here's the diff from what you originally posted to what's currently on my
pci/switchtec branch:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f178cecdc001..d54a182a09cf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4787,14 +4787,13 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 	pci_info(pdev, "Setting Switchtec proxy ID aliases\n");
 
 	mmio_ntb = mmio + SWITCHTEC_GAS_NTB_OFFSET;
-	mmio_ctrl = (void * __iomem) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
+	mmio_ctrl = (void __iomem *) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
 	mmio_sys_info = mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
 
 	partition = ioread8(&mmio_ntb->partition_id);
 
-	partition_map = (u64) ioread32((void * __iomem) &mmio_ntb->ep_map);
-	partition_map |=
-		((u64) ioread32((void * __iomem) &mmio_ntb->ep_map + 4)) << 32;
+	partition_map = ioread32(&mmio_ntb->ep_map);
+	partition_map |= ((u64) ioread32(&mmio_ntb->ep_map + 4)) << 32;
 	partition_map &= ~(1ULL << partition);
 
 	for (pp = 0; pp < (sizeof(partition_map) * 8); pp++) {
@@ -4829,7 +4828,7 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 			rid_entry = ioread32(&mmio_peer_ctrl->req_id_table[te]);
 			devfn = (rid_entry >> 1) & 0xFF;
 			pci_dbg(pdev,
-				"Aliasing Partition %d Proxy ID %02d.%d\n",
+				"Aliasing Partition %d Proxy ID %02x.%d\n",
 				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
 			pci_add_dma_alias(pdev, devfn);
 		}
@@ -4838,115 +4837,59 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 	pci_iounmap(pdev, mmio);
 	pci_disable_device(pdev);
 }
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFX24XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFX32XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFX48XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFX64XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFX80XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFX96XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PSX48XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PSX64XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PSX80XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PSX96XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PAX24XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PAX32XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PAX48XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PAX64XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PAX80XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PAX96XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXL24XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXL32XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXL48XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXL64XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXL80XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXL96XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXI24XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXI32XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXI48XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXI64XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXI80XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
-			      PCI_DEVICE_ID_MICROSEMI_PFXI96XG3,
-			      PCI_CLASS_BRIDGE_OTHER, 8,
-			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8531,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8532,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8533,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8534,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8535,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8536,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8543,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8544,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8545,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8546,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8551,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8552,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8553,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8554,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8555,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8556,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8561,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8562,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8563,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8564,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8565,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8566,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8571,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8572,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8573,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8574,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8575,
+			quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8576,
+			quirk_switchtec_ntb_dma_alias);
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 07a03b90498e..9940cc70f38b 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Microsemi Switchtec(tm) PCIe Management Driver
  * Copyright (c) 2017, Microsemi Corporation
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 7bc61402d28b..80aec5b9a6c1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1668,6 +1668,7 @@
 #define PCI_DEVICE_ID_COMPEX_ENET100VG4	0x0112
 
 #define PCI_VENDOR_ID_PMC_Sierra	0x11f8
+#define PCI_VENDOR_ID_MICROSEMI		0x11f8
 
 #define PCI_VENDOR_ID_RP		0x11fe
 #define PCI_DEVICE_ID_RP32INTF		0x0001
@@ -3082,36 +3083,4 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
-#define PCI_VENDOR_ID_MICROSEMI			0x11f8
-#define PCI_DEVICE_ID_MICROSEMI_PFX24XG3	0x8531
-#define PCI_DEVICE_ID_MICROSEMI_PFX32XG3	0x8532
-#define PCI_DEVICE_ID_MICROSEMI_PFX48XG3	0x8533
-#define PCI_DEVICE_ID_MICROSEMI_PFX64XG3	0x8534
-#define PCI_DEVICE_ID_MICROSEMI_PFX80XG3	0x8535
-#define PCI_DEVICE_ID_MICROSEMI_PFX96XG3	0x8536
-#define PCI_DEVICE_ID_MICROSEMI_PSX24XG3	0x8541
-#define PCI_DEVICE_ID_MICROSEMI_PSX32XG3	0x8542
-#define PCI_DEVICE_ID_MICROSEMI_PSX48XG3	0x8543
-#define PCI_DEVICE_ID_MICROSEMI_PSX64XG3	0x8544
-#define PCI_DEVICE_ID_MICROSEMI_PSX80XG3	0x8545
-#define PCI_DEVICE_ID_MICROSEMI_PSX96XG3	0x8546
-#define PCI_DEVICE_ID_MICROSEMI_PAX24XG3	0x8551
-#define PCI_DEVICE_ID_MICROSEMI_PAX32XG3	0x8552
-#define PCI_DEVICE_ID_MICROSEMI_PAX48XG3	0x8553
-#define PCI_DEVICE_ID_MICROSEMI_PAX64XG3	0x8554
-#define PCI_DEVICE_ID_MICROSEMI_PAX80XG3	0x8555
-#define PCI_DEVICE_ID_MICROSEMI_PAX96XG3	0x8556
-#define PCI_DEVICE_ID_MICROSEMI_PFXL24XG3	0x8561
-#define PCI_DEVICE_ID_MICROSEMI_PFXL32XG3	0x8562
-#define PCI_DEVICE_ID_MICROSEMI_PFXL48XG3	0x8563
-#define PCI_DEVICE_ID_MICROSEMI_PFXL64XG3	0x8564
-#define PCI_DEVICE_ID_MICROSEMI_PFXL80XG3	0x8565
-#define PCI_DEVICE_ID_MICROSEMI_PFXL96XG3	0x8566
-#define PCI_DEVICE_ID_MICROSEMI_PFXI24XG3	0x8571
-#define PCI_DEVICE_ID_MICROSEMI_PFXI32XG3	0x8572
-#define PCI_DEVICE_ID_MICROSEMI_PFXI48XG3	0x8573
-#define PCI_DEVICE_ID_MICROSEMI_PFXI64XG3	0x8574
-#define PCI_DEVICE_ID_MICROSEMI_PFXI80XG3	0x8575
-#define PCI_DEVICE_ID_MICROSEMI_PFXI96XG3	0x8576
-
 #endif /* _LINUX_PCI_IDS_H */
