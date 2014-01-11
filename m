Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:59258 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB0m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:26:42 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so5276986pde.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:26:42 -0800 (PST)
Subject: [PATCH v2 00/12] Remove dead code
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>
Date: Fri, 10 Jan 2014 18:26:39 -0700
Message-ID: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is basically a v2 of Stephen's patches [1,2].

I split them up into smaller patches because we're removing some PCIe 3.0
functionality (ID-Based Ordering, Optimized Buffer Flush/Fill, and Latency
Tolerance Reporting) that people might care about, and splitting it makes
that more visible and easier to add back in the future.

I kept pci_sriov_migration() and sriov_migration().  I think we could and
should remove these, but they were added by 74bb1bcc7dbb ("PCI: handle
SR-IOV Virtual Function Migration"), and I think we probably could revert
that commit entirely.  I just got tired of poking at this, so I left that
for somebody more interested.

pci_request_region_exclusive() and pci_request_regions_exclusive() were
added by e8de1481fd71 ("resource: allow MMIO exclusivity for device
drivers").  This series removes them but keeps the rest of that commit,
including pci_request_selected_regions_exclusive() and some other stuff.
e8de1481fd71 was for debugging a bad memory corruption, and e1000e is the
only user I see.  I'm not sure it's worth keeping all that stuff just for
one driver.  But again, I got tired of fiddling with this, so I just kept
Stephen's patch removing the obvious parts.

I left pci_cfg_space_size() global because it is used by powerpc and sparc.

I also left pci_find_next_ext_capability() global and exported.  It is used
internally and is also the only way for drivers to find capabilities that
can occur multiple times (though admittedly nones use it today).

I intend to merge this or an updated version for v3.14.  It's currently on
my pci/cleanup branch [3].

Bjorn

[1] http://lkml.kernel.org/r/20131227132734.2aa9bc16@nehalam.linuxnetplumber.net
[2] http://lkml.kernel.org/r/20131227132710.7190647c@nehalam.linuxnetplumber.net
[3] http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/cleanup

---

Bjorn Helgaas (2):
      PCI: Reorder pci.h so actual interfaces come before stubs
      PCI: Cleanup pci.h whitespace

Stephen Hemminger (10):
      PCI: Removed unused parts of Page Request Interface support
      PCI: Remove unused Latency Tolerance Reporting support
      PCI: Remove unused Optimized Buffer Flush/Fill support
      PCI: Remove unused ID-Based Ordering support
      PCI: Remove unused exclusive region support
      PCI: Remove unused pci_vpd_truncate()
      PCI: Remove unused pcie_aspm_enabled()
      PCI: Remove unused pci_renumber_slot()
      PCI: Remove unused alloc_pci_dev()
      PCI: Make local functions static


 drivers/pci/access.c              |   24 ---
 drivers/pci/ats.c                 |   82 ---------
 drivers/pci/hotplug/pciehp.h      |    1 
 drivers/pci/hotplug/pciehp_core.c |    2 
 drivers/pci/pci.c                 |  336 +++----------------------------------
 drivers/pci/pci.h                 |    2 
 drivers/pci/pcie/aspm.c           |   12 -
 drivers/pci/probe.c               |  117 ++++++-------
 drivers/pci/slot.c                |   26 ---
 include/linux/pci-ats.h           |   17 --
 include/linux/pci.h               |  129 +++-----------
 11 files changed, 114 insertions(+), 634 deletions(-)
