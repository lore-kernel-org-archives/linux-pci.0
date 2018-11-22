Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A405C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217BB20838
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 18:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OCF/tmxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217BB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725745AbeKWFBh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:01:37 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:44608 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeKWFBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 00:01:37 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B8C3310C1465;
        Thu, 22 Nov 2018 10:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542910865; bh=wrK20lDPwWbkw9v4MyGowyQrMYtLsDSXeoI1+G6RbVw=;
        h=From:To:Cc:Subject:Date:From;
        b=OCF/tmxIeMNJ/IWERikOCLv0O7mtEe37/v1k7bGQVvGHpsW6WNlW/iQe4BD7ve0VS
         KZ1qI5zolu4BcQ2+XiLzS06H4avuY8rc0MMsFpHcNcCAiG/I9DMfHQB4mGJlxQkFPY
         lEeuwAHKnVh9uRnafjZJQduq2Z1q17d348/zvtDYJ7GcELfK3e/SuQMcw7o2ihUC0d
         pjjZ8hdKPM3/3D4T3E3dfjnyI+ydzwbo09eKNlTiYJ2TIf1DOQQL/B3WhW6Cp3EjCv
         MfdP6wSG5X+vRXzOO6tIziSe5e7946U0Kn5BI7Vx+GNykfRCHc5/XZPL6h8vrsLF+d
         /bF3IvgotkxeA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 808F136C7;
        Thu, 22 Nov 2018 10:21:05 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B769F3E503;
        Thu, 22 Nov 2018 19:21:04 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     jingoohan1@gmail.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     joao.pinto@synopsys.com, linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] PCI: dwc: Print debug error message when MSI-X entry control mask bit is set
Date:   Thu, 22 Nov 2018 19:20:55 +0100
Message-Id: <113052d54c1f3fa01f8ea1aa6e5a49e2620b5c64.1542910855.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add debug error message when MSI-X entry control mask bit is set, to help
depur which reason why a MSI-X interrupt is not being trigger.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1e7b022..b52b986 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -466,8 +466,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	iounmap(msix_tbl);
 
-	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
+	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
+		dev_err(pci->dev, "MSI-X entry ctrl set\n");
 		return -EPERM;
+	}
 
 	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
 				  epc->mem->page_size);
-- 
2.7.4

