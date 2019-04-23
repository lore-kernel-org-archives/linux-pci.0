Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80104C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9BE217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM3hq3uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfDWQdz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:33:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35164 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfDWQdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:33:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so7886566pgf.2;
        Tue, 23 Apr 2019 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xTrnLrO59umJmSOvr4epn2M5miwC5OKlGYVuirCoC0=;
        b=IM3hq3uOs4nXIMqaVCPkR+wmGVqnUYUAe2kfzxLiWVFI16Po9dzRGA2HEL3HTkFS0Y
         yIRE1YfFsBZWwKLtF7pxM2H6HTLfiI0ecsylitlE0QrTK0PBvM1CSbxFDnOM+JvHatdf
         SV28RxH4G2Z5bsYXMGcsUAbc1qqgAXv3yZdORTxV4D7NP97bqoQed6Qxa/UqCR2ZMR2z
         0irvdt100pc8mJM//h6u3lDSti3tCpE7DKg9Kyt6yiWkAqvOQpAVP9/ak2hcHY7RB9YV
         MOplj8bdzATistWqkFYsXOssi0OqMMCXspkn+JIXz2agpujc4ykwxK0apEBNF4k1xB9W
         m0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xTrnLrO59umJmSOvr4epn2M5miwC5OKlGYVuirCoC0=;
        b=Pcg9C4qsyOqL20EsFGBMqRzJaN+uG1362z9tStD8xgVLHrV99w2xJ7yhVlD+jupYru
         vaR3ZoyZS3wxSITbbkcNez0KehePtLpZTAojV/Hp2ec0n31vkvVKERnmMijFciilIhP9
         p5b4SmVUpJRIC4+fbAPT+0H4OWoVSnqI2SSZFEz6Eyosy7DQxlrFTVfk8OBFqoONST5/
         PLbhJVwQDuS2k39aSMo5qckcVjs9mFjXBZrLxKvi1Mz6Ry+Gu/ry/z54OIKvUFNo6Hyi
         ZDl2mzqqEx8mTNQoSxsDZ4LypbTLzGMSPCu7gafcOgBQ/eWiM3hnL9SPOTJaKllR4qZW
         j45Q==
X-Gm-Message-State: APjAAAWfos4yVJQZkZ+OQdvUTA9wF+OeIMA9TSMIhVQgxIRSfKcudlfZ
        1k3WZWSuBHzUnqF6Rkm+d2E=
X-Google-Smtp-Source: APXvYqzCN4JlnPcIBBixsCPKXX8eA6Ikw06oVo5Ar9KruZby+Z0pOXPDt6n8BU3DR0OKk9a/I0AbTA==
X-Received: by 2002:a65:6202:: with SMTP id d2mr25646108pgv.176.1556037233885;
        Tue, 23 Apr 2019 09:33:53 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:33:53 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 22/63] Documentation: ACPI: move lpit.txt to firmware-guide/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:51 +0800
Message-Id: <20190423162932.21428-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
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
---
 Documentation/firmware-guide/acpi/index.rst    |  1 +
 .../lpit.txt => firmware-guide/acpi/lpit.rst}  | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index fca854f017d8..0e60f4b7129a 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -22,3 +22,4 @@ ACPI Support
    gpio-properties
    i2c-muxes
    acpi-lid
+   lpit
diff --git a/Documentation/acpi/lpit.txt b/Documentation/firmware-guide/acpi/lpit.rst
similarity index 68%
rename from Documentation/acpi/lpit.txt
rename to Documentation/firmware-guide/acpi/lpit.rst
index b426398d2e97..aca928fab027 100644
--- a/Documentation/acpi/lpit.txt
+++ b/Documentation/firmware-guide/acpi/lpit.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Low Power Idle Table (LPIT)
+===========================
+
 To enumerate platform Low Power Idle states, Intel platforms are using
 “Low Power Idle Table” (LPIT). More details about this table can be
 downloaded from:
@@ -8,13 +14,15 @@ Residencies for each low power state can be read via FFH
 
 On platforms supporting S0ix sleep states, there can be two types of
 residencies:
-- CPU PKG C10 (Read via FFH interface)
-- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
+
+  - CPU PKG C10 (Read via FFH interface)
+  - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
 
 The following attributes are added dynamically to the cpuidle
-sysfs attribute group:
-	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
-	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
+sysfs attribute group::
+
+  /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
+  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
 
 The "low_power_idle_cpu_residency_us" attribute shows time spent
 by the CPU package in PKG C10
-- 
2.20.1

