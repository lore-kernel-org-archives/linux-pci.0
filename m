Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:60792 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbaCKRsE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Mar 2014 13:48:04 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so9267840iec.18
        for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2014 10:48:04 -0700 (PDT)
Subject: [PATCH] PCI: INTx disable fix
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org,
	Chris Cheng <chris.cheng@atrustcorp.com>,
	Jamie Chen <jamie.chen@intel.com>,
	Andreas Noever <andreas.noever@gmail.com>
Date: Tue, 11 Mar 2014 11:48:02 -0600
Message-ID: <20140311174555.23257.66798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

My earlier "Enable INTx if BIOS left them disabled" patch fixed a problem
with EHCI devices on Intel Baytrail platforms, but had the unintended
consequence of breaking pciehp surprise removal.

This patch should fix the pciehp issue.

This is in my pci/misc branch and intended for v3.14.

---

Bjorn Helgaas (1):
      PCI: Do not enable INTx in pci_reenable_device()


 drivers/pci/pci.c |    3 +++
 1 file changed, 3 insertions(+)
