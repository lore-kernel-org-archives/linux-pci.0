Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C758BC4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931E4206DF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHJTvjSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDCPum (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39210 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCPuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 11:50:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id b65so8240838plb.6;
        Wed, 03 Apr 2019 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36cEZmnmtOkaov721mtn2QbmycBaC73t9mbRPPBnUkY=;
        b=sHJTvjSqBg+v1+azbXNwUk6TDnLAYo8GAl2XGm9s7bb23TroJ1APucHCWDbAA7dP4C
         6SjTwCd19xyvD8R1KhyqjyxaL8NpvPM36Ove12ei1ZlpV69Zbqypz5tZ8KbQG+9T2nx5
         ptr9V++iyNIY/3skt+yH46AWzvmw+gNgn3LFD23aieM8JTI9UyVib3zb9NHFLHI3uWUV
         mcXQY4bnQ5wOMqD+EUyGLFjr66hdA9afRyU7qwImetWMLS0VYyhXvl44L4wnLy9at+QJ
         zjk5olY1bPavEgPeojSxhLrUbJgWbTAelhCw09q0NoN8GuoWMIuaqjCejdZ7a5ZjgI9e
         qmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36cEZmnmtOkaov721mtn2QbmycBaC73t9mbRPPBnUkY=;
        b=dC0HIbbHKGdBpfNbkrUWPqWXodpqCobeQDWN5aOvDQs4rhj4sb29w4yxGUPE08CpBU
         z3Tz5/jYYivY2UQ+Alj8rEraXvbuqbMoNaCBTJn0crK3gsklOPwms8ApCFEVtkU6d+/G
         YlUhOpRsnahUcWipPDvJxCIzIQjqVAjnT9qPXewbwgVRJ/SbcGV2F6JMlT7CysskpAHl
         H7LNjnsh2qbXcN9cozgaJRQGdRlVxvd8TiV09PT8wljlGGrz81lUzmukKrDtLEeuhg9q
         Og9rXlslGMb6QQ1MHFXhgwNLkZ0E65t15VNqZDr5F8xWqIVRh+AfJ5Xd94/PlMj0hPg0
         CXNA==
X-Gm-Message-State: APjAAAXtRRobqwbsoWwqdSeEQGb05TdRV2C/RAIod3R7y6vO23fXfiFv
        PVg7GjaQS1Pz81R+TrSHrgc=
X-Google-Smtp-Source: APXvYqyAStD6CSpcteHW8x+HstM8EsfeR6cZIRTyhl0qtTDYnCgGOavcGcRftjTDh/Gy8aQ1+3HeWw==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr671252pla.19.1554306638410;
        Wed, 03 Apr 2019 08:50:38 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b8sm18906922pgq.33.2019.04.03.08.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:50:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 06/12] Documentation: PCI: convert PCI/acpi-info.txt to reST format
Date:   Wed,  3 Apr 2019 23:49:49 +0800
Message-Id: <20190403154955.12096-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403154955.12096-1-changbin.du@gmail.com>
References: <20190403154955.12096-1-changbin.du@gmail.com>
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

