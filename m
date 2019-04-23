Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B4C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2833217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjdr5fH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfDWQcx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:32:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38390 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfDWQcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:32:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so7872574pgl.5;
        Tue, 23 Apr 2019 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJA6tiQZwx6yBbKwk/N0i/otgq3I5GG+LtpVFmwuzZc=;
        b=cjdr5fH+7YSVSMwkUOXmIbORo85b04iRON71K7O+cRUTlDLa0dnyHLZsifmOJMiVwu
         s+1JjOtcNw59OrhcVTyiKstEDF8oYAYJUIokfTuSg5NrYtQ90e53eA631xR9lCvEIY3f
         iSlv55SspZmUofCS1Im84NZjNExQuVZ4ZctqpyKGig009AUWNxlMXRr4CKK+2/0Bq8ML
         cCtNWBI3jMzSuIw3Kd7Miystf67KZcbLRaGN3xNwG8CoCbER7AoUL0kPgwOyKBx+zyZ0
         VXqJDHQGHV0jWT0O5I/rFcn7TWEmQwa3tnYUXQ+24XKgOow0rlpR84ut0jOhedEM7dWz
         jI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJA6tiQZwx6yBbKwk/N0i/otgq3I5GG+LtpVFmwuzZc=;
        b=iGQiMr8E/RnuBcU4ernO5O0OrzpcNkA1T5N3e08bbH6d0cJjSUnMe95xQ0sP6y+4qG
         JFONpPx6Z++VfRXKuxIl32Z0CgD9dtZDEiichPw4ZxUJ7T1maEWy5ltRCT+QUvSnJU5a
         ovsux7SFLGBRmh0Y1WZdDhPz51Zd3sKLnxYsb4BQzGgy8i4xmKY+ijlasteIKeGkpExJ
         zXSIqrKWvQ0XIJ93/Zltij3qiq9rpPmyx+Vk9ZNtIMkDlIrLPhM3ywQZRix7O73HnnpI
         CEhIavHfqoQ3yCh9I7wUMKrcOHl4g3yy5Pu2TnR5KQ0fu0u23uf2fkmA/ozyutOxuPSF
         CwNw==
X-Gm-Message-State: APjAAAUN7Du4zu0XJQrIB3rUAW74ZGMcR9BG8cn/UHfbAt2kZpVbD0/l
        0vM7MZtJvFqQE6c2qrlRNeU=
X-Google-Smtp-Source: APXvYqwAmFQW6hQfyB2r9DH+9hqcfOfp0W3uRL72uQBaoDQZiJxLqrbXDLF6ggjJ9/whJV4OtzUqww==
X-Received: by 2002:a63:3287:: with SMTP id y129mr26094054pgy.9.1556037171255;
        Tue, 23 Apr 2019 09:32:51 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:32:50 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 16/63] Documentation: ACPI: move debug.txt to firmware-guide/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:45 +0800
Message-Id: <20190423162932.21428-17-changbin.du@gmail.com>
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
 .../acpi/debug.rst}                           | 31 ++++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 2 files changed, 19 insertions(+), 15 deletions(-)
 rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)

diff --git a/Documentation/acpi/debug.txt b/Documentation/firmware-guide/acpi/debug.rst
similarity index 91%
rename from Documentation/acpi/debug.txt
rename to Documentation/firmware-guide/acpi/debug.rst
index 65bf47c46b6d..1a152dd1d765 100644
--- a/Documentation/acpi/debug.txt
+++ b/Documentation/firmware-guide/acpi/debug.rst
@@ -1,18 +1,21 @@
-			ACPI Debug Output
+.. SPDX-License-Identifier: GPL-2.0
 
+=================
+ACPI Debug Output
+=================
 
 The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
 output.  This document describes how to use this facility.
 
 Compile-time configuration
---------------------------
+==========================
 
 ACPI debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this config
 option is turned off, the debug messages are not even built into the
 kernel.
 
 Boot- and run-time configuration
---------------------------------
+================================
 
 When CONFIG_ACPI_DEBUG=y, you can select the component and level of messages
 you're interested in.  At boot-time, use the acpi.debug_layer and
@@ -21,7 +24,7 @@ debug_layer and debug_level files in /sys/module/acpi/parameters/ to control
 the debug messages.
 
 debug_layer (component)
------------------------
+=======================
 
 The "debug_layer" is a mask that selects components of interest, e.g., a
 specific driver or part of the ACPI interpreter.  To build the debug_layer
@@ -33,7 +36,7 @@ to /sys/module/acpi/parameters/debug_layer.
 
 The possible components are defined in include/acpi/acoutput.h and
 include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
-shows the supported mask values, currently these:
+shows the supported mask values, currently these::
 
     ACPI_UTILITIES                  0x00000001
     ACPI_HARDWARE                   0x00000002
@@ -65,7 +68,7 @@ shows the supported mask values, currently these:
     ACPI_PROCESSOR_COMPONENT        0x20000000
 
 debug_level
------------
+===========
 
 The "debug_level" is a mask that selects different types of messages, e.g.,
 those related to initialization, method execution, informational messages, etc.
@@ -81,7 +84,7 @@ to /sys/module/acpi/parameters/debug_level.
 
 The possible levels are defined in include/acpi/acoutput.h.  Reading
 /sys/module/acpi/parameters/debug_level shows the supported mask values,
-currently these:
+currently these::
 
     ACPI_LV_INIT                    0x00000001
     ACPI_LV_DEBUG_OBJECT            0x00000002
@@ -113,9 +116,9 @@ currently these:
     ACPI_LV_EVENTS                  0x80000000
 
 Examples
---------
+========
 
-For example, drivers/acpi/bus.c contains this:
+For example, drivers/acpi/bus.c contains this::
 
     #define _COMPONENT              ACPI_BUS_COMPONENT
     ...
@@ -127,22 +130,22 @@ statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
 definition.)
 
 Enable all AML "Debug" output (stores to the Debug object while interpreting
-AML) during boot:
+AML) during boot::
 
     acpi.debug_layer=0xffffffff acpi.debug_level=0x2
 
-Enable PCI and PCI interrupt routing debug messages:
+Enable PCI and PCI interrupt routing debug messages::
 
     acpi.debug_layer=0x400000 acpi.debug_level=0x4
 
-Enable all ACPI hardware-related messages:
+Enable all ACPI hardware-related messages::
 
     acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
 
-Enable all ACPI_DB_INFO messages after boot:
+Enable all ACPI_DB_INFO messages after boot::
 
     # echo 0x4 > /sys/module/acpi/parameters/debug_level
 
-Show all valid component values:
+Show all valid component values::
 
     # cat /sys/module/acpi/parameters/debug_layer
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 6d4e0df4f063..a45fea11f998 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -14,6 +14,7 @@ ACPI Support
    osi
    method-customizing
    DSD-properties-rules
+   debug
    gpio-properties
    i2c-muxes
-   acpi-lid
\ No newline at end of file
+   acpi-lid
-- 
2.20.1

