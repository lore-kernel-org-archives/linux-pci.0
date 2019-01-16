Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B277C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBD620840
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GAh9Us2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfAPKO2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:28 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:45158 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfAPKO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:27 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4A3C324E224F;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633667; bh=R0BnOwd1xmsgG9UtmSPqTXJqiXJrphN/oSnWoPxmBMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GAh9Us2SIbUHwWco2QZ+Jg2VA1Cnm6hvARj0FccFNsdvwlhpJquzfP5vnsipOZTye
         HBfv3y7F/tPgFkfmSfGQW6QnVr1s4r73SH9DbEY+U/Q2HBCXwtB1lQrKTGGXXat48E
         91RJPwcyvNwGPwirH0ChBuJLX2JcZ8KuChVOmex4KhcldCbuyp3NAkDNjta+2TldJW
         F7z/hEnnl/1+Gsh5ikOBY3Gge+IPharhNEcjLNS3bJxTxzfzaYGp+hC21b18DoQXDL
         XUrvkYOCKHtdIosydunUfFRWS/pyf38A+wOKpcQPINkGfNW0rsN3n4jIM641mznPz3
         5n/XiH8yWclfA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1405B581E;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 464093F689;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 4/9] PCI: dwc: Replace variable name from data to d on dw_pci_setup_msi_msg()
Date:   Wed, 16 Jan 2019 11:14:17 +0100
Message-Id: <1737c59f842c0274824615a1bfb6ff64ad9d69fd.1547631485.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace variable from data to d to maintain coherency between similar
functions, such as dw_pci_setup_msi_msg().

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 36e284c..0c6e19a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -120,9 +120,9 @@ static void dw_chained_msi_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u64 msi_target;
 
@@ -135,12 +135,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_hi = upper_32_bits(msi_target);
 
 	if (pp->ops->get_msi_data)
-		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
+		msg->data = pp->ops->get_msi_data(pp, d->hwirq);
 	else
-		msg->data = data->hwirq;
+		msg->data = d->hwirq;
 
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
-		(int)data->hwirq, msg->address_hi, msg->address_lo);
+		(int)d->hwirq, msg->address_hi, msg->address_lo);
 }
 
 static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
-- 
2.7.4

