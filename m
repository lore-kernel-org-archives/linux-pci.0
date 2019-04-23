Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B83C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACD4218B0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC1WPwmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfDWQin (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43450 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfDWQim (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so7783943plp.10;
        Tue, 23 Apr 2019 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9skjzp96cygvVz+1JSKV6lvwc3vgk2hHizbPglWd7s=;
        b=HC1WPwmIlG+hlyxRIZOH4CnRvVGwgWVa8brKz231nxL34WdA7oIv1fV5i09oVTPQZf
         HGb7skRKqQOEDwz7Nvih8QFEy8wtKy8dT/lu8CJ+eSB/mCx/vsNdhZQ2eHhSD6QHo2YG
         TuxotwAoJX08deAs0U38LEGdW6TiWo/Jj7iSaEcRvY0nmp38CIEY4/H5B890tE45wqyF
         HsZfKjucwW1hqfafZ6YstpPJ0y6Xkfaf/2btpDk3ncRlqLjR57n6TQR8GhbrVGm1cAKR
         +jB4LseocMLJWC88f3+dQQ1dTw4PG93BGi+/ScqkZy+AW2l/SYsh6i6jGWQXmL68+cHS
         nokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9skjzp96cygvVz+1JSKV6lvwc3vgk2hHizbPglWd7s=;
        b=ZntfUqjY5ovX0HBYhkkHjGONwIKqFLp/6CK/48mPsBMVEijUbw98cFpKCEDvbQFcsP
         EJZG2BcCY+5NyWM4mB/D3ROgWYXmbw+ITik0l4dAJKrlzKIQ6bwhanxUqaLspbbwH3N8
         eo55gC9mRziK232IUYLn6o0riqNcgmsv5LSsN0Jqnk0rA0LJ91U8luJjY4NQHS16rXJG
         0Lyg822tj4gN+1Y5BwUdVL3FhjZvAscIGY4Xr4/c6gfoHs34qO7vV9ROgcy0D7jdczRG
         8CuchkriIBhraGGBn66Ro4+kWns68yekYDaxs5zBkicjxSki+eP4Rd1X5atX1XQ4MeRI
         zrHA==
X-Gm-Message-State: APjAAAXZYRQU2RUbTElcSJgUTRbB+2ridZ3VUtETT+wu3Jt6c8URR5UA
        STEz+t95C0nH9vievEsf3sU=
X-Google-Smtp-Source: APXvYqxW4QBYEj4LOBC2F/7Xh+EtfVt86Gw4890OAPE41pEAwNvEos7lM78G5yOaeekXq29BA133cQ==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr26582784plt.59.1556037521465;
        Tue, 23 Apr 2019 09:38:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 55/63] Documentation: x86: convert usb-legacy-support.txt to reST
Date:   Wed, 24 Apr 2019 00:29:24 +0800
Message-Id: <20190423162932.21428-56-changbin.du@gmail.com>
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
 Documentation/x86/index.rst                               | 1 +
 .../{usb-legacy-support.txt => usb-legacy-support.rst}    | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c41c17906b6d..526f7a008b8e 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -25,3 +25,4 @@ Linux x86 Support
    pti
    microcode
    resctrl_ui
+   usb-legacy-support
diff --git a/Documentation/x86/usb-legacy-support.txt b/Documentation/x86/usb-legacy-support.rst
similarity index 92%
rename from Documentation/x86/usb-legacy-support.txt
rename to Documentation/x86/usb-legacy-support.rst
index 1894cdfc69d9..19abead7f1a8 100644
--- a/Documentation/x86/usb-legacy-support.txt
+++ b/Documentation/x86/usb-legacy-support.rst
@@ -1,7 +1,11 @@
+
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
 USB Legacy support
-~~~~~~~~~~~~~~~~~~
+==================
 
-Vojtech Pavlik <vojtech@suse.cz>, January 2004
+:Author: Vojtech Pavlik <vojtech@suse.cz>, January 2004
 
 
 Also known as "USB Keyboard" or "USB Mouse support" in the BIOS Setup is a
-- 
2.20.1

