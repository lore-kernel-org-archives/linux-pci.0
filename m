Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33859 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbcAFTzE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 14:55:04 -0500
Subject: [PATCH 0/2] PCI: designware: Simplify config accessors
To: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Jan 2016 13:54:59 -0600
Message-ID: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These make the code slightly smaller and easier to read but shouldn't make
any functional difference.

---

Bjorn Helgaas (2):
      PCI: designware: Simplify control flow
      PCI: designware: Make config accessor override checking symmetric


 drivers/pci/host/pcie-designware.c |   53 ++++++++++++------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)
