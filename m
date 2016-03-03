Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52944 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756924AbcCCRnR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 12:43:17 -0500
Date: Thu, 3 Mar 2016 11:43:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Minghuan Lian <Minghuan.Lian@nxp.com>,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: [GIT PULL] PCI fixes for v4.5
Message-ID: <20160303174313.GA9613@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are a couple more fixes for v4.5.  These only affect the Layerscape
and Keystone host controllers, and they fix system crashes and hangs.

Bjorn


The following changes since commit 61d9e854dfb91b46b99ffd3d31fc7d45d2b95f31:

  PCI: mvebu: Restrict build to 32-bit ARM (2016-02-27 08:52:20 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.5-fixes-4

for you to fetch changes up to 1195c103f6c98d9ff381cac3a8760d4f8a133627:

  PCI: layerscape: Fix MSG TLP drop setting (2016-02-29 17:24:15 -0600)

----------------------------------------------------------------
PCI updates for v4.5:

  Freescale Layerscape host bridge driver
    Fix MSG TLP drop setting (Minghuan Lian)

  TI Keystone host bridge driver
    Fix MSI code that retrieves struct pcie_port pointer (Murali Karicheri)

----------------------------------------------------------------
Minghuan Lian (1):
      PCI: layerscape: Fix MSG TLP drop setting

Murali Karicheri (1):
      PCI: keystone: Fix MSI code that retrieves struct pcie_port pointer

 drivers/pci/host/pci-keystone-dw.c | 11 +++--------
 drivers/pci/host/pci-layerscape.c  | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)
