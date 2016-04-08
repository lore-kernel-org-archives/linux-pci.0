Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35203 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbcDHARL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:17:11 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 00/60] PCI: Resource allocation cleanup for v4.7
Date: Thu,  7 Apr 2016 17:15:13 -0700
Message-Id: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
to 64-bit resources), we have several reports on resource allocation
failure, and we try to fix the problem with resource clip, and find
more problems.

One is realloc fail with two graphics cards above 4G.
One is from sparc that have problem with clip as we don't parse
mem64 for it.

Other report is about pci remove/rescan does not work on some setup
when BIOS tend to allocate small bus size.

This patchset enhance resource allocation to address those problems.

patch 1-11: parse MEM64 for sparc and other system with OF

patch 12-16: MMIO64 allocation enhancement
        treat non-pref mmio64 if parent bridges are all pcie.
        restore old pref allocation logic if hostbridge does not support mmio64.

patch 17-19: FIXED resource handling during realloc
        don't realloc resource if device firmware does not support bar change.

patch 20-23: bridge MMIO allocation with hotplug and last try.
        treat optional as required on first try when hotplug.
        MMIO size set to 0 for last try during realloc

patch 24-56: enhancement for mmio resource allocation:
        optimize bus mmio alignment calculation.
        optimize bus mmio optional alignment calculation.
        add support for alt size to prefer small bus size to small bus alignment.
        treat ROM bar as optional resource.
        during allocation, will pick up best fit resource, and allocate near end.

patch 57: add pci=assign_pref_bars to clear and assign pref bars.

patch 58-59: don't clear resource when allocation fails

patch 60: don't try io port allocation if root bus does not have io port.

I put latest copy at:
  git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-v4.7-next

That is rebased on v4.6-rc2+.

Yijing and Wei Yang both tested the branch, and the patchset fixs rescan
problem, and is working well on powerpc setup.

Khalid Aziz tested on some sparc platforms that have different offset to
mem space start or support 64bit mmio.

-v11: replace pci_find_root_bus_resource with pci_find_bus_resource
      add two patches from Bjorn for checking with pci_mmap.
      refreshed to current linus tree v4.6-rc2+

Hope at least patch 1-16 could get into v4.7.
Patch 3-16 has been Oracle UEK4 for a while to boot on some sparc platforms as
them have 64bt mmio above 4G.

Thanks

Yinghai

Bjorn Helgaas (2):
  PCI: Fix iomem_is_exclusive() checking in pci_mmap_resource()
  alpha/PCI: Only check iomem_is_exclusive() for IORESOURCE_MEM, not IORESOURCE_IO

