Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:58097 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751189AbbJBK1p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 06:27:45 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phil Edworthy <phil.edworthy@renesas.com>
Message-ID: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 2 Oct 2015 11:25:03 +0100
Subject: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple instances
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fixes and changes to get PCIe working on ARM64 with mulitple instances.

I've tested these on ARM (Koelsch board), and it works fine.
I've also tested on ARM64 (Salvator-X board), but I currently have an issue
with inbound PCI accesses. I am reasonably sure that this problem is hardware
related.

Phil Edworthy (4):
  PCI: rcar-pcie: Make PCI aware of the IO resources
  PCI: rcar-pcie: Remove dependency on ARM-specific struct hw_pci
  PCI: rcar-pcie: Set root bus nr to that provided in DT
  PCI: rcar-pcie: Fix IO offset for multiple instances

 drivers/pci/host/pcie-rcar.c | 86 ++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 31 deletions(-)

-- 
1.9.1

