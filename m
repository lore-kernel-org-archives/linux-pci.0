Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48022 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933474AbcCIRSP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Mar 2016 12:18:15 -0500
Date: Wed, 9 Mar 2016 11:18:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI fixes for v4.5
Message-ID: <20160309171811.GA21388@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here's another fix for v4.5.  It fixes an ARM regression in v4.0 that
causes many boxes to crash on boot, including cns3xxx, dove, footbridge,
iopl13xx, ip32x, iop33x, ixp4xx, ks8695, mv78xx0, orion5x, pxa, sa1100,
etc.  The change is in code that's only built for ARM and ARM64.

Bjorn


The following changes since commit 1195c103f6c98d9ff381cac3a8760d4f8a133627:

  PCI: layerscape: Fix MSG TLP drop setting (2016-02-29 17:24:15 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.5-fixes-5

for you to fetch changes up to 54c6e2dd00c313d0add58e5befe62fe6f286d03b:

  PCI: Allow a NULL "parent" pointer in pci_bus_assign_domain_nr() (2016-03-07 14:33:16 -0600)

----------------------------------------------------------------
PCI updates for v4.5:

  Enumeration
    Allow generic PCI domains without bridge "parent" pointer (Krzysztof Hałasa)

----------------------------------------------------------------
Krzysztof =?utf-8?Q?Ha=C5=82asa?= (1):
      PCI: Allow a NULL "parent" pointer in pci_bus_assign_domain_nr()

 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
