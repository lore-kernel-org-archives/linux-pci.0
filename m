Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:20679 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750971AbaF0Q4S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jun 2014 12:56:18 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
Message-ID: <1403888155-9709-1-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 27 Jun 2014 17:55:53 +0100
Subject: [PATCH 0/2] PCI: host: pcie-rcar: minor clean ups
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A couple of relatively minor clean up patches for the pcie-rcar driver. These
are on top of Sergei's recent patch "pcie-rcar: kill duplicate checks".

Thanks to Sergei for point these out.

Phil Edworthy (2):
  PCI: host: pcie-rcar: Use correct initial HW settings
  PCI: host: pcie-rcar: Style and formatting changes.

 drivers/pci/host/pcie-rcar.c | 146 +++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 75 deletions(-)

-- 
2.0.0

