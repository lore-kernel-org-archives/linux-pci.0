Return-Path: <SRS0=K8vK=UU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9FC43613
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 15:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC372070B
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tU4B2enB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfFUPOo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:14:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUPOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 11:14:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so3772310pfd.2;
        Fri, 21 Jun 2019 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLu3Y0O1Cdy8sgEXtdnAkdEST9WDREreBBj3EafUb+I=;
        b=tU4B2enBHlTy8p7yKuwY9mi3Pw/sEHGg2aqpHBMcZICaVAav+SYP0FgvbaBsmDGbDk
         v8psS4BIrOdhOtnX+UzM2r8tEH6GJdyAxuxOuwFw0YVZaXQdKath8nTdcY/NgucptVPx
         2wKmaG76eN/O4DIv9PYVywVa+OEAHtoCtAYVuk9b6yvLdHIjLdfwGhVyhBlyiJOh+YvD
         S93wbGgERc+IHjbkKtxh7ORkclB74TdDmPs7iwRGiEqQXKpGnjlovYUVPco86LQqt4hy
         3JGSCPnV6Di/AV5+KkqKfncTbSCQupDbk8SIU8yEXOcmJ4pC3cPi8owqSxXImPgryUTV
         /akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLu3Y0O1Cdy8sgEXtdnAkdEST9WDREreBBj3EafUb+I=;
        b=l2GnnJlZMGGRUdve3GcMLdi7KYpSjl3U37jAFwG7D2Z8Ij+3FvqTsvMW3K40WBJa+r
         GHNx8smpjbk0Xuoakn04wUet7WOSrylJFgxWQ2KPyqX/hQp017RdXtsuvwP4KkIzF77u
         NLbIdpaeZj7ZC/z/gAImvF121xgAI+iDMwkeCfWPRyaHRNvNW4TwMqAZsTJ3d2Oa0R96
         LdG4ksDcPtnf4V1eVLodas04a+R0Fyn7r6XusuXb7cheasAQAo7dyKBV/o/E9d5Wr4bf
         iVWW+uc5xhgaBJy+yd8WbokujcjTwKmZM1NABwX0BxcBVKcPAj7Z3E14yf0Rpp2NhxYk
         rF5g==
X-Gm-Message-State: APjAAAUJjv30Rc6ntuJk2WrXujyCiBRwqywN8Ag+GCCr1VC4gy2fZvxD
        Gli/vhUgtjtI3sJJsdFc5bPMVkbdmgFrpQ==
X-Google-Smtp-Source: APXvYqwzYyywi5wndVPPY0gY5itoyyesvxpsvlSka9QItqlN5WvPMx4jXOck+FClEnQ+fA1rUjHr3g==
X-Received: by 2002:a63:1b07:: with SMTP id b7mr18724986pgb.133.1561130081914;
        Fri, 21 Jun 2019 08:14:41 -0700 (PDT)
Received: from localhost.localdomain ([112.196.181.13])
        by smtp.googlemail.com with ESMTPSA id 25sm3254465pfp.76.2019.06.21.08.14.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 08:14:41 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 2/3] net: fddi: skfp: Include generic PCI definitions
Date:   Fri, 21 Jun 2019 20:44:14 +0530
Message-Id: <20190621151415.10795-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621151415.10795-1-puranjay12@gmail.com>
References: <20190621151415.10795-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include the uapi/linux/pci_regs.h header file which contains the generic
PCI defines.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/net/fddi/skfp/drvfbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fddi/skfp/drvfbi.c b/drivers/net/fddi/skfp/drvfbi.c
index b324c1acf195..9c8aa3a95463 100644
--- a/drivers/net/fddi/skfp/drvfbi.c
+++ b/drivers/net/fddi/skfp/drvfbi.c
@@ -20,6 +20,7 @@
 #include "h/supern_2.h"
 #include "h/skfbiinc.h"
 #include <linux/bitrev.h>
+#include <linux/pci_regs.h>
 
 #ifndef	lint
 static const char ID_sccs[] = "@(#)drvfbi.c	1.63 99/02/11 (C) SK " ;
-- 
2.21.0

