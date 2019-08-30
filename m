Return-Path: <SRS0=+/41=W2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6338DC3A59B
	for <linux-pci@archiver.kernel.org>; Fri, 30 Aug 2019 23:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3147B23431
	for <linux-pci@archiver.kernel.org>; Fri, 30 Aug 2019 23:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mJNxoFoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfH3XSf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:18:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38846 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfH3XSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2019 19:18:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so5552018pfg.5
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2019 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRkLiK2zQKW37sHjUWJi7ClUsfSJsVnDy5LzPyDzYvE=;
        b=mJNxoFoPw68Pczu3Q5Tl9Hubb1oPwPMN4HNOUR5BMqcq1lrDlYBVP6S84iC0HCLgRk
         bxc9EPapppZF4nytHiwbl/a1svpheNULWsFifiCEEtJxbx/2Nd5ec0nyECglpbsmGi7n
         tU+hvwsEYwTZP9DetuJiTg4UUwmi2g/IyPVjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRkLiK2zQKW37sHjUWJi7ClUsfSJsVnDy5LzPyDzYvE=;
        b=brIVydT5A2MZDpYKKNft05uGtgmQlp8XRcLbMb6l6/ZRH1d8usPStipSsf4l+Mt9t6
         rPa2GFiKJWk9/LfRDhnNndp2kkcAk9k58YFy6e/9J7Y/AygpKPliaVLRzObbaGRNVC6x
         bRv1G3bA886g0xn7js3j7hJu1UvfOzOwE4P5NG+N6v3lqx2UtY8+KD4juYP6/TV416H4
         t6FhnDh58O9c3AvdLHk8SH8iXDi/YUshkgTnHKb2Yc1SbrUKPKIjDHOXr9/4t2+aue8F
         qST9a1r52DyaYIejYYshulh080XJKjhDorxog0CPAOH3lrQ8QLw8HNrldxq3Q2QPb7LT
         a7Ow==
X-Gm-Message-State: APjAAAX3SrFMzuLyxUArKangHk+b09MUHbjd/kXqrcNVC8ohSDrx7N8t
        E3avGSj4QC2NYsOk5ZnB45lhoyc9zUA=
X-Google-Smtp-Source: APXvYqwWcIpjQmKfZ2KNw+QhAexpYhPxvb+SAlTByxWo8nuTzYepBvzn5LLXes3DPdl/v5VIIOmnfg==
X-Received: by 2002:a17:90a:bc06:: with SMTP id w6mr1009296pjr.45.1567207114673;
        Fri, 30 Aug 2019 16:18:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t23sm8479395pfl.154.2019.08.30.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:18:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/2] pci: Convert to use built-in RCU list checking
Date:   Fri, 30 Aug 2019 19:18:16 -0400
Message-Id: <20190830231817.76862-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CONFIG_PROVE_RCU_LIST requires list_for_each_entry_rcu() to pass a
lockdep expression if using srcu or locking for protection. It can only
check regular RCU protection, all other protection needs to be passed as
lockdep expression.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/pci/controller/vmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 4575e0c6dc4b..127631d0c6da 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -718,7 +718,8 @@ static irqreturn_t vmd_irq(int irq, void *data)
 	int idx;
 
 	idx = srcu_read_lock(&irqs->srcu);
-	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
+	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node,
+				srcu_read_lock_held(&irqs->srcu))
 		generic_handle_irq(vmdirq->virq);
 	srcu_read_unlock(&irqs->srcu, idx);
 
-- 
2.23.0.187.g17f5b7556c-goog

