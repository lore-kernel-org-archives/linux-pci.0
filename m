Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18840 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164AbbG0Xax (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 19:30:53 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 00/51] PCI: Resource allocation cleanup for v4.3
Date: Mon, 27 Jul 2015 16:29:18 -0700
Message-Id: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
to 64-bit resources), we have several reports on resource allocation
failure, and we try to fix the problem with resource clip, and get
more problems.

One is realloc fail with two graphics cards above 4G.
One is from sparc that have problem with clip as we don't parse
mem64 for it.

Other report is about pci remove/rescan does not work on some setup
when BIOS tend to allocate small bus size.

This patchset enhance resource allocation to address those problems.
1. optimize bus mmio alignment calculation.
2. optimize bus mmio optional alignment calculation.
3. add support for alt size to prefer small bus size to small bus alignment.
   when we have small resource window on parent bridges.
4. treat ROM bar as optional resource.
5. during allocation, will pick up just fit resource.
6. parse MEM64 for sparc and other system with OF.
7. treat non-pref mmio64 if parent bridges are all pcie.
8. restore old pref allocation logic if hostbridge does not support mmio64 really.
9. don't realloc resource if device firmware does not support bar change.
10. add pci=assign_pref_bars to clear and assign pref bars.
11. don't clear resource when allocation fails.

I put latest copy at:
  git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-v4.3-next

That is based on kind of v4.2-rc4.

Yijing and Wei Yang both test the branch, and the patchset fixs rescan problem,
and is working well on powerpc setup.

Thanks

Yinghai

v2:
    - fix resource_disabled allocation from powerpc
    - other warnings that were found by Fengguang's build robot.
    - io port alignment clean up.
    - rebased to v4.2-rc2
    - better for two alt_size support.

v3:
    - fix reset bridge resource on last try: only with bridge resources
    - remove/rescan path checking with old_size.


Yinghai Lu (51):
  PCI: Cleanup res_to_dev_res() printout for addon resources
  PCI: Reuse res_to_dev_res in reassign_resources_sorted
  PCI: Use correct align for optional only resources during sorting
  PCI: Optimize bus align/size calculation during sizing
  PCI: Optimize bus align/size calculation for optional during sizing
  PCI: Don't add too much optional size for hotplug bridge mmio
  PCI: Reorder resources list for must/optional resources
  PCI: Remove duplicated code for resource sorting
  PCI: Rename pdev_sort_resources to pdev_check_resources
  PCI: Treat ROM resource as optional during realloc
  PCI: Add debug printout during releasing partial assigned resources
  PCI: Simplify res reference using in __assign_resourcs_sorted
  PCI: Separate realloc list checking after allocation
  PCI: Add __add_to_list()
  PCI: Cache window alignment value
  PCI: Check if resource is allocated before pci_assign
  PCI: Separate out save_resources/restore_resource
  PCI: Move comment to pci_need_to_release()
  PCI: Separate must+optional assigning to another function
  PCI: Skip must+optional if there is no optional addon
  PCI: Move saved required resource list out of must+optional assigning
  PCI: Add alt_size allocation support
  PCI: Add support for more than two alt_size under same bridge
  PCI: Better support for two alt_size
  PCI: Fix size calculation with old_size on rescan path
  PCI: Don't add too much optional size for hotplug bridge io
  PCI: Move ISA ioport align out of calculate_iosize
  PCI: Unifiy calculate_size for io port and mmio
  PCI: Allow optional only io resource must size to be 0
  PCI: Unify skip_ioresource_align()
  PCI: Kill macro checking for bus io port sizing
  resources: Split out __allocate_resource()
  resources: Make allocate_resource return just fit resource
  PCI: Check pref compatible bit for mem64 resource of pcie device
  PCI: Only treat non-pef mmio64 as pref if all bridges has MEM_64
  PCI: Add has_mem64 for host_bridge
  PCI: Only treat non-pef mmio64 as pref if host-bridge has_mem64
  PCI: Restore pref mmio allocation logic for hostbridge without mmio64
  sparc/PCI: Add mem64 resource parsing for root bus
  sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in of parsing
  powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in of parsing
  of/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
  PCI: Treat optional as must in first try for bridge rescan
  PCI: Get new realloc size for bridge for last try
  PCI: Don't release sibiling bridge resources during hotplug
  PCI: Don't release fixed resource for realloc
  PCI: Claim fixed resource during remove/rescan path
  PCI: Set resource to FIXED for lsi devices
  PCI, x86: Add pci=assign_pref_bars to re-allocate pref bars
  PCI: Introduce resource_disabled()
  PCI: Don't set flags to 0 when assign resource fail

 arch/alpha/kernel/pci.c                   |    2 +-
 arch/ia64/pci/pci.c                       |    4 +-
 arch/microblaze/pci/pci-common.c          |   23 +-
 arch/mn10300/unit-asb2305/pci-asb2305.c   |    4 +-
 arch/mn10300/unit-asb2305/pci.c           |    4 +-
 arch/powerpc/kernel/pci-common.c          |   27 +-
 arch/powerpc/kernel/pci_of_scan.c         |    4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |   12 +-
 arch/s390/pci/pci.c                       |    2 +-
 arch/sparc/kernel/of_device_32.c          |    5 +-
 arch/sparc/kernel/of_device_64.c          |    5 +-
 arch/sparc/kernel/pci.c                   |    9 +-
 arch/sparc/kernel/pci_common.c            |   15 +-
 arch/sparc/kernel/pci_impl.h              |    1 +
 arch/x86/include/asm/pci_x86.h            |    2 +-
 arch/x86/pci/common.c                     |    7 +-
 arch/x86/pci/i386.c                       |   72 +-
 arch/xtensa/kernel/pci.c                  |    4 +-
 drivers/iommu/intel-iommu.c               |    3 +-
 drivers/of/address.c                      |    4 +-
 drivers/pci/bus.c                         |    6 +-
 drivers/pci/host/pcie-rcar.c              |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c        |    1 +
 drivers/pci/iov.c                         |    2 +-
 drivers/pci/pci.c                         |    3 +-
 drivers/pci/pci.h                         |    4 +
 drivers/pci/probe.c                       |   44 +-
 drivers/pci/quirks.c                      |   37 +
 drivers/pci/rom.c                         |    2 +-
 drivers/pci/setup-bus.c                   | 1321 +++++++++++++++++++++--------
 drivers/pci/setup-res.c                   |   18 +-
 include/asm-generic/pci-bridge.h          |    2 +
 include/linux/ioport.h                    |    6 +-
 include/linux/pci.h                       |    2 +
 kernel/resource.c                         |  175 +++-
 35 files changed, 1361 insertions(+), 473 deletions(-)

-- 
1.8.4.5

