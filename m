Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC176C282D9
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A18C21901
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AqwNNnh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfAaSRT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:19 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:54712 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9E39F24E1EDF;
        Thu, 31 Jan 2019 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958634; bh=MjOpuKV7r/NUMmif7iCwjLZniYecYCZJc8KuLdM1MUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AqwNNnh0N25CW8PStFQw/buVx5UTKRydvKnU6n5hmXnuQgTadjzNCv41ijnNYEEhd
         O3c77lyAbBdyJ1VQbLX51JaY3MeWkIkRnWHpLPAmcvd7VBoL6pOH4DIiLuuk0UqKyb
         mQi4r+pqEm5MkU9y89kjWqIBpqyQe3sbbjB6tq7cLhW11xEZnxF2b4UgfWGiSrT8HY
         BBsqFUXm1UMuM2OvaOzuS1y4IpMcgTkMOyvQ4S/HCgC2E7AHVsDQ0tlCNJ8jaQQGhd
         4SLiu1v1qhlb3u6peNLx7QsRYhi4pxfI44jZ58OWA9e6vp8Vx9bVjnX0i/47U/bheE
         vAKZ9AFc2JchA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6A080A009B;
        Thu, 31 Jan 2019 18:17:14 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 9B2203CED6;
        Thu, 31 Jan 2019 19:17:13 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 2/8] PCI: dwc: Remove unnecessary header include (signal.h)
Date:   Thu, 31 Jan 2019 19:17:01 +0100
Message-Id: <0af58bf745bec80e1f23decfb0a91b56c02c816d.1548958059.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
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

