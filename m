Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33709 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbbFRQMe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 12:12:34 -0400
Received: by igbqq3 with SMTP id qq3so19218280igb.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 09:12:33 -0700 (PDT)
Subject: [PATCH 0/4] PCI: pciehp cleanup
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2015 11:12:31 -0500
Message-ID: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches don't *do* anything except get rid of some overly verbose
debug logging and a bunch of boilerplate code by inlining trivial things.

Unless I made a mistake, this should not change the way anything works at
all, although I did change some of the message text.

---

Bjorn Helgaas (4):
      PCI: pciehp: Clean up debug logging
      PCI: pciehp: Make queue_interrupt_event() void
      PCI: pciehp: Rename queue_interrupt_event() to pciehp_queue_interrupt_event()
      PCI: pciehp: Inline the "handle event" functions into the ISR


 drivers/pci/hotplug/pciehp.h      |    6 -
 drivers/pci/hotplug/pciehp_core.c |   37 +--------
 drivers/pci/hotplug/pciehp_ctrl.c |  154 +++----------------------------------
 drivers/pci/hotplug/pciehp_hpc.c  |   89 +++++++++------------
 4 files changed, 53 insertions(+), 233 deletions(-)
