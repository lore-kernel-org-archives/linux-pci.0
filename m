Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
Date: Tue, 27 Oct 2015 13:54:52 -0700
Message-Id: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

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
patch 24-57: enhancement for mmio resource allocation:
	optimize bus mmio alignment calculation.
	optimize bus mmio optional alignment calculation.
	add support for alt size to prefer small bus size to small bus alignment.
	treat ROM bar as optional resource.
	during allocation, will pick up best fit resource, and allocate near end.
patch 58: add pci=assign_pref_bars to clear and assign pref bars.
patch 59-60: don't clear resource when allocation fails
patch 61: don't try io port allocation if root bus does not have io port.

I put latest copy at:
  git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-v4.4-next

That is based on v4.3-rc4+.

Yijing and Wei Yang both tested the branch, and the patchset fixs rescan
problem, and is working well on powerpc setup.

Khalid Aziz tested on some sparc platforms that have different offset to
mem space start or support 64bit mmio.

Thanks

Yinghai

v2:
    - fix resource_disabled allocation from powerpc.
    - other warnings that were found by Fengguang's build robot.
    - io port alignment clean up.
    - rebased to v4.2-rc2.
    - better for two alt_size support.

v3:
    - fix reset bridge resource on last try: only with bridge resources.
    - remove/rescan path checking with old_size.

v4:
    - Update changelog according to Bjorn.
    - split calculate_size patch to two.
    - use required instead of must.

v5:
    - update changelog.
    - add one debug patch.
    - add one patch that get resource allocation near end of avialable window.

v6:
    - reorder patches according to Bjorn.

v7:
    - add some patches that fix problems on sparc that Khalid Aziz found.

v8:
    - update patch 2, 3 to remove the assumpation about mem64_offset == mem_offset.
    - add one patch for pci_find_root_bus_resource() to support above change.
    - update pref_compatible flags handling after pci_find_root_bus_resource().
    - add patch for quirk that ignore BAR for M1533 PCI-ISA bridge.

Yinghai Lu (61):
  sparc/PCI: Add mem64 resource parsing for root bus
  PCI: Add pci_find_root_bus_resource()
  sparc/PCI: Use correct bus address to resource offset
  sparc/PCI: Reserve legacy mmio after PCI mmio
  sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  sparc/PCI: Keep resource idx order with bridge register number
  PCI: Kill wrong quirk about M7101
  PCI: Ignore BAR for ALi M1533 PCI-ISA bridge
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
  resources: Split out __allocate_resource()
  resources: Make allocate_resource() return best fit resource
  PCI, x86: Allocate from high in available window for MMIO
  PCI: Add debug print out for min_align and alt_size
  PCI, x86: Add pci=assign_pref_bars to reallocate pref BARs
  PCI: Introduce resource_disabled()
  PCI: Don't set flags to 0 when assign resource fail
  PCI: Only try to assign io port only for root bus that support it

 arch/alpha/kernel/pci.c                   |    2 +-
 arch/ia64/pci/pci.c                       |    4 +-
 arch/microblaze/pci/pci-common.c          |   23 +-
 arch/mn10300/unit-asb2305/pci-asb2305.c   |    4 +-
 arch/mn10300/unit-asb2305/pci.c           |    4 +-
 arch/powerpc/kernel/pci-common.c          |   27 +-
 arch/powerpc/kernel/pci_of_scan.c         |   12 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |   12 +-
 arch/s390/pci/pci.c                       |    2 +-
 arch/sparc/kernel/of_device_32.c          |    5 +-
 arch/sparc/kernel/of_device_64.c          |    5 +-
 arch/sparc/kernel/pci.c                   |   66 +-
 arch/sparc/kernel/pci_common.c            |  100 ++-
 arch/sparc/kernel/pci_impl.h              |    6 +
 arch/x86/include/asm/pci_x86.h            |    2 +-
 arch/x86/pci/common.c                     |    7 +-
 arch/x86/pci/i386.c                       |   86 +-
 arch/xtensa/kernel/pci.c                  |    4 +-
 drivers/iommu/intel-iommu.c               |    3 +-
 drivers/of/address.c                      |    4 +-
 drivers/pci/bus.c                         |    6 +-
 drivers/pci/host/pcie-rcar.c              |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c        |    1 +
 drivers/pci/iov.c                         |    2 +-
 drivers/pci/pci.c                         |   40 +-
 drivers/pci/pci.h                         |    4 +
 drivers/pci/probe.c                       |   48 +-
 drivers/pci/quirks.c                      |   60 +-
 drivers/pci/rom.c                         |    2 +-
 drivers/pci/setup-bus.c                   | 1312 +++++++++++++++++++++--------
 drivers/pci/setup-res.c                   |   18 +-
 include/asm-generic/pci-bridge.h          |    2 +
 include/linux/ioport.h                    |    6 +-
 include/linux/pci.h                       |    8 +
 kernel/resource.c                         |  175 +++-
 35 files changed, 1508 insertions(+), 556 deletions(-)

-- 
1.8.4.5

