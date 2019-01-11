Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5DBC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924B720874
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="mRSZIorn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfAKPn7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:59 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40076 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731975AbfAKPn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 104FE419C0
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221051; x=1549035452; bh=yWOP/t3o7W/g1Yw9tCQ66cBeDXlxqnPxkpk
        ug1M0fOw=; b=mRSZIornQhiaww3uZg4mUgrHznq7CQ4mWU23iNSvCuQv1IDC7Ng
        SRKcI8q1iTJWJtauqGt/IMDIzdXm0PUp220tmrPkJ3wI7m9+4KT75RaS2FEGTM6g
        KsvtkF/2sZMjTvXad3ebWxWYr3Vt1Td+rnk10V9nCV45cdgpFncsDAtg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JDZpZODN1qMv for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 52E04419C2
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:25 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:24 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 19/21] powerpc/pci: Fix crash with enabled movable BARs
Date:   Fri, 11 Jan 2019 18:37:05 +0300
Message-ID: <20190111153707.10140-20-s.miroshnichenko@yadro.com>
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

Check a resource for the UNSET flags.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1d6406a051f1..6706dac69ee6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3037,7 +3037,8 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 	int index;
 	int64_t rc;
 
-	if (!res || !res->flags || res->start > res->end)
+	if (!res || !res->flags || res->start > res->end ||
+	    (res->flags & IORESOURCE_UNSET))
 		return;
 
 	if (res->flags & IORESOURCE_IO) {
-- 
2.20.1

