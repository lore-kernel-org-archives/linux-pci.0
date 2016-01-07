Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59383 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750745AbcAGGQt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2016 01:16:49 -0500
From: Jisheng Zhang <jszhang@marvell.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>, <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] PCI: designware: comment the condition of programming ATU in host init
Date: Thu, 7 Jan 2016 14:12:38 +0800
Message-ID: <1452147158-2526-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some platforms don't support ATU, e.g pci-keystone.c, these platforms
use their own address translation component rather than ATU, and they
provide the rd_other_conf and wr_other_conf to programming the
translation component then do the required access, so we ignore the ATU
programming for these platforms. Add the comment to explain the reason.

As Bjorn pointed out,

  "these definitions:

  #define PCIE_ATU_TYPE_MEM
  #define PCIE_ATU_TYPE_IO
  #define PCIE_ATU_TYPE_CFG0
  #define PCIE_ATU_TYPE_CFG1

  and these uses:

  - In dw_pcie_host_init(), set PCIE_ATU_TYPE_MEM for unit 1
    (but only if rd_other_conf is not overridden)

  - In dw_pcie_rd_other_conf() and dw_pcie_wr_other_conf(),
    set PCIE_ATU_TYPE_CFG0 before config access to own bus;
    set PCIE_ATU_TYPE_CFG1 before config access to other bus;
    set PCIE_ATU_TYPE_IO after completion

   Why is that initialization related to rd_other_conf?  Shouldn't that
   be set up always?  A comment here would be nice..."

To be honest, I can't answer this question immediately until I read the
code carefully again. So indeed, the comment is really necessary.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pcie-designware.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 02a7452..b795b20 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -517,6 +517,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
+	/*
+	 * If the platform provides ->rd_other_conf, it means the platform
+	 * doesn't support ATU, it uses its own address translation component
+	 * rather than ATU, so we should ignore ATU programming for this
+	 * kind of platform.
+	 */
 	if (!pp->ops->rd_other_conf)
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-- 
2.7.0.rc3

