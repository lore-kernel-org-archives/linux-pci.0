Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64618C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E5420645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyMyEVWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfDWQjX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:39:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43267 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfDWQjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:39:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so7869061pgu.10;
        Tue, 23 Apr 2019 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6w+/ukhBs5A+/Cpc4cy3lRbWsMEd9es6i7ZvKVBddzs=;
        b=dyMyEVWDLZJEfWEezbupnV/PWKS/cnXhuL4Ok400eGTQf28IPq7U9hBqT6GPyhUH80
         xDkmV3xv83ujk8WxZWoltaWP3SYsH/9s+aQGQ+o0mT64b33NneoSTzbUdCjA0oVoiAze
         eO0RCeeEyMHUAe1vHZ8wZgRLqdmnGICiW/GaTDXgF0/LK16RQfHfxdOwXq67v4q/qhcA
         6UfRD/SJD/2pvUTATCa4HyeBKxNpO7eQPNt2y9Nu9R24VfM86aOK69kWgYrqk1LIYd7j
         4c++D5x73S5bs6WuPzV21ONTCFYQxFjDcEWKcKoKGYVOB+mGdYBMFF6M2smIfrGZWb+b
         S7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6w+/ukhBs5A+/Cpc4cy3lRbWsMEd9es6i7ZvKVBddzs=;
        b=VyWIILRoInwAH4O5DtS6RW+0TZ0YPITgxkUujI+VKyLLk8LFVIE+5TBC3F3pZB/BHj
         8DGZmfoJA6CupJcpcEvpV0ckpkwmosdhJbozTqG0NP6VqRGaQkYnDvDo1kEjCjr14hYi
         5OoeJ9fKkT+nqXZPs3L8/z0p/iNlwsF6ZqO03NhmbSt2ImhC0izG5maJcWtQb3+sg5kN
         MZjsN6e/ewvRkOcfuLb4rU6QIrPkesjLuJlwRcttN+qCDcgon9z3oduTrT8pDR9lVeQT
         Pc2rkFf3Fmr+3nfmMdEFCTLLj4KOuMWcepRFdtm1y7hGObuz8jarNIaLdDB8PkZa2PIF
         7zXg==
X-Gm-Message-State: APjAAAW0CwWnvH6Ocm5IS7C3ttmTB09gFc1iy+RwzTVCGBFmevsPzqrO
        kDmaKSYOdk22ZUxOFHSFxxg=
X-Google-Smtp-Source: APXvYqx276i5IPfOnVxMQNuxIDAAkHLbEiVeWvrYnY1fHoBHgUWH60klV/bze67U67znXMVhhTJctg==
X-Received: by 2002:a63:5059:: with SMTP id q25mr18784756pgl.314.1556037561717;
        Tue, 23 Apr 2019 09:39:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:39:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 63/63] Documentation: x86: convert x86_64/machinecheck to reST
Date:   Wed, 24 Apr 2019 00:29:32 +0800
Message-Id: <20190423162932.21428-64-changbin.du@gmail.com>
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
 Documentation/x86/x86_64/index.rst                    |  1 +
 .../x86/x86_64/{machinecheck => machinecheck.rst}     | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)

diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index c04b6eab3c76..d6eaaa5a35fc 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -13,3 +13,4 @@ x86_64 Support
    5level-paging
    fake-numa-for-cpusets
    cpu-hotplug-spec
+   machinecheck
diff --git a/Documentation/x86/x86_64/machinecheck b/Documentation/x86/x86_64/machinecheck.rst
similarity index 92%
rename from Documentation/x86/x86_64/machinecheck
rename to Documentation/x86/x86_64/machinecheck.rst
index d0648a74fceb..8e9d2d529a8d 100644
--- a/Documentation/x86/x86_64/machinecheck
+++ b/Documentation/x86/x86_64/machinecheck.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-Configurable sysfs parameters for the x86-64 machine check code.
+===============================================================
+Configurable sysfs parameters for the x86-64 machine check code
+===============================================================
 
 Machine checks report internal hardware error conditions detected
 by the CPU. Uncorrected errors typically cause a machine check
@@ -16,14 +19,12 @@ log then mcelog should run to collect and decode machine check entries
 from /dev/mcelog. Normally mcelog should be run regularly from a cronjob.
 
 Each CPU has a directory in /sys/devices/system/machinecheck/machinecheckN
-(N = CPU number)
+(N = CPU number).
 
 The directory contains some configurable entries:
 
-Entries:
-
 bankNctl
-(N bank number)
+	(N bank number)
 	64bit Hex bitmask enabling/disabling specific subevents for bank N
 	When a bit in the bitmask is zero then the respective
 	subevent will not be reported.
-- 
2.20.1

