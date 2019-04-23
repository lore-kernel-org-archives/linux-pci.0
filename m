Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734CC282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EE42183E
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePlgw5d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfDWQbP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:31:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33682 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfDWQbO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:31:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so7877781pgh.0;
        Tue, 23 Apr 2019 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xerTm3VfTwwIXo29rsoW7SuRTHKgFB7tOjiZbttFTM=;
        b=ePlgw5d0ij796SpuWMMljIQPe26ujwx2u69aSihHH34H9VNxTBqVqC9JDzOSQffBIf
         FK4fsGn0sv9sj6O4u15d+SBUhQ0ZzlZ/62j4MJtxUv7Ac6cznKZZqSQs/BkQMSGFBTEF
         CVPh4ng3NKkBPO69n5bg/t2NynDmmA1JD/A68xSTqP6w4XGee0EA5M4jUOBClrFKnHru
         bdO+l5eMVhI9w+jSq35mvVzBXGqTAldf6XIvu7FmD6oqKDdmr8Aew2mUCk7p3SmVaJwY
         dRH7tDJlpCEM5qzlwEz/HWdy3izqSy4m/Ft6gXs3fZiHWVOn/kFY9r7+v5UDHssqPnPW
         AC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xerTm3VfTwwIXo29rsoW7SuRTHKgFB7tOjiZbttFTM=;
        b=occ9iuGYiyb9Ap/uxTjYK6sRJlv2YRaGhol7F6FcQ6d4tvdrH1yG9URNtbuMJM0MrO
         PnnWDMYOOS1N+bWQSmXlj9JtE9bKNXXFTvnLGkn9VxZ5fT+M13ygd/xMNy+DdSHUaaAq
         AFYbpjNJik133QNgoUVUhsXCoRJvYI3pH803pyBbU+HxFK71ffhuJxhZXRlJHLaeqPnp
         /O84Y6FdY2i3TOUuaOUFxvHH5ac8sQ3iG6KFno7i4u9Y7PkZ8wnyk1UZ/QU2XMN8XLMu
         Lcrv4FdsiYaadpSmqAchQglZ4GxHFXvw6Jt3+c6UvKYfTL+FQUuQqiv24V40MarfhM/q
         TvqA==
X-Gm-Message-State: APjAAAWaSviBKETT8HqYHp2OYAuJpGuulrSEcRrAGn3hNVhV3qyE7ZE1
        3HTY0K+J9MrxHTkg96B5c5g=
X-Google-Smtp-Source: APXvYqwZa4hivcq2EcEi39jhEWFSWP8AO8b2FQnBlBbgzRJPRFxT5c1A/tYw9BEJSG5Utah0fO9DGA==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr13634575pgm.0.1556037073332;
        Tue, 23 Apr 2019 09:31:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:31:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 06/63] Documentation: ACPI: move scan_handlers.txt to driver-api/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:35 +0800
Message-Id: <20190423162932.21428-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/driver-api/acpi/index.rst       |  1 +
 .../acpi/scan_handlers.rst}                   | 24 ++++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)
 rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)

diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
index 12649947b19b..ace0008e54c2 100644
--- a/Documentation/driver-api/acpi/index.rst
+++ b/Documentation/driver-api/acpi/index.rst
@@ -6,3 +6,4 @@ ACPI Support
    :maxdepth: 2
 
    linuxized-acpica
+   scan_handlers
diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/driver-api/acpi/scan_handlers.rst
similarity index 90%
rename from Documentation/acpi/scan_handlers.txt
rename to Documentation/driver-api/acpi/scan_handlers.rst
index 3246ccf15992..7a197b3a33fc 100644
--- a/Documentation/acpi/scan_handlers.txt
+++ b/Documentation/driver-api/acpi/scan_handlers.rst
@@ -1,7 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+==================
 ACPI Scan Handlers
+==================
+
+:Copyright: |copy| 2012, Intel Corporation
 
-Copyright (C) 2012, Intel Corporation
-Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 During system initialization and ACPI-based device hot-add, the ACPI namespace
 is scanned in search of device objects that generally represent various pieces
@@ -30,14 +36,14 @@ to configure that link so that the kernel can use it.
 Those additional configuration tasks usually depend on the type of the hardware
 component represented by the given device node which can be determined on the
 basis of the device node's hardware ID (HID).  They are performed by objects
-called ACPI scan handlers represented by the following structure:
+called ACPI scan handlers represented by the following structure::
 
-struct acpi_scan_handler {
-	const struct acpi_device_id *ids;
-	struct list_head list_node;
-	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
-	void (*detach)(struct acpi_device *dev);
-};
+	struct acpi_scan_handler {
+		const struct acpi_device_id *ids;
+		struct list_head list_node;
+		int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
+		void (*detach)(struct acpi_device *dev);
+	};
 
 where ids is the list of IDs of device nodes the given handler is supposed to
 take care of, list_node is the hook to the global list of ACPI scan handlers
-- 
2.20.1

