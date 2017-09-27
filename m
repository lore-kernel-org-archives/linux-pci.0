Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:6641 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdI0VwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2017 17:52:22 -0400
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: benve@cisco.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org
Cc: Govindarajulu Varadarajan <gvaradar@cisco.com>
Subject: [PATCH 0/4] pci aer: fix deadlock in do_recovery
Date: Wed, 27 Sep 2017 14:42:16 -0700
Message-Id: <20170927214220.41216-1-gvaradar@cisco.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am seeing a dead lock while loading enic driver with sriov enabled.

CPU0					CPU1
---------------------------------------------------------------------
__driver_attach()
device_lock(&dev->mutex) <--- device mutex lock here
driver_probe_device()
pci_enable_sriov()
pci_iov_add_virtfn()
pci_device_add()
					aer_isr()		<--- pci aer error
					do_recovery()
					broadcast_error_message()
					pci_walk_bus()
					down_read(&pci_bus_sem) <--- rd sem
down_write(&pci_bus_sem) <-- stuck on wr sem
					report_error_detected()
					device_lock(&dev->mutex)<--- DEAD LOCK

This can also happen when aer error occurs while pci_dev->sriov_config() is
called.

Only fix I could think of is to lock &pci_bus_sem and try locking all
device->mutex under that pci_bus. If it fails, unlock all device->mutex
and &pci_bus_sem and try again. This approach seems to be hackish and I
do not have better solution. I would like to open the discussion for
this.

Path 1 and 2 are code refactoring for pci locking api. Patch 3 fixes the
issue.

With current fix, we hold mutex lock of parent device and all the
devices under the bus. This can exceed the size of held_locks in lockdep
if number of devices (VFs) exceed 48. Patch 4 extends this 63, max
supported by lockdep.

Govindarajulu Varadarajan (4):
  pci: introduce __pci_walk_bus for caller with pci_bus_sem held
  pci: code refactor pci_bus_lock/unlock/trylock
  pci aer: fix deadlock in do_recovery
  lockdep: make MAX_LOCK_DEPTH configurable from Kconfig

 drivers/pci/bus.c                  | 13 ++++++++--
 drivers/pci/pci.c                  | 38 ++++++++++++++++++++---------
 drivers/pci/pcie/aer/aerdrv_core.c | 50 ++++++++++++++++++++++++++++++--------
 fs/configfs/inode.c                |  2 +-
 include/linux/pci.h                | 18 ++++++++++++++
 include/linux/sched.h              |  3 +--
 kernel/locking/lockdep.c           | 13 +++++-----
 lib/Kconfig.debug                  | 10 ++++++++
 8 files changed, 115 insertions(+), 32 deletions(-)

-- 
2.14.1
