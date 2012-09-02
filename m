Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH part2 0/6] PCI, x86: pci root bus hotplug support - part2
Date: Sun,  2 Sep 2012 14:50:47 -0700
Message-Id: <1346622653-30741-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Refactor x86 pci pcibios_allocate related function to take bus as parameter.

So later could use it for root bus add case.

could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug-part2

Yinghai Lu (6):
  x86, PCI: Separate pcibios_allocate_bridge_resources()
  x86, PCI: Separate pcibios_allocate_dev_resources()
  x86, PCI: Let pcibios_allocate_bus_resources() take bus instead
  x86, PCI: Separate rom resource claim out
  PCI, x86: Add pcibios_fw_addr_done
  PCI: Claim hw/fw allocated resources in hot add path.

 arch/x86/pci/i386.c |  192 ++++++++++++++++++++++++++++++++++-----------------
 drivers/pci/bus.c   |    2 +
 include/linux/pci.h |    1 +
 3 files changed, 131 insertions(+), 64 deletions(-)

-- 
1.7.7

