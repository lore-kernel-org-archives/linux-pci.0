Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ADCC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27451218C3
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cHatkC/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfDWSa1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:30:27 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:60434 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfDWSa0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 14:30:26 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1514BC0B0E;
        Tue, 23 Apr 2019 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556044225; bh=cotk7CwgB83p6FWxrnMRwiJSWlyG+lQYXtvsuqZsM2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=cHatkC/vc3j0ZVBfR+G0sBWNn7BXnSIFLh7vFhI4X+98H7nQLiWyPk0Fed0e9zEQy
         vB2wAgujsUriwidvRsjxbycV5Nw6XcpOEROizBZuChSc50LNcCS5V/h9fz4WIEzQHa
         El1lZgCneZ7Mqys6y9/Tgg+OM0AvIlsZRJ03G5H2dSYYUB/qesUbdCrUFbyCWMIGa2
         aiTb3OkNihgpNFbsv39jQRtRk3XP7kJ1ODdOVL0SqrhB1vt88G3GKL7YBj69TjeJJv
         kZckP5eBchY6AOxrJ5NtlyOTqRYcs2vVtp3CN1q1HUfK0D//3oBNL+uv4uwLI2o4h8
         3i8arV4HbA0+w==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id CBAE9A00A1;
        Tue, 23 Apr 2019 18:30:25 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 195B83F834;
        Tue, 23 Apr 2019 20:30:24 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [RFC v6 6/6] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Tue, 23 Apr 2019 20:30:13 +0200
Message-Id: <aafdd8ccf01206a81af00087fca8e6e072ac1319.1556043127.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
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
RFC v5->RFC v6:
 - Following patch version

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..32222b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4513,6 +4513,13 @@ L:	linux-mtd@lists.infradead.org
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

