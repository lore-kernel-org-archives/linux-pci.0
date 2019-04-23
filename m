Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCC9C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E121121773
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsCwwjDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfDWQa6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:30:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43892 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfDWQa6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:30:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so7774195plp.10;
        Tue, 23 Apr 2019 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpgKz65tnvrvCC0pB/gLUr3SLlay4vQrqcACci7Mjag=;
        b=FsCwwjDOS13uczkYHr8q+k54kXRaMFjtsB6Y9cCG4xVMZyJX7U3Vzjhmizdic/L7GR
         qzDoWVzz8oz+OL0+IKeX+U/qlF/n5fS9NRWGXnMAoIceKd20H6BvlXZSXdi9ITWrHJQv
         mfO8SYrGmAfn/mRhYgq7gDsPX0DIBH5r4hqpiek0kbNM5dfIf0kURfdJsMyKs24EcEO/
         M259lF6PAfo1Gnv2XEy5KZW0E5/MMKk5KNoWsq7h7cr4cy6Eq44jKZPkCZCHDFzHryfQ
         o6u6TtiqGP+SFttfB2EfBX1HG7MtadVH1sSlPY4mFe4+aNHI343KdzzdkBaI2p5NRtC4
         sF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpgKz65tnvrvCC0pB/gLUr3SLlay4vQrqcACci7Mjag=;
        b=e21yJZJ9JOxfYJ9YkdWeX5ByyIMi7BAqbp458HyZZK58C8Szm3sYj3P3PyLu5HfBgA
         qF1i4FD+4UNQD2VZ6priNTcp8Uf7zMXlCuLE+Cn1KAh4VFC5oG2OiRJ6MNaHIcSlHbNK
         TZmo+Jm24D+2w38cNhnOvMFE09b5A8jKkklJTEui/OHTboZAzoIeOkpwT17w1O2xdE0g
         8MENcm9fZExnfzHBLsy9ETvaNVGgW9fr/fse9U/13XU8j9253JbbDLrBjoWqVmTgyOJW
         g9K5DzUXvT8XWwV1HITl7HpN/rBS5wHi9B80922dA1nqaeeNkI15aN/A/6bUn5n6SIMM
         FUJQ==
X-Gm-Message-State: APjAAAWwro+Ped4ybANqul4bXUxoEIu0IGQQEA4Xy1hJE0aEY6Wixalt
        2vTBnoBeQ0fv2ZQ1fAW8a4c=
X-Google-Smtp-Source: APXvYqxgZcMw50wq7kSvu4ZdtxkeQXfjcgqKPAKY+rBTcispmYC66UrPxhCrk0Pqd0dOrqaRQbOpaQ==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr17741244plp.223.1556037057322;
        Tue, 23 Apr 2019 09:30:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:30:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 04/63] Documentation: ACPI: move osi.txt to firmware-guide/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:33 +0800
Message-Id: <20190423162932.21428-5-changbin.du@gmail.com>
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
 Documentation/firmware-guide/acpi/index.rst       |  1 +
 .../{acpi/osi.txt => firmware-guide/acpi/osi.rst} | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 99677c73f1fb..868bd25a3398 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -9,3 +9,4 @@ ACPI Support
 
    namespace
    enumeration
+   osi
diff --git a/Documentation/acpi/osi.txt b/Documentation/firmware-guide/acpi/osi.rst
similarity index 97%
rename from Documentation/acpi/osi.txt
rename to Documentation/firmware-guide/acpi/osi.rst
index 50cde0ceb9b0..29e9ef79ebc0 100644
--- a/Documentation/acpi/osi.txt
+++ b/Documentation/firmware-guide/acpi/osi.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
 ACPI _OSI and _REV methods
---------------------------
+==========================
 
 An ACPI BIOS can use the "Operating System Interfaces" method (_OSI)
 to find out what the operating system supports. Eg. If BIOS
@@ -14,7 +17,7 @@ This document explains how and why the BIOS and Linux should use these methods.
 It also explains how and why they are widely misused.
 
 How to use _OSI
----------------
+===============
 
 Linux runs on two groups of machines -- those that are tested by the OEM
 to be compatible with Linux, and those that were never tested with Linux,
@@ -62,7 +65,7 @@ the string when that support is added to the kernel.
 That was easy.  Read on, to find out how to do it wrong.
 
 Before _OSI, there was _OS
---------------------------
+==========================
 
 ACPI 1.0 specified "_OS" as an
 "object that evaluates to a string that identifies the operating system."
@@ -96,7 +99,7 @@ That is the *only* viable strategy, as that is what modern Windows does,
 and so doing otherwise could steer the BIOS down an untested path.
 
 _OSI is born, and immediately misused
---------------------------------------
+=====================================
 
 With _OSI, the *BIOS* provides the string describing an interface,
 and asks the OS: "YES/NO, are you compatible with this interface?"
@@ -144,7 +147,7 @@ catastrophic failure resulting from the BIOS taking paths that
 were never validated under *any* OS.
 
 Do not use _REV
----------------
+===============
 
 Since _OSI("Linux") went away, some BIOS writers used _REV
 to support Linux and Windows differences in the same BIOS.
@@ -164,7 +167,7 @@ from mid-2015 onward.  The ACPI specification will also be updated
 to reflect that _REV is deprecated, and always returns 2.
 
 Apple Mac and _OSI("Darwin")
-----------------------------
+============================
 
 On Apple's Mac platforms, the ACPI BIOS invokes _OSI("Darwin")
 to determine if the machine is running Apple OSX.
-- 
2.20.1

