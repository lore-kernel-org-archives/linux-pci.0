Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 0/5] pci/e1000e: return runtime-pm back to work
To: linux-kernel@vger.kernel.org
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: e1000-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Date: Fri, 18 Jan 2013 15:42:08 +0400
Message-ID: <20130118113019.6698.25941.stgit@zurg>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset contains some fixes for e1000e diver (broken since v2.6.35)
and some related fixes for PCI code (more fresh bugs).
Last patch adds simple debug for catching device-enable-cointer underflows.

All together this fixes my regression report for v3.8-rc1:
https://lkml.org/lkml/2013/1/1/25

---

Konstantin Khlebnikov (5):
      e1000e: fix resuming from runtime-suspend
      e1000e: fix pci device enable counter balance
      PCI: revert preparing for wakeup in runtime-suspend finalization
      PCI: don't touch enable_cnt in pci_device_shutdown()
      PCI: catch enable-counter underflows


 drivers/net/ethernet/intel/e1000e/netdev.c |   20 +++++++++++++++-----
 drivers/pci/pci-driver.c                   |    7 ++++---
 drivers/pci/pci.c                          |    3 +++
 3 files changed, 22 insertions(+), 8 deletions(-)

-- 
Signature
