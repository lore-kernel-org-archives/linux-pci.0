Return-Path: <SRS0=OhUz=XL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08FDC49ED7
	for <linux-pci@archiver.kernel.org>; Mon, 16 Sep 2019 20:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F850214AF
	for <linux-pci@archiver.kernel.org>; Mon, 16 Sep 2019 20:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfIPUrp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:47:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38106 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391655AbfIPUrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so706934wme.3;
        Mon, 16 Sep 2019 13:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cjyw4iwufFr2TJPexscuSdiVbwU5mYSUwRk7WraBNI=;
        b=Tr8MstYMiKd76A0jbU81wmUaK3mG8bOCOCjqAnKQjMSzM3+p2IOo5VlN3LLNoZYRz7
         F7ed+xbcJCdl9c/jcME5w2fghr7deqNSw2HjuoHdzPszgI3r7EC+4o7UkOMFKfIfJhvo
         R3gwvYk5yp75qXdfUffW3miAEUXLB5q2QpHL0c+NsOWXho2EwtZ4vczH5+1desM3SclK
         13o+sPa2AwU87ktvHDAvBQe2vQKDNM4m3OOsKHYCDc31PpV3fFJj/Jq+VLJU0zfPwItN
         cUuUuSZGmo37JjYW3ekQmRzJCgKsBXcJlQ1A3orreoXs1V/h/uxCl0ke2Pl2Oe+hy8el
         ayhA==
X-Gm-Message-State: APjAAAXnBT2PeyZnnbmXKyWJFHvGxqpYbBJp8QX/0C8oxERBwGXSlrRc
        RS6kh0bqaR7wgQItHA1Tazjv+AMxhEs=
X-Google-Smtp-Source: APXvYqzMPwcH5G6tl3Joo+Hv1PKsJgaFKV0jqz+iiMxqYzKNshopG5ryQA7iKmg12oFq25aYnYYLhA==
X-Received: by 2002:a1c:9615:: with SMTP id y21mr704785wmd.5.1568666863156;
        Mon, 16 Sep 2019 13:47:43 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:42 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-mmc@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 23/26] memstick: use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:55 +0300
Message-Id: <20190916204158.6889-24-efremov@linux.com>
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

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 32747425297d..fd281c1d39b1 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -848,7 +848,7 @@ static int jmb38x_ms_count_slots(struct pci_dev *pdev)
 {
 	int cnt, rc = 0;
 
-	for (cnt = 0; cnt < PCI_ROM_RESOURCE; ++cnt) {
+	for (cnt = 0; cnt < PCI_STD_NUM_BARS; ++cnt) {
 		if (!(IORESOURCE_MEM & pci_resource_flags(pdev, cnt)))
 			break;
 
-- 
2.21.0

