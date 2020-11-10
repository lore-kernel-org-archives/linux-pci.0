Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1848C4742C
	for <linux-pci@archiver.kernel.org>; Tue, 10 Nov 2020 22:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914AF207D3
	for <linux-pci@archiver.kernel.org>; Tue, 10 Nov 2020 22:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgKJWK6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:10:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKJWKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 17:10:55 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kcbqi-0005Ct-U2; Tue, 10 Nov 2020 22:10:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] PCI: Fix a potential uninitentional integer overflow issue
Date:   Tue, 10 Nov 2020 22:10:48 +0000
Message-Id: <20201110221048.3411288-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shift of 1 by align_order is evaluated using 32 bit arithmetic
and the result is assigned to a resource_size_t type variable that
is a 64 bit unsigned integer on 64 bit platforms. Fix an overflow
before widening issue by making the 1 a ULL.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Use ULL instead of BIT_ULL(), fix spelling mistake and capitalize first
    word of patch subject.

---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3ef63a101fa1..248044a7ef8c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6214,7 +6214,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 			if (align_order == -1)
 				align = PAGE_SIZE;
 			else
-				align = 1 << align_order;
+				align = 1ULL << align_order;
 			break;
 		} else if (ret < 0) {
 			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
-- 
2.28.0

