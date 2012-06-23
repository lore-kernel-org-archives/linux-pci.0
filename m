Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:16749 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab2FWHmI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jun 2012 03:42:08 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/5] PCI: hotplug related misc patches
Date: Sat, 23 Jun 2012 00:42:00 -0700
Message-Id: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

minor changes that should be safe for 3.6

could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-next

Yinghai Lu (5):
  PCI, acpiphp: remove not used res_lock
  pciehp: Don't enable presence notification while surprise removal is
    not supported.
  PCI, acpiphp: Merge acpiphp_debug and debug
  PCI, acpiphp: add is_hotplug_bridge detection
  PCI: add root bus children dev's res to fail list

 drivers/pci/hotplug/acpiphp.h      |    4 +---
 drivers/pci/hotplug/acpiphp_core.c |    7 ++-----
 drivers/pci/hotplug/acpiphp_glue.c |   30 ++++++++++++++++++++++++++----
 drivers/pci/hotplug/pciehp_hpc.c   |    5 +++--
 drivers/pci/setup-bus.c            |    2 +-
 5 files changed, 33 insertions(+), 15 deletions(-)

-- 
1.7.7

