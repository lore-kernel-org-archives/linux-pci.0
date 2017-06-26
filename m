Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:47506 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752218AbdFZNec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2017 09:34:32 -0400
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
CC: Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] critical patch to fix build bot failed
Date: Mon, 26 Jun 2017 21:34:00 +0800
Message-ID: <1498484041-6181-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This is a critical patch (based on pcie -next branch) to fix build bot failure:

This build failure is still present in -next:

> 	arm-allmodconfig
> ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]

and we're at -rc7 now.


This is because host/pci-mediatek is a separate branch in pci-tree but we (Lorenzo's patches) merge together.
Seems Bjorn didn't response these days, so I need someone help to apply this patch to -next.

Hi Arnd and Mark,

Do you have better idea to handle this situation? I'm really not sure how to fix it in proper ways.
Thanks a lot.

Ryder

Ryder Lee (1):
  PCI: mediatek: change to use pci_scan_root_bus_bridge()

 drivers/pci/host/pcie-mediatek.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
1.9.1
