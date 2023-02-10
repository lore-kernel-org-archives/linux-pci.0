Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89856C636D7
	for <linux-pci@archiver.kernel.org>; Fri, 10 Feb 2023 20:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjBJUhs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 10 Feb 2023 15:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjBJUhs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:37:48 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB66270714;
        Fri, 10 Feb 2023 12:37:45 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 0972910189E11;
        Fri, 10 Feb 2023 21:37:44 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id CEB656031F06;
        Fri, 10 Feb 2023 21:37:43 +0100 (CET)
X-Mailbox-Line: From 4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2 Mon Sep 17 00:00:00 2001
Message-Id: <4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:04 +0100
Subject: [PATCH v3 04/16] cxl/pci: Handle excessive CDAT length
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the length in the CDAT header is larger than the concatenation of the
header and all table entries, then the CDAT exposed to user space
contains trailing null bytes.

Not every consumer may be able to handle that.  Per Postel's robustness
principle, "be liberal in what you accept" and silently reduce the
cached length to avoid exposing those null bytes.

Fixes: c97006046c79 ("cxl/port: Read CDAT table")
Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.0+
---
 Changes v2 -> v3:
 * Newly added patch in v3

 drivers/cxl/core/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a3fb6bd68d17..c37c41d7acb6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -582,6 +582,9 @@ static int cxl_cdat_read_table(struct device *dev,
 		}
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
+	/* Length in CDAT header may exceed concatenation of CDAT entries */
+	cdat->length -= length;
+
 	return 0;
 }
 
-- 
2.39.1

