Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E4C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F072183E
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROeiph+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfDWQcS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:32:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39609 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfDWQcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:32:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so6000716plb.6;
        Tue, 23 Apr 2019 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S70C++BhYe3LidhJGoAnqu6I0VuKIAPGUTVEYVjwoHM=;
        b=ROeiph+56zr6OCltGO24rxEzduP6Ynoe/Tizw3pWksnoaFPJPIqya9kOMnOrC8W175
         F7WVjkj67da+uo9gCYAODARDlSnsj/qs5U8Rl7SrttwvQtoNIH0IB/66yx8iAuo/0moR
         FLzV/2FNeNWE4XEyWeF8gy1yX3GQPMDKJAbjH3nqI0fBVoPD2eDpQzHfV0quCjPYCaPz
         SSbQDSS+7WPvtoE6F7RGWBTWBL4W44Be6KUiT1p19UCzmol6UkUaUI6u8A6QC3DIgrdB
         Um6UbyfiW4J/xb7WBEIWSszTE2HbVEQ2kWB/zQjVC6MLK3YKCHdCRuitMlqcHSwAoyzp
         k2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S70C++BhYe3LidhJGoAnqu6I0VuKIAPGUTVEYVjwoHM=;
        b=fQwh3msUbTIzVcT+rh8kIYM9z0S7GwrnqoE3rYme6JYmF7etUclRgiPGrej6kb0PCA
         P15X+tqPARZFkvxvEgJe+/bn6Pwd79QPMmrLW1tIkvOGUt3JPrSSgZVm2g+mxmFrkupY
         FVKl+8F0+VnYCD6nRA5v7x2KUZo3TMcjJvPibY2pZC5ZjQ1yLcWIoNvxIvCIhQcXATau
         +rjwsQ56XW5gRaBnCcA5VUpVMaC0le6pwnbIGrfApgeqeB7X/vTSKtR4uH5kuniXXBtL
         V4fZsqyNRQNMwbaKMcIuc6Tn93akelDdcVoXlUArgkSgWg2HD9FStJrXji2whQRgZ+TD
         eQug==
X-Gm-Message-State: APjAAAVyTUGpZj4uLuSsfzkaWGnLvqLFYahvRlxCSn/XtzgFgwvk3jTQ
        Sc0WWnJrLKOVploL3V9O6bw=
X-Google-Smtp-Source: APXvYqwn1rodjYqifxX2JhfX2TAP5ehvlN7pDi56oVyQ7ZX5Wq0zOQ8WaH3TMxKnESYlo3TwGZFh2g==
X-Received: by 2002:a17:902:b20f:: with SMTP id t15mr9214223plr.341.1556037133050;
        Tue, 23 Apr 2019 09:32:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:32:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 12/63] Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:41 +0800
Message-Id: <20190423162932.21428-13-changbin.du@gmail.com>
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
 Documentation/acpi/i2c-muxes.txt              | 58 ------------------
 .../firmware-guide/acpi/i2c-muxes.rst         | 61 +++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 3 files changed, 63 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst

diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
deleted file mode 100644
index 9fcc4f0b885e..000000000000
--- a/Documentation/acpi/i2c-muxes.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-ACPI I2C Muxes
---------------
-
-Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
-Device () scope per mux channel.
-
-Consider this topology:
-
-+------+   +------+
-| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
-|      |   | 0x70 |--CH01--> i2c client B (0x50)
-+------+   +------+
-
-which corresponds to the following ASL:
-
-Device (SMB1)
-{
-    Name (_HID, ...)
-    Device (MUX0)
-    {
-        Name (_HID, ...)
-        Name (_CRS, ResourceTemplate () {
-            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                          AddressingMode7Bit, "^SMB1", 0x00,
-                          ResourceConsumer,,)
-        }
-
-        Device (CH00)
-        {
-            Name (_ADR, 0)
-
-            Device (CLIA)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH00", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-
-        Device (CH01)
-        {
-            Name (_ADR, 1)
-
-            Device (CLIB)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH01", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-    }
-}
diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
new file mode 100644
index 000000000000..3a8997ccd7c4
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+ACPI I2C Muxes
+==============
+
+Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
+Device () scope per mux channel.
+
+Consider this topology::
+
+    +------+   +------+
+    | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
+    |      |   | 0x70 |--CH01--> i2c client B (0x50)
+    +------+   +------+
+
+which corresponds to the following ASL::
+
+    Device (SMB1)
+    {
+        Name (_HID, ...)
+        Device (MUX0)
+        {
+            Name (_HID, ...)
+            Name (_CRS, ResourceTemplate () {
+                I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
+                            AddressingMode7Bit, "^SMB1", 0x00,
+                            ResourceConsumer,,)
+            }
+
+            Device (CH00)
+            {
+                Name (_ADR, 0)
+
+                Device (CLIA)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+
+            Device (CH01)
+            {
+                Name (_ADR, 1)
+
+                Device (CLIB)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+        }
+    }
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index d1d069b26bbc..1c89888f6ee8 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -12,4 +12,5 @@ ACPI Support
    osi
    method-customizing
    DSD-properties-rules
-   gpio-properties
\ No newline at end of file
+   gpio-properties
+   i2c-muxes
-- 
2.20.1

