Return-Path: <SRS0=+Ydv=VQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF44C76195
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71642082E
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510967;
	bh=leuje/BwHEBKQQl3X8zI1LBJIPhRyKhC/r2bwUoyqkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XrAMXKZEYcnkGjFJOcCH9+IdrEVOpbZQePJF7tMdN0A+qiPe/HRtdaONMEKgcg2IF
	 8/hhCvJdh3BYQgnJhRnddTcgrXDFBM0c7K2lg5uA5fzMK2KpyOPKhsnYf5RbPMAlpW
	 HO+75qY4R7FT1ASTCaSAcI2dNMJI+J8yHqf3hl4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfGSEgC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbfGSEAm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C769321852;
        Fri, 19 Jul 2019 04:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508841;
        bh=leuje/BwHEBKQQl3X8zI1LBJIPhRyKhC/r2bwUoyqkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnLUUVxO7XYwdNyNnLXcxwvNG3Sk5Zedp6baZlEMu6hGZazI13wk4ravvxu7np7rf
         MAxORVvBUCgTFPFI5W6AVfj6i5/8GfkNd4yjeoEpTmdXoAqR2bzLqZ9WNcpKW8fmE0
         vLNbohx6bGerprtxuluES7wcNb2DKefELB6INetA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 120/171] PCI: mobiveil: Initialize Primary/Secondary/Subordinate bus numbers
Date:   Thu, 18 Jul 2019 23:55:51 -0400
Message-Id: <20190719035643.14300-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

[ Upstream commit 6f3ab451aa5c2cbff33197d82fe8489cbd55ad91 ]

The reset value of Primary, Secondary and Subordinate bus numbers is
zero which is a broken setup.

Program a sensible default value for Primary/Secondary/Subordinate
bus numbers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 88e9b70081fc..e4a1964e1b43 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -501,6 +501,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 		return err;
 	}
 
+	/* setup bus numbers */
+	value = csr_readl(pcie, PCI_PRIMARY_BUS);
+	value &= 0xff000000;
+	value |= 0x00ff0100;
+	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
-- 
2.20.1

