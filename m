Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 06/10] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
Date: Mon, 18 Apr 2016 18:58:36 +0800
Message-Id: <1460977120-29367-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
which indicates all devices on the bus are protected by the
hardware which supports IRQ remapping(intel naming).

This flag will be used to know whether it's safe to expose
MSI-X tables of PCI BARs to userspace. Because the capability
of IRQ remapping can guarantee the PCI device cannot trigger
MSIs that correspond to interrupt IDs of other devices.

There is a existing flag for this in the IOMMU space:

enum iommu_cap {
	IOMMU_CAP_CACHE_COHERENCY,
--->	IOMMU_CAP_INTR_REMAP,
	IOMMU_CAP_NOEXEC,
};

and Eric also posted a patchset [1] to abstract this
capability on MSI controller side for ARM. But it would
make sense to have a more common flag like
PCI_BUS_FLAGS_MSI_REMAP so that we can use a universal
flag to test this capability for different archs on
PCI side.

[1] http://www.spinics.net/lists/kvm/msg130256.html

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 include/linux/pci.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..d619228 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -193,6 +193,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+	PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 4,
 };
 
 /* These values come from the PCI Express Spec */
-- 
1.7.9.5
