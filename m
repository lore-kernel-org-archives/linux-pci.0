Return-Path: <SRS0=an1L=53=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0857CC2BBFD
	for <linux-pci@archiver.kernel.org>; Sat, 11 Apr 2020 23:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDD8206E9
	for <linux-pci@archiver.kernel.org>; Sat, 11 Apr 2020 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648560;
	bh=OpFbVyvYnIHYbXaql1M7ib78tJ4gNMyNDUmLjzivcGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h6PJQY6jwnQ73wDAbIH87o2JkoaRlCnz03Ds4cPltJcDlpAXbIrdN0KR6h0VThOrS
	 7Zw5mTVomtAMXUxcXcvukXicJvCNQNXrcsU5uH6Z1jEepEu2p2Tt2YWqnRmXm053vz
	 3zissagxDTh7UR/9v9Ak/HwAdBnFh6x/TqPIo7AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgDKXGi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgDKXGh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Apr 2020 19:06:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03AF2214D8;
        Sat, 11 Apr 2020 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646397;
        bh=OpFbVyvYnIHYbXaql1M7ib78tJ4gNMyNDUmLjzivcGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWVlA58lktUHHnOy583PmAaQnEb/Ed7OHvfRQCSpdu76E0f2Kb4FodWiLUoG6UJRx
         oOPydRZmUa6gpjDA7eAPGqo1OJzeRkuFULmhoRLLk5rP2s/oNjPeZ1c8YlIYm2154V
         K7w0BKpQKIbp/R8FF+PRXOepvLg7qNnVj+IN83Uc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 135/149] PCI: hv: Add missing kfree(hbus) in hv_pci_probe()'s error handling path
Date:   Sat, 11 Apr 2020 19:03:32 -0400
Message-Id: <20200411230347.22371-135-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 42c3d41832ef4fcf60aaa6f748de01ad99572adf ]

Now that we use kzalloc() to allocate the hbus buffer, we must call
kfree() in the error path as well to prevent memory leakage.

Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9977abff92fc5..6b3cee4324047 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3058,7 +3058,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 free_dom:
 	hv_put_dom_num(hbus->sysdata.domain);
 free_bus:
-	free_page((unsigned long)hbus);
+	kfree(hbus);
 	return ret;
 }
 
-- 
2.20.1

