Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 00/13] PCI: sparc related 64bit resource fixup
Date: Thu, 20 Apr 2017 22:04:47 -0700
Message-Id: <20170421050500.13957-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Please check sparc related 64bit resource handling patches.

patch 1-8: parse MEM64 for sparc and other system with OF.
	So device 64bit resource could find their parent resource.

patch 9-12: MMIO64 handling enhancement
        treat non-pref mmio64 as pref mmio64 if all bridges to root all pcie.

patch 13: restore old pref allocation logic if hostbridge does not support mmio64.

Those patches could be applied on top of today's pci/next.

Thanks

Yinghai


Yinghai Lu (13):
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

 arch/powerpc/kernel/pci_of_scan.c | 12 +++++-
 arch/sparc/kernel/of_device_32.c  |  5 ++-
 arch/sparc/kernel/of_device_64.c  |  5 ++-
 arch/sparc/kernel/pci.c           | 15 +++++--
 arch/sparc/kernel/pci_common.c    | 91 +++++++++++++++++++++++----------------
 arch/sparc/kernel/pci_impl.h      |  5 +++
 drivers/of/address.c              |  4 +-
 drivers/pci/bus.c                 |  4 +-
 drivers/pci/pci.c                 | 31 +++++++------
 drivers/pci/pci.h                 |  2 +
 drivers/pci/probe.c               | 40 +++++++++++++++++
 drivers/pci/setup-bus.c           | 65 ++++++++++++++++++++++++----
 drivers/pci/setup-res.c           | 13 ++++--
 include/linux/pci.h               |  4 ++
 14 files changed, 224 insertions(+), 72 deletions(-)

-- 
2.9.3
