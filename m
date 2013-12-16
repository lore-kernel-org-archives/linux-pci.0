Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56865 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBO6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:14:58 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so5718306iec.30
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:14:57 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id qi3sm13361232igc.8.2013.12.15.17.14.57
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:14:57 -0800 (PST)
Subject: [PATCH 0/8] pciehp cleanups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:14:55 -0700
Message-ID: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are a few cleanups for pciehp to make it easier to read.  There
shouldn't be any change in behavior except a dmesg change or two.

Rajat, I know these might conflict with what you're doing, but it shouldn't
be major.  I can fix up any conflicts for you, or if it makes your life
easier, you can rebase on top of my pci/pciehp branch.

---

Bjorn Helgaas (8):
      PCI: pciehp: Drop pciehp_readw()/pciehp_writew() wrappers
      PCI: pciehp: Remove error checks when accessing PCIe Capability
      PCI: pciehp: Make various functions void since they can't fail
      PCI: pciehp: Announce slot capabilities (slot #, button, LEDs, etc)
      PCI: pciehp: Simplify "Power Fault Detected" checking/clearing
      PCI: pciehp: Use symbolic constants, not hard-coded bitmask
      PCI: pciehp: Use symbolic constants for Slot Control fields
      PCI: pciehp: Move Attention & Power Indicator support tests to accessors


 drivers/pci/hotplug/pciehp.h      |   14 +
 drivers/pci/hotplug/pciehp_core.c |   15 +
 drivers/pci/hotplug/pciehp_ctrl.c |   90 +++------
 drivers/pci/hotplug/pciehp_hpc.c  |  380 ++++++++++++-------------------------
 drivers/pci/hotplug/pciehp_pci.c  |    6 -
 include/uapi/linux/pci_regs.h     |    8 +
 6 files changed, 185 insertions(+), 328 deletions(-)
