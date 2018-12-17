Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D03CC43444
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F9B2133F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bJ8GIzxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeLQRTv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:19:51 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:56436 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733151AbeLQRTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:19:47 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B703F10C1D7B;
        Mon, 17 Dec 2018 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545067187; bh=DsKkGtd82IScKAGELxidp2McGi0W89eerLRpz9xkktw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bJ8GIzxljw7aJxoEQTVZa+BHkc84YXl2Ppp+bHT7SXMvhSrCktxH8YSwifY8T9NZ1
         pGN3GOjah1384wVZTGhCMPCOIUuVGPYFacOof7eiUx9+ASJcOyUXwP0y6xoocE8HBX
         3WI9bqXQweJI198Iy6Ynds6rulNhW1RQpBlnx9eCRfgr7rGN2EKxQoMeXwmwJewbkE
         4bLS0d5OgIyqN860G3Nqjr+02AAQROtLbv76NbmHwGfaaEFemyJAgJ3jkQIh9pQALT
         9w8KcxssVC9nfheL71LpiuiSn3je7PEKIXCOIRmRKp/ePby7Jv7dmBf1CjYGyjICRJ
         BF8X/MCZDDDgg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6CC4E30CC;
        Mon, 17 Dec 2018 09:19:47 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 993527F44;
        Mon, 17 Dec 2018 18:19:45 +0100 (CET)
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
Subject: [RFC v2 6/6] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Mon, 17 Dec 2018 18:19:38 +0100
Message-Id: <55dd20085659e5e76be11f7212107e94b52c0ea0.1545066805.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys eDMA IP driver maintainer.

This driver aims to support Synopsys eDMA IP and is normally distributed
along with Synopsys PCIe EndPoint IP (depends of the use and licensing
agreement).

Changes:
RFC v1->RFC v2:
 - No changes

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
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..bdbfc14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4256,6 +4256,13 @@ L:	linux-mtd@lists.infradead.org
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

