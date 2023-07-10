Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CD0EB64DA
	for <linux-pci@archiver.kernel.org>; Mon, 10 Jul 2023 23:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGJXO3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Jul 2023 19:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGJXO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 19:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014E5137;
        Mon, 10 Jul 2023 16:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 948FF6125F;
        Mon, 10 Jul 2023 23:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9602C433C8;
        Mon, 10 Jul 2023 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689030866;
        bh=3pacJFdrciplk9UTyYfKnVqmTOkTDznXreLebZgCpcc=;
        h=From:To:Cc:Subject:Date:From;
        b=FFa1cwZMYTNEk2+uKOfl/u+Z354qKOEXsU7dCcJNHIgSwW3g81vYZuz+hbnKvFKHJ
         TwCwS1KkJzzi2H6SiZnQY8tlT13Js5S3z4dxDXczn3VEVUGwV+MhTDwxWawomkIPZN
         DuQzYbNxYHwFiTK8quELngQuJ+onwLUNBvK29jwcgyR3OHWncK9CsjzClfxOWXUiwl
         OD+y4x3gRviZCmYPG+lPvvx0lGr/HREp/B4kNTUHUWrOhF8BM28cgTFH8hNFM0vL9o
         gTBfHPFSgaVmbrP4qP9oML6CUJBSBLLz+HExEWfdcNBQ/4Mp6qJLRoUke6uiqVQ3Co
         Keod6VwjvIbfA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] cxl/pci: Remove unnecessary aer.h include
Date:   Mon, 10 Jul 2023 18:14:16 -0500
Message-Id: <20230710231416.232751-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..8314cf2ac16a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -8,7 +8,6 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/pci.h>
-#include <linux/aer.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
-- 
2.34.1

