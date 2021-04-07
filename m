Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568D6C43600
	for <linux-pci@archiver.kernel.org>; Wed,  7 Apr 2021 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E896128A
	for <linux-pci@archiver.kernel.org>; Wed,  7 Apr 2021 22:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhDGW1E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:27:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:14309 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhDGW0w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:26:52 -0400
IronPort-SDR: azuVK6m0rKXbjpIHRM4/Mnv32GW0NX/i7AQ7x6cQwHyDwsOXeKFZ+FAdowF7iwT3ptwSdkFt9S
 TjNKXgM1DNMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524912"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="193524912"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:38 -0700
IronPort-SDR: nXmuEZ4eA97r1e4GYdIvBECXcH+Z12PfklUt1M92z0WmmU8TPLt8o4DG+XQUlFHzCaF+bciM3Z
 vf8vixY4sZ9g==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="458548529"
Received: from hmfaraby-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.128.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] cxl/mem: Use dev instead of pdev->dev
Date:   Wed,  7 Apr 2021 15:26:19 -0700
Message-Id: <20210407222625.320177-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407222625.320177-1-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Trivial cleanup.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index b6fe4e81d38a..99534260034e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -935,7 +935,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 	u8 bar;
 	int rc;
 
-	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
+	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
 	if (!cxlm) {
 		dev_err(dev, "No memory available\n");
 		return NULL;
-- 
2.31.1

