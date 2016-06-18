Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v13 00/16] PCI: Fixup for 64bit resource with sparc
Date: Fri, 17 Jun 2016 19:24:45 -0700
Message-Id: <20160618022501.15648-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
to 64-bit resources), we have several reports on resource allocation
failure, and we try to fix the problem with resource clip, and find
more problems.

One is from sparc that have problem with clip as we don't parse
mem64 for it.

This patchset try to fix the problem for sparc.

patch 1-3: try to fix the pci mmap for proc path for sparc, that will
make fix for sparc 64bit resource offset handling much simple.

patch 4-11: parse MEM64 for sparc and other system with OF.
So device 64bit resource could find their parent resource.

patch 12-15: MMIO64 handling enhancement
        treat non-pref mmio64 if parent bridges are all pcie.

patch 16: restore old pref allocation logic if hostbridge does not support mmio64.

Khalid Aziz tested on some sparc platforms that have different offset to
mem space start or support 64bit mmio.

-v13: update patchset with pci/resource that have pci_resource_to_user
      changes. date 2016-06-17

Hope we can get them into v4.8.

Thanks

Yinghai

Yinghai Lu (16):
  PCI: Let pci_mmap_page_range() take resource address
  PCI: Remove __pci_mmap_make_offset()
  PCI: Check resource alignment for /sys pci_mmap_resource path
  sparc/PCI: Use correct offset for bus address to resource
  PCI: Add pci_find_bus_resource()
  sparc/PCI: Reserve legacy mmio after PCI mmio
  sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  sparc/PCI: Keep resource idx order with bridge register number
  powerpc/PCI: Keep resource idx order with bridge register number
  powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
  PCI: Check pref compatible bit for mem64 resource of PCIe device
  PCI: Only treat non-pref mmio64 as pref if all bridges have MEM_64
  PCI: Add has_mem64 for struct host_bridge
  PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
  PCI: Restore pref MMIO allocation logic for host bridge without mmio64

 arch/microblaze/pci/pci-common.c  |  74 ++-------------------
 arch/powerpc/kernel/pci-common.c  |  74 ++-------------------
 arch/powerpc/kernel/pci_of_scan.c |  12 +++-
 arch/sparc/kernel/of_device_32.c  |   5 +-
 arch/sparc/kernel/of_device_64.c  |   5 +-
 arch/sparc/kernel/pci.c           | 132 ++++----------------------------------
 arch/sparc/kernel/pci_common.c    |  91 +++++++++++++++-----------
 arch/sparc/kernel/pci_impl.h      |   5 ++
 arch/xtensa/kernel/pci.c          |  75 +++-------------------
 drivers/of/address.c              |   4 +-
 drivers/pci/bus.c                 |   4 +-
 drivers/pci/pci-sysfs.c           |  33 +++++++---
 drivers/pci/pci.c                 |  31 +++++----
 drivers/pci/pci.h                 |   4 +-
 drivers/pci/probe.c               |  40 ++++++++++++
 drivers/pci/proc.c                |  60 ++++++++++++++---
 drivers/pci/setup-bus.c           |  65 ++++++++++++++++---
 drivers/pci/setup-res.c           |  13 +++-
 include/linux/pci.h               |   4 ++
 19 files changed, 325 insertions(+), 406 deletions(-)

-- 
2.8.3
