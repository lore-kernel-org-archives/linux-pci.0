Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbdIES0z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Sep 2017 14:26:55 -0400
Subject: [PATCH 0/4] iproc/xgene PCIe cap & whitespace cleanup
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Scott Branden <sbranden@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Tue, 05 Sep 2017 13:26:52 -0500
Message-ID: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Both iproc and xgene mask out PCI_EXP_RTCAP_CRSVIS (CRS Software
Visibility).  The point of these is to make them do it more
consistently.

For iproc, I renamed PCI_EXP_CAP to IPROC_PCI_EXP_CAP to make it
obviously iproc-specific.  Apparently the X-Gene PCIe capability is at
0x40, at least for V1 root ports, so I added a corresponding
XGENE_V1_PCI_EXP_CAP.

X-Gene also defines PCIECORE_CTLANDSTATUS at 0x50, which is looks a
little like the PCI_EXP_LNKCTL and PCI_EXP_LNKSTA registers which
would be at 0x50 in the PCIe capability, and PCIECORE_CTLANDSTATUS is
used to determine whether the link is up.  If this *were* actually
part of a PCIe capability, I'd like to use the generic definitions.

But it's not clear from the code because PCIECORE_CTLANDSTATUS is used
with a simple xgene_pcie_readl(), while we read PCI_EXP_RTCTL using
pci_generic_config_read32(), so I'm not sure they're in the same
address space.  So I didn't touch anything there.

Also, some trivial whitespace cleanup.

---

Bjorn Helgaas (4):
      PCI: iproc: Rename PCI_EXP_CAP to IPROC_PCI_EXP_CAP
      PCI: iproc: Clean up whitespace
      PCI: xgene: Define XGENE_PCI_EXP_CAP and use generic PCI_EXP_RTCTL offset
      PCI: xgene: Clean up whitespace


 drivers/pci/host/pci-xgene.c  |   41 +++----
 drivers/pci/host/pcie-iproc.c |  250 ++++++++++++++++++++---------------------
 2 files changed, 144 insertions(+), 147 deletions(-)
