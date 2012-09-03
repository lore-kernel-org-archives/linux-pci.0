Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:50691 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab2ICH6K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Sep 2012 03:58:10 -0400
Date: Mon, 3 Sep 2012 16:58:31 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org
Cc: kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Subject: [PATCH v2 0/6] acpi,pci: hostbridge hotplug support
Message-Id: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,
 
  This patchset is 2nd version of the following:
    http://marc.info/?l=linux-pci&m=134457928913775&w=2

 v1 -> v2:
   - rebased against current "next" branch
   - omit a few patches
   - split global list protection patch into 2 patches (NO3,4)

  * [PATCH v2 1/6] ACPI, PCI: Use normal list for struct acpi_pci_driver
  * [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
  * [PATCH v2 3/6] ACPI, PCI: add acpi_pci_drivers protection
  * [PATCH v2 4/6] ACPI, PCI: add acpi_pci_roots protection
  * [PATCH v2 5/6] ACPI, PCI: add hostbridge removal function
  * [PATCH v2 6/6] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge

-- 
Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

