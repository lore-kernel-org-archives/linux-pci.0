Return-Path: <SRS0=Nj4F=YA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76158C47404
	for <linux-pci@archiver.kernel.org>; Mon,  7 Oct 2019 08:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4600F20867
	for <linux-pci@archiver.kernel.org>; Mon,  7 Oct 2019 08:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX6GKbtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfJGImK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:42:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45831 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfJGImK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 04:42:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so12655750ljb.12
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2019 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=EAzRJHaK8MFYWZ+2OczEzydZNLqk1pQAhI/xImdxyuM=;
        b=RX6GKbtw161xTFvTIVZr1/4nBfXg/66y2e347sn9I5Z1z6ApLV1o4L8Kk9xpqNNW0A
         3WM57Fnzw6RT3lV62YNMertB4naEOnGx9Rsy/BvRlRF6aVfpQpeGRqjiZH9LDOSOCtnS
         pB4UG6H4qF0f1LPMxRLG+XJhLQLDZ18ZHrO2I2hpqsKV3CqaghOIyGtLE3MMq11ZMdSZ
         GD8bkSxzwfd/8OXWJUDZeUlR+EJoarpWv9zNdN3JTvC6hWjC8HCW0TNAzLKn5rtPTOWH
         WgeX4Mk9fRAbTLWRX9BcxvH4Poe60N2eDkchiM57A5MNbeN4ZWozQnsTqr6Rui5XoPAN
         5CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=EAzRJHaK8MFYWZ+2OczEzydZNLqk1pQAhI/xImdxyuM=;
        b=BUeqUH2x+1MYZSzg9yGIRhCzPtIJhsBmGlndZmaBdmJuu1rPfJXI6qUQetSMMPs8L+
         TTKRTg5vIbsrbCG4n/LXYYfhOOGLyVvbAUeDZDvID96gkdo05qVSdWhtdlUHWa38fzer
         EwyD5MQ6NjJwxpmkD5YIBsvx628ETDC+qTHp2DDrMI3kArDZ9WRZABmuiGBDZzJdPxpN
         W1JVGIAewwT80kA+SGUPis71yGtm8mBBsPqLTwlYr8YN5pHB/1rcz+Kqg/QRtb3hm9+9
         bYQY4eMbJuTaIz7XRPl36tSd3zkpDSbZHRdQm24uRPow6TKnNvgbWy9CHVA1xBwlDoNy
         hRZw==
X-Gm-Message-State: APjAAAXTLM1b+j8U7TA2rT2FOwk1AuQAnoxQJk9ac8ko2mRBbJeuLsr/
        BqQ/GVYenoivyPGlAhDta9AgAP73B0wm0Q==
X-Google-Smtp-Source: APXvYqwtd1qnxXJjvZ1VaeKGElBM5/8hrfEaJYU9UN66MfehR3JxE6+Y/cjye/Y8lBF6R9XXA181/Q==
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr17114895ljk.166.1570437727975;
        Mon, 07 Oct 2019 01:42:07 -0700 (PDT)
Received: from monakov-y.office.kontur-niirs.ru ([81.222.243.34])
        by smtp.gmail.com with ESMTPSA id m15sm3259151ljg.97.2019.10.07.01.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 01:42:07 -0700 (PDT)
Date:   Mon, 7 Oct 2019 11:41:59 +0300
From:   Yurii Monakov <monakov.y@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     m-karicheri2@ti.com, andrew.murray@arm.com
Subject: [PATCH] PCI: keystone: Link training retries initiation
Message-ID: <20191007114159.61ad83ea@monakov-y.office.kontur-niirs.ru>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ks_pcie_stop_link function never cleared LTSSM_EN_VAL bit so
link training was never triggered more than once after startup.
In configurations where link can be unstable during early boot,
for example, under low temperature, it will never be established.

Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f19de60ac991..ea8e7ebd8c4f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -510,7 +510,7 @@ static void ks_pcie_stop_link(struct dw_pcie *pci)
 	/* Disable Link training */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 }
 
 static int ks_pcie_start_link(struct dw_pcie *pci)
-- 
2.17.1

