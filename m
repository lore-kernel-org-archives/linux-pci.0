Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24621C10F00
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 05:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79C9218A1
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 05:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hGk3uUZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfCOFHX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:07:23 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:35802 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfCOFHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Mar 2019 01:07:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id C32CAD24
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2019 05:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zIJdDw6DTh6n for <linux-pci@vger.kernel.org>;
        Fri, 15 Mar 2019 00:07:20 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 97F8ED1F
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2019 00:07:20 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id i1so6198847ioq.9
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2019 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MH76t9kyzCAYqgMIcgO6OuxcOMmte5MRyPGol0wrWyk=;
        b=hGk3uUZ+BAEgvh3z3ErlGCyL5arnj25cJRzutdAe5oCIrX/d95usy4n8P57QB8Slbc
         T7iT944cmOSrUtpNbrIgJKw7iCLgUBkJDbR0IV6DXVKYa8lILJodRlLJEDcYjwzyDirV
         XODVDwAs17tnPX0PvyAVuuoeLJLtjM5TDaZ45lvdlpAducAfW9cP90ZKosUPlfbYwuBZ
         Tn87bGj6Vzp6QBeJdBysrPEiW5TZJfT93/5TWn9LhfCcjSHITxxHRNMnlY1FYBwJmToo
         shs4p0ojbYBF+VZL9szEkyv1ZZurV6UJPHAPDcfxWWyRuSHHpA7S83f8a+nLqa9s5awR
         KQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MH76t9kyzCAYqgMIcgO6OuxcOMmte5MRyPGol0wrWyk=;
        b=Yl1r0WXWTu3BdiOyZxnub18NTctIaXuHKosTArWAbIrcwUY7GM6fr5ot/Oq1g9CUyv
         8wZW427BNsJukYjor75wrGnRaU+qa2b5nBjfgzCrx+lhro2ecr+rIl+KDS3WxNqbUgCm
         2DIUXrG3Nwv3gTUced41IOJp0pfk0nGZSYODx7Lgils7S3ffNvDxla1X7/qE31gcz1SR
         yCWwP7AoCbnzgdBCaM45f9gx4bxJKkAquKMg5Trnt7+kEA4nncdExl764VqKC2cAwJ39
         zjKFDlp4cG8u8EkBJ4jbNyKAIPYAkFV1tMitE9JOlUSKT8Tl+4fYxndZf4+iMqdVPS+k
         ITAA==
X-Gm-Message-State: APjAAAWmD9PhymI82vMLy5hQZ3P2FqsdQ9IQ3iLM16NlvMbPcnSRJu0e
        GysHv15hrg3MC1clA35KBAg7jihjE2u1kyXqzigaHZqugkRxruBM5NrYUXRmYaikWn71fidIhDG
        GvuC6FbLMs9Ds2h3qsXGpu07+
X-Received: by 2002:a24:2546:: with SMTP id g67mr794208itg.18.1552626440224;
        Thu, 14 Mar 2019 22:07:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKTt5B0MhdRiezIvucSKFXhY46yQaUIp6UuZi+YyVa6ogQQRUNHWrjaZSoDvbJWsA0ZUiIJg==
X-Received: by 2002:a24:2546:: with SMTP id g67mr794191itg.18.1552626439984;
        Thu, 14 Mar 2019 22:07:19 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 22sm489974ioc.28.2019.03.14.22.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 22:07:19 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: endpoint: fix a potential NULL pointer dereference
Date:   Fri, 15 Mar 2019 00:07:10 -0500
Message-Id: <20190315050711.8652-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case alloc_workqueue, the fix returns -ENOMEM to avoid
potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 3e86fa3c7da3..dc610eb1543a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -570,6 +570,10 @@ static int __init pci_epf_test_init(void)
 
 	kpcitest_workqueue = alloc_workqueue("kpcitest",
 					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (unlikely(!kpcitest_workqueue)) {
+		pr_err("Failed to allocate the kpcitest work queue\n");
+		return -ENOMEM;
+	}
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
 		pr_err("Failed to register pci epf test driver --> %d\n", ret);
-- 
2.17.1

