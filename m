Return-Path: <SRS0=S6xX=TR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E2FC04AB4
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1426217D4
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558118435;
	bh=v5VdbvByT5Kbm6ftnFHwsT3AnG9Byib1XRr5zOj7l/o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0GessDpGP3lAq/f0O/FXPVKwR2LLoyWuJIRfr/hN89SGCd1tU9GSVPmyp2/Ak/T0v
	 dqHUw91kHk0qi7++rBfGtdXqWIhMkjIXppTJD6I9fp9JapGFP4cm6o+UMLsVWSvEQY
	 KtfBk2+Rw0pQU3Z/z8yoqj19YeFUNhk6tVJibVJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEQSke (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 May 2019 14:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfEQSke (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 14:40:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CFD218AD;
        Fri, 17 May 2019 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558118433;
        bh=v5VdbvByT5Kbm6ftnFHwsT3AnG9Byib1XRr5zOj7l/o=;
        h=From:To:Cc:Subject:Date:From;
        b=mG3oR6R3yzrYegIzcAWgaCFiwGW9sSzTg+zdm7SeHKcNmr+6IC8yHumjDTJ5H9Y+W
         JkjRxrvJw1iexO5HdrHIXwhJJC/2RLLfqLeymabVlOxuC0pb0RfoeOTjLXZxTj00Rv
         p1ITo02pWFMlbpvJzzA73Ki+IDGcAVCu5ECsKa2g=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] lspci: Reorder Express Root Complex registers to Cap, Ctl, Sta
Date:   Fri, 17 May 2019 13:40:22 -0500
Message-Id: <20190517184022.79914-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Registers in the PCI Express Capability come in sets of three (Capability,
Control, Status), and we typically print them in that order.  The Root
Complex-related registers were an exception: we printed them in the
(Control, Capability, Status) order.

Decode the RootCap, RootCtl, and RootSta registers in the usual order.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index a739f46..f1f325d 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -897,7 +897,13 @@ static void cap_express_slot(struct device *d, int where)
 
 static void cap_express_root(struct device *d, int where)
 {
-  u32 w = get_conf_word(d, where + PCI_EXP_RTCTL);
+  u32 w;
+
+  w = get_conf_word(d, where + PCI_EXP_RTCAP);
+  printf("\t\tRootCap: CRSVisible%c\n",
+	FLAG(w, PCI_EXP_RTCAP_CRSVIS));
+
+  w = get_conf_word(d, where + PCI_EXP_RTCTL);
   printf("\t\tRootCtl: ErrCorrectable%c ErrNon-Fatal%c ErrFatal%c PMEIntEna%c CRSVisible%c\n",
 	FLAG(w, PCI_EXP_RTCTL_SECEE),
 	FLAG(w, PCI_EXP_RTCTL_SENFEE),
@@ -905,10 +911,6 @@ static void cap_express_root(struct device *d, int where)
 	FLAG(w, PCI_EXP_RTCTL_PMEIE),
 	FLAG(w, PCI_EXP_RTCTL_CRSVIS));
 
-  w = get_conf_word(d, where + PCI_EXP_RTCAP);
-  printf("\t\tRootCap: CRSVisible%c\n",
-	FLAG(w, PCI_EXP_RTCAP_CRSVIS));
-
   w = get_conf_long(d, where + PCI_EXP_RTSTA);
   printf("\t\tRootSta: PME ReqID %04x, PMEStatus%c PMEPending%c\n",
 	w & PCI_EXP_RTSTA_PME_REQID,
-- 
2.21.0.1020.gf2820cf01a-goog

