Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34143 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965208AbbHKPvD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 11:51:03 -0400
Received: by igui7 with SMTP id i7so43095480igu.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 08:51:02 -0700 (PDT)
Subject: [PATCH v3 00/11] PCI: Fix ATS deadlock
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>,
	iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 11 Aug 2015 10:50:59 -0500
Message-ID: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gregor reported a deadlock [1] when enabling a VF that supports ATS.
This series is intended to fix that.  The second patch should be enough to
fix the deadlock; the rest are simplification and cleanup.

These are based on v4.2-rc2.

[1] http://permalink.gmane.org/gmane.linux.kernel.iommu/9433

Changes between v2 and v3:
  - Initialize info->ats.enabled, qdep in intel-iommu.c (Yinghai)
  - Use "u8 enabled:1", not "int enabled:1" in intel-iommu.c state
  - WARN_ON() if enabling ATS when already enabled (Joerg)
  - Return -EBUSY, not -EINVAL if enabling ATS when already enabled
  - Added Reviewed-by from Joerg

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


 drivers/iommu/intel-iommu.c |   28 ++++++---
 drivers/pci/ats.c           |  132 +++++++++++++++----------------------------
 drivers/pci/probe.c         |    3 +
 include/linux/pci-ats.h     |   49 ----------------
 include/linux/pci.h         |   18 ++++++
 5 files changed, 85 insertions(+), 145 deletions(-)
