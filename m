Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:15932 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752680AbaF3Hye (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 03:54:34 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
Message-ID: <1404114864-17330-1-git-send-email-phil.edworthy@renesas.com>
Date: Mon, 30 Jun 2014 08:54:21 +0100
Subject: [PATCH v2 0/3] PCI: host: pcie-rcar: minor clean ups
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Relatively minor clean up patches for the pcie-rcar driver. These
are on top of Sergei's recent patch "pcie-rcar: kill duplicate checks".

Thanks to Sergei for point these out.

v2:
 - break out replacing function arg with local var into separate patch

Phil Edworthy (3):
  PCI: host: pcie-rcar: Use correct initial HW settings
  PCI: host: pcie-rcar: Style and formatting changes.
  PCI: host: pcie-rcar: Replace arg passed into a func with local var

 drivers/pci/host/pcie-rcar.c | 146 +++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 75 deletions(-)

-- 
2.0.0

