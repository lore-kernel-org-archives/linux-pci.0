Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C293AC433EF
	for <linux-pci@archiver.kernel.org>; Fri, 10 Sep 2021 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CD46124C
	for <linux-pci@archiver.kernel.org>; Fri, 10 Sep 2021 16:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhIJQP5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 10 Sep 2021 12:15:57 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47068
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhIJQPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 12:15:31 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 967A43F236;
        Fri, 10 Sep 2021 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631290458;
        bh=+Q2vTAAq7QHzyF1atFoswScUho+hy4URUfVAKgzhNG0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=KQR9Q4qFS2yP4to8uPWyNIpCloyS5WrQq81a/D1CEl+vzqL77bGSIF4Xecl520BHu
         Exo30Opr387nVOkgBggz7MChTc8DOpdyGtSJ8qzpOSshY56H7/2+bS+O/3Xl6kiqWZ
         QBFPRWMQahGsAXLbjazl/SpREv71zDmVgD3e25q3SHRgCY6u8MxdpQAmI4UN49H/Df
         utE8p5Gx8PwYkLdoHCFf+KRN/e6EU0oGrwVSdu1xPsJStTCgl/2nN5RvH/oNntAaRa
         9TZHqV2yQGVW0BtvUhfcKseAdnvc4iYWBzFWoN/RY37f2+XwTx2qddgDvf1VVCjYWC
         8WeslW+HN1QAA==
From:   Colin King <colin.king@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Remove redundant initialization of variable rc
Date:   Fri, 10 Sep 2021 17:14:17 +0100
Message-Id: <20210910161417.91001-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is never read, it
is being updated later on. The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..cd8cb94cc450 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5288,7 +5288,7 @@ const struct attribute_group pci_dev_reset_method_attr_group = {
  */
 int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	int i, m, rc = -ENOTTY;
+	int i, m, rc;
 
 	might_sleep();
 
-- 
2.32.0

