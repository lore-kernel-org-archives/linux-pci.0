Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE02FC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E71B20643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyOLGRqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfDWQeN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:34:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35448 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfDWQeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:34:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so7798149plp.2;
        Tue, 23 Apr 2019 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Nheobiyx/Oj/jQbmMwyJ6CcDMSw+Li7Rz9pOwmVplA=;
        b=kyOLGRqjNToGUUVIJgXkQ9lBpwbwr1Z1OzphUd1XAu+vOZuKnt1W/4VlyoUrTQ9N7t
         L2ENzC+d1HpFxuYP/B6zEfQo85LOE0Evi2EhRiC49Xo1nFzfjtTyBftNOiGiU+etwXgZ
         csgN8HUpRWRy/EMElFkMAY6brHk5mksmXYgRzW7hQyYZ5fq8t1Xxl2RpfCXlOY9j1/Xo
         vEKU1p10GeCdlbTvpoox/SRCOKCCYHWg2cSQrPo1vv0uvsDMQqRM5HLTqqHOBUh2AtbX
         0803BNwJ6q+YJXJA1wJr9z/fnHHv6vHpFWmVa6U2B+pqa4cGonsDsUGQn8JR+3C1d7be
         0k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Nheobiyx/Oj/jQbmMwyJ6CcDMSw+Li7Rz9pOwmVplA=;
        b=APtaQNPJdIqSG6aBmcoXOcYwNEUPQZykVh2DL+zxYc0KnDmXZjYThS8txEn5qGG7LF
         ShQ/mlOjYWX1gGvh1laRNCU53dc6/56YduVud2zaqLz5TIQLIk9rOx3NldABGT3g5wk3
         Bi+UXpBNGISuohFcPCr7bi0x21TxuAwW8Bd0OBbczWObYsoiIuT6xebIJmC5VL5xzIcG
         EIe0JBmLxvYLIQzimmpTGmJ6pX0vBLylJ7BfstPDkPGJFMsDZnW3cq78fS+hACc5t+e9
         S3w0TjFtlbw2XytHosUloRjEmRWhAG1jGi2OWnVLh6fePHbQ9sOn4uQZ3lYZGxa9yUIs
         u5tQ==
X-Gm-Message-State: APjAAAW/FYNsUCM1MRk4GoyRZUlpiyC3xV9E/byxPb0Z3rIp0quOOlvq
        hQzL7EBLeZmh11cWkB5R6vg=
X-Google-Smtp-Source: APXvYqwpcNA1C0AJaAn5NpKA27BO1ryqGyrsfgPDIO7XslflQRQX3HrhW/xaqo85d7Ncuz1mUxzc/g==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr26560917plt.59.1556037251789;
        Tue, 23 Apr 2019 09:34:11 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:34:10 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 24/63] Documentation: ACPI: move video_extension.txt to firmware-guide/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:53 +0800
Message-Id: <20190423162932.21428-25-changbin.du@gmail.com>
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
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 .../acpi/video_extension.rst}                 | 63 ++++++++++---------
 2 files changed, 36 insertions(+), 28 deletions(-)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (79%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 0e60f4b7129a..ae609eec4679 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -23,3 +23,4 @@ ACPI Support
    i2c-muxes
    acpi-lid
    lpit
+   video_extension
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/firmware-guide/acpi/video_extension.rst
similarity index 79%
rename from Documentation/acpi/video_extension.txt
rename to Documentation/firmware-guide/acpi/video_extension.rst
index 79bf6a4921be..06f7e3230b6e 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/firmware-guide/acpi/video_extension.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
 ACPI video extensions
-~~~~~~~~~~~~~~~~~~~~~
+=====================
 
 This driver implement the ACPI Extensions For Display Adapters for
 integrated graphics devices on motherboard, as specified in ACPI 2.0
@@ -8,9 +11,10 @@ defining the video POST device, retrieving EDID information or to
 setup a video output, etc.  Note that this is an ref. implementation
 only.  It may or may not work for your integrated video device.
 
-The ACPI video driver does 3 things regarding backlight control:
+The ACPI video driver does 3 things regarding backlight control.
 
-1 Export a sysfs interface for user space to control backlight level
+1. Export a sysfs interface for user space to control backlight level
+=====================================================================
 
 If the ACPI table has a video device, and acpi_backlight=vendor kernel
 command line is not present, the driver will register a backlight device
@@ -32,26 +36,26 @@ type: firmware
 
 Note that ACPI video backlight driver will always use index for
 brightness, actual_brightness and max_brightness. So if we have
-the following _BCL package:
+the following _BCL package::
 
-Method (_BCL, 0, NotSerialized)
-{
-	Return (Package (0x0C)
+	Method (_BCL, 0, NotSerialized)
 	{
-		0x64,
-		0x32,
-		0x0A,
-		0x14,
-		0x1E,
-		0x28,
-		0x32,
-		0x3C,
-		0x46,
-		0x50,
-		0x5A,
-		0x64
-	})
-}
+		Return (Package (0x0C)
+		{
+			0x64,
+			0x32,
+			0x0A,
+			0x14,
+			0x1E,
+			0x28,
+			0x32,
+			0x3C,
+			0x46,
+			0x50,
+			0x5A,
+			0x64
+		})
+	}
 
 The first two levels are for when laptop are on AC or on battery and are
 not used by Linux currently. The remaining 10 levels are supported levels
@@ -62,13 +66,15 @@ as a "brightness level" indicator. Thus from the user space perspective
 the range of available brightness levels is from 0 to 9 (max_brightness)
 inclusive.
 
-2 Notify user space about hotkey event
+2. Notify user space about hotkey event
+=======================================
 
 There are generally two cases for hotkey event reporting:
+
 i) For some laptops, when user presses the hotkey, a scancode will be
    generated and sent to user space through the input device created by
    the keyboard driver as a key type input event, with proper remap, the
-   following key code will appear to user space:
+   following key code will appear to user space::
 
 	EV_KEY, KEY_BRIGHTNESSUP
 	EV_KEY, KEY_BRIGHTNESSDOWN
@@ -82,7 +88,7 @@ ii) For some laptops, the press of the hotkey will not generate the
     about the event. The event value is defined in the ACPI spec. ACPI
     video driver will generate an key type input event according to the
     notify value it received and send the event to user space through the
-    input device it created:
+    input device it created::
 
 	event		keycode
 	0x86		KEY_BRIGHTNESSUP
@@ -94,13 +100,14 @@ so this would lead to the same effect as case i) now.
 Once user space tool receives this event, it can modify the backlight
 level through the sysfs interface.
 
-3 Change backlight level in the kernel
+3. Change backlight level in the kernel
+=======================================
 
 This works for machines covered by case ii) in Section 2. Once the driver
 received a notification, it will set the backlight level accordingly. This does
 not affect the sending of event to user space, they are always sent to user
 space regardless of whether or not the video module controls the backlight level
 directly. This behaviour can be controlled through the brightness_switch_enabled
-module parameter as documented in admin-guide/kernel-parameters.rst. It is recommended to
-disable this behaviour once a GUI environment starts up and wants to have full
-control of the backlight level.
+module parameter as documented in admin-guide/kernel-parameters.rst. It is
+recommended to disable this behaviour once a GUI environment starts up and
+wants to have full control of the backlight level.
-- 
2.20.1

