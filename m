Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3A6C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 19:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F48218A4
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfABTsg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:48:36 -0500
Received: from gabe.freedesktop.org ([131.252.210.177]:56272 "EHLO
        gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfABTsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 14:48:35 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 14:48:35 EST
Received: from annarchy.freedesktop.org (annarchy.freedesktop.org [IPv6:2610:10:20:722:a800:ff:feda:470f])
        by gabe.freedesktop.org (Postfix) with ESMTP id DD93F6E063;
        Wed,  2 Jan 2019 19:39:17 +0000 (UTC)
Received: by annarchy.freedesktop.org (Postfix, from userid 3222)
        id D185018189; Wed,  2 Jan 2019 19:39:17 +0000 (UTC)
From:   Vinson Lee <vlee@freedesktop.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] lspci: Fix extra newline if L1.2 is not supported.
Date:   Wed,  2 Jan 2019 19:39:17 +0000
Message-Id: <20190102193917.11871-1-vlee@freedesktop.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes: fb17077dc378 ("Cleaned up the previous patch")
Signed-off-by: Vinson Lee <vlee@freedesktop.org>
---
 ls-ecaps.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index db99ed0098d7..4417cd9e1824 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -711,17 +711,19 @@ cap_l1pm(struct device *d, int where)
     FLAG(val, PCI_L1PM_SUBSTAT_CTL1_ASPM_L11));
 
   if (l1_cap & PCI_L1PM_SUBSTAT_CAP_PM_L12 || l1_cap & PCI_L1PM_SUBSTAT_CAP_ASPM_L12)
-    printf("\t\t\t   T_CommonMode=%dus", BITS(val, 8, 8));
-
-  if (l1_cap & PCI_L1PM_SUBSTAT_CAP_ASPM_L12)
     {
-      scale = BITS(val, 29, 3);
-      if (scale > 5)
-	printf(" LTR1.2_Threshold=<error>");
-      else
-	printf(" LTR1.2_Threshold=%lldns", BITS(val, 16, 10) * (unsigned long long) cap_ltr_scale(scale));
+      printf("\t\t\t   T_CommonMode=%dus", BITS(val, 8, 8));
+
+      if (l1_cap & PCI_L1PM_SUBSTAT_CAP_ASPM_L12)
+	{
+	  scale = BITS(val, 29, 3);
+	  if (scale > 5)
+	    printf(" LTR1.2_Threshold=<error>");
+	  else
+	    printf(" LTR1.2_Threshold=%lldns", BITS(val, 16, 10) * (unsigned long long) cap_ltr_scale(scale));
+	}
+      printf("\n");
     }
-  printf("\n");
 
   val = get_conf_long(d, where + PCI_L1PM_SUBSTAT_CTL2);
   printf("\t\tL1SubCtl2:");
-- 
2.19.1

