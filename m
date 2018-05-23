Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44400 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934825AbeEWUSu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 16:18:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id q22-v6so11037338pff.11
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 13:18:49 -0700 (PDT)
From: dmeyer@gigaio.com
To: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>
Subject: [PATCH v2 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality with IOMMU On
Date: Wed, 23 May 2018 13:18:06 -0700
Message-Id: <1527106686-18852-3-git-send-email-dmeyer@gigaio.com>
In-Reply-To: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Doug Meyer <dmeyer@gigaio.com>

Here we add the PCI quirk for the Microsemi Switchtec parts to allow
DMA access via non-transparent bridging to work when the IOMMU is
turned on.

This exclusively addresses the ability of a remote NT endpoint to
perform DMA accesses through the locally enumerated NT endpoint.
Other aspects of the Switchtec NTB functionality, such as interrupts
for doorbells and messages are independent of this quirk, and will
work whether the IOMMU is on or off.

When a requestor on one NT endpoint accesses memory on another NT
endpoint, it does this via a devfn proxy ID. Proxy IDs are statically
assigned to each NT endpoint by the NTB hardware as part of the
release-from-reset sequence prior to PCI enumeration. These proxy IDs
cannot be modified dynamically, and are not visible to the host during
enumeration.

When the Switchtec NTB driver loads it will map local requestor IDs,
such as the root complex and transparent bridge DMA engines, to proxy
IDs by populating those requestor IDs in hardware mapping table table
entries. This establishes a fixed relationship between a requestor ID
and a proxy ID.

When a peer on a remote NT endpoint performs an access within a
particular translation window in it's NT endpoint BAR address space,
that access is translated to a DMA request on the local endpoint's
bus. As part of the translation process, the original requestor ID has
its devfn replaced with the proxy ID, and the bus portion of the BDF
is replaced with the bus of the local NT endpoint. Thus, the DMA
access from a remote NT endpoint will appear on the local bus to have
come from the unknown devfn which the IOMMU will reject.

The quirk introduced here interrogates NTB hardware registers for each
remote NT endpoint to obtain the proxy IDs that have been assigned to
it, and aliases them to the local (enumerated) NT endpoint's
device. The IOMMU then accepts the remote proxy IDs as if they were
requests coming directly from the enumerated endpoint, giving remote
requestors access to memory resources which the local host has made
available.

Note that the aliasing of the proxy IDs cannot be performed at the
driver level given the current IOMMU architecture. Superficially this
is because pci_add_dma_alias() symbol is not exported. Functionally,
the current IOMMU design requires the aliasing to be performed prior
to the creation of IOMMU groups. If a driver were to attempt to use
pci_add_dma_alias() in its probe routine it would fail since the
IOMMU groups have been set up by that time. If the Switchtec hardware
supported dynamic proxy ID (re-)assignment this would be an issue, but
it does not.

To further clarify static proxy ID assignment: While the requester
ID to proxy ID mapping can be dynamically changed, the number and
value of proxy IDs given to an NT EP cannot, even for dynamic
reconfiguration such as hot-add. Therefore, the chip configuration
must account a priori for the proxy IDs needs, considering both
static and dynamic system configurations. For example, a port on the
chip may not having anything plugged into it at start of day; but it
must have a sufficient number of proxy IDs assigned to accommodate the
supported devices which may be hot-added.

Switchtec NTB functionality with the IOMMU off is unchanged by this quirk.

Signed-off-by: Doug Meyer <dmeyer@gigaio.com>
---
 drivers/pci/quirks.c | 197 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1..4456165 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
+#include <linux/switchtec.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -4741,3 +4742,199 @@ static void quirk_gpu_hda(struct pci_dev *hda)
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
+
+/*
+ * Microsemi Switchtec NTB uses devfn proxy IDs to move TLPs between
+ * NT endpoints via the internal switch fabric. These IDs replace the
+ * originating requestor ID TLPs which access host memory on peer NTB
+ * ports. Therefore, all proxy IDs must be aliased to the NTB device
+ * to permit access when the IOMMU is turned on.
+ */
+static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
+{
+	void __iomem *mmio;
+	struct ntb_info_regs __iomem *mmio_ntb;
+	struct ntb_ctrl_regs __iomem *mmio_ctrl;
+	struct sys_info_regs __iomem *mmio_sys_info;
+	u64 partition_map;
+	u8 partition;
+	int pp;
+
+	if (pci_enable_device(pdev)) {
+		pci_err(pdev, "Cannot enable Switchtec device\n");
+		return;
+	}
+
+	mmio = pci_iomap(pdev, 0, 0);
+	if (mmio == NULL) {
+		pci_disable_device(pdev);
+		pci_err(pdev, "Cannot iomap Switchtec device\n");
+		return;
+	}
+
+	pci_info(pdev, "Setting Switchtec proxy ID aliases\n");
+
+	mmio_ntb = mmio + SWITCHTEC_GAS_NTB_OFFSET;
+	mmio_ctrl = (void * __iomem) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
+	mmio_sys_info = mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
+
+	partition = ioread8(&mmio_ntb->partition_id);
+
+	partition_map = (u64) ioread32((void * __iomem) &mmio_ntb->ep_map);
+	partition_map |=
+		((u64) ioread32((void * __iomem) &mmio_ntb->ep_map + 4)) << 32;
+	partition_map &= ~(1ULL << partition);
+
+	for (pp = 0; pp < (sizeof(partition_map) * 8); pp++) {
+		struct ntb_ctrl_regs __iomem *mmio_peer_ctrl;
+		u32 table_sz = 0;
+		int te;
+
+		if (!(partition_map & (1ULL << pp)))
+			continue;
+
+		pci_dbg(pdev, "Processing partition %d\n", pp);
+
+		mmio_peer_ctrl = &mmio_ctrl[pp];
+
+		table_sz = ioread16(&mmio_peer_ctrl->req_id_table_size);
+		if (!table_sz) {
+			pci_warn(pdev, "Partition %d table_sz 0\n", pp);
+			continue;
+		}
+
+		if (table_sz > 512) {
+			pci_warn(pdev,
+				 "Invalid Switchtec partition %d table_sz %d\n",
+				 pp, table_sz);
+			continue;
+		}
+
+		for (te = 0; te < table_sz; te++) {
+			u32 rid_entry;
+			u8 devfn;
+
+			rid_entry = ioread32(&mmio_peer_ctrl->req_id_table[te]);
+			devfn = (rid_entry >> 1) & 0xFF;
+			pci_dbg(pdev,
+				"Aliasing Partition %d Proxy ID %02d.%d\n",
+				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
+			pci_add_dma_alias(pdev, devfn);
+		}
+	}
+
+	pci_iounmap(pdev, mmio);
+	pci_disable_device(pdev);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFX24XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFX32XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFX48XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFX64XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFX80XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFX96XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PSX48XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PSX64XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PSX80XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PSX96XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PAX24XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PAX32XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PAX48XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PAX64XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PAX80XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PAX96XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXL24XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXL32XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXL48XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXL64XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXL80XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXL96XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXI24XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXI32XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXI48XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXI64XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXI80XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
+			      PCI_DEVICE_ID_MICROSEMI_PFXI96XG3,
+			      PCI_CLASS_BRIDGE_OTHER, 8,
+			      quirk_switchtec_ntb_dma_alias);
-- 
1.8.3.1
