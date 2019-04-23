Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23309C282E1
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84FD20645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSEjJqm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfDWQjS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:39:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37210 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfDWQjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:39:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so7882963pgc.4;
        Tue, 23 Apr 2019 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yvtB3uaTRGxnRgaWP7FcK1I6Vvjpy6XLjw84eVyA1w=;
        b=mSEjJqm1Uh9lERZuTImsCQu6ENHXJ7Tv3P2SgTBOwRN1RA1F+W22zdJSFHOTxfQ8mv
         iKtnE+HwXt6ZnFfUgDAbJZX4w1xVglJs5Qpk8+qyIhYSfX0nLYaMnc8xC26DxSQf4A6Y
         uz9aBRqpV1z6edqMo5qfAhfSrQwishu34hMCLkXioD1UQZMbiKBO7ZGOLIJPdxX3YeDX
         YfXaZrsPtQDIDqyB4hIZ4+qvtC99RaX/eZ9Xq9snN66BQxGdY74tEBvqlLNpQkofen7p
         rZYuHJSG2XVCSC4GdFvQ/jM2UjJltMSeP0O7LAExvKoqh00S7h5gpWD0kWt+KB5UXSMx
         yfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yvtB3uaTRGxnRgaWP7FcK1I6Vvjpy6XLjw84eVyA1w=;
        b=j4wfMkqfax/1e1OWYOvsc0HJwozVt2gz2HgJJJyPYilI0FnarstmTLzxixunpPlTAE
         Hna9IFxLX7scKFk7LycTsIBFb8P++LOf5hWnuwuGeIjxgRNxXO62Pc8Kcbubzghgn7Zd
         a40AfzUoaA4+PQWbdnCNRvg2EK0oF9UTnBcUrsdgDa3IGinVaSUjCIxnS1fwyxwxuHnH
         r4bl29q4KWKYdzs0mlpONrDhnHU1EtiEknFOSxfQOjTZhLu8m422CxgXTg22tublUAN1
         mxyYFAHvkHJ7Ft9HaGKTTMBYuZCUWPzdLtLuIBIAMlLqElwa37JeiuMABz0BTu5uiy+8
         I0Ng==
X-Gm-Message-State: APjAAAVSKJjQONtM2UuGJU9sMPO1AqwdaFHJSYS5TH3upmldTmIkOw0/
        SKiMCMo6NKnuFCcRi/7or5s=
X-Google-Smtp-Source: APXvYqz7nIbYvWFGQ7St8YWnYNdpaoYF3I5r3o/MDQqQCS+rkAvyEtbbpVhd8SKQZLRUyxQ8J7eGrA==
X-Received: by 2002:a63:de0a:: with SMTP id f10mr15896380pgg.418.1556037556886;
        Tue, 23 Apr 2019 09:39:16 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:39:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 62/63] Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
Date:   Wed, 24 Apr 2019 00:29:31 +0800
Message-Id: <20190423162932.21428-63-changbin.du@gmail.com>
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
 .../x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst}    | 5 ++++-
 Documentation/x86/x86_64/index.rst                           | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)

diff --git a/Documentation/x86/x86_64/cpu-hotplug-spec b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
similarity index 88%
rename from Documentation/x86/x86_64/cpu-hotplug-spec
rename to Documentation/x86/x86_64/cpu-hotplug-spec.rst
index 3c23e0587db3..8d1c91f0c880 100644
--- a/Documentation/x86/x86_64/cpu-hotplug-spec
+++ b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
 Firmware support for CPU hotplug under Linux/x86-64
----------------------------------------------------
+===================================================
 
 Linux/x86-64 supports CPU hotplug now. For various reasons Linux wants to
 know in advance of boot time the maximum number of CPUs that could be plugged
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index e2a324cde671..c04b6eab3c76 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -12,3 +12,4 @@ x86_64 Support
    mm
    5level-paging
    fake-numa-for-cpusets
+   cpu-hotplug-spec
-- 
2.20.1

