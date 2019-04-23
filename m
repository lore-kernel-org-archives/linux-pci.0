Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5ECC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ED720645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuDeX39f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfDWQiR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37836 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfDWQiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so7809086ply.4;
        Tue, 23 Apr 2019 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk9nZS7LGFvUdGAy8fxGcY6/ybb9v25OpTL3KOWjoH8=;
        b=WuDeX39fX4agIFCWjj2UXkCBdilJHadtSLMPWebq4Rj2dKnTXDHt5SlLFppnzcYLAC
         IkHNgWFVDFCM6f6sjsBx8ibu+xMEAVZpoGFT5IQBWVe4suxYdu8w1079KziAV/6Pqb3t
         YhOttilmfQn7oq1+Mv6OJSscb7S/HL6OkoXbSbUpW2cqTjYEcpdXeP+4tyG6F02sE218
         SvYtBt4/x+9oA4EYl80+mohhEypZ3F/AZxj2R1e8kDRDGXBykEawe/OMqrGR0n9ffQua
         IcCBGLqzCUNI6XWPuUtXgBlLgX+BdRkPPordmbYhbf+OQqOZ32e265qxgnK8Mq8dlJiW
         pbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk9nZS7LGFvUdGAy8fxGcY6/ybb9v25OpTL3KOWjoH8=;
        b=Sq4r/d+tsnwTNH6+Dh+xYs1C/fnerf61rgusEctHxaJHaIuNIb7gjzNiXt+cBk4jeS
         RUX89hIVC1Ta7B6SJEJ/4L8BkKvSORt0sv4n1LGoiJE1EbCNculU8WYzLCiNBXVJHZlR
         utgV5+niygINQ24ZMFrjP0+dgeObJ4Ujtico5k2GfQwHPW2l5pxMwzk1m93ZQll6636B
         YHFbjgMYGjTWwAOUrdCtqVlErd6SSvcXKT//yU11KKQAnxCLf/HCMY7mRo1YZl3Jj75d
         nQgAm/BRqoSJm/fkFsOJkLag9d/E8KkC5D6fhCg5DUcihWpU7MUya2DkjHVeLyJcFHP6
         NJTA==
X-Gm-Message-State: APjAAAX7vGV3R2BmOrOnmVmfJXaVg0isNw6USKxCpslu7X5Id/r0UwQF
        Q9adT68BN22KsDD2TzHB2Mo=
X-Google-Smtp-Source: APXvYqw1PBt2NhuOso4l/c8zot051+AWjvFK/viNfPGzVPsV033yeEPBb8FPDNcm0y9d3R/Xkb9RdA==
X-Received: by 2002:a17:902:c1:: with SMTP id a59mr26257460pla.176.1556037495088;
        Tue, 23 Apr 2019 09:38:15 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:14 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 50/63] Documentation: x86: convert amd-memory-encryption.txt to reST
Date:   Wed, 24 Apr 2019 00:29:19 +0800
Message-Id: <20190423162932.21428-51-changbin.du@gmail.com>
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
 ...ory-encryption.txt => amd-memory-encryption.rst} | 13 ++++++++++---
 Documentation/x86/index.rst                         |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)

diff --git a/Documentation/x86/amd-memory-encryption.txt b/Documentation/x86/amd-memory-encryption.rst
similarity index 94%
rename from Documentation/x86/amd-memory-encryption.txt
rename to Documentation/x86/amd-memory-encryption.rst
index afc41f544dab..c48d452d0718 100644
--- a/Documentation/x86/amd-memory-encryption.txt
+++ b/Documentation/x86/amd-memory-encryption.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+AMD Memory Encryption
+=====================
+
 Secure Memory Encryption (SME) and Secure Encrypted Virtualization (SEV) are
 features found on AMD processors.
 
@@ -34,7 +40,7 @@ is operating in 64-bit or 32-bit PAE mode, in all other modes the SEV hardware
 forces the memory encryption bit to 1.
 
 Support for SME and SEV can be determined through the CPUID instruction. The
-CPUID function 0x8000001f reports information related to SME:
+CPUID function 0x8000001f reports information related to SME::
 
 	0x8000001f[eax]:
 		Bit[0] indicates support for SME
@@ -48,14 +54,14 @@ CPUID function 0x8000001f reports information related to SME:
 			   addresses)
 
 If support for SME is present, MSR 0xc00100010 (MSR_K8_SYSCFG) can be used to
-determine if SME is enabled and/or to enable memory encryption:
+determine if SME is enabled and/or to enable memory encryption::
 
 	0xc0010010:
 		Bit[23]   0 = memory encryption features are disabled
 			  1 = memory encryption features are enabled
 
 If SEV is supported, MSR 0xc0010131 (MSR_AMD64_SEV) can be used to determine if
-SEV is active:
+SEV is active::
 
 	0xc0010131:
 		Bit[0]	  0 = memory encryption is not active
@@ -68,6 +74,7 @@ requirements for the system.  If this bit is not set upon Linux startup then
 Linux itself will not set it and memory encryption will not be possible.
 
 The state of SME in the Linux kernel can be documented as follows:
+
 	- Supported:
 	  The CPU supports SME (determined through CPUID instruction).
 
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 20091d3e5d97..a0426ab156bd 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -20,3 +20,4 @@ Linux x86 Support
    pat
    protection-keys
    intel_mpx
+   amd-memory-encryption
-- 
2.20.1

