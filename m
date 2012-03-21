Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, chenkeping@huawei.com
Subject: [PATCH 0/3]  Enhance pci_root.c to better support PCI root bus hotplug
Date: Thu, 22 Mar 2012 00:22:34 +0800
Message-Id: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series of patches is based on Yinghai's work on PCI root bus hotplug,
which enhance the pci_root.c to better support PCI root bus hotplug.
It applies to
	93c6c6b PCI: Add /sys/bus/pci/rescan_root
at
	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug

Jiang Liu (3):
  ACPI,PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
  ACPI,PCI: protect global lists in drivers/acpi/pci_root.c
  ACPI,PCI: Use normal list for struct acpi_pci_driver

 drivers/acpi/pci_root.c |  111 +++++++++++++++++++++++++++--------------------
 include/linux/acpi.h    |    2 +-
 2 files changed, 65 insertions(+), 48 deletions(-)

-- 
1.7.5.4

