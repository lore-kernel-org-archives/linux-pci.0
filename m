Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:50435 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab2EGU3a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 16:29:30 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/7] PCI: hotplug bridge replated clean up
Date: Mon,  7 May 2012 13:29:09 -0700
Message-Id: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reduce the open code with create bus/scan bus.
Make them more like updated pciehp driver.

Need to apply it before for-pci-busn_res

could be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-hotplug

Yinghai Lu (7):
  PCI, pciehp: Separate pci_hp_add_bridge()
  PCI, cpci_hotplug: Simplify configure_slot
  PCI, shpchp: Simplify configure_device
  PCI, cpqhp: Using pci_hp_add_bridge
  PCI, ibmhp: Using pci_hp_add_bridge
  PCI, sgihp: Using pci_hp_add_bridge
  PCI, hotplug: remove pci_do_scan_bus()

 drivers/pci/hotplug-pci.c              |   30 +++++++++++++--------
 drivers/pci/hotplug/cpci_hotplug_pci.c |   35 ++++--------------------
 drivers/pci/hotplug/cpqphp_pci.c       |    8 +++---
 drivers/pci/hotplug/ibmphp_core.c      |    8 +++---
 drivers/pci/hotplug/pciehp_pci.c       |   28 +------------------
 drivers/pci/hotplug/sgi_hotplug.c      |   12 +++-----
 drivers/pci/hotplug/shpchp_pci.c       |   45 ++++++++++---------------------
 drivers/pci/pci.h                      |    2 +-
 8 files changed, 56 insertions(+), 112 deletions(-)

-- 
1.7.7

