Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57184 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbbLIQCO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Dec 2015 11:02:14 -0500
Date: Wed, 9 Dec 2015 10:02:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ley Foon Tan <lftan@altera.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [GIT PULL] PCI fixes for v4.4
Message-ID: <20151209160205.GA29844@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

These are more fixes I'd like to have in v4.4.  Several for the Altera
driver added for v4.4, and one for an MSI domain problem that affects
several arm64 platforms.

Bjorn


The following changes since commit 7c7a0e945349a3d0d497d7f32db6ed33d4031110:

  ARM/PCI: Move align_resource function pointer to pci_host_bridge structure (2015-11-25 13:23:38 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.4-fixes-2

for you to fetch changes up to 99496bd2971fc378226ad4413e5b72c4545714bd:

  PCI: altera: Fix error when INTx is 4 (2015-12-04 16:21:21 -0600)

----------------------------------------------------------------
PCI updates for v4.4:

  MSI
    Only use the generic MSI layer when domain is hierarchical (Marc Zyngier)

  Altera host bridge driver
    Fix loop in tlp_read_packet() (Dan Carpenter)
    Fix Requester ID for config accesses (Ley Foon Tan)
    Check TLP completion status (Ley Foon Tan)
    Fix error when INTx is 4 (Ley Foon Tan)

----------------------------------------------------------------
Dan Carpenter (1):
      PCI: altera: Fix loop in tlp_read_packet()

Ley Foon Tan (3):
      PCI: altera: Fix Requester ID for config accesses
      PCI: altera: Check TLP completion status
      PCI: altera: Fix error when INTx is 4

Marc Zyngier (1):
      PCI/MSI: Only use the generic MSI layer when domain is hierarchical

 drivers/pci/host/pcie-altera.c | 23 ++++++++++++++++-------
 drivers/pci/msi.c              |  4 ++--
 2 files changed, 18 insertions(+), 9 deletions(-)
