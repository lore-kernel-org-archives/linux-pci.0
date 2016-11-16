Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbcKPWNG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Nov 2016 17:13:06 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 0540E203C4
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:05 +0000 (UTC)
Received: from localhost (unknown [69.71.4.155])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070A1203DF
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:03 +0000 (UTC)
Subject: [PATCH 0/4] PCI: Tidy up messages
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Wed, 16 Nov 2016 16:13:02 -0600
Message-ID: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove a few messages that don't contain any useful information, e.g.,

  pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
  pci_hotplug: PCI Hot Plug PCI Core version: 0.5
  pciehp 0000:80:02.0:pcie04: service driver pciehp loaded
  pciehp: PCI Express Hot Plug Controller Driver version: 0.4

---

Bjorn Helgaas (4):
      PCI: Remove service driver load/unload messages
      PCI: hotplug: Remove hotplug core message
      PCI: pciehp: Remove loading message
      PCI: Expand "VPD access disabled" quirk message


 drivers/pci/hotplug/pci_hotplug_core.c |   10 +++-------
 drivers/pci/hotplug/pciehp_core.c      |    9 ++++-----
 drivers/pci/pcie/portdrv_core.c        |    3 ---
 drivers/pci/quirks.c                   |    2 +-
 4 files changed, 8 insertions(+), 16 deletions(-)
