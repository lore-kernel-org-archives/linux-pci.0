Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:21976 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2JBGdJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:09 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 00/10] PCI, ACPI: Use bus type notifier for root bus hotplug
Date: Mon,  1 Oct 2012 23:32:58 -0700
Message-Id: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device drivers_autoprobe to make hotplug path more like booting path:
create all acpi device and add them to device tree at first
 then attach acpi drivers.
create all pci devices and add them to device tree at first
 then attach pci drivers.

1. kill acpi_pci_root_start.
2. register pci devices to device tree as soon as possible after pci devices
   and bus get created.
   After pci_scan_child_bus, all bus and devices get into devices already.
   pci_bus_add_devices will only attach driver to pci devices.

could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-next

Yinghai Lu (10):
  device: add drivers_autoprobe in struct device
  ACPI: use device drivers_autoprobe to delay loading acpi drivers
  PCI: prepare to use device drivers_autoprobe to delay attach drivers
  PCI: Use device_add for device and bus early
  PCI, ACPI: Separate out acpi_pci_root_osc_contorl_set
  PCI, ACPI: Move hot add root bus conf code to acpi_pci_root_add
  PCI, ACPI: Remove not used acpi_pci_root_start()
  PCI: Add dev_is_pci_host_bridge() helper
  PCI, ACPI: using acpi/pci bind path for pci_host_bridge
  PCI, ACPI: use bus_type notifier for acpi_pci_bind_notify

 drivers/acpi/glue.c         |    4 -
 drivers/acpi/pci_bind.c     |   99 +++++++++++++++----
 drivers/acpi/pci_root.c     |  223 +++++++++++++++++++++++--------------------
 drivers/acpi/scan.c         |   48 +++++++++-
 drivers/base/bus.c          |    2 +-
 drivers/base/core.c         |    1 +
 drivers/pci/bus.c           |   45 +++------
 drivers/pci/hotplug.c       |   25 +++++
 drivers/pci/iov.c           |    7 --
 drivers/pci/probe.c         |   25 ++++--
 include/acpi/acpi_drivers.h |    2 +
 include/linux/device.h      |    1 +
 include/linux/pci.h         |    1 +
 13 files changed, 310 insertions(+), 173 deletions(-)

-- 
1.7.7

