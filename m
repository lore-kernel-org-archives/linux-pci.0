Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47402 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbbJUSmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 14:42:46 -0400
Subject: [PATCH v4 0/4] PCI: designware: LTSSM #define cleanup
To: Fabio Estevam <festevam@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, pratyush.anand@gmail.com,
	m-karicheri2@ti.com, l.stach@pengutronix.de
Date: Wed, 21 Oct 2015 13:42:43 -0500
Message-ID: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a revision of Fabio's series:
http://lkml.kernel.org/r/1444664808-16445-1-git-send-email-festevam@gmail.com

Lucas, you reviewed the v3 patches, but I fiddled enough with this that I
didn't want to blindly carry your review forward.  I don't *think* I
changed anything substantive, but I might have missed something.

Changes since Fabio's v3:
  - Split removal of spear unused #defines to separate patch
  - Combine LTSSM_STATE_MASK definition and use changes in one patch
  - Combine LTSSM_STATE_RCVRY_LOCK definition and use in one patch
  - Use common LTSSM_STATE_L0 definition

---

Bjorn Helgaas (1):
      PCI: designware: Use common LTSSM_STATE_L0 definition

Fabio Estevam (3):
      PCI: designware: Use common LTSSM_STATE_MASK definition
      PCI: designware: Use common LTSSM_STATE_RCVRY_LOCK definition
      PCI: spear: Remove unused #defines


 drivers/pci/host/pci-imx6.c        |    3 +-
 drivers/pci/host/pci-keystone-dw.c |    2 -
 drivers/pci/host/pci-layerscape.c  |    4 +-
 drivers/pci/host/pcie-designware.h |    4 ++
 drivers/pci/host/pcie-spear13xx.c  |   70 ------------------------------------
 5 files changed, 6 insertions(+), 77 deletions(-)
