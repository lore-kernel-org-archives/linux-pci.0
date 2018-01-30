Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbeA3Akr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jan 2018 19:40:47 -0500
Subject: [PATCH] PCI: Add SPDX tag for s390_pci_hpc.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Date: Mon, 29 Jan 2018 18:40:42 -0600
Message-ID: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I previously posted patches [1] to add SPDX tags to all drivers/pci files
except drivers/pci/hotplug/s390_pci_hpc.c.  I omitted that one because it
contained only a "License: GPL" comment, which I thought was ambiguous.

However, I think it is actually unambiguous because the file was added with
a 'MODULE_LICENSE("GPL")', and include/linux/module.h shows that means "GPL
v2 or later".

So this patch adds the GPL-2.0+ tag to the file.  I plan to include this
for v4.16 unless somebody objects.

[1] https://lkml.kernel.org/r/20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com

---

Bjorn Helgaas (1):
      PCI: Add SPDX GPL-2.0+ to replace implicit GPL v2 or later statement


 drivers/pci/hotplug/s390_pci_hpc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
