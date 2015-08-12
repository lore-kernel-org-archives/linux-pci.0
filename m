Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36241 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbbHLJd6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 05:33:58 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH v3 0/5] Designware host multivector MSI and 64bit MSI fixes
Date: Wed, 12 Aug 2015 11:33:51 +0200
Message-Id: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a reworked version of the multivector MSI support for the designware
PCIe host controller driver.

v3 added patch 2 to share more code between the single and multivector MSI
code paths.

While not really related to this topic patches 4+5 fix the MSI message setup
to work on 64bit and 32bit PAE systems. I included them in this series as
they depend on patch 2.

Regards,
Lucas

Lucas Stach (5):
  PCI: allow MSI chip providers to implement their own multivector MSI
    setup
  PCI: designware: factor out MSI msg setup
  PCI: designware: implement multivector MSI irq setup
  PCI: designware: change prototype of get_msi_addr
  PCI: designware: set up high part of MSI target address

 drivers/pci/host/pci-keystone-dw.c |  2 +-
 drivers/pci/host/pcie-designware.c | 62 +++++++++++++++++++++++++++++++-------
 drivers/pci/host/pcie-designware.h |  2 +-
 drivers/pci/msi.c                  |  3 ++
 include/linux/msi.h                |  2 ++
 5 files changed, 58 insertions(+), 13 deletions(-)

-- 
2.4.6

