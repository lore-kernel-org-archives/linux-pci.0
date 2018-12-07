Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F697C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 17:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B4720837
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Cyeaiima"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B4720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLGRYX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:24:23 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:41342 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeLGRYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 12:24:23 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1198A24E2048;
        Fri,  7 Dec 2018 09:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544203463; bh=cV1TWCidK3fYmQj/SuoTDm9CKiCSAw0hssfRoR+tW/A=;
        h=From:To:Cc:Subject:Date:From;
        b=Cyeaiima6gqbieIuFjXtJa92SjeYYNe/IFimsaM01vE0r7RNujvRY8xMWMIjRN7vH
         mIjCOdAIPADfwVldaP7wk1DlS4blriq9ojRSvharp4lLql9gOqhPHAYtF1wXC2HJrK
         UFm6O/uwSrntWcKQ+wfDAkGcGCSYm1iX9Y8JKopTPuBgQ5pIwHRfIAT3fotgipx6NM
         FW/Kt4Rycf0Dwxoob4blYywvDiAQbK5p7NqHIkXlWGlgC1igmKsas9o7uWLz+C3LWD
         yIiZrNLI/VoEMuooQ2FQ20Khn3JOKZUtLHQTlGrPdAkGsUlHMepR+v6kn4QbKR6lR9
         L/C4lNc/GWaTg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id C5C9833FF;
        Fri,  7 Dec 2018 09:24:22 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id EF0673E81D;
        Fri,  7 Dec 2018 18:24:21 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     lorenzo.pieralisi@arm.com
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <joao.pinto@synopsys.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: Print debug error message when MSI-X entry control mask bit is set
Date:   Fri,  7 Dec 2018 18:24:04 +0100
Message-Id: <a5f26b59ae720edf4f3b90e4ee2d052e2920dca9.1544203444.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add debug error message when MSI-X entry control mask bit is set, to help
debug the reason why a MSI-X interrupt is not being triggered.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <joao.pinto@synopsys.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1e7b022..a969322 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -466,8 +466,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	iounmap(msix_tbl);
 
-	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
+	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
+		dev_dbg(pci->dev, "MSI-X entry ctrl set\n");
 		return -EPERM;
+	}
 
 	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
 				  epc->mem->page_size);
-- 
2.7.4

