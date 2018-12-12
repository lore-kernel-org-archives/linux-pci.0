Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF38C04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A902084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Q8LWEehE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A902084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeLLLN6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:13:58 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37680 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 06:13:58 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9B87624E2250;
        Wed, 12 Dec 2018 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544613237; bh=oCQMFrisgrUbXZMmA0K4nQiKCO/Gi7QRh8Ud8vnY8nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Q8LWEehE6G8Sls7qcNriODLSOh6EdRA3QJ2gCyp1xk0E7L2cCFNItOVxeSmeEaJkN
         7Usaay1TIyMOaeQlC5PMC3ln+dJpLN9YmPMnjHMOFsbRtx5YK3uN4k3+aLLVNZBuhf
         LQyyX39JW14BVqXykzfZVBCTUqzCPYFCdkuCwsVAr+BYMcY9y9QzNHAr2xb3eWjYWs
         KcW2nTY7alw8jqwUIWKAxJUL4Ogrm1s7sz/ZmADVctfNHQnusTsXe5U6X98cG3q8HZ
         dHmbgyLFwl1bymlSNvV+yqc9WekMOGZcL27H8WVaSzL+uFI0rfSKk6/D98eUyaII5U
         bTHukXliH8hAA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5C4CD3D78;
        Wed, 12 Dec 2018 03:13:57 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 982D33BDE1;
        Wed, 12 Dec 2018 12:13:56 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [RFC 5/6] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Wed, 12 Dec 2018 12:13:25 +0100
Message-Id: <45584389de19948652a32b2cdf2780d3a0003c01.1544610287.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
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

