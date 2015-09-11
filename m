Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbbIKSQu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Sep 2015 14:16:50 -0400
Subject: [RFC PATCH] vfio/pci: Use kernel VPD access functions
From: Alex Williamson <alex.williamson@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, mark.d.rustad@intel.com,
	alexander.h.duyck@redhat.com, myron.stowe@redhat.com,
	linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2015 12:16:49 -0600
Message-ID: <20150911181332.32399.74472.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI VPD capability operates on a set of window registers in PCI
config space.  Writing to the address register triggers either a read
or write, depending on the setting of the PCI_VPD_ADDR_F bit within
the address register.  The data register provides either the source
for writes or the target for reads.

This model is susceptible to being broken by concurrent access, for
which the kernel has adopted a set of access functions to serialize
these registers.  Additionally, commits like 932c435caba8 ("PCI: Add
dev_flags bit to access VPD through function 0") and 7aa6ca4d39ed
("PCI: Add VPD function 0 quirk for Intel Ethernet devices") indicate
that VPD registers can be shared between functions on multifunction
devices creating dependencies between otherwise independent devices.

Fortunately it's quite easy to emulate the VPD registers, simply
storing copies of the address and data registers in memory and
triggering a VPD read or write on writes to the address register.
This allows vfio users to avoid seeing spurious register changes from
accesses on other devices and enables the use of shared quirks in the
host kernel.  We can theoretically still race with access through
sysfs, but the window of opportunity is much smaller.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

RFC - Is this something we should do?  Should we consider providing
similar emulation through PCI sysfs to allow lspci to also make use
of the vpd interfaces?

 drivers/vfio/pci/vfio_pci_config.c |   70 +++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index ff75ca3..a8657ef 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -671,6 +671,73 @@ static int __init init_pci_cap_pm_perm(struct perm_bits *perm)
 	return 0;
 }
 
+static int vfio_vpd_config_write(struct vfio_pci_device *vdev, int pos,
+				 int count, struct perm_bits *perm,
+				 int offset, __le32 val)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	__le16 *paddr = (__le16 *)(vdev->vconfig + pos - offset + PCI_VPD_ADDR);
+	__le32 *pdata = (__le32 *)(vdev->vconfig + pos - offset + PCI_VPD_DATA);
+	u16 addr;
+	u32 data;
+
+	/*
+	 * Write through to emulation.  If the write includes the upper byte
+	 * of PCI_VPD_ADDR, then the PCI_VPD_ADDR_F bit is written and we
+	 * have work to do.
+	 */
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (count < 0 || offset > PCI_VPD_ADDR + 1 ||
+	    offset + count <= PCI_VPD_ADDR + 1)
+		return count;
+
+	addr = le16_to_cpu(*paddr);
+
+	if (addr & PCI_VPD_ADDR_F) {
+		data = le32_to_cpu(*pdata);
+		if (pci_write_vpd(pdev, addr & ~PCI_VPD_ADDR_F, 4, &data) != 4)
+			return count;
+	} else {
+		if (pci_read_vpd(pdev, addr, 4, &data) != 4)
+			return count;
+		*pdata = cpu_to_le32(data);
+	}
+
+	/*
+	 * Toggle PCI_VPD_ADDR_F in the emulated PCI_VPD_ADDR register to
+	 * signal completion.  If an error occurs above, we assume that not
+	 * toggling this bit will induce a driver timeout.
+	 */
+	addr ^= PCI_VPD_ADDR_F;
+	*paddr = cpu_to_le16(addr);
+
+	return count;
+}
+
+/* Permissions for Vital Product Data capability */
+static int __init init_pci_cap_vpd_perm(struct perm_bits *perm)
+{
+	if (alloc_perm_bits(perm, pci_cap_length[PCI_CAP_ID_VPD]))
+		return -ENOMEM;
+
+	perm->writefn = vfio_vpd_config_write;
+
+	/*
+	 * We always virtualize the next field so we can remove
+	 * capabilities from the chain if we want to.
+	 */
+	p_setb(perm, PCI_CAP_LIST_NEXT, (u8)ALL_VIRT, NO_WRITE);
+
+	/*
+	 * Both the address and data registers are virtualized to
+	 * enable access through the pci_vpd_read/write functions
+	 */
+	p_setw(perm, PCI_VPD_ADDR, (u16)ALL_VIRT, (u16)ALL_WRITE);
+	p_setd(perm, PCI_VPD_DATA, ALL_VIRT, ALL_WRITE);
+
+	return 0;
+}
+
 /* Permissions for PCI-X capability */
 static int __init init_pci_cap_pcix_perm(struct perm_bits *perm)
 {
@@ -790,6 +857,7 @@ void vfio_pci_uninit_perm_bits(void)
 	free_perm_bits(&cap_perms[PCI_CAP_ID_BASIC]);
 
 	free_perm_bits(&cap_perms[PCI_CAP_ID_PM]);
+	free_perm_bits(&cap_perms[PCI_CAP_ID_VPD]);
 	free_perm_bits(&cap_perms[PCI_CAP_ID_PCIX]);
 	free_perm_bits(&cap_perms[PCI_CAP_ID_EXP]);
 	free_perm_bits(&cap_perms[PCI_CAP_ID_AF]);
@@ -807,7 +875,7 @@ int __init vfio_pci_init_perm_bits(void)
 
 	/* Capabilities */
 	ret |= init_pci_cap_pm_perm(&cap_perms[PCI_CAP_ID_PM]);
-	cap_perms[PCI_CAP_ID_VPD].writefn = vfio_raw_config_write;
+	ret |= init_pci_cap_vpd_perm(&cap_perms[PCI_CAP_ID_VPD]);
 	ret |= init_pci_cap_pcix_perm(&cap_perms[PCI_CAP_ID_PCIX]);
 	cap_perms[PCI_CAP_ID_VNDR].writefn = vfio_raw_config_write;
 	ret |= init_pci_cap_exp_perm(&cap_perms[PCI_CAP_ID_EXP]);