Yinghai Lu (58):
  PCI: Add pci_find_bus_resource()
  sparc/PCI: Use correct offset for bus address to resource
  sparc/PCI: Reserve legacy mmio after PCI mmio
  sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  sparc/PCI: Keep resource idx order with bridge register number
  PCI: Kill wrong quirk about M7101
  powerpc/PCI: Keep resource idx order with bridge register number
  powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
  PCI: Check pref compatible bit for mem64 resource of PCIe device
  PCI: Only treat non-pref mmio64 as pref if all bridges have MEM_64
  PCI: Add has_mem64 for struct host_bridge
  PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
  PCI: Restore pref MMIO allocation logic for host bridge without mmio64
  PCI: Don't release fixed resource for realloc
  PCI: Claim fixed resource during remove/rescan path
  PCI: Set resource to FIXED for LSI devices
  PCI: Separate realloc list checking after allocation
  PCI: Treat optional as required in first try for bridge rescan
  PCI: Get new realloc size for bridge for last try
  PCI: Don't release sibling bridge resources during hotplug
  PCI: Cleanup res_to_dev_res() printout
  PCI: Reuse res_to_dev_res() in reassign_resources_sorted()
  PCI: Use correct align for optional only resources during sorting
  PCI: Optimize bus min_align/size calculation during sizing
  PCI: Optimize bus align/size calculation for optional during sizing
  PCI: Don't add too much optional size for hotplug bridge MMIO
  PCI: Reorder resources list for required/optional resources
  PCI: Remove duplicated code for resource sorting
  PCI: Rename pdev_sort_resources() to pdev_assign_resources_prepare()
  PCI: Treat ROM resource as optional during realloc
  PCI: Add debug printout during releasing partial assigned resources
  PCI: Simplify res reference using in __assign_resources_sorted()
  PCI: Add __add_to_list()
  PCI: Cache window alignment value during bus sizing
  PCI: Check if resource is allocated before trying to assign one
  PCI: Separate out save_resources()/restore_resources()
  PCI: Move comment to pci_need_to_release()
  PCI: Separate required+optional assigning to another function
  PCI: Skip required+optional if there is no optional
  PCI: Move saved required resource list out of required+optional assigning
  PCI: Add alt_size ressource allocation support
  PCI: Add support for more than two alt_size entries under same bridge
  PCI: Fix size calculation with old_size on rescan path
  PCI: Don't add too much optional size for hotplug bridge io
  PCI: Move ISA io port align out of calculate_iosize()
  PCI: Don't add too much io port for hotplug bridge with old size
  PCI: Unify calculate_size() for io port and MMIO
  PCI: Allow bridge optional only io port resource required size to be 0
  PCI: Unify skip_ioresource_align()
  PCI: Kill macro checking for bus io port sizing
  resources: Make allocate_resource() return best fit resource
  PCI, x86: Allocate from high in available window for MMIO
  PCI: Add debug print out for min_align and alt_size
  PCI, x86: Add pci=assign_pref_bars to reallocate pref BARs
  PCI: Introduce resource_disabled()
  PCI: Don't set flags to 0 when assign resource fail
  PCI: Only try to assign io port only for root bus that support it

 arch/alpha/kernel/pci-sysfs.c             |    4 +-
 arch/alpha/kernel/pci.c                   |    2 +-
 arch/ia64/pci/pci.c                       |    4 +-
 arch/microblaze/pci/pci-common.c          |   15 +-
 arch/mn10300/unit-asb2305/pci-asb2305.c   |    4 +-
 arch/mn10300/unit-asb2305/pci.c           |    4 +-
 arch/powerpc/kernel/pci-common.c          |   27 +-
 arch/powerpc/kernel/pci_of_scan.c         |   12 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |   12 +-
 arch/s390/pci/pci.c                       |    2 +-
 arch/sparc/kernel/of_device_32.c          |    5 +-
 arch/sparc/kernel/of_device_64.c          |    5 +-
 arch/sparc/kernel/pci.c                   |   65 +-
 arch/sparc/kernel/pci_common.c            |   91 +-
 arch/sparc/kernel/pci_impl.h              |    5 +
 arch/x86/include/asm/pci_x86.h            |    2 +-
 arch/x86/pci/common.c                     |    7 +-
 arch/x86/pci/i386.c                       |   85 +-
 arch/xtensa/kernel/pci.c                  |    4 +-
 drivers/iommu/intel-iommu.c               |    3 +-
 drivers/of/address.c                      |    4 +-
 drivers/pci/bus.c                         |    6 +-
 drivers/pci/host/pcie-rcar.c              |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c        |    1 +
 drivers/pci/iov.c                         |    2 +-
 drivers/pci/pci-sysfs.c                   |    7 +-
 drivers/pci/pci.c                         |   31 +-
 drivers/pci/pci.h                         |    4 +
 drivers/pci/probe.c                       |   48 +-
 drivers/pci/quirks.c                      |   55 +-
 drivers/pci/rom.c                         |    2 +-
 drivers/pci/setup-bus.c                   | 1316 +++++++++++++++++++++--------
 drivers/pci/setup-res.c                   |   18 +-
 include/linux/ioport.h                    |    6 +-
 include/linux/pci.h                       |   10 +
 kernel/resource.c                         |  104 ++-
 36 files changed, 1427 insertions(+), 547 deletions(-)

-- 
1.8.4.5

