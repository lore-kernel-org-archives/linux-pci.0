Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D75FC282D7
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0CC21B18
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WcfaFnwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfBKRen (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:34:43 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:32850 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfBKRek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 12:34:40 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B089F10C0D86;
        Mon, 11 Feb 2019 09:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549906480; bh=hujC3fFhNuHuyx4UkJzXE5fAzXp4IYbHj1UDRYL67Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WcfaFnwdMMvoJeDSNekRKOL1xQal87LzXUaprk+yGxEbHtGpNf4kANc8LYYSacikn
         ZMi0n+lIIqnD3h7X/6zeC/J13bsxOOxGEzQF5Ktee28ReHWytCSrRSYS2gv520FfzT
         +aTPybYm4IH+HsJzQux+Cvb0rYS7DkmYGI0PyjHk8kU/jmwPQjK7IAkCysRopTXwvx
         evBrE9qfZTYvQwJIL/i0hub+NSDzBSEIcegN66IZdqtXuSY5+fZOcjtu9bakzFI6tx
         JA53aa/DBx1cr+TESsGkPrVSQxPLejBFfZIhuzXq8yDRjfjiN+63fEntAg4HS7kCSO
         JxRRRNhgNFFuw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5748EA00B4;
        Mon, 11 Feb 2019 17:34:40 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id EC8073C247;
        Mon, 11 Feb 2019 18:34:38 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: [RFC v5 6/6] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Mon, 11 Feb 2019 18:34:35 +0100
Message-Id: <06542f172ebbf76401cddee65ebca0e6d8115257.1549905325.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys eDMA IP driver maintainer.

This driver aims to support Synopsys eDMA IP and is normally distributed
along with Synopsys PCIe EndPoint IP (depends of the use and licensing
agreement).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jose Abreu <jose.abreu@synopsys.com>
Cc: Luis Oliveira <lolivei@synopsys.com>
Cc: Vitor Soares <vitor.soares@synopsys.com>
Cc: Nelson Costa <nelson.costa@synopsys.com>
Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
---
Changes:
RFC v1->RFC v2:
 - No changes
RFC v2->RFC v3:
 - Rebase to v5.0-rc1
RFC v3->RFC v4:
 - No changes
RFC v4->RFC v5:
 - Patch resended, forgot to replace of '___' by '---' and to remove
 duplicate signed-off

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3a5c97..5e9f620 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4338,6 +4338,13 @@ L:	linux-mtd@lists.infradead.org
 S:	Supported
 F:	drivers/mtd/nand/raw/denali*
 
+DESIGNWARE EDMA CORE IP DRIVER
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	drivers/dma/dw-edma/
+F:	include/linux/dma/edma.h
+
 DESIGNWARE USB2 DRD IP DRIVER
 M:	Minas Harutyunyan <hminas@synopsys.com>
 L:	linux-usb@vger.kernel.org
-- 
2.7.4

