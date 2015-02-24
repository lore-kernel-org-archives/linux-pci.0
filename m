Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:41468 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbBXIc5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:32:57 -0500
Received: by padfb1 with SMTP id fb1so34389137pad.8
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:32:57 -0800 (PST)
Subject: [PATCH v12 00/21] Enable SRIOV on Power8
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 02:32:55 -0600
Message-ID: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Wei Yang's most recent POWER8 SR-IOV patchset was v11, posted on Jan 15,
2015.

I'm having a hard time keeping everything straight between the tweaks I've
made on my branch and incremental updates.  I think it's easier to repost
the whole series so one can easily collect everything that goes together.
So here'a a v12 with the changes I've made.

Wei, please follow up with a v13 to fix anything I broke here.  Here's how
I would do that using stgit:

  git checkout -b pci/virtualization-v13 pci/virtualization-v12
  stg init
  stg uncommit -n 21
  <hack on the patches>
  stg mail -v v13 ... pci-print-more-info-in..powerpc-pci-add-pci-resource

I put v10, v11, and v12 on branches based on v4.0-rc1:

  pci/virtualization-v10	(posted 12/22/2014)
  pci/virtualization-v11	(posted 01/15/2015)
  pci/virtualization-v12	(this posting)

This makes it relatively easy to diff the versions, e.g.,

  git diff pci/virtualization-v11 pci/virtualization-v12

These branches are at

  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/

v12:
   * remove "align" parameter from pcibios_iov_resource_alignment()
     default version returns pci_iov_resource_size() instead of the
     "align" parameter
   * in powerpc pcibios_iov_resource_alignment(), return
     pci_iov_resource_size() if there's no ppc_md function pointer
   * in pci_sriov_resource_alignment(), don't re-read base, since we
     saved the required alignment when reading it the first time
   * remove "vf_num" parameter from add_dev_pci_info() and
     remove_dev_pci_info(); use pci_sriov_get_totalvfs() instead
   * use dev_warn() instead of pr_warn() when possible
   * check to be sure IOV BAR is still in range after shifting, change
     pnv_pci_vf_resource_shift() from void to int
   * improve sriov_enable() error message
   * improve SR-IOV BAR sizing message
   * index IOV resources in conventional style
   * include preamble patches (refresh offset/stride when updating numVFs,
     calculate max buses required
   * restructure pci_iov_max_bus_range() to return value instead of updating
     internally, rename to virtfn_max_buses()
   * fix typos & formatting
   * expand documentation

Bjorn

---

Bjorn Helgaas (2):
      PCI: Print more info in sriov_enable() error message
      PCI: Index IOV resources in the conventional style

Gavin Shan (1):
      powerpc/pci: Refactor pci_dn

Wei Yang (18):
      PCI: Print PF SR-IOV resource that contains all VF(n) BAR space
      PCI: Keep individual VF BAR size in struct pci_sriov
      PCI: Refresh First VF Offset and VF Stride when updating NumVFs
      PCI: Calculate maximum number of buses required for VFs
      PCI: Export pci_iov_virtfn_bus() and pci_iov_virtfn_devfn()
      PCI: Add pcibios_sriov_enable() and pcibios_sriov_disable()
      PCI: Add pcibios_iov_resource_alignment() interface
      PCI: Consider additional PF's IOV BAR alignment in sizing and assigning
      powerpc/pci: Don't unset PCI resources for VFs
      powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
      powerpc/powernv: Allocate struct pnv_ioda_pe iommu_table dynamically
      powerpc/powernv: Reserve additional space for IOV BAR according to the number of total_pe
      powerpc/powernv: Implement pcibios_iov_resource_alignment() on powernv
      powerpc/powernv: Shift VF resource with an offset
      powerpc/powernv: Reserve additional space for IOV BAR, with m64_per_iov supported
      powerpc/powernv: Group VF PE when IOV BAR is big on PHB3
      powerpc/pci: Remove unused struct pci_dn.pcidev field
      powerpc/pci: Add PCI resource alignment documentation


 .../powerpc/pci_iov_resource_on_powernv.txt        |  305 ++++++++
 arch/powerpc/include/asm/device.h                  |    3 
 arch/powerpc/include/asm/iommu.h                   |    3 
 arch/powerpc/include/asm/machdep.h                 |    5 
 arch/powerpc/include/asm/pci-bridge.h              |   24 +
 arch/powerpc/kernel/pci-common.c                   |   19 
 arch/powerpc/kernel/pci_dn.c                       |  256 ++++++-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   14 
 arch/powerpc/platforms/powernv/pci-ioda.c          |  777 +++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c               |   87 +-
 arch/powerpc/platforms/powernv/pci.h               |   13 
 drivers/pci/iov.c                                  |  155 +++-
 drivers/pci/pci.h                                  |    2 
 drivers/pci/setup-bus.c                            |   83 ++
 include/linux/pci.h                                |   15 
 15 files changed, 1622 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/powerpc/pci_iov_resource_on_powernv.txt
