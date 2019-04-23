Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9771C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0021773
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3W2yuDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfDWQbI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:31:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39554 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfDWQbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:31:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so7756698pfo.6;
        Tue, 23 Apr 2019 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdLelaXabUTskOyM5jBlptNNQEyo5U0PY94WF2JNz94=;
        b=o3W2yuDfUVPHC9Q4404vLJ5TZXyLVM7U2ZN8jA+rcARlAAbZgv0ZgWfnh2cBGGLvX0
         Z625qvNjE4HDGwBWSg++yC7k0eBG6I9ed/QgM/hw4FL2tjISaiEpuBrKUYpELZ/+umwD
         21seVLOrZ+BNw9C1cAXc6sEVH1D29Jd5BcWRN4uynWLEFsQDVRBaLWChO2nDzjMurl2g
         qQo6pFYzL0iLqT/oQrDgk9bs5MFp5tyO9w9L4pPeX7D/5EHaR46u257UzZqTZ4uV5lCE
         JWousjwLUHr+eCHFd0ZHxShxKS6KyXdgoSANU5QglACRN+tVMLMsqeUQyr8krQQTNy/s
         UalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdLelaXabUTskOyM5jBlptNNQEyo5U0PY94WF2JNz94=;
        b=WrATirfjS8xhyFIHHam54Xpc9B45VfSUOzfBwHdMSzcWOT5Y/g/aLExOTotyX3HvnP
         /QXqaCRsc86qHw7uQIJ56tXERJLnkrjCyxS3x9GUcUDKTUFoN0diBalzqxNWrZqxVEI7
         3BA9g4INftEypBe40q9fWPCebjieFGEHhcKW2LFhRtDrZ3vlADEP4T0a/2Rupmff17kh
         /cO3HJI0J8+QRX6Ab2AM1ih4fur5mhhhezTjWbcA0l/UHQdP6vnx/9xVTHs1v1vqZXpv
         /49RNRv7G1MqUHboyeQkMenctU0yV2lO5T/ROKsssCsh/jnlu6yK7oTdgKe4S6g0QTP9
         CQ8Q==
X-Gm-Message-State: APjAAAV/9UcaqMUrqZOVsuR4SCo0no6W7db2VQsWAwCaGqNbbCI9xEYt
        lS7UXDGfRCMiaFtGd4jOvhM=
X-Google-Smtp-Source: APXvYqymlmKcsUBQFE+5wB1zQHWACudeKutUoj5DKanapW3TDicunMj7V4FfYesQb4shpI/mQ9j63A==
X-Received: by 2002:a63:5953:: with SMTP id j19mr25372600pgm.260.1556037066364;
        Tue, 23 Apr 2019 09:31:06 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:31:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 05/63] Documentation: ACPI: move linuxized-acpica.txt to driver-api/acpi and convert to  reST
Date:   Wed, 24 Apr 2019 00:28:34 +0800
Message-Id: <20190423162932.21428-6-changbin.du@gmail.com>
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
 Documentation/driver-api/acpi/index.rst       |   1 +
 .../acpi/linuxized-acpica.rst}                | 115 ++++++++++--------
 2 files changed, 66 insertions(+), 50 deletions(-)
 rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (78%)

diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
index 898b0c60671a..12649947b19b 100644
--- a/Documentation/driver-api/acpi/index.rst
+++ b/Documentation/driver-api/acpi/index.rst
@@ -5,3 +5,4 @@ ACPI Support
 .. toctree::
    :maxdepth: 2
 
+   linuxized-acpica
diff --git a/Documentation/acpi/linuxized-acpica.txt b/Documentation/driver-api/acpi/linuxized-acpica.rst
similarity index 78%
rename from Documentation/acpi/linuxized-acpica.txt
rename to Documentation/driver-api/acpi/linuxized-acpica.rst
index 3ad7b0dfb083..f8aaea668e41 100644
--- a/Documentation/acpi/linuxized-acpica.txt
+++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
@@ -1,31 +1,35 @@
-Linuxized ACPICA - Introduction to ACPICA Release Automation
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-Copyright (C) 2013-2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+============================================================
+Linuxized ACPICA - Introduction to ACPICA Release Automation
+============================================================
 
