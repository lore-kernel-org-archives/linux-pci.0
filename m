Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B3C43613
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F02E20859
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b3ggdUSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfAPKO1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:27 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:33022 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389370AbfAPKO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:27 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1ED4010C1642;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633667; bh=9csHtqj3Jet/E+LVXmpxrwDq1DEiwJ4cyQEWZ+QEMuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=b3ggdUSIzneb5Q26mS94mJIeVRsAZKvmAwO/uFrMIRkOnP2qp3lS4lmcMzditS6F0
         TPjovQaSPsCruohelTxI4x/Yn8FD0x9Yifgzwv45yaiVRxAY8bj7B28qIB03ZSFqDZ
         IfTG+F2qTkRMPE6rmoNsucal+3D4N/8AOhEL5Y8dPbq1nb7AkjGXtmCfBiseDeNPIN
         pLGAd7LU6EIO2/pCyTimugeqNlwY1Sq/ONMY0ZhCgA6r30aU0yB5b6+3Qz4x3X2OHp
         sctFSd6YqWSxV/5lZkXVRQzoSiN2Ty3uotBJUdcT1YAaYudm0MS7I8OIXWrzvSyDs4
         0A779hGBBakvg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id D9867581C;
        Wed, 16 Jan 2019 02:14:26 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 17A683F67D;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 1/9] PCI: dwc: Remove unnecessary header include (of_gpio.h)
Date:   Wed, 16 Jan 2019 11:14:14 +0100
Message-Id: <df4d0e7d76fe23a66c3664bb2b003b2aa7a6d9a1.1547631485.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary header include (of_gpio.h) since it doesn't provide
any needed symbols.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 99ad471..e889512 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
-- 
2.7.4

