Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A4C43444
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C8D2087E
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YHpTpp5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbfAPKO1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:27 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:33026 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389372AbfAPKO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:27 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2B17A10C165C;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633667; bh=MjOpuKV7r/NUMmif7iCwjLZniYecYCZJc8KuLdM1MUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YHpTpp5Sc5yGPQhgwMlGldQ0h5CqV60dHxNWrcSa7V+R05yYXPHmBT7pNmY0DCP6A
         Y4w5AqCKwHKLVcNR6BTwkK8Alm5431eyPN1dz5q2Mt/3zpQhy1svu8W6PdiI+DMuh/
         JBOySllDmjGhI89HqsshJ/4JOtHsqjPdrwxO7YSVsj9eN7XUKEd83Ehqivz6a2g07E
         hP/brNDOmujUag5LlPozjNHqSond6/pmHwcGm6xcr3kBYNJ2M3NXS4rDF683H53qTe
         UrdOd6CWToLcEUKXROOg4i5IyZ+XAIlImnj0N4//aVfRZMbPSW3+hXrWA/jwZeZq6s
         BjYFSFbJctcfQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id E97A64E4A;
        Wed, 16 Jan 2019 02:14:26 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 287203F683;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 2/9] PCI: dwc: Remove unnecessary header include (signal.h)
Date:   Wed, 16 Jan 2019 11:14:15 +0100
Message-Id: <fd539d572fffc048af7d59d824fee0da35d996fd.1547631485.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary header include (signal.h) since it doesn't provide
any needed symbols.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index e889512..4272c4c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -16,7 +16,6 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
-#include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/regmap.h>
 
-- 
2.7.4

