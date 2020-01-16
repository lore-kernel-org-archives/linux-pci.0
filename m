Return-Path: <SRS0=0+aG=3F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC0CC33CB3
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6A6217F4
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200530;
	bh=lV6vCJ54AZJJG/iIgMdGhEKiyRI7RwaFGDruA9QXvkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VySQTXVW3r+dFzowx9GAlVxa6P2JDv6vLIqCuFDFfRc43AIvgRmq1sBoNpllYP6mL
	 kenlhCN0ZO25xqVZzwV1akIJUWwZQfS+yBQmfE4eexs/Qra47GtSXYr5EUFNN9708z
	 IZCg0mzsoKMNV3DIng5qAqO+46Mcuv9rzIc7RMQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbgAPSsn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:48:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389068AbgAPRJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E557D2081E;
        Thu, 16 Jan 2020 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194580;
        bh=lV6vCJ54AZJJG/iIgMdGhEKiyRI7RwaFGDruA9QXvkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFeOe3C+EYsGO6AIAehSqPbsUF1AH1b/+dt8SaZ9WiD8ZHgc02g7pISBiNMNPdoPM
         4tRvj4iyh1svAxzMmIT9BFaKDsH2et9269p7NE9w0wQhPTaRXj4XB+3QCBL9vZZhPA
         TMeqQUvaulH+bQ2mfBzk6qacg1184UKTr+u/CKsk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 454/671] PCI: mobiveil: Remove the flag MSI_FLAG_MULTI_PCI_MSI
Date:   Thu, 16 Jan 2020 12:01:32 -0500
Message-Id: <20200116170509.12787-191-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

[ Upstream commit a131fb6364c1be0924dcb969ecf6b988c556a5d5 ]

The Mobiveil internal MSI controller requires separate target addresses,
one per MSI vector; this is clearly incompatible with the Multiple MSI
feature, which requires the same target address for all vectors
requested by an endpoint (ie the Message Address field in the MSI
Capability structure), so the multi MSI feature is clearly not
supported by the host controller driver.

Remove the flag MSI_FLAG_MULTI_PCI_MSI and with it multi MSI support,
fixing the misconfiguration.

Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a2d1e89d4867..dc228eb500ed 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -643,7 +643,7 @@ static struct irq_chip mobiveil_msi_irq_chip = {
 
 static struct msi_domain_info mobiveil_msi_domain_info = {
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_PCI_MSIX),
 	.chip	= &mobiveil_msi_irq_chip,
 };
 
-- 
2.20.1

