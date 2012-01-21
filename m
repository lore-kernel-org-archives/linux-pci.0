Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/7] PCI: pcie hotplug related patch
Date: Sat, 21 Jan 2012 01:52:12 -0800
Message-Id: <1327139539-14301-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

b40c9ef: pciehp: Disable/enable link during slot power off/on
fe877ae: pciehp: Add Disable/enable link functions
292e286: pciehp: Add pcie_wait_link_not_active()
186b3fd: pciehp: print out link status when dlla get active.
2781df4: pciehp: Checking pci conf reading to new added device instead of sleep 1s
bf1c4ac: PCI: Separate pci_bus_read_dev_vendor_id from pci_scan_device
601c6f1: PCI: Make sriov work with hotplug remove

 drivers/pci/hotplug/pciehp_hpc.c |  133 +++++++++++++++++++++++++++++++-------
 drivers/pci/pci.h                |    2 +
 drivers/pci/probe.c              |   48 +++++++++-----
 drivers/pci/remove.c             |   28 ++++++++-
 4 files changed, 169 insertions(+), 42 deletions(-)

First one is for hotplug with sriov under bridge.
following two are for hotplug probing with pci conf reading.
Last four are for pcie link disable when power off slots.

Thanks

Yinghai Lu
