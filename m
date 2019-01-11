Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B904C43444
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1462C20874
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="kWgJYtQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfAKPn7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:59 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40074 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731859AbfAKPnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:55 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D3B50419CF
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221052; x=1549035453; bh=oW/E446PIoYsz78RDzI3+79je16l19k7b6k
        lzyaq4lA=; b=kWgJYtQY+wzG2jTwB4BjDuvqxqivoQlSCpHB7Gj+jyV/go/EhoM
        UjBzb8NJglHAfLegLCuhabOQYvf8tHdXm88DUPHrar+L8Ld1cZnyrpZVy4TdBKg9
        TXtjiCEkGJ15t3+ASn4Z2433dkR2N45r6/JJSuwebHFd2EnmppA1O3bE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 66Im7H6_TJsn for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:32 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C4694419C6
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:25 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:25 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 21/21] x86: enable movable BARs
Date:   Fri, 11 Jan 2019 18:37:07 +0300
Message-ID: <20190111153707.10140-22-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
References: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the feature by default. Can be overridden by the command line
argument "pcie_movable_bars=off".

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/x86/pci/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/pci/init.c b/arch/x86/pci/init.c
index 5fc617edf108..f93843f702d1 100644
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -40,6 +40,8 @@ static __init int pci_arch_init(void)
 
 	dmi_check_skip_isa_align();
 
+	pci_add_flags(PCI_MOVABLE_BARS);
+
 	return 0;
 }
 arch_initcall(pci_arch_init);
-- 
2.20.1

