Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:61325 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbaFXTTD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jun 2014 15:19:03 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so762386qcz.9
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 12:19:02 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: r65037@freescale.com, shawn.guo@freescale.com, marex@denx.de,
	d.mueller@elsoft.ch, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	tharvey@gateworks.com, Fabio Estevam <fabio.estevam@freescale.com>
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Date: Tue, 24 Jun 2014 16:18:27 -0300
Message-Id: <1403637507-9424-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
hang inside imx6_add_pcie_port().

Adding a 30ms delay allows the kernel to boot.

Suggested-by: David Müller <d.mueller@elsoft.ch>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
I am happy to get feedback on how to properly fix this.

Thanks

 drivers/pci/host/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efa..669f771 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -507,6 +507,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
+	usleep_range(25000, 30000);
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize host\n");
-- 
1.8.3.2

