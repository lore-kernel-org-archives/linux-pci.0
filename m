Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11532C61DA4
	for <linux-pci@archiver.kernel.org>; Sat, 11 Mar 2023 14:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCKOw2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 11 Mar 2023 09:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCKOw1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 09:52:27 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3EF1135C6;
        Sat, 11 Mar 2023 06:52:14 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id CED4410190FD0;
        Sat, 11 Mar 2023 15:52:12 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 9416260049B2;
        Sat, 11 Mar 2023 15:52:12 +0100 (CET)
X-Mailbox-Line: From 6d98b3c7da5343172bd3ccabfabbc1f31c079d74 Mon Sep 17 00:00:00 2001
Message-Id: <6d98b3c7da5343172bd3ccabfabbc1f31c079d74.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:04 +0100
Subject: [PATCH v4 04/17] cxl/pci: Handle excessive CDAT length
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: stable@vger.kernel.org # v6.0+
---
 drivers/cxl/core/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index fb600dfbf5a6..523d5b9fd7fc 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -564,6 +564,9 @@ static int cxl_cdat_read_table(struct device *dev,
 		}
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
+	/* Length in CDAT header may exceed concatenation of CDAT entries */
+	cdat->length -= length;
+
 	return 0;
 }
 
-- 
2.39.1

