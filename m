Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E0C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A2021104
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 18:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A2021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeK3FaR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:30:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbeK3FaQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 00:30:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BABA280D;
        Thu, 29 Nov 2018 10:24:00 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDFE33F575;
        Thu, 29 Nov 2018 10:23:59 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] MAINTAINERS: Remove Jianguo Sun from Hisilicon STB DWC entry
Date:   Thu, 29 Nov 2018 18:23:54 +0000
Message-Id: <20181129182354.3273-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jianguo Sun's email address reported in MAINTAINERS is not active any
longer, remove it from the DWC Hisilicon STB entry.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..5d7beffe9935 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11541,7 +11541,6 @@ F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
 F:	drivers/pci/controller/dwc/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
-M:	Jianguo Sun <sunjianguo1@huawei.com>
 M:	Shawn Guo <shawn.guo@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-- 
2.19.2

