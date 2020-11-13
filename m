Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55ECC388F7
	for <linux-pci@archiver.kernel.org>; Fri, 13 Nov 2020 08:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A945217A0
	for <linux-pci@archiver.kernel.org>; Fri, 13 Nov 2020 08:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKMI6v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:58:51 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59327 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbgKMI6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 03:58:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UFAepvk_1605257910;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAepvk_1605257910)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 16:58:38 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: fix a comments issue
Date:   Fri, 13 Nov 2020 16:58:14 +0800
Message-Id: <1605257895-5536-5-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The comments is using kernel-doc markup, while it isn't, so remove it
from kernel-doc type to avoid warning:
arch/x86/pci/i386.c:373: warning: Function parameter or member
'pcibios_assign_resources' not described in 'fs_initcall'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Borislav Petkov <bp@alien8.de> 
Cc: x86@kernel.org 
Cc: "H. Peter Anvin" <hpa@zytor.com> 
Cc: linux-pci@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 arch/x86/pci/i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index fa855bbaebaf..77fda6d432c6 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -366,7 +366,7 @@ static int __init pcibios_assign_resources(void)
 	return 0;
 }
 
-/**
+/*
  * called in fs_initcall (one below subsys_initcall),
  * give a chance for motherboard reserve resources
  */
-- 
2.29.GIT

