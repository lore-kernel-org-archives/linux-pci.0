Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC2C43612
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816C020872
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NzHaDkqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfAKSdx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:33:53 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:50456 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733164AbfAKSdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 13:33:53 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2223E10C0CD6;
        Fri, 11 Jan 2019 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547231633; bh=9SJAnAhBGkGoKueghcaOkLd8P/CP4NxM1yOmbuxpS0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NzHaDkqzDJX4ElLebJe7UUC3KI+wxVjqqYuB2FJy6TWD/7vQsIlMVkE27VrXN0+ox
         HEiFq7JzCW94s9AofhGlPVIzGhD9iGsT+jjOmDyMo7uqLJ2lactV601nQOes3cNPdo
         Il5pAQFoui7/2wgq8dUNUiOTe3YoHaRwjGmalQrCRo6DGOmxNd2cyCJC1Z2keqjM4+
         ar1PnCPHBzdBSKb/rpCmkvXRLPP7FcggcN3HVj5V7m+dxq1ENpemC+8lzSuCdVXinS
         MsEGmLo2E0tNQvX9J3ddRVcAVGTqKVQ30Js09cg6gjW8mOg26rGseal72LVczHOSLK
         YxOx+gdj6OE+A==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id E4AD857AC;
        Fri, 11 Jan 2019 10:33:52 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 245EA3EDB7;
        Fri, 11 Jan 2019 19:33:51 +0100 (CET)
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
Subject: [RFC v3 6/7] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Fri, 11 Jan 2019 19:33:42 +0100
Message-Id: <d3d5f89e6e7c3c984a944fde512f5ab23ebd934d.1547230339.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
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
RFC v2->RFC v3:
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
index 32d44447..e30c1ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4401,6 +4401,13 @@ L:	linux-mtd@lists.infradead.org
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

