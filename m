Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BBC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C920855
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iiGUuInt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfDDLHT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:07:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50902 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfDDLHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 07:07:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34B7ErO071032;
        Thu, 4 Apr 2019 06:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554376034;
        bh=e6DcWDo3OCHtrefJpX2XsLERr6UZA2Xj3zcBx0kKNIM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iiGUuIntohliccrMjV+M2+YHv4dnuQ3S0U4C1OQ9SAiSAJ1P1xOqKf0g3wrv8zyvX
         Vg0KeT9HWXuRvXbkOeWzLgkFIuemHWVi76YwJMrt/g7bKp0XVOiMtfrAHSQXdU7CrF
         Mumyecqbz4df6mz8n7txUa4IskYwcRDXdpjuP8RU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34B7EWU057637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 06:07:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 06:07:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 06:07:14 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34B78dW106541;
        Thu, 4 Apr 2019 06:07:13 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 2/2] tools: PCI: Handle pcitest.sh independently from pcitest
Date:   Thu, 4 Apr 2019 16:36:09 +0530
Message-ID: <20190404110609.26158-3-kishon@ti.com>
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

Handling pcitest.sh along with pcitest (obtained by compiling
pcitest.c) results in pcitest.sh getting removed inadvertently
while "make -C tools/pci clean". Fix it here by handling
pcitest.sh independently of pcitest.

Fixes: 1ce78ce09430a5f ("tools: PCI: Change pcitest compiling
process")
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 tools/pci/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 46e4c2f318c9..9b7534457060 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -14,9 +14,12 @@ MAKEFLAGS += -r
 
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := pcitest pcitest.sh
+ALL_TARGETS := pcitest
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
+SCRIPTS := pcitest.sh
+ALL_SCRIPTS := $(patsubst %,$(OUTPUT)%,$(SCRIPTS))
+
 all: $(ALL_PROGRAMS)
 
 export srctree OUTPUT CC LD CFLAGS
@@ -46,6 +49,9 @@ install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
 	for program in $(ALL_PROGRAMS); do		\
 		install $$program $(DESTDIR)$(bindir);	\
+	done;						\
+	for script in $(ALL_SCRIPTS); do		\
+		install $$script $(DESTDIR)$(bindir);	\
 	done
 
 FORCE:
-- 
2.17.1

