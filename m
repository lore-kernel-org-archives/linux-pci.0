Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23330 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbJHVjy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 17:39:54 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v7 04/60] sparc/PCI: Reserve legacy mmio after PCI mmio
Date: Thu,  8 Oct 2015 14:38:23 -0700
Message-Id: <1444340359-8011-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On one system found bunch of claim resource fail from pci device.
pci_sun4v f02b894c: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x2000000000000-0x200007effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x20007ffffffff] (bus address [0x100000000-0x7ffffffff])
...
PCI: Claiming 0000:00:02.0: Resource 14: 0002000000000000..00020000004fffff [200]
pci 0000:00:02.0: can't claim BAR 14 [mem 0x2000000000000-0x20000004fffff]: address conflict with Video RAM area [??? 0x20000000a0000-0x20000000bffff flags 0x80000000]
pci 0000:02:00.0: can't claim BAR 0 [mem 0x2000000000000-0x20000000fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.0: Resource 3: 0002000000100000..0002000000103fff [200]
pci 0000:02:00.0: can't claim BAR 3 [mem 0x2000000100000-0x2000000103fff]: no compatible bridge window
PCI: Claiming 0000:02:00.1: Resource 0: 0002000000200000..00020000002fffff [200]
pci 0000:02:00.1: can't claim BAR 0 [mem 0x2000000200000-0x20000002fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.1: Resource 3: 0002000000104000..0002000000107fff [200]
pci 0000:02:00.1: can't claim BAR 3 [mem 0x2000000104000-0x2000000107fff]: no compatible bridge window
PCI: Claiming 0000:02:00.2: Resource 0: 0002000000300000..00020000003fffff [200]
pci 0000:02:00.2: can't claim BAR 0 [mem 0x2000000300000-0x20000003fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.2: Resource 3: 0002000000108000..000200000010bfff [200]
pci 0000:02:00.2: can't claim BAR 3 [mem 0x2000000108000-0x200000010bfff]: no compatible bridge window
PCI: Claiming 0000:02:00.3: Resource 0: 0002000000400000..00020000004fffff [200]
pci 0000:02:00.3: can't claim BAR 0 [mem 0x2000000400000-0x20000004fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.3: Resource 3: 000200000010c000..000200000010ffff [200]
pci 0000:02:00.3: can't claim BAR 3 [mem 0x200000010c000-0x200000010ffff]: no compatible bridge window

The bridge 00:02.0 resource does not get reserved as Video RAM take the position early,
and following children all failed.

Move down Video RAM area reservation after pci mmio get reserved,
so we leave pci driver to use those regions.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/sparc/kernel/pci.c        | 1 +
 arch/sparc/kernel/pci_common.c | 3 +--
 arch/sparc/kernel/pci_impl.h   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 451792e..41dcbc7 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -677,6 +677,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pci_bus_register_of_sysfs(bus);
 
 	pci_claim_bus_resources(bus);
+	pci_register_legacy_regions(pbm);
 	pci_bus_add_devices(bus);
 	return bus;
 }
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index c4b6989..957dc9d 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -363,7 +363,7 @@ static void pci_register_region(struct pci_pbm_info *pbm, const char *name,
 	}
 }
 
-static void pci_register_legacy_regions(struct pci_pbm_info *pbm)
+void pci_register_legacy_regions(struct pci_pbm_info *pbm)
 {
 	/* VGA Video RAM. */
 	pci_register_region(pbm, "Video RAM area", 0xa0000UL, 0x20000UL);
@@ -498,7 +498,6 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	if (pbm->mem64_space.flags)
 		request_resource(&iomem_resource, &pbm->mem64_space);
 
-	pci_register_legacy_regions(pbm);
 	pci_register_iommu_region(pbm);
 }
 
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 08b74af..5b92ad4 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -166,6 +166,7 @@ void pci_get_pbm_props(struct pci_pbm_info *pbm);
 struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 				 struct device *parent);
 void pci_determine_mem_io_space(struct pci_pbm_info *pbm);
+void pci_register_legacy_regions(struct pci_pbm_info *pbm);
 
 /* Error reporting support. */
 void pci_scan_for_target_abort(struct pci_pbm_info *, struct pci_bus *);
-- 
1.8.4.5

