Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHIWac (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 18:30:32 -0400
Subject: [PATCH v4 0/3] PCI: NVMe reset quirks
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Thu, 09 Aug 2018 14:04:03 -0600
Message-ID: <153384487209.15793.15203778129263981368.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v4: Fix 0-day i386 build error for readq, simply use readl
    instead, the bits we're interested in are 24:31 and the NVMe
    spec indicates that smaller, aligned accesses are allowed.
    Update bz links for both device specific resets.

v3: Separate quirks, only for the afflicted devices

v2: Add bug link, use Samsung vendor ID, add spec references

Fix two different NVMe device reset issues with device specific
quirks.  The Samsung controller in patch 2 sometimes doesn't like
being reset while enabled, so disable the NVMe controller prior to
FLR.  This quirk is generic to all NVMe class devices, though I've
dropped the additional delay some devices require between disabling
and checking ready status.  This can be added later should any of
those devices need this quirk.  The Intel controller quirk is now
just a simple delay after FLR, which clearly any device needing
similar behavior can also use.  Thanks,

Alex

---

Alex Williamson (3):
      PCI: Export pcie_has_flr()
      PCI: Samsung SM961/PM961 NVMe disable before FLR quirk
      PCI: Intel DC P3700 NVMe delay after FLR quirk


 drivers/pci/pci.c    |    3 +
 drivers/pci/quirks.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 
 3 files changed, 108 insertions(+), 1 deletion(-)