+:Copyright: |copy| 2013-2016, Intel Corporation
 
-Abstract:
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-This document describes the ACPICA project and the relationship between
-ACPICA and Linux.  It also describes how ACPICA code in drivers/acpi/acpica,
-include/acpi and tools/power/acpi is automatically updated to follow the
-upstream.
+:Abstract: This document describes the ACPICA project and the relationship
+           between ACPICA and Linux.  It also describes how ACPICA code in
+           drivers/acpi/acpica, include/acpi and tools/power/acpi is
+           automatically updated to follow the upstream.
 
 
-1. ACPICA Project
+ACPICA Project
+==============
 
-   The ACPI Component Architecture (ACPICA) project provides an operating
-   system (OS)-independent reference implementation of the Advanced
-   Configuration and Power Interface Specification (ACPI).  It has been
-   adapted by various host OSes.  By directly integrating ACPICA, Linux can
-   also benefit from the application experiences of ACPICA from other host
-   OSes.
+The ACPI Component Architecture (ACPICA) project provides an operating
+system (OS)-independent reference implementation of the Advanced
+Configuration and Power Interface Specification (ACPI).  It has been
+adapted by various host OSes.  By directly integrating ACPICA, Linux can
+also benefit from the application experiences of ACPICA from other host
+OSes.
 
-   The homepage of ACPICA project is: www.acpica.org, it is maintained and
-   supported by Intel Corporation.
+The homepage of ACPICA project is: www.acpica.org, it is maintained and
+supported by Intel Corporation.
 
-   The following figure depicts the Linux ACPI subsystem where the ACPICA
-   adaptation is included:
+The following figure depicts the Linux ACPI subsystem where the ACPICA
+adaptation is included::
 
       +---------------------------------------------------------+
       |                                                         |
@@ -71,21 +75,27 @@ upstream.
 
                  Figure 1. Linux ACPI Software Components
 
-   NOTE:
+.. note::
     A. OS Service Layer - Provided by Linux to offer OS dependent
        implementation of the predefined ACPICA interfaces (acpi_os_*).
+       ::
+
          include/acpi/acpiosxf.h
          drivers/acpi/osl.c
          include/acpi/platform
          include/asm/acenv.h
     B. ACPICA Functionality - Released from ACPICA code base to offer
        OS independent implementation of the ACPICA interfaces (acpi_*).
+       ::
+
          drivers/acpi/acpica
          include/acpi/ac*.h
          tools/power/acpi
     C. Linux/ACPI Functionality - Providing Linux specific ACPI
        functionality to the other Linux kernel subsystems and user space
        programs.
+       ::
+
          drivers/acpi
          include/linux/acpi.h
          include/linux/acpi*.h
@@ -95,24 +105,27 @@ upstream.
        ACPI subsystem to offer architecture specific implementation of the
        ACPI interfaces.  They are Linux specific components and are out of
        the scope of this document.
