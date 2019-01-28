Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70396C282CF
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3740221741
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695261;
	bh=hIsqLgJIVecRCPkiS/x7U8wfvg+g3uWTtxMvbTqZBms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UlrlND9852xBuEE4Bgb+3yNrf73jx/DUFlOBvCouq2ch1XsoT9zCAv8eY53XU9IX+
	 HxeaRsCMGuMjBIefCOUi8sEyuDp5xzq2YCWryZiwaWeCkcUNPAa24BUuy206SrFba0
	 dCKcYATeYyKR5e0T2Yi0yLAcIEL1nlEbkfJQonG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbfA1QMl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbfA1QMh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DFB2148E;
        Mon, 28 Jan 2019 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691956;
        bh=hIsqLgJIVecRCPkiS/x7U8wfvg+g3uWTtxMvbTqZBms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoXx3u00Zql0xT42TKvl+EaJPZh1Tlsu+lPvs9oh2oIr9b0TL1qJMO6dWITdxl+Dv
         O+zfWV6Xxvjod8OAAsWR1xVJmiIOk+UesznHKGj2aifVAvXqw2YZG8rjXnjyVVsmPQ
         penwg1A9Q2at/PrhVzRbkllRcDoL7vW46J1JB6r0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 015/170] x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)
Date:   Mon, 28 Jan 2019 11:09:25 -0500
Message-Id: <20190128161200.55107-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 53bb565fc5439f2c8c57a786feea5946804aa3e9 ]

In the expression "word1 << 16", word1 starts as u16, but is promoted to a
signed int, then sign-extended to resource_size_t, which is probably not
what was intended.  Cast to resource_size_t to avoid the sign extension.

This fixes an identical issue as fixed by commit 0b2d70764bb3 ("x86/PCI:
Fix Broadcom CNB20LE unintended sign extension") back in 2014.

Detected by CoverityScan, CID#138749, 138750 ("Unintended sign extension")

Fixes: 3f6ea84a3035 ("PCI: read memory ranges out of Broadcom CNB20LE host bridge")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/broadcom_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
index 526536c81ddc..ca1e8e6dccc8 100644
--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -50,8 +50,8 @@ static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
 	word1 = read_pci_config_16(bus, slot, func, 0xc0);
 	word2 = read_pci_config_16(bus, slot, func, 0xc2);
 	if (word1 != word2) {
-		res.start = (word1 << 16) | 0x0000;
-		res.end   = (word2 << 16) | 0xffff;
+		res.start = ((resource_size_t) word1 << 16) | 0x0000;
+		res.end   = ((resource_size_t) word2 << 16) | 0xffff;
 		res.flags = IORESOURCE_MEM;
 		update_res(info, res.start, res.end, res.flags, 0);
 	}
-- 
2.19.1

