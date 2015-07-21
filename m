Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37112 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbbGUANw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:13:52 -0400
Received: by igbpg9 with SMTP id pg9so93983918igb.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:13:52 -0700 (PDT)
Subject: [PATCH v2 00/11] PCI: Fix ATS deadlock
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:13:49 -0500
Message-ID: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gregor reported a deadlock [1] when enabling a VF that supports ATS.
This series is intended to fix that.  The second patch should be enough to
fix the deadlock; the rest are simplification and cleanup.

These are based on v4.2-rc2.

[1] http://permalink.gmane.org/gmane.linux.kernel.iommu/9433

Changes between v1 and v2:
  - Remove use of pci_ats_enabled() (intel-iommu.c)
  - Call pci_ats_queue_depth() only once per device and cache result
    (intel-iommu.c)
  - Remove pci_ats_enabled() interface
  - Stop caching queue depth in pci_dev to save space
  - Add PF refcount of how many associated VFs have ATS enabled
  - Add comment that ATS must be enabled on PF before on VFs
  - Require ATS to be disabled on all VFs and PF before changing STU


---

Bjorn Helgaas (11):
      iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
      PCI: Allocate ATS struct during enumeration
      PCI: Embed ATS info directly into struct pci_dev
      PCI: Reduce size of ATS structure elements
      PCI: Rationalize pci_ats_queue_depth() error checking
      PCI: Inline the ATS setup code into pci_ats_init()
      PCI: Use pci_physfn() rather than looking up physfn by hand
      PCI: Clean up ATS error handling
      PCI: Move ATS declarations to linux/pci.h so they're all together
      PCI: Stop caching ATS Invalidate Queue Depth
      PCI: Remove pci_ats_enabled()


 drivers/iommu/intel-iommu.c |   26 +++++----
 drivers/pci/ats.c           |  131 +++++++++++++++----------------------------
 drivers/pci/probe.c         |    3 +
 include/linux/pci-ats.h     |   49 ----------------
 include/linux/pci.h         |   18 ++++++
 5 files changed, 82 insertions(+), 145 deletions(-)