+       ::
+
          include/asm/acpi.h
          include/asm/acpi*.h
          arch/*/acpi
 
-2. ACPICA Release
+ACPICA Release
+==============
 
-   The ACPICA project maintains its code base at the following repository URL:
-   https://github.com/acpica/acpica.git. As a rule, a release is made every
-   month.
+The ACPICA project maintains its code base at the following repository URL:
+https://github.com/acpica/acpica.git. As a rule, a release is made every
+month.
 
-   As the coding style adopted by the ACPICA project is not acceptable by
-   Linux, there is a release process to convert the ACPICA git commits into
-   Linux patches.  The patches generated by this process are referred to as
-   "linuxized ACPICA patches".  The release process is carried out on a local
-   copy the ACPICA git repository.  Each commit in the monthly release is
-   converted into a linuxized ACPICA patch.  Together, they form the monthly
-   ACPICA release patchset for the Linux ACPI community.  This process is
-   illustrated in the following figure:
+As the coding style adopted by the ACPICA project is not acceptable by
+Linux, there is a release process to convert the ACPICA git commits into
+Linux patches.  The patches generated by this process are referred to as
+"linuxized ACPICA patches".  The release process is carried out on a local
+copy the ACPICA git repository.  Each commit in the monthly release is
+converted into a linuxized ACPICA patch.  Together, they form the monthly
+ACPICA release patchset for the Linux ACPI community.  This process is
+illustrated in the following figure::
 
     +-----------------------------+
     | acpica / master (-) commits |
@@ -153,7 +166,7 @@ upstream.
 
                 Figure 2. ACPICA -> Linux Upstream Process
 
-   NOTE:
+.. note::
     A. Linuxize Utilities - Provided by the ACPICA repository, including a
        utility located in source/tools/acpisrc folder and a number of
        scripts located in generate/linux folder.
@@ -170,19 +183,20 @@ upstream.
    following kernel configuration options:
    CONFIG_ACPI/CONFIG_ACPI_DEBUG/CONFIG_ACPI_DEBUGGER
 
-3. ACPICA Divergences
+ACPICA Divergences
+==================
 
-   Ideally, all of the ACPICA commits should be converted into Linux patches
-   automatically without manual modifications, the "linux / master" tree should
-   contain the ACPICA code that exactly corresponds to the ACPICA code
-   contained in "new linuxized acpica" tree and it should be possible to run
-   the release process fully automatically.
+Ideally, all of the ACPICA commits should be converted into Linux patches
+automatically without manual modifications, the "linux / master" tree should
+contain the ACPICA code that exactly corresponds to the ACPICA code
+contained in "new linuxized acpica" tree and it should be possible to run
+the release process fully automatically.
 
-   As a matter of fact, however, there are source code differences between
-   the ACPICA code in Linux and the upstream ACPICA code, referred to as
-   "ACPICA Divergences".
+As a matter of fact, however, there are source code differences between
+the ACPICA code in Linux and the upstream ACPICA code, referred to as
+"ACPICA Divergences".
 
-   The various sources of ACPICA divergences include:
+The various sources of ACPICA divergences include:
    1. Legacy divergences - Before the current ACPICA release process was
       established, there already had been divergences between Linux and
       ACPICA. Over the past several years those divergences have been greatly
@@ -213,11 +227,12 @@ upstream.
       rebased on the ACPICA side in order to offer better solutions, new ACPICA
       divergences are generated.
 
-4. ACPICA Development
+ACPICA Development
+==================
 
-   This paragraph guides Linux developers to use the ACPICA upstream release
-   utilities to obtain Linux patches corresponding to upstream ACPICA commits
-   before they become available from the ACPICA release process.
+This paragraph guides Linux developers to use the ACPICA upstream release
+utilities to obtain Linux patches corresponding to upstream ACPICA commits
+before they become available from the ACPICA release process.
 
    1. Cherry-pick an ACPICA commit
 
@@ -225,7 +240,7 @@ upstream.
    you want to cherry pick must be committed into the local repository.
 
    Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
-   from the ACPICA local repository:
+   from the ACPICA local repository::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -240,7 +255,7 @@ upstream.
    changes that haven't been applied to Linux yet.
 
    You can generate the ACPICA release series yourself and rebase your code on
-   top of the generated ACPICA release patches:
+   top of the generated ACPICA release patches::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -254,7 +269,7 @@ upstream.
    3. Inspect the current divergences
 
    If you have local copies of both Linux and upstream ACPICA, you can generate
-   a diff file indicating the state of the current divergences:
+   a diff file indicating the state of the current divergences::
 
    # git clone https://github.com/acpica/acpica
    # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1

