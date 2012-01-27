Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:24488 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab2A0Szd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2012 13:55:33 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2 0/7] PCI: pcie hotplug related patch
Date: Fri, 27 Jan 2012 10:55:08 -0800
Message-Id: <1327690515-2991-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

75e4615: pciehp: Disable/enable link during slot power off/on
92bdfaf: pciehp: Add Disable/enable link functions
47442c1: pciehp: Add pcie_wait_link_not_active()
40b6c9b: pciehp: print out link status when dlla get active.
dcc66b6: pciehp: Checking pci conf reading to new added device instead of sleep 1s
aadd74c: PCI: Separate pci_bus_read_dev_vendor_id from pci_scan_device
e7457be: PCI: Make sriov work with hotplug remove

 drivers/pci/hotplug/pciehp_hpc.c |  133 +++++++++++++++++++++++++++++++-------
 drivers/pci/pci.h                |    2 +
 drivers/pci/probe.c              |   48 +++++++++-----
 drivers/pci/remove.c             |   10 +++-
 4 files changed, 151 insertions(+), 42 deletions(-)

First one is for hotplug with sriov under bridge.
following two are for hotplug probing with pci conf reading.
Last four are for pcie link disable when power off slots.

-v2: update first one according to reviewing from linus.
     other like pci_dev_read_config return checking is not changed.

Resending whole set according to Jesse.

Thanks

Yinghai Lu
