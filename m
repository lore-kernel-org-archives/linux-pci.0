Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35051 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755413AbdGKJ3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2017 05:29:11 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, paulus@samba.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] constify pci attribute_group structures.
Date: Tue, 11 Jul 2017 14:58:43 +0530
Message-Id: <1499765324-617-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

Arvind Yadav (3):
  [PATCH 1/3] PCI: pci-sysfs: constify attribute_group structures.
  [PATCH 2/3] PCI: pci-label: constify attribute_group structures.
  [PATCH 3/3] PCI: hotplug: constify attribute_group structures.

 drivers/pci/hotplug/rpadlpar_sysfs.c |  2 +-
 drivers/pci/pci-label.c              |  4 ++--
 drivers/pci/pci-sysfs.c              | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.1
