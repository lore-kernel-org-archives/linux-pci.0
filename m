Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:35382 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab2IYI0c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:32 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 00/29] PCI: use pci host bridge to loop pci root bus
Date: Tue, 25 Sep 2012 01:26:01 -0700
Message-Id: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

could remove pci_root_buses list.

Yinghai Lu (29):
  PCI, x86: Separate out pcibios_allocate_bridge_resources()
  PCI. x86: Separate out pcibios_allocate_dev_resources()
  PCI, x86: Let pcibios_allocate_bus_resources() take bus instead
  PCI, x86: Separate out rom resource claim
  PCI: rename pci_release_bus_bridge_dev to pci_release_host_bridge_dev
  PCI: Add dummy bus_type for pci_host_bridge
  PCI, ACPI: add acpi_bus_type for host bridge
  PCI, ACPI: Remove acpi_find_bridge_device for acpi_bus_type
  PCI, libata: remove find_bridge in acpi_bus_type
  PCI, USB: remove find_bridge in acpi_bus_type
  PCI, ACPI: remove find_bridge in acpi_bus_type
  PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
  PCI, hotplug: kill pci_find_next_bus n sgi_hotplug
  PCI: kill pci_find_next_bus in pci_sysfs
  PCI, edac: kill pci_find_next_bus in edac
  PCI, x86: kill pci_find_next_bus in pcibios_scan_root
  PCI, x86: kill pci_root_buses in resources reservations
  PCI, drm: kill pci_root_buses in alpha hose setting
  PCI: kill pci_root_buses in setup-bus
  PCI, sparc: kill pci_find_next_bus
  PCI, ia64: kill pci_find_next_bus
  PCI, alpha: kill pci_root_buses
  PCI, arm: kill pci_root_buses
  PCI, frv: kill pci_root_buses in resources reservations
  PCI, microblaze: kill pci_root_buses in resources reservations
  PCI, mn10300: kill pci_root_buses in resources reservations
  PCI, powerpc: kill pci_root_buses in resources reservations
  PCI: kill pci_find_next_bus
  PCI: kill pci_root_buses

 arch/alpha/kernel/pci.c                 |    6 +-
 arch/arm/kernel/bios32.c                |    9 +-
 arch/frv/mb93090-mb00/pci-frv.c         |   37 ++++---
 arch/ia64/hp/common/sba_iommu.c         |    7 +-
 arch/ia64/sn/kernel/io_common.c         |    5 +-
 arch/microblaze/pci/pci-common.c        |   10 +-
 arch/mn10300/unit-asb2305/pci-asb2305.c |   62 ++++++------
 arch/powerpc/kernel/pci-common.c        |   13 +--
 arch/powerpc/kernel/pci_64.c            |    7 +-
 arch/sparc/kernel/pci.c                 |    6 +-
 arch/x86/pci/common.c                   |    9 +-
 arch/x86/pci/i386.c                     |  162 +++++++++++++++++++------------
 drivers/acpi/glue.c                     |   22 +----
 drivers/ata/libata-acpi.c               |    6 -
 drivers/edac/i7core_edac.c              |    6 +-
 drivers/gpu/drm/drm_fops.c              |   10 ++-
 drivers/pci/hotplug/sgi_hotplug.c       |    6 +-
 drivers/pci/pci-acpi.c                  |   13 ++-
 drivers/pci/pci-driver.c                |   11 ++-
 drivers/pci/pci-sysfs.c                 |    6 +-
 drivers/pci/probe.c                     |   13 +--
 drivers/pci/search.c                    |   60 ++++++------
 drivers/pci/setup-bus.c                 |   24 +++--
 drivers/usb/core/usb-acpi.c             |    1 -
 include/acpi/acpi_bus.h                 |    2 -
 include/linux/pci.h                     |   11 +--
 26 files changed, 281 insertions(+), 243 deletions(-)

-- 
1.7.7

