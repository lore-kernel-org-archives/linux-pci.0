Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v7 0/4] PCI: pciehp, shpchp deadlock fixes
To: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Daniel J Blueman <daniel@quora.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <liuj97@gmail.com>
Date: Sun, 13 Jan 2013 16:27:32 -0700
Message-ID: <20130113232606.7225.94802.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is v7 of Yijing Wang's pciehp deadlock fix.  Here's the history of
previous postings:

    RFC Oct 31 2012
    v2  Nov  9 2012  use slot name, not device name
    v3  Nov 12 2012  create workqueues in pcie_init_slot(), pciehp-%u format
    v4  Nov 13 2012  use alloc_workqueue(name, 0, 0) again
    v5  Jan  9 2013  fix similar problem in shpchp
    v6  Jan 10 2013  add pciehp backtrace from Daniel 

This v7 series is functionally identical to v6.  In v7, I split the single
shpchp patch into three:

    PCI: shpchp: Make shpchp_wq non-ordered
    PCI: shpchp: Handle push button event asynchronously
    PCI: shpchp: Use per-slot workqueues to avoid deadlock

The first fixes what appears to be an error in e24dcbef93 ("shpchp: update
workqueue usage").  I split this out so Tejun could easily review it by itself.

I split the second out because it corresponds to a pciehp bugfix, 486b10b9f4
("PCI: pciehp: Handle push button event asynchronously"), that also affects
shpchp.

The "PCI: shpchp: Use per-slot workqueues to avoid deadlock" that remains
then corresponds exactly to Yijing's original pciehp deadlock fix.

I also rewrote the changelogs.

I propose to push the entire series for inclusion in v3.8, since it
fixes an easy-to-cause deadlock with Thunderbolt adapters.

---

Bjorn Helgaas (3):
      PCI: shpchp: Make shpchp_wq non-ordered
      PCI: shpchp: Handle push button event asynchronously
      PCI: shpchp: Use per-slot workqueues to avoid deadlock

Yijing Wang (1):
      PCI: pciehp: Use per-slot workqueues to avoid deadlock


 drivers/pci/hotplug/pciehp.h      |    2 +-
 drivers/pci/hotplug/pciehp_core.c |   11 ++---------
 drivers/pci/hotplug/pciehp_ctrl.c |    8 ++++----
 drivers/pci/hotplug/pciehp_hpc.c  |   11 ++++++++++-
 drivers/pci/hotplug/shpchp.h      |    3 +--
 drivers/pci/hotplug/shpchp_core.c |   36 ++++++++++++++----------------------
 drivers/pci/hotplug/shpchp_ctrl.c |    6 +++---
 7 files changed, 35 insertions(+), 42 deletions(-)
