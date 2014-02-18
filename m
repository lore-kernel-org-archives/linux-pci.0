Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:39236 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaBRU7e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 15:59:34 -0500
Received: by mail-ob0-f179.google.com with SMTP id wo20so19021589obc.24
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2014 12:59:34 -0800 (PST)
Subject: [PATCH v2 0/4] Remove dead code
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: e1000-devel@lists.sourceforge.net, Joerg Roedel <joro@8bytes.org>,
	Sudeep Dutt <sudeep.dutt@intel.com>,
	linux-kernel@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	iommu@lists.linux-foundation.org,
	Tomas Winkler <tomas.winkler@intel.com>,
	Aaron F Brown <aaron.f.brown@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Date: Tue, 18 Feb 2014 13:59:31 -0700
Message-ID: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is v2 of my rework of part of Stephen's patch [1].  My v1 posting,
with a little discussion, is here [2].

This removes SR-IOV migration support, which seems to be unused.

Changes since v1:
  - Drop the removal of MMIO exclusivity.
  - Add a few includes of <linux/irqreturn.h>.  The SR-IOV migration
    support included irqreturn.h via linux/pci.h, and a few drivers relied
    on that.  So this v2 series updates those drivers to include
    irqreturn.h directly.

Unless there's objection, I'd like to merge all these through my PCI tree
for v3.15.

Bjorn

[1] http://lkml.kernel.org/r/20131227132710.7190647c@nehalam.linuxnetplumber.net
[2] https://lkml.kernel.org/r/20140130192011.25426.45702.stgit@bhelgaas-glaptop.roam.corp.google.com

---

Bjorn Helgaas (4):
      misc: mic: Add include of <linux/irqreturn.h>
      mei: Add include of <linux/irqreturn.h>
      iommu/amd: Add include of <linux/irqreturn.h>
      PCI: Remove unused SR-IOV VF Migration support


 Documentation/PCI/pci-iov-howto.txt |    4 -
 drivers/iommu/amd_iommu_types.h     |    1 
 drivers/misc/mei/hw-me.h            |    1 
 drivers/misc/mic/card/mic_device.h  |    1 
 drivers/misc/mic/host/mic_device.h  |    1 
 drivers/pci/iov.c                   |  119 -----------------------------------
 drivers/pci/pci.h                   |    4 -
 include/linux/pci.h                 |    4 -
 8 files changed, 4 insertions(+), 131 deletions(-)
