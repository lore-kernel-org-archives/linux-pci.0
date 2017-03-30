Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755014AbdC3WA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Mar 2017 18:00:28 -0400
Date: Thu, 30 Mar 2017 17:00:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>,
        Robert Richter <rrichter@cavium.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Subject: [GIT PULL] PCI fixes for v4.11
Message-ID: <20170330220025.GA31318@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix iProc memory corruption

  - fix ThunderX usage of unregistered PNP/ACPI ID

  - fix ThunderX resource reservation on early firmware


The following changes since commit 3bd7db63a841e8c5297bb18ad801df67d5e38ad2:

  PCI/ASPM: Always set link->downstream to avoid NULL dereference on remove (2017-03-07 14:23:30 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.11-fixes-3

for you to fetch changes up to 9abb27c7594a62bbf6385e20b7f5a90b4eceae2f:

  PCI: thunder-pem: Add legacy firmware support for Cavium ThunderX host controller (2017-03-23 17:11:26 -0500)

----------------------------------------------------------------
pci-v4.11-fixes-3

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI: iproc: Save host bridge window resource in struct iproc_pcie

Tomasz Nowicki (2):
      PCI: thunder-pem: Use Cavium assigned hardware ID for ThunderX host controller
      PCI: thunder-pem: Add legacy firmware support for Cavium ThunderX host controller

 drivers/pci/host/pci-thunder-pem.c     | 58 ++++++++++++++++++++++++++++++++--
 drivers/pci/host/pcie-iproc-bcma.c     | 24 +++++++-------
 drivers/pci/host/pcie-iproc-platform.c | 19 +++++------
 drivers/pci/host/pcie-iproc.h          |  1 +
 4 files changed, 78 insertions(+), 24 deletions(-)
