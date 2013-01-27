Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47455 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352Ab3A0FhQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 00:37:16 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 00/22] PCI: use pci host bridge to loop pci root bus
Date: Sat, 26 Jan 2013 21:36:21 -0800
Message-Id: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We could add bus_type for pci_host_bridge, and generic code in driver
core to loop pci_host_bridge and could remove pci_root_buses list,
as host_bridge->bus is the root bus.

based on pci/next

could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-for-each-host-bridge

-v2: updated after pci_root_bus_hotplug get into pci/next

Yinghai Lu (22):
  PCI: Rename pci_release_bus_bridge_dev to pci_release_host_bridge_dev
  PCI: Add dummy bus_type for pci_host_bridge
  PCI, libata: remove find_bridge in acpi_bus_type
  PCI, ACPI: Update comments for find_bridge in acpi_bus_type
  PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
  PCI, hotplug: Kill pci_find_next_bus in sgi_hotplug
  PCI: Kill pci_find_next_bus in pci_sysfs
  PCI, edac: Kill pci_find_next_bus in edac
  PCI, x86: Kill pci_find_next_bus in pcibios_scan_root
  PCI, x86: Kill pci_root_buses in resources reservations
  PCI, drm: Kill pci_root_buses in alpha hose setting
  PCI: Kill pci_root_buses in setup-bus
  PCI, sparc: Kill pci_find_next_bus
  PCI, ia64: Kill pci_find_next_bus
  PCI, alpha: Kill pci_root_buses
  PCI, arm: Kill pci_root_buses
  PCI, frv: Kill pci_root_buses in resources reservations
  PCI, microblaze: Kill pci_root_buses in resources reservations
  PCI, mn10300: Kill pci_root_buses in resources reservations
  PCI, powerpc: Kill pci_root_buses in resources reservations
  PCI: Kill pci_find_next_bus
  PCI: Kill pci_root_buses

 arch/alpha/kernel/pci.c                 |    6 +--
 arch/arm/kernel/bios32.c                |    9 ++---
 arch/frv/mb93090-mb00/pci-frv.c         |   37 +++++++++---------
 arch/ia64/hp/common/sba_iommu.c         |    7 ++--
 arch/ia64/sn/kernel/io_common.c         |    5 ++-
 arch/microblaze/pci/pci-common.c        |   10 ++---
 arch/mn10300/unit-asb2305/pci-asb2305.c |   62 ++++++++++++++++---------------
 arch/powerpc/kernel/pci-common.c        |   13 +++----
 arch/powerpc/kernel/pci_64.c            |    8 ++--
 arch/sparc/kernel/pci.c                 |    6 ++-
 arch/x86/pci/common.c                   |    9 +++--
 arch/x86/pci/i386.c                     |   20 +++++-----
 drivers/ata/libata-acpi.c               |    6 ---
 drivers/edac/i7core_edac.c              |    6 +--
 drivers/gpu/drm/drm_fops.c              |   10 +++--
 drivers/pci/hotplug/sgi_hotplug.c       |    6 ++-
 drivers/pci/pci-driver.c                |   11 +++++-
 drivers/pci/pci-sysfs.c                 |    6 +--
 drivers/pci/probe.c                     |   13 ++-----
 drivers/pci/search.c                    |   61 +++++++++++++++---------------
 drivers/pci/setup-bus.c                 |   24 ++++++------
 include/acpi/acpi_bus.h                 |    2 +-
 include/linux/pci.h                     |   18 +++++----
 23 files changed, 187 insertions(+), 168 deletions(-)

-- 
1.7.10.4

