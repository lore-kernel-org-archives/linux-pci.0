Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39837 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933739Ab2GDIEA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:04:00 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id F1AC23EE0C1
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:03:58 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D895145DEA6
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:03:58 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BF6C645DEB4
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:03:58 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id ACA5F1DB803E
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:03:58 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5FABC1DB803B
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:03:58 +0900 (JST)
Date: Wed, 4 Jul 2012 17:03:45 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 0/7] acpi, pci: hostbridge hotplug support
Message-Id: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
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

  * [PATCH 1/7] x86, PCI: Fix non acpi path pci_sysdata leaking with release_fn
  * [PATCH 2/7] PCI: Correctly clean up pci root buses in function pci_remove_bus()
  * [PATCH 3/7] ACPI, PCI: Use normal list for struct acpi_pci_driver
  * [PATCH 4/7] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
  * [PATCH 5/7] ACPI, PCI: Protect global lists in drivers/acpi/pci_root.c
  * [PATCH 6/7] ACPI, PCI: add hostbridge removal function
  * [PATCH 7/7] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge

-- 
Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

