Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:20360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbcKSIcw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Nov 2016 03:32:52 -0500
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix improper handling of pcie hotplug events.
Date: Sat, 19 Nov 2016 00:32:44 -0800
Message-Id: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series fixes pciehp for certain special conditions observed during
testing.

Ashok Raj (3):
  pciehp: Prioritize data-link event over presence detect
  pciehp: Fix led status when enabling already enabled slot.
  pciehp: Fix race condition handling surprise link-down

 drivers/pci/hotplug/pciehp_ctrl.c |  6 +++---
 drivers/pci/hotplug/pciehp_hpc.c  | 21 ++++++++++++---------
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.7.4

