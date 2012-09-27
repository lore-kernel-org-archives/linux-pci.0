Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/8] PCI, ACPI, x86: pci root bus hotplug support pci_root.c related core changes
Date: Thu, 27 Sep 2012 01:11:51 -0700
Message-Id: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

based on pci/next

could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug

Yinghai Lu (8):
  PCI: Separate out pci_assign_unassigned_bus_resources()
  PCI: Move pci_rescan_bus() back to probe.c
  PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
  PCI, ACPI: assign unassigned resource for hot add root bus
  PCI: Add pci_stop_and_remove_root_bus()
  PCI, ACPI: Make acpi_pci_root_remove stop/remove pci root bus
  PCI, ACPI: delete root bus prt during hot remove path
  PCI, ACPI: remove acpi_root_driver in reserse order

 drivers/acpi/pci_root.c |   21 ++++++++++++++++++++-
 drivers/pci/probe.c     |   22 ++++++++++++++++++++++
 drivers/pci/remove.c    |   36 ++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c |   22 +---------------------
 include/linux/pci.h     |    3 +++
 5 files changed, 82 insertions(+), 22 deletions(-)

-- 
1.7.7

