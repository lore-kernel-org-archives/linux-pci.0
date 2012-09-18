Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48610 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab2IRGMR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 02:12:17 -0400
Date: Tue, 18 Sep 2012 15:12:15 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org
Cc: kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Subject: [PATCH v3 0/6] acpi,pci: hostbridge hotplug support
Message-Id: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,
 
  This patchset is 3rd version of the following:
    http://marc.info/?l=linux-pci&m=134457928913775&w=2
    http://marc.info/?l=linux-pci&m=134665909321684&w=2

 v2 -> v3:
   - change acpi_pci_drivers' add/remove interface according to Bjorn's suggestion
   - abandon RCU for protecting acpi_pci_roots list according to Bjorn's suggestion
   - change acpi_pci_find_root implementation to avoid potential deadlock

  * [PATCH v3 1/8] ACPI, PCI: Use normal list for struct acpi_pci_driver
  * [PATCH v3 2/8] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
  * [PATCH v3 3/8] ACPI, PCI: add acpi_pci_drivers protection
  * [PATCH v3 4/8] ACPI, PCI: change acpi_pci_drivers' add/remove interface
  * [PATCH v3 5/8] ACPI, PCI: change acpi_pci_find_root implementation
  * [PATCH v3 6/8] ACPI, PCI: add acpi_pci_roots protection
  * [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
  * [PATCH v3 8/8] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge

-- 
Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

