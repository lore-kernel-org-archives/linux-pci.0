Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36376 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbHDX7M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 19:59:12 -0400
Received: by ioeg141 with SMTP id g141so33494127ioe.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 16:59:12 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id k68sm775580iod.8.2015.08.04.16.59.10
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 16:59:10 -0700 (PDT)
Subject: [PATCH 0/2] PCI: pciehp: Remove unused interrupt stuff
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Aug 2015 18:59:09 -0500
Message-ID: <20150804235823.15421.71342.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are pretty trivial; they just remove some unused interrupt things.

---

Bjorn Helgaas (2):
      PCI: pciehp: Remove unused interrupt events
      PCI: pciehp: Remove ignored MRL sensor interrupt events


 drivers/pci/hotplug/pciehp.h     |   14 ++++----------
 drivers/pci/hotplug/pciehp_hpc.c |   17 +++--------------
 2 files changed, 7 insertions(+), 24 deletions(-)
