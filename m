Return-Path: <SRS0=OhUz=XL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A563C49ED7
	for <linux-pci@archiver.kernel.org>; Mon, 16 Sep 2019 20:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4E120644
	for <linux-pci@archiver.kernel.org>; Mon, 16 Sep 2019 20:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfIPUrW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:47:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfIPUrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so706097wme.3;
        Mon, 16 Sep 2019 13:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujovi4XPDNySnmAMKOgDa4VaedmyqoxIIAtYaqvsCwo=;
        b=QfDhwKjIJ0ubzz44BRt0mpxEHpE18jjp1L1Iduzq47jtT7F1GeWvFGKK3uVdmu6tqI
         kyVwMoo77npQvUN4+kqsW68CX3UgHn52lXubKMoAFy2NWdreV5ZrDwl6UlLRME8j+8zH
         IjLJgXhiq4fgFfGvHnQRdjJeT3dxhqpuN8YWqLZNOHerdEaASkuL6k2YFRwYWVztdZGK
         TwuVHQ3khtR4adqYsVN5gaVuCf1yt0ovuOq6otyzpfQZ4z8d5di10UQSz4AXJ3uB17zO
         AfFVBJ0wBieeMQ0mPV1jlT/NnBfO4B3TlCoiNCiQtPM7wNZmBx3oF46nztgQxd7AkKEo
         drOg==
X-Gm-Message-State: APjAAAXe5Z68LHg/XtxgJJxsQ2vChYJurLivdBILMQaO/3K9g3riOYCN
        3dnNuJ5VL0dsLlN1ya3IL70TgUDUYSE=
X-Google-Smtp-Source: APXvYqwJN5xzlDI6G/MI49jkTwJJQQnvs9yDf29e2hrZ3u/WBbjKYtYB4auYSROBjzRE2CuBPOpyEA==
X-Received: by 2002:a1c:9cd0:: with SMTP id f199mr652570wme.111.1568666839843;
        Mon, 16 Sep 2019 13:47:19 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:19 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v3 16/26] fbmem: use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:48 +0300
Message-Id: <20190916204158.6889-17-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
PCI BARs.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 64dd732021d8..485e798cd404 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1784,7 +1784,7 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 	int err, idx, bar;
 	bool res_id_found = false;
 
-	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+	for (idx = 0, bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
 		idx++;
@@ -1794,7 +1794,7 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 	if (!ap)
 		return -ENOMEM;
 
-	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+	for (idx = 0, bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
 		ap->ranges[idx].base = pci_resource_start(pdev, bar);
-- 
2.21.0

