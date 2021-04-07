Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5168BC43461
	for <linux-pci@archiver.kernel.org>; Wed,  7 Apr 2021 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1555D613CD
	for <linux-pci@archiver.kernel.org>; Wed,  7 Apr 2021 22:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhDGW1X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:27:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:14322 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhDGW1P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:27:15 -0400
IronPort-SDR: dW4IYUcxDExgcLO0ZQNl/7FZkmS37KpxyyG7A/nRh3pcETDti0r4lsKoYv/xVeAT/Tgss4tOaE
 I10ITMTRJZbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524931"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="193524931"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:39 -0700
IronPort-SDR: rhY2/D6RpXcG5mGIq1pg/6BWHHDCa1u27cFeIKVeUy4w9M1YDbKppyPJ/2I6lSlIDQJ5V2QSmF
 NfMpvZoWCtRQ==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="458548547"
Received: from hmfaraby-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.128.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] cxl/mem: Move device register setup
Date:   Wed,  7 Apr 2021 15:26:23 -0700
Message-Id: <20210407222625.320177-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407222625.320177-1-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support expansion of register block types that the driver will attempt
to recognize by pulling the code up into the register block scanning
loop. Subsequent code can easily add in new register block types with
this.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 60b95c524c3e..49f651694cb0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1020,6 +1020,15 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
 			if (IS_ERR(base))
 				return PTR_ERR(base);
+
+			cxl_setup_device_regs(dev, base, &regs->device_regs);
+			if (!regs->status || !regs->mbox || !regs->memdev) {
+				dev_err(dev, "registers not found: %s%s%s\n",
+						!regs->status ? "status " : "",
+						!regs->mbox ? "mbox " : "",
+						!regs->memdev ? "memdev" : "");
+				return -ENXIO;
+			}
 			break;
 		}
 	}
@@ -1029,16 +1038,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		return -ENXIO;
 	}
 
-	cxl_setup_device_regs(dev, base, &regs->device_regs);
-
-	if (!regs->status || !regs->mbox || !regs->memdev) {
-		dev_err(dev, "registers not found: %s%s%s\n",
-			!regs->status ? "status " : "",
-			!regs->mbox ? "mbox " : "",
-			!regs->memdev ? "memdev" : "");
-		return -ENXIO;
-	}
-
 	return 0;
 }
 
-- 
2.31.1

