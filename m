Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1811C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116321773
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA7e/dfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfBRT5i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:57:38 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51750 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfBRT5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Feb 2019 14:57:38 -0500
Received: by mail-it1-f195.google.com with SMTP id y184so823820itc.1;
        Mon, 18 Feb 2019 11:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3ZPBl+NkmY1fFLUUIG+BLi/V1PJ5iahTFGc7kmz5Vho=;
        b=nA7e/dfKrMRn+KKUfxhZmpp6UjWq21+HZ2ZXFHM2ODbB8qT9IweiAh5zVdfOOtqYDN
         ybC7ZQLGNkcd6ithK1a1aOmr8+955A6x0Ge7HwBqS1brY2zZPdSBk/5h+mGT/PF9Kz7Y
         AVs396qQogGE2pEYsAXq5bjaUT7GWNRFa3oMObI0z9kGJ9S2qT9W76AJNR5w6UsS6zgG
         7W7NE7/ckuq5R17YhY9YmQEa8IWTUiEC+XNiGVQIBodpcSNpXlafjlhhNSxhkk484wQc
         nVNE8UDM88Qkw6SECk5siNsmIwl2WE0eBWNx4m4bR2vsnMSZ+RqDosczwsk3toUKpcZ1
         Bz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ZPBl+NkmY1fFLUUIG+BLi/V1PJ5iahTFGc7kmz5Vho=;
        b=fCJGc8b0hsW3Eg+chggYiUmkretEG5VJgv9I1dvqRjf13Cy6bpND1iWBQUpQfHX3iH
         BNDMIvkxCOpGaWP6Kba1Yz7XhCQfYqGJOkBX5uHRPi7D8tGftMI35UsDI1wnIeeTx3yo
         ZS4jDz/WndgV+qgLXcz/8kANXltUWcLhktcLdl7Jp+yXJVW1Q1UsgTqu3+TP7FsiMSNy
         +O5dUjk2J+ppGzlyvtZ6limkreuOuGyIPF5HAr1v3MFImfIUKgKb6zx2XLP1LTAqnk5Y
         oJ1Ml2Z5O9Rs7R7O19vSLBK0VdVA4lr6KwjsBjWSaqlDfNUbKTApHUv1uek0T/mRa8ZQ
         TEXQ==
X-Gm-Message-State: AHQUAuZVCgP63r0gzbAzFM/5uXA+B8zCPaVjSLsrh9sWBpJLAX6CpUof
        pWxYFEFLCeBtG9W1hF7sDeE=
X-Google-Smtp-Source: AHgI3IYZkFVF8aDOkbWNuSSqBPM63lXCdeI1nZ9zoS9mK6JQbApIiG0crAtBgx00Pt83F12kxUt01g==
X-Received: by 2002:a5d:859a:: with SMTP id f26mr14871701ioj.150.1550519857629;
        Mon, 18 Feb 2019 11:57:37 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id e141sm154400itc.40.2019.02.18.11.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 11:57:37 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@kernel.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCIE/PME: fix possible use-after-free on remove
Date:   Mon, 18 Feb 2019 14:57:30 -0500
Message-Id: <20190218195730.4975-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In remove(), ensure that the pme work cannot run after kfree()
is called. Otherwise, this could result in a use-after-free.

This issue was detected with the help of Coccinelle.

Cc: Sinan Kaya <okaya@kernel.org>
Cc: Frederick Lawler <fred@fredlawl.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/pci/pcie/pme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 0dbcf429089f..87823f669ccc 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -427,9 +427,12 @@ static int pcie_pme_resume(struct pcie_device *srv)
  */
 static void pcie_pme_remove(struct pcie_device *srv)
 {
+	struct pcie_pme_service_data *data = get_service_data(srv);
+
 	pcie_pme_suspend(srv);
 	free_irq(srv->irq, srv);
-	kfree(get_service_data(srv));
+	cancel_work_sync(&data->work);
+	kfree(data);
 }
 
 static int pcie_pme_runtime_suspend(struct pcie_device *srv)
-- 
2.17.1

