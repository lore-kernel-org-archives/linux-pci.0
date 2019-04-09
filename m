Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B0FC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D062084C
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfXu8hFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDIP5H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:57:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38117 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfDIP5E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 11:57:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so9964111pfo.5;
        Tue, 09 Apr 2019 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ic7Mz9ZN66lX6qBzL4R/C06u702++iEG8zGQWvLykvo=;
        b=EfXu8hFNJdiZ7gs/66FoERD9yFq9EWGodKCvBrL4YXCnI8BgPZV73g2j4XC3i4I/9s
         8ZroU/T0ALCO0MlUfIlBtbd1im7D1t6U6+fCtGMZwtB4aQBjEh2GWHmnkAH2Y8AjNVum
         DPt1S4IgbNGwyMDOasZz7kZIxzjY0PzRRVt272x7jREPc2AV30nSg17xH9C+JXYBC2eP
         Gd5MvXYWEN0dhNV+IZlZNpLMZZtCQ3M2QTI0CgdLCpRedWRXvzRf+rpwugXSpFVXjbgB
         u1N1iPUdx3Gms4jcIhrUCxB4wAqO32t6ZVjs8YOVtNr60C5B92YQH3KXKX7ETT5SeIvg
         KOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ic7Mz9ZN66lX6qBzL4R/C06u702++iEG8zGQWvLykvo=;
        b=Wzd3gleofnv3GzktG3ZDWkKTw+L5D36OFWGVa0LRmyJ4zTABK2HejOGeT88qfPqe5p
         dbFdtIvQ/KNSBy25YEjFnP1BfAjcadbf8br7loDVbPz4O7fRbiPVuuT2+zOS/235TfHO
         GVD1uCxuAXjTTJKPlkkaj4Z7z1SyplH949pEhWs64+q5rotCdkF6WnNorrjyfvtR1QhI
         8+0R+R6YUbjWvNsRFsBZWMJ+HXAocJ1V4vGeg2SACjpPL9zfjxx1t1Aqyk6um5o5VAo4
         lnUTrrgrl3TwQfWAzV6H+K/7J3V6Q/tL7mapOpvp4iEuszLkuslQxyh8yxrTx4D8nmce
         ocaw==
X-Gm-Message-State: APjAAAVjTz/A8y432mOQo0/pz6VG3KpdZsI8UXA7+VFc0q7l2MpWw0Oy
        3bFWsZAeM7w6L5OunTzcTSM=
X-Google-Smtp-Source: APXvYqxgeACwiJh2vDC5iR+IUX4Nly5N04V6g0a9h087GUpmwDC4yLQ85l9QiZgRw+tQJ2GzJLOL0g==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr37439600pfn.31.1554825423544;
        Tue, 09 Apr 2019 08:57:03 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b72sm70383560pga.86.2019.04.09.08.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:57:02 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 06/12] Documentation: PCI: convert acpi-info.txt to reST
Date:   Tue,  9 Apr 2019 23:56:20 +0800
Message-Id: <20190409155626.6049-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409155626.6049-1-changbin.du@gmail.com>
References: <20190409155626.6049-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/{acpi-info.txt => acpi-info.rst} | 11 ++++++++---
 Documentation/PCI/index.rst                        |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)

diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.rst
similarity index 97%
rename from Documentation/PCI/acpi-info.txt
rename to Documentation/PCI/acpi-info.rst
index 3ffa3b03970e..f7dabb7ca255 100644
--- a/Documentation/PCI/acpi-info.txt
+++ b/Documentation/PCI/acpi-info.rst
@@ -1,4 +1,8 @@
-		ACPI considerations for PCI host bridges
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+ACPI considerations for PCI host bridges
+========================================
 
 The general rule is that the ACPI namespace should describe everything the
 OS might use unless there's another way for the OS to find it [1, 2].
@@ -135,8 +139,9 @@ address always corresponds to bus 0, even if the bus range below the bridge
 
     Extended Address Space Descriptor (.4)
     General Flags: Bit [0] Consumer/Producer:
-	1–This device consumes this resource
-	0–This device produces and consumes this resource
+
+        * 1 – This device consumes this resource
+        * 0 – This device produces and consumes this resource
 
 [5] ACPI 6.2, sec 19.6.43:
     ResourceUsage specifies whether the Memory range is consumed by
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 1b25bcc1edca..c877a369481d 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -12,3 +12,4 @@ Linux PCI Bus Subsystem
    PCIEBUS-HOWTO
    pci-iov-howto
    MSI-HOWTO
+   acpi-info
-- 
2.20.1

