Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51371 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab2HJGKF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 02:10:05 -0400
Date: Fri, 10 Aug 2012 15:09:55 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org
Cc: kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Subject: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
Message-Id: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hi all,

 
 I'd like to merge hostbridge hotplug feature.
 I looked at Yinghai's branch and found that this branch contains 
 many work and can be split into some parts. 
 I believe it is good to merge step by step.

 My idea is splitting into the following 4 parts:
   1. basic hostbirdge hotplug work
   2. acpiphp work
   3. /sysfs interface work (logical hotplug?)
   4. cleanup

 This patchset is 1st step based on the following Yinghai's branch:

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-root-bus-hotplug

  * [PATCH 1/7][RESEND] x86, PCI: Fix non acpi path pci_sysdata leaking with release_fn
  * [PATCH 2/7][RESEND] PCI: Correctly clean up pci root buses in function pci_remove_bus()
  * [PATCH 3/7][RESEND] ACPI, PCI: Use normal list for struct acpi_pci_driver
  * [PATCH 4/7][RESEND] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
  * [PATCH 5/7][RESEND] ACPI, PCI: Protect global lists in drivers/acpi/pci_root.c
  * [PATCH 6/7][RESEND] ACPI, PCI: add hostbridge removal function
  * [PATCH 7/7][RESEND] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge

-- 
Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

