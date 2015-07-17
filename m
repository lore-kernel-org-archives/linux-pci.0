Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:32812 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbGQVbr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:31:47 -0400
Received: by oige126 with SMTP id e126so78450080oig.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:31:47 -0700 (PDT)
Subject: [PATCH 0/8] PCI: Fix ATS deadlock
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:31:44 -0500
Message-ID: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gregor reported a deadlock [1] when enabling a VF that supports ATS.
This series is intended to fix that.  The first patch should be enough to
fix the deadlock; the rest are simplification and cleanup.

These are based on v4.2-rc2.

[1] http://permalink.gmane.org/gmane.linux.kernel.iommu/9433

---

Bjorn Helgaas (8):
      PCI: Allocate ATS struct during enumeration
      PCI: Embed ATS info directly into struct pci_dev
      PCI: Reduce size of ATS structure elements
      PCI: Rationalize pci_ats_queue_depth() error checking
      PCI: Inline the ATS setup code into pci_ats_init()
      PCI: Use pci_physfn() rather than looking up physfn by hand
      PCI: Clean up ATS error handling
      PCI: Move ATS declarations to linux/pci.h so they're all together


 drivers/pci/ats.c       |  110 +++++++++++------------------------------------
 drivers/pci/probe.c     |    3 +
 drivers/pci/remove.c    |    1 
 include/linux/pci-ats.h |   49 ---------------------
 include/linux/pci.h     |   20 ++++++++-
 5 files changed, 49 insertions(+), 134 deletions(-)
