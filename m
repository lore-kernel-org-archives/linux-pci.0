Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDFBC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F98E218C3
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA1XgoCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfDWQcH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:32:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43972 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfDWQcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:32:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so7775562plp.10;
        Tue, 23 Apr 2019 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8igPQQHrzrEs/9s/PKFdKcGM+LWdva05Fr6Vq8bcYY=;
        b=FA1XgoCeWkH8trVeNgE8rElFPeWZzznVNhCX+awUX+siMxQrFF0InuvJjhKs6z9EUj
         n2EU432SrLYnUdRd5TZmN7+weutI4heRTBpUjl6TAEJ6iQIg3ZeGfYiTkteYjr42Ue4p
         bU1EOm0O3azbvsA5SRVBDHu5NSf7miuutUdlKBdwbwlesVntVRHwmNMu0l4fqbH6a317
         IdyoXqEdUou6cULQNbXWsEcb1xn9XF1NGumnsDzFZlLVjDgQUBivUqQUCaiQUK9FGkmT
         TRFFnaHtKT0x1vzWvAR9CkbQFZcPRaLwgLga3+97/a20TvjVqVi/uEx5LkxsrIFxm2C9
         +Axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8igPQQHrzrEs/9s/PKFdKcGM+LWdva05Fr6Vq8bcYY=;
        b=D2R98pMkR6CFXWyHx4CsQ7Iczlw88S8AXMAq/6vjrg7Uf8tkMt9DN1ZKgwkYmDoYDI
         0m7DDTrOzF5TjFJSV05Rr6WBKc94bQGmp+YVvjaRLWebDjfGUC7+lnLd8nakLXiNvN6W
         vYDCvCSkvVlLxb4D7NbwkaktkGgLiucE72iWDrSQOmGtF4jr7cPQfAhpoBhPqnKKux+H
         4RwW9DllwcTEN9dkjuvOOOqvRpgHrh3JnHuxAJVRz3qAhI1iom+qg7gffbDW4eqhYh7/
         cttflpV17jQ86nZ9ZO1KCraJC8gTwd5IN/nTwCUC4XFXTJfIgPQZWo4SSH3ah1viIhj6
         mfQw==
X-Gm-Message-State: APjAAAUABxOGNtdAVS8usy23TzGJHGFaJZTE3SkcytSCUyPkrE9erSJb
        9UEdJIjNFcgyvh44v5gpVi4=
X-Google-Smtp-Source: APXvYqyMv/fotyxDCvscY/sZBwwHNhfPXDK4fPqHVMbNnK3jOM609aD+PiDcNjC3op/R8i0LcUZmbw==
X-Received: by 2002:a17:902:b10c:: with SMTP id q12mr27690400plr.254.1556037124712;
        Tue, 23 Apr 2019 09:32:04 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:32:04 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 11/63] Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:40 +0800
Message-Id: <20190423162932.21428-12-changbin.du@gmail.com>
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
 .../acpi/dsdt-override.rst}                               | 8 +++++++-
 Documentation/admin-guide/acpi/index.rst                  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)

diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/admin-guide/acpi/dsdt-override.rst
similarity index 56%
rename from Documentation/acpi/dsdt-override.txt
rename to Documentation/admin-guide/acpi/dsdt-override.rst
index 784841caa6e6..50bd7f194bf4 100644
--- a/Documentation/acpi/dsdt-override.txt
+++ b/Documentation/admin-guide/acpi/dsdt-override.rst
@@ -1,6 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Overriding DSDT
+===============
+
 Linux supports a method of overriding the BIOS DSDT:
 
-CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
+CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
 
 When to use this method is described in detail on the
 Linux/ACPI home page:
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 09e4e81e4fb7..d68e9914c5ff 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -9,3 +9,4 @@ the Linux ACPI support.
    :maxdepth: 1
 
    initrd_table_override
+   dsdt-override
-- 
2.20.1

