Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v3 00/11] PCI: pci_host_bridge related cleanup
Date: Sun, 18 Mar 2012 22:40:13 -0700
Message-Id: <1332135624-13528-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

will add struct device dev into host_bridge struct.
also will add release support to make sure allocated resource get
freed during root bus removal including hostbridge and pci_sysdata.

The patches need to apply to linus v3.3 plus pci/linux-next

could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-hostbridge-cleanup

-v2: dropped the patch that is with x86 pcibios_bus_to_resource that Bjorn objected.
     reorder the patchesset to mold one appended patch into previous patch.
-v3: separate the patchset.

Thanks

Yinghai

Yinghai Lu (11):
  PCI: Separate host_bridge code out from probe.c
  x86, PCI: Fix memleak with get_current_resources()
  PCI: Rename pci_host_bridge() to find_pci_root_bridge()
  PCI: Add generic device into pci_host_bridge struct
  PCI: Add host bridge release support
  x86, PCI: Break down get_current_resource()
  x86, PCI: Add host bridge resource release for _CRS path
  x86, PCI: Embed name into pci_root_info struct
  x86, PCI: Embed pci_sysdata into pci_root_info on acpi path
  x86, PCI: Allocate pci_root_info for not using _CRS path
  x86, PCI: Merge root info printing for not using _CRS path

 arch/x86/pci/acpi.c         |  116 +++++++++++++++++++++-------------
 arch/x86/pci/amd_bus.c      |   78 +++++++----------------
 arch/x86/pci/broadcom_bus.c |   17 +----
 arch/x86/pci/bus_numa.c     |   86 +++++++++++++++++++-------
 arch/x86/pci/bus_numa.h     |   19 +++---
 drivers/pci/Makefile        |    2 +-
 drivers/pci/host-bridge.c   |   96 ++++++++++++++++++++++++++++
 drivers/pci/probe.c         |  146 +++++++++++--------------------------------
 include/linux/pci.h         |    9 +++-
 9 files changed, 313 insertions(+), 256 deletions(-)
 create mode 100644 drivers/pci/host-bridge.c

-- 
1.7.7

