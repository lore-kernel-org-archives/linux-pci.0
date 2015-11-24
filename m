Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33778 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbbKXJhH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 04:37:07 -0500
Received: by wmec201 with SMTP id c201so199274510wme.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2015 01:37:06 -0800 (PST)
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] PCI: designware: remove wrong io_base assignment
Date: Tue, 24 Nov 2015 11:36:52 +0200
Message-Id: <1448357812-23906-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The io_base is used to keep the cpu physical address parsed
from ranges dt property. After issue pci_remap_iospace the
io_base has been assigned with io->start, which is not correct
cause io->start is a PCI bus address.

Fixes: 0021d22b73d6 ("PCI: designware: Use of_pci_get_host_bridge_resources() to parse DT")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/pci/host/pcie-designware.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 540f077c37ea..02a7452bdf23 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -440,7 +440,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					 ret, pp->io);
 				continue;
 			}
-			pp->io_base = pp->io->start;
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
-- 
1.7.9.5

