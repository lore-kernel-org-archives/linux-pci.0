Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <201605301338.u4UDY5lS030402@mx0a-001b2d01.pphosted.com>
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
Subject: [PATCH v2 3/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
Date: Mon, 30 May 2016 21:32:10 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The capability of IRQ remapping is abstracted on IOMMU side on
some archs. There is a existing flag IOMMU_CAP_INTR_REMAP for this.

To have a universal flag to test this capability for different
archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
when IOMMU_CAP_INTR_REMAP is set.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/probe.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2b9e3ba..15a33e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -16,6 +16,7 @@
 #include <linux/aer.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
+#include <linux/iommu.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -2160,6 +2161,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	pci_set_bus_of_node(b);
 	pci_set_bus_msi_domain(b);
 
+	if (iommu_capable(&pci_bus_type, IOMMU_CAP_INTR_REMAP))
+		b->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+
 	if (!parent)
 		set_dev_node(b->bridge, pcibus_to_node(b));
 
-- 
1.7.9.5
