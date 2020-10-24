Return-Path: <SRS0=Kuk7=D7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39323C55178
	for <linux-pci@archiver.kernel.org>; Sat, 24 Oct 2020 20:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3B721D41
	for <linux-pci@archiver.kernel.org>; Sat, 24 Oct 2020 20:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp7r/Hx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764538AbgJXU4A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 24 Oct 2020 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764536AbgJXU4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Oct 2020 16:56:00 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9076C0613CE
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2020 13:55:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 77so6709180lfl.2
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2020 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQSwDx/8ku9V+K5hldQkcp4a98iVQPx94jQsc+N/fFY=;
        b=hp7r/Hx2x7+Z9Y50FJ7M5wmV+nlF2f49Ma6L6SWmZY5/Dl5G9wR0HxsNc5X+1KEQSS
         PuENmVrJtxnlOjDs9xnEJl4OgjFnvKsi6ttjWrYTdhPAO7qJrO5NK9Upaee6ypP7r/2l
         YOU4r01avoU4AWuuLQlXvekHj/gXTCI00mCZ3xrd8QGcvjE+NQGT5s6mRf/VhRiFJUWJ
         NiDnj+4IHY4SQCsS9G3vpT+QFBCBx/OslFHBArd0BD4S51CyYhowwEcj83aUFoPEbeYx
         NoJByQ45L04BKehzOTawHBOKPrL7/4yF9Otw0TBkPwWop8ecTdCkh4/tcN3atzmOeuAu
         R9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQSwDx/8ku9V+K5hldQkcp4a98iVQPx94jQsc+N/fFY=;
        b=r1NfBQnGsMW5x0ScQww2DM+UGkRl5d4Q0mbQ8CrZ5uBCpZNUSPAPwPAuQah9cUD5l+
         /Vc4Li3YjUDTby/trgJeDxTHm5GOgy1Hd4Ue+nTyv8CQ+LMkAbxnvx/QqjNGab2n7Vup
         nhEw1rL0A+8/ZX43+1xVq3HOLVEX2Sl4lO3qYX6Jr6RLXyW8byCUo/cXONw6P7OwfXsu
         M85s6wKwEnqPeSeiC2VQqjU1B3lB3Dq+X12yJY3MnaWrb6fQ1IIJkJ7sCJ1zL5JFAvRk
         zh7jbqub6sIgkmL5fe5VJU4CTSggJxj14pbeH6skFlYE7eoimTZgEo5uauDjI6tVj656
         cruw==
X-Gm-Message-State: AOAM532gD4lRZRryWGgIs7IKJW3A3i9RmHhVEFKpYYCktkwkUMb7jjVT
        mlRhxNafQMVYo4Z0PCDaf6Co8Uul1NxtMA==
X-Google-Smtp-Source: ABdhPJyosCRFQCL7wCIuidxQAwzVFjn6I2pbllpwD336aznIoG307ytSgQWf4jtUW41/pmn4huanhA==
X-Received: by 2002:a05:6512:786:: with SMTP id x6mr2925906lfr.550.1603572958124;
        Sat, 24 Oct 2020 13:55:58 -0700 (PDT)
Received: from octa.pomac.com (c-f9c8225c.013-195-6c756e10.bbcust.telenor.se. [92.34.200.249])
        by smtp.gmail.com with ESMTPSA id f26sm246815lfc.302.2020.10.24.13.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 13:55:57 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     kai.heng.feng@canonical.com, linux-pci@vger.kernel.org,
        alexander.duyck@gmail.com, refactormyself@gmail.com,
        puranjay12@gmail.com
Cc:     Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH 2/3] PCI/ASPM: Fix L0s max latency check
Date:   Sat, 24 Oct 2020 22:55:47 +0200
Message-Id: <20201024205548.1837770-2-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201024205548.1837770-1-ian.kumlien@gmail.com>
References: <20201022183030.GA513862@bjorn-Precision-5520>
 <20201024205548.1837770-1-ian.kumlien@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From what I have been able to figure out, it seems like LOs path latency
is cumulative, so the max path latency should be the sum of all links
maximum latency.

Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
---
 drivers/pci/pcie/aspm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c03ead0f1013..dbe3ce60c1ff 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
+	u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
+		l0s_latency_up = 0, l0s_latency_dw = 0;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 
 	while (link) {
 		/* Check upstream direction L0s latency */
-		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-		    (link->latency_up.l0s > acceptable->l0s))
-			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
+		if (link->aspm_capable & ASPM_STATE_L0S_UP) {
+			l0s_latency_up += link->latency_up.l0s;
+			if (l0s_latency_up > acceptable->l0s)
+				link->aspm_capable &= ~ASPM_STATE_L0S_UP;
+		}
 
 		/* Check downstream direction L0s latency */
-		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-		    (link->latency_dw.l0s > acceptable->l0s))
-			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+		if (link->aspm_capable & ASPM_STATE_L0S_DW) {
+			l0s_latency_dw += link->latency_dw.l0s;
+			if (l0s_latency_dw > acceptable->l0s)
+				link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+		}
 
 		/*
 		 * Check L1 latency.
-- 
2.29.1

