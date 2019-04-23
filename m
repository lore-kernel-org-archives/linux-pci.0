Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3792C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BE420643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGKEzzrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfDWQfZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:35:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46217 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfDWQfY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:35:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so5544782pll.13;
        Tue, 23 Apr 2019 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ic7Mz9ZN66lX6qBzL4R/C06u702++iEG8zGQWvLykvo=;
        b=pGKEzzrj8OrzEBxn5nOXdnc5T2C6n2D/v+oO6JGzhQKyWqhAN3MzW+BkdIakK7jaeT
         jeBzkyAfHSIVHrUg93WK1IRsOTLY38UX+P9zG/0idBhOPjDQW8pWhZeLbmH7mXoY6+3t
         YqaSqk+foyb6lCSU9gKFasVpPBSmdQu4hQW6aOn29tb+qy6/ZNXnNYTs3cNN6cvPmst0
         V8MMaAlZkNlgaFBh68Nhp1LMMZyRIncBFyu3rj3Wnxe9b9/nyvJeW+x0qs+1q7RDNJpv
         k2yM6JK6D9u9WXTAqy8Fl+k6r9qh30o5aeX20c+fMrhqmuyp7ytn0oaybTL/TrpzSSKG
         FU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ic7Mz9ZN66lX6qBzL4R/C06u702++iEG8zGQWvLykvo=;
        b=EMJMxW6C7CN7ZUvCNzUHAMfUJPvyuvnyXOkEEMWt171WxJs0nJK/Sy1zhyNnIFo2jc
         dZLxdsd3riodcW+BaP96EojHeZ7sPt/6kJ+jp7D8ohUmORPwq4o5zhg2Pkb1UXUMlLsL
         3Y11oDwhCcBK+qLuRx+evJlTMyNU4yGd4RBqCGaFroT2u8k13EtSg2RWK6Xjo022K3nl
         aXxz2MqMTX6S3T23FX/jS6awBm7xvMHftv8aKFx4ckrnzHmKmwSD5NwkGphbjkCakldl
         vTe9bRRS3rKdHkWwj10/CJQT9rW2y5TXVyIZrydozSPe4oL5CF3wpZJ5asxleZmaOfWf
         mBOA==
X-Gm-Message-State: APjAAAURr5GBu2swwTibDrEFD8bdU5AREOmKUugflfoXOyJ/RrJ37n//
        qcPyuABokWoPguGNjCU+ls8=
X-Google-Smtp-Source: APXvYqyLEwwLyCN3ZpGrjGmn4YGJeRqIGRw6sIoisL487VVT0eEVJORTD5KLeCS430OsaIfJnNvY/w==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr9532556pln.144.1556037323164;
        Tue, 23 Apr 2019 09:35:23 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:35:22 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 30/63] Documentation: PCI: convert acpi-info.txt to reST
Date:   Wed, 24 Apr 2019 00:28:59 +0800
Message-Id: <20190423162932.21428-31-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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

