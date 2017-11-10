Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:48784 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKJV67 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:58:59 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 0/5] PCI: rcar: Add suspend/resume support
Date: Fri, 10 Nov 2017 22:58:38 +0100
Message-Id: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds support for suspend/resume on the Renesas RCar PCIe
controller. First two patches clean the driver up a little, while the
remaining three add the required suspend/resume functionality.

Kazufumi Ikeda (2):
  PCI: rcar: Add the initialization of PCIe link in resume_noirq
  PCI: rcar: Add the suspend/resume for pcie-rcar driver

Marek Vasut (2):
  PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
  PCI: rcar: Clean up the macros

Phil Edworthy (1):
  PCI: rcar: Support runtime PM, link state L1 handling

 drivers/pci/host/pcie-rcar.c | 182 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 146 insertions(+), 36 deletions(-)

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
-- 
2.11.0
