Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D8AC282CE
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58470218A4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dTTXkKOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfBKREF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:04:05 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:35186 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfBKREE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 12:04:04 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id A212524E0E41;
        Mon, 11 Feb 2019 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549904644; bh=c+aPREqSYlBpuMXMGSfGb3vwYIohFHxf2DhrXvX9Ur8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dTTXkKOC463r1t52HI4KKjdKVfGCdxw1BEu9/0umCY9BWXjSsxJdZAbbjSHrwHuRs
         PmAwo3QijJxcFXPxwn27BLYCbJb9DkITEEoUio7aCXM7ivc0655WGDRESbDlCjYS6f
         uEXzOLw+NshlWYuvWHiyouuUxey1x+0gXNd3vFIqkKxZsijyJFXgutz0TZwrvoIdCV
         QRGEyPPV5fqNdnMO2ke5Cr5bg+0oaqe0H1db+rtswRd142hxUFXrj70UKXWsxYxUmR
         6SFLCC0XxBmo+Ui9q06W57o6HqP5t3puE/XoM6rH2qN10ydMQPOoTLasV65b596VUA
         oF2EbluQlOb8w==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6D0B0A0110;
        Mon, 11 Feb 2019 17:04:04 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id C43937D89;
        Mon, 11 Feb 2019 18:04:02 +0100 (CET)
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
Subject: [RFC v4 6/6] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Mon, 11 Feb 2019 18:03:57 +0100
Message-Id: <06542f172ebbf76401cddee65ebca0e6d8115257.1549904495.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549904495.git.gustavo.pimentel@synopsys.com>
References: <cover.1549904495.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1549904495.git.gustavo.pimentel@synopsys.com>
References: <cover.1549904495.git.gustavo.pimentel@synopsys.com>
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

___
Changes:
RFC v1->RFC v2:
 - No changes
RFC v2->RFC v3:
 - Rebase to v5.0-rc1
RFC v3->RFC v4:
 - No changes

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
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

