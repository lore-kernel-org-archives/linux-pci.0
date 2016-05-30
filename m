Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <201605301337.u4UDY4eh016595@mx0a-001b2d01.pphosted.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 1/6] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
Date: Mon, 30 May 2016 21:32:08 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
which indicates interrupts of all devices on the bus are
managed by the hardware enabling IRQ remapping(intel naming).
When the capability is enabled, a given PCI device can only
shoot the MSIs assigned for it. In other words, the hardware
can protect system from invalid MSIs of the device by checking
the target address and data when there is something wrong
with MSI part in device or device driver.

There is a existing flag for this capability in the IOMMU space:

enum iommu_cap {
	IOMMU_CAP_CACHE_COHERENCY,
--->	IOMMU_CAP_INTR_REMAP,
	IOMMU_CAP_NOEXEC,
};

and Eric also posted a patchset [1] to abstract it on MSI
controller side for ARM. But it would make sense to have a
more common flag like PCI_BUS_FLAGS_MSI_REMAP so that we can
use a universal flag to test this capability on PCI side for
different archs.

With this flag enabled, we can easily know whether it's safe
to expose MSI-X tables of PCI BARs to userspace. Some usespace
drivers such as VFIO may benefit from this.

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 include/linux/pci.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 932ec74..4ec37da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -187,6 +187,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+	PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 4,
 };
 
 /* These values come from the PCI Express Spec */
-- 
1.7.9.5
