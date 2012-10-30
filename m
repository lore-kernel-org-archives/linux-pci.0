Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:38947 "EHLO
	aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab2J3V6n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 17:58:43 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: 
Date: Tue, 30 Oct 2012 10:42:37 -0700
Message-Id: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <20121030040237.GA10472@google.com>
References: <20121030040237.GA10472@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Subject: [PATCH resend 0/8] PCI, ACPI, x86: pci root bus hotplug support resources assign and remove path

1. add support for assign resource for hot add path.
2. stop and remove root bus during acpi root remove.


could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug

Yinghai Lu (8):
  PCI: Separate out pci_assign_unassigned_bus_resources()
  PCI: Move pci_rescan_bus() back to probe.c
  PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
  PCI, ACPI: assign unassigned resource for hot add root bus
  PCI: Add pci_stop/remove_root_bus()
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

