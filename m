Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34627 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbHUPHh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 11:07:37 -0400
Received: by padfo6 with SMTP id fo6so9046991pad.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 08:07:37 -0700 (PDT)
Subject: [PATCH 0/3] MPS tuning
To: Keith Busch <keith.busch@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Date: Fri, 21 Aug 2015 10:07:31 -0500
Message-ID: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith, et al,

This is essentially your patch, tweaked a little to move it to the
pci_device_add() path instead of the pcie_bus_configure_settings() path.

One interesting wrinkle is the quirk_intel_mc_errata() quirk, which
was previously essentially disabled because it did nothing in
PCIE_BUS_TUNE_OFF mode, which was the default.  If we change the mode to
something else (as I did in the last patch), that quirk will now be active
when it wasn't before.  I'd like to chat with Jon about whether that's the
right thing.
---

Bjorn Helgaas (2):
      PCI: Move MPS configuration check to pci_configure_device()
      PCI: Change MPS default to "match upstream bridge"

Keith Busch (1):
      PCI: Set MPS to match upstream bridge


 drivers/pci/pci.c   |    2 +-
 drivers/pci/probe.c |   54 +++++++++++++++++++++++++++++++++------------------
 include/linux/pci.h |    9 +++++----
 3 files changed, 41 insertions(+), 24 deletions(-)
