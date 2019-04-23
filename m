Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961A8C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6192183E
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oztcbau6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfDWQai (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:30:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39489 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfDWQai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:30:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so5998573plb.6;
        Tue, 23 Apr 2019 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hv6IafG6PXUChLf829/adbyNwFbqlej4B8eSgkihCvw=;
        b=oztcbau6apuY+tQ1gv1wXtWycyIG1ePkZ3TZUcqYNBtAZPzIrXG3UMDXYog4F5hGGk
         BolSUGeA6YcqjLxwNUjXSaLlg3nR+XvhzJ2Xwb5xtUmA52GMxmCtLtvcI8gBdJpEMWoc
         nsQZl3IAyQ3gKNFd0auG067WG1SBmyGwysYH35NoQufYctcjyjajOzGsaqG8awtI1atB
         LKmodt+SHo4/FGrsKwvNNH9vW4bZ898+CueZ5DnzjhcklwM3QPe+V7vQMT8wu9JhttLw
         T/Qvif5GWKyfvn8ezlf/rKdJDqFE1esdWWloa7yOSR0MMqwQWgDwSvIIW+ACD6lRlrQC
         qyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hv6IafG6PXUChLf829/adbyNwFbqlej4B8eSgkihCvw=;
        b=E/Ybr37b7F6NGNrpodPI/bavaWevh3PtY5jzyRpzMBEjLyAryZYCddchCmad/N3MvQ
         9jFefnoV5iGSEzmp+d537Hr8Tl2zpf0r0FuzBycqbv/i3rjIbf2c5GM73/ZJst05us/Q
         ChxwkxAz+aYdpXQ4XDSh53goZjLoTnCTnaVjCZMYvbL4CxZDE+TV3iim1G8L24CLb1zA
         V8wBKZr4Fr88V2iMBXCsuDNNPU2J8oH3EF6iKsGeopekyrGj4T0vDv+Gx68BlM/vOmJi
         arlJB07htJjWRWKEGIcCCdK9MDAi4EEvwfg0tXppyRKFnclB896rTaqoRs0FhqocwqnT
         9Gxg==
X-Gm-Message-State: APjAAAXzHVJO9NivTp0h8EifsRkHaC6bjuuD2hP/ukBBXpa1TEre5r5n
        cWVkEJRRwEIb+dsdjJfG/qw=
X-Google-Smtp-Source: APXvYqyRcQ1bWn1RSbUodd0gmW7wNKgBdvn2k41su9mqh6NFMD3ZM9hb6237tdxgyB260tU9VnKz6w==
X-Received: by 2002:a17:902:c1:: with SMTP id a59mr26218800pla.176.1556037036874;
        Tue, 23 Apr 2019 09:30:36 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:30:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 01/63] Documentation: add Linux ACPI to Sphinx TOC tree
Date:   Wed, 24 Apr 2019 00:28:30 +0800
Message-Id: <20190423162932.21428-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add below index.rst files for ACPI subsystem. More docs will be added later.
  o admin-guide/acpi/index.rst
  o driver-api/acpi/index.rst
  o firmware-guide/index.rst

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/admin-guide/acpi/index.rst    | 10 ++++++++++
 Documentation/admin-guide/index.rst         |  1 +
 Documentation/driver-api/acpi/index.rst     |  7 +++++++
 Documentation/driver-api/index.rst          |  1 +
 Documentation/firmware-guide/acpi/index.rst |  9 +++++++++
 Documentation/firmware-guide/index.rst      | 13 +++++++++++++
 Documentation/index.rst                     | 10 ++++++++++
 7 files changed, 51 insertions(+)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/index.rst

diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
new file mode 100644
index 000000000000..3e041206089d
--- /dev/null
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -0,0 +1,10 @@
+============
+ACPI Support
+============
+
+Here we document in detail how to interact with various mechanisms in
+the Linux ACPI support.
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 0a491676685e..5b8286fdd91b 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -77,6 +77,7 @@ configure specific aspects of kernel behavior to your liking.
    LSM/index
    mm/index
    perf-security
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
new file mode 100644
index 000000000000..898b0c60671a
--- /dev/null
+++ b/Documentation/driver-api/acpi/index.rst
@@ -0,0 +1,7 @@
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 2
+
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index c0b600ed9961..aa87075c7846 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -56,6 +56,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
new file mode 100644
index 000000000000..0ec7d072ba22
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
new file mode 100644
index 000000000000..5355784ca0a2
--- /dev/null
+++ b/Documentation/firmware-guide/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+The Linux kernel firmware guide
+===============================
+
+This section describes the ACPI subsystem in Linux from firmware perspective.
+
+.. toctree::
+   :maxdepth: 1
+
+   acpi/index
+
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..fdfa85c56a50 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -35,6 +35,16 @@ trying to get it to work optimally on a given system.
 
    admin-guide/index
 
+Firmware-related documentation
+------------------------------
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
+
+.. toctree::
+   :maxdepth: 2
+
+   firmware-guide/index
+
 Application-developer documentation
 -----------------------------------
 
-- 
2.20.1

