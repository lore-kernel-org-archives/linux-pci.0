Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DCDC4363B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3718520840
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LFRjQijR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbfAPKO2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:28 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:45164 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389381AbfAPKO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:28 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0231424E2255;
        Wed, 16 Jan 2019 02:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633668; bh=lI8IFlCij1mdCsrN1s/GmKIRKzExi7AeqEpd0tLqnr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LFRjQijR7OV+rcsLh4EBN+pNZtnqd+M3/N/cX/A0wcE08wDCJXBWUxIQ/vD5SZYr8
         TXYmDU/xh/RvztSILcX12+RoFLup4emDcXJtzLoqF6HDWurFGhiofetUGjRr8qSM1O
         v+a+grPMwD9m+XpysYa85d+m3ZwhCiP2f/De/wRJWprROKJ5oAHA2QndJl2aBvCE6l
         EQ3VL0+jjE7VoSywZB69zRGvslnnuIK4U76sUfQXIWCfhucvQ8Z2GYZtINC4R9BMQL
         kVNHV5sTHqs8rz6R3gBY6XZM3xF6exFBp6Y+sXkmAArDTbwFq1u0lU1aqCjlitWH+t
         Sp3cQxM6FqkBQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id BEA205822;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 593AA3F68C;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 5/9] PCI: dwc: Replace variable name from data to d on dw_pci_msi_set_affinity()
Date:   Wed, 16 Jan 2019 11:14:18 +0100
Message-Id: <b5c27d810b6bfe4372ef806fc34be92b82844873.1547631485.git.gustavo.pimentel@synopsys.com>
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
functions.

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
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

