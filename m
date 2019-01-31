Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB656C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E32218F0
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZmRq+pkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfAaSRR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:17 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:54726 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 77AAF24E1205;
        Thu, 31 Jan 2019 10:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958635; bh=4kVSO8wl/w4Poa4+SYvQjH0HMBBxxgOzAyvegyRTV2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZmRq+pkJdezKY2pnY3L/eqS6EjwwntSexqlpcsga2SbqokcV44bW1ZZzSsE97tbzt
         VTQ3BwVklZ4y4d8jja2kKfS41rZ1YhGc9dsG+m3Sr/qC7FFLzIzljP40kWP/nNAyjs
         5D/AWQzMDOi3Hig8MQRO8eyAkEU56wr4NJCW4mDR0MBksAWH1CN0UF5s3HI3xHGJk3
         JGGnk/1TYm1BIsKkoExqjYkAJwL9GwL9WEVAKLRVXVboiA0t3fZPNEADZyP3zzUsei
         OFUEw1tbUs8R6xjS3dIBJ4xmTT3b6Z2WwZumOe1UFVorhjnlO3PLJM3NupPDfd2Nur
         M2oFwPE1KTq+w==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4310FA009A;
        Thu, 31 Jan 2019 18:17:15 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D07A43CEE0;
        Thu, 31 Jan 2019 19:17:13 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 5/8] PCI: dwc: Rename variable name from data to d on dw_pci_msi_set_affinity()
Date:   Thu, 31 Jan 2019 19:17:04 +0100
Message-Id: <3ef51f8a9ce02e8cc541f9f46027969aa51d17de.1548958059.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename variable from data to d to maintain consistency between driver
functions.

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
Changes v1 -> v2:
 - Fix description terminology

 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0c6e19a..a59fc17e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -143,7 +143,7 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 		(int)d->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
+static int dw_pci_msi_set_affinity(struct irq_data *d,
 				   const struct cpumask *mask, bool force)
 {
 	return -EINVAL;
-- 
2.7.4

