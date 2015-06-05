Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Cc: zhen-hual@hp.com, bhe@redhat.com, dwmw2@infradead.org,
	vgoyal@redhat.com, dyoung@redhat.com, alex.williamson@redhat.com,
	ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com,
	indou.takao@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com,
	jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com,
	lisa.mitchell@hp.com, billsumnerlinux@gmail.com, rwright@hp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH 00/17] Fixes and Cleanups for the Intel VT-d driver
Date: Fri,  5 Jun 2015 16:10:46 +0200
Message-Id: <1433513463-19128-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey,

here are a couple of patches to fix the fall-out from the
patch set fixing the kdump faults with VT-d enabled. A few
important issues have been fixed:

	* Moved sleeping functions out of atomic sections,
	  mainly iremap_cache/iounmap.

	* Mark domain ids used in the old kernel as reserved
	  in the kdump kernel, so that any new domains don't
	  interfere with domains from the old kernel

	* Mark all IRT entries from the old kernel as
	  reservered in the new kernel, so that we don't
	  overwrite an entry which might still be in use by
	  a device

	* Only try to load anything from the old kernel when
	  we are in a kdump kernel. If we find the iommu
	  hardware enabled and we are not in a kdump kernel,
	  just disable the iommu and proceed with
	  initialization.

	* Fix a compile error

Besides that I also cleaned up the code to simplify it:

	* Move necessary initialization steps before the
	  root entry table and the irq remapping table is
	  programmed into hardware. This makes sure QI is
	  initialized so that we can flush the iommu caches
	  when hardware got the new tables.

	* Make the new root entry table and irq remapping
	  table visible to hardware immediatly after they
	  are created and loaded with the data from the old
	  kernel. This allows to remove the code to update
	  both, the old and the new version of the table at
	  the same time.

	* Clean up log messages from the VT-d driver to have
	  a common prefix that can be grepped for.

	* Remove unused code

The changes have been tested by me an Baoquan He. I'll plan
to put them into the x86/vt-d branch for v4.2.

Regards,

	Joerg

Joerg Roedel (17):
  iommu/vt-d: Fix compile error when CONFIG_INTEL_IOMMU=n
  iommu/vt-d: Remove __iommu_save_to_oldmem() function
  iommu/vt-d: Make two functions static
  iommu/vt-d: Load old data structures only in kdump kernel
  iommu/vt-d: Mark root-entry present in set_root_entry
  iommu/vt-d: Rework loading of old root-entry table
  iommu/vt-d: Copy context-tables outside of spin_lock
  iommu/vt-d: Don't reuse domain-ids from old kernel
  iommu/vt-d: Clean up log messages in intel-iommu.c
  iommu/vt-d: Allocate irq remapping table bitmap with GFP_KERNEL
  iommu/vt-d: Move QI initialization to intel_setup_irq_remapping
  iommu/vt-d: Move EIM detection to intel_prepare_irq_remapping
  iommu/vt-d: Split up iommu_set_irq_remapping
  iommu/vt-d: Move kdump pointer intialization to __iommu_load_old_irte
  iommu/vt-d: Mark irt entries from old kernel as allocated
  iommu/vt-d: Copy old irte in intel_setup_irq_remapping
  iommu/vt-d: Remove update code for old ir-table

 drivers/iommu/dmar.c                |  26 +-
 drivers/iommu/intel-iommu.c         | 463 ++++++++++++++----------------------
 drivers/iommu/intel_irq_remapping.c | 263 +++++++++-----------
 include/linux/intel-iommu.h         |  17 +-
 4 files changed, 299 insertions(+), 470 deletions(-)

-- 
1.9.1

