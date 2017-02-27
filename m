Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbdB0PPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 10:15:33 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        John Garry <john.garry@huawei.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Ray Jui <rjui@broadcom.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Jon Mason <jonmason@broadcom.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 06/20] PCI: ECAM: use pci_remap_cfgspace() to map config region
Date: Mon, 27 Feb 2017 15:14:17 +0000
Message-Id: <20170227151436.18698-7-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current ECAM kernel implementation uses ioremap() to map the ECAM
configuration space memory region; this is not safe in that on some
architectures the ioremap interface provides mappings that allow posted
write transactions. This, as highlighted in the PCIe specifications
(4.0 - Rev0.3, "Ordering Considerations for the Enhanced Configuration
Address Mechanism"), can create ordering issues for software because
posted writes transactions on the CPU host bus are non posted in the
PCI express fabric.

Update the ioremap() interface to use pci_remap_cfgspace() whose
mapping attributes guarantee that non-posted writes transactions
are issued for memory writes within the ECAM memory mapped address
region.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ecam.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 2fee61b..e2068a4 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -84,12 +84,13 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 		if (!cfg->winp)
 			goto err_exit_malloc;
 		for (i = 0; i < bus_range; i++) {
-			cfg->winp[i] = ioremap(cfgres->start + i * bsz, bsz);
+			cfg->winp[i] =
+				pci_remap_cfgspace(cfgres->start + i * bsz, bsz);
 			if (!cfg->winp[i])
 				goto err_exit_iomap;
 		}
 	} else {
-		cfg->win = ioremap(cfgres->start, bus_range * bsz);
+		cfg->win = pci_remap_cfgspace(cfgres->start, bus_range * bsz);
 		if (!cfg->win)
 			goto err_exit_iomap;
 	}
-- 
2.10.0
