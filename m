Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3385ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D15421531
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 15:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OTM7GGpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D15421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeITUrD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:47:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54104 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeITUrD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 16:47:03 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8KF31it023463;
        Thu, 20 Sep 2018 10:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537455781;
        bh=SWzWLjrntZ7+njI6Lx5pp0oLmW+FzjXXaTvFXf8H8fE=;
        h=From:To:CC:Subject:Date;
        b=OTM7GGpAYFqsR7xXovifzfPh1QymW3+ep1fTFaW3GeuQGhnHz40NQtT8pc/CFJTDG
         GolZxolh7r/fiy3qmmPIl6ITsvQ6lQjo8LOw+9IXipJByTbme0aZbVt7ggS+0GeuIr
         toQ2ZL1fx53lHcdzn/MvZO8bPJUzYdaV+XaFonu0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8KF31ZU010825;
        Thu, 20 Sep 2018 10:03:01 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 20
 Sep 2018 10:03:01 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 20 Sep 2018 10:03:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8KF2xMY012651;
        Thu, 20 Sep 2018 10:03:00 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH] tools: PCI: exit with error code when test fails
Date:   Thu, 20 Sep 2018 17:02:53 +0200
Message-ID: <1537455773-13470-1-git-send-email-jjhiblot@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This makes it easier to use pcitest in automated setups.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 tools/pci/pcitest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index af146bb..5adc8cd 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -143,6 +143,7 @@ static int run_test(struct pci_test *test)
 	}
 
 	fflush(stdout);
+	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
 }
 
 int main(int argc, char **argv)
@@ -231,6 +232,5 @@ int main(int argc, char **argv)
 		return -EINVAL;
 	}
 
-	run_test(test);
-	return 0;
+	return run_test(test);
 }
-- 
2.7.4

