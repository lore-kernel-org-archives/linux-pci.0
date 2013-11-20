Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36475 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3KTBwS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 20:52:18 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/6] PCI: double remove fixing and allocate 64bit mmio pref
Date: Tue, 19 Nov 2013 17:51:51 -0800
Message-Id: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First 3 are for Gu Zheng <guz.fnst@cn.fujitsu.com> to help double pci
device removing via sysfs.

Second 3 are about mmio 64 allocation that could help Guo Chao <yan@linux.vnet.ibm.com> on powerpc mmio allocation.
It will try to assign 64 bit resource above 4g at first.

I extracted them from big piles of pci related...

Could be found:
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-3.14

And it is based on current pci/for-linus, and should be applied without
problem on 3.13-rc1 after linus pull pci/for-linus.

Thanks

Yinghai

Yinghai Lu (6):
  PCI: move back pci_proc_attach_devices calling
  PCI: move resources and bus_list releasing to pci_release_dev
  PCI: Destroy pci dev only once
  PCI: pcibus address to resource converting take bus directly
  PCI: Add pcibios_bus_addr_to_res()
  PCI: Try to allocate mem64 above 4G at first

 arch/x86/include/asm/pci.h |  1 -
 drivers/pci/bus.c          | 43 +++++++++++++++++++++++++++++++++--------
 drivers/pci/host-bridge.c  | 48 +++++++++++++++++++++++++++++++++-------------
 drivers/pci/pci.h          |  2 ++
 drivers/pci/probe.c        | 23 ++++++++++++++++++----
 drivers/pci/remove.c       | 24 ++++-------------------
 include/linux/pci.h        | 10 ++++++----
 7 files changed, 101 insertions(+), 50 deletions(-)

-- 
1.8.1.4

