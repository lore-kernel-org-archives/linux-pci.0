Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:58563 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751701AbbJBK2C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 06:28:02 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1443781507-5011-2-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 2 Oct 2015 11:25:04 +0100
Subject: [PATCH 1/4] PCI: rcar-pcie: Make PCI aware of the IO resources
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 7678fe0..27e2c20 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -373,8 +373,9 @@ static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
 		if (res->flags & IORESOURCE_IO) {
 			phys_addr_t io_start = pci_pio_to_address(res->start);
 			pci_ioremap_io(nr * SZ_64K, io_start);
-		} else
-			pci_add_resource(&sys->resources, res);
+		}
+
+		pci_add_resource(&sys->resources, res);
 	}
 	pci_add_resource(&sys->resources, &pcie->busn);
 
-- 
1.9.1

