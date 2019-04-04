Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF0C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546E720855
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DxF21jQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfDDLHQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:07:16 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33996 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfDDLHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 07:07:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34B7C1u024749;
        Thu, 4 Apr 2019 06:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554376032;
        bh=rTCB4trMp3+/hiirLD2nEEbonlYRZIaX35QyuQfeVRM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DxF21jQRIODFjP3PFvOkZqaaZSCN/jP898h51AODXUI+uoJ4YiOVrmFF58+ehYUt1
         s7DhS0cHSypQVT86p22LKl1+MnMANDt070tkQwfhCyAIeRxZZAdYFySt69dW3ix1lI
         hC4ewQPgSgVcFhmaF15ppkY47m4xzfYPBaGMUPGc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34B7CM6057594
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 06:07:12 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 06:07:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 06:07:12 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34B78dV106541;
        Thu, 4 Apr 2019 06:07:11 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/2] tools: PCI: Add 'h' in optstring of getopt()
Date:   Thu, 4 Apr 2019 16:36:08 +0530
Message-ID: <20190404110609.26158-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404110609.26158-1-kishon@ti.com>
References: <20190404110609.26158-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'h' is a valid option character for pcitest utility used to print
the pcitest usage. Add 'h' in optstring of getopt() in order to get
rid of "pcitest: invalid option -- 'h'" warning. While at that remove
unncessary case '?'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 tools/pci/pcitest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index ec4d51f3308b..34d71f7d3b12 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -162,7 +162,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -206,7 +206,6 @@ int main(int argc, char **argv)
 	case 's':
 		test->size = strtoul(optarg, NULL, 0);
 		continue;
-	case '?':
 	case 'h':
 	default:
 usage:
@@ -224,6 +223,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n",
+			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;
 	}
-- 
2.17.1

