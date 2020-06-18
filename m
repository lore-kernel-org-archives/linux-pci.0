Return-Path: <SRS0=agHd=77=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E1C433E1
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 02:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CF8208D5
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 02:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446782;
	bh=wScORoqPjb/mww96WHzaFvxef/YuoV7yz9L9Y915LtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdmteHar7NEMDDTl3M72FAlIokHqZXFP1WadUfAY4IkIwGOF193anI043h6OlPfMJ
	 qBwKKW7g4mHRPutZ7gBwMhTcPYsZp81H7GDcZ0BZTD1l6jN2IAtdikVqArXO1E8YNW
	 7kChom+jCGtkkq2BywMZg53tGKqiOZnVrjw4RxpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgFRBTP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgFRBTM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15CE21D80;
        Thu, 18 Jun 2020 01:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443152;
        bh=wScORoqPjb/mww96WHzaFvxef/YuoV7yz9L9Y915LtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3IeFl7iRHIRba0a/E5kibqfda3Wg/assir0YRINGb4ctq71wyPIyuypKQCgp+4S6
         nHAcXz0Ts/PLDZzNILxCOehxPqesmCYPWtR8TJsixR40EnUJck/JxdZR7mpZauiiHQ
         0JZIbzzxurLJRoxvujk0OPTui2Ek5pd2i7fi0YFo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 120/266] PCI: v3-semi: Fix a memory leak in v3_pci_probe() error handling paths
Date:   Wed, 17 Jun 2020 21:14:05 -0400
Message-Id: <20200618011631.604574-120-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bca718988b9008d0d5f504e2d318178fc84958c1 ]

If we fails somewhere in 'v3_pci_probe()', we need to free 'host'.

Use the managed version of 'pci_alloc_host_bridge()' to do that easily.
The use of managed resources is already widely used in this driver.

Link: https://lore.kernel.org/r/20200418081637.1585-1-christophe.jaillet@wanadoo.fr
Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-v3-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index d219404bad92..9a86bb7448ac 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -743,7 +743,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	int ret;
 	LIST_HEAD(res);
 
-	host = pci_alloc_host_bridge(sizeof(*v3));
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*v3));
 	if (!host)
 		return -ENOMEM;
 
-- 
2.25.1

