Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA46C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44082070B
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAcqqhRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfC2QFP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:05:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36792 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbfC2QFO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:05:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so38520plb.3;
        Fri, 29 Mar 2019 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tre2zPBgZUxfwfxKvdLKphYOnSoAtvVOVqMmlUwCda8=;
        b=eAcqqhRWlhd+z6psd8s5HaJxQQ4i0pRddtmhZJAFEeAyU4ng+0iZbTxdFpDmL3Q+XK
         DfKDIvy4MQ45BykkU4HiGv8AeSuq+Uqk/iP+TDTTGuVUCzpgfhWCCkcxFmsJGCeh/LkJ
         BGZlPJFeA4xybMLu5XyB/vIhJmIzNsEnaSbkeFQscmdP3/dv5T8ClkOFb9p6lJoNmnjX
         vYF93NIeRJeEYxFui38ZEzE4uFFGjit6cPbyDxqBspWFFdNsNZNu6o9pwTVjirTUjXrA
         qOtCSZsPthUJerbWbPflTitd+ZhscuyYHT423+lnbu9vNCyKxoCq0/7wJYJj9RPJQygw
         WgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tre2zPBgZUxfwfxKvdLKphYOnSoAtvVOVqMmlUwCda8=;
        b=NzLJwzs58QBWVuxeZGZA91GUEWSYULCCcNyG/LX5sbNorI/J46SCi5IvFmg9k1H49A
         jH6zqcx32gxot2rOiYWy4sTbgy02ruxusX0kxx5ukhcAyPyFCM0AwLqru6lx6wlLL/UC
         LQ6QF9jbJ7c7tD4f5xKmWL1r8pXEo+ZPZBiDl/EsbYLBxE3QjEBLGMsxqfgVea03l9IW
         NHGckF01HaFSLfbrTFMyvm6DiYxaAN4YLNSepcqHPAPoKrgnUHgIcXEC1noIhqjPy6W7
         zBd6zLz7e57aaX3YE2qP3SapmGZVyyDYDhg5+vDYW6pBS0vu4uxd2/PYoSrAEaOgASm5
         FUug==
X-Gm-Message-State: APjAAAVZqS2GMG5FnPS/c3+1Zq9Rn6J+MNcF3qXdAnOPnt6mJom5Mt2P
        WF5XmD+0a4+Z59YwiYKkmMY=
X-Google-Smtp-Source: APXvYqx3adCOw3xtnf1gMskxuP5tKruX73nvcFxduSWYr8sddJq6EjWN6SMRHg2x61aIaM5LWmFL4g==
X-Received: by 2002:a17:902:599d:: with SMTP id p29mr14605987pli.156.1553875513679;
        Fri, 29 Mar 2019 09:05:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:05:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 11/12] pci doc: convert PCI/endpoint/pci-test-function.txt to rst format
Date:   Sat, 30 Mar 2019 00:04:12 +0800
Message-Id: <20190329160413.4293-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329160413.4293-1-changbin.du@gmail.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
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
 Documentation/PCI/endpoint/index.rst          |  1 +
 ...est-function.txt => pci-test-function.rst} | 32 +++++++++++--------
 2 files changed, 20 insertions(+), 13 deletions(-)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 3951de9f923c..b680a3fc4fec 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -9,3 +9,4 @@ PCI Endpoint Framework
 
    pci-endpoint
    pci-endpoint-cfs
+   pci-test-function
diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.rst
similarity index 84%
rename from Documentation/PCI/endpoint/pci-test-function.txt
rename to Documentation/PCI/endpoint/pci-test-function.rst
index 5916f1f592bb..be18ec3d1da0 100644
--- a/Documentation/PCI/endpoint/pci-test-function.txt
+++ b/Documentation/PCI/endpoint/pci-test-function.rst
@@ -1,5 +1,10 @@
-				PCI TEST
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PCI TEST FUNCTION
+=================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 Traditionally PCI RC has always been validated by using standard
 PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
@@ -23,30 +28,31 @@ The PCI endpoint test device has the following registers:
 	8) PCI_ENDPOINT_TEST_IRQ_TYPE
 	9) PCI_ENDPOINT_TEST_IRQ_NUMBER
 
-*) PCI_ENDPOINT_TEST_MAGIC
+* PCI_ENDPOINT_TEST_MAGIC
 
 This register will be used to test BAR0. A known pattern will be written
 and read back from MAGIC register to verify BAR0.
 
-*) PCI_ENDPOINT_TEST_COMMAND:
+* PCI_ENDPOINT_TEST_COMMAND:
 
 This register will be used by the host driver to indicate the function
 that the endpoint device must perform.
 
-Bitfield Description:
+Bitfield Description::
+
   Bit 0		: raise legacy IRQ
   Bit 1		: raise MSI IRQ
   Bit 2		: raise MSI-X IRQ
   Bit 3		: read command (read data from RC buffer)
   Bit 4		: write command (write data to RC buffer)
-  Bit 5		: copy command (copy data from one RC buffer to another
-		  RC buffer)
+  Bit 5		: copy command (copy data from one RC buffer to another RC buffer)
 
-*) PCI_ENDPOINT_TEST_STATUS
+* PCI_ENDPOINT_TEST_STATUS
 
 This register reflects the status of the PCI endpoint device.
 
-Bitfield Description:
+Bitfield Description::
+
   Bit 0		: read success
   Bit 1		: read fail
   Bit 2		: write success
@@ -57,17 +63,17 @@ Bitfield Description:
   Bit 7		: source address is invalid
   Bit 8		: destination address is invalid
 
-*) PCI_ENDPOINT_TEST_SRC_ADDR
+* PCI_ENDPOINT_TEST_SRC_ADDR
 
 This register contains the source address (RC buffer address) for the
 COPY/READ command.
 
-*) PCI_ENDPOINT_TEST_DST_ADDR
+* PCI_ENDPOINT_TEST_DST_ADDR
 
 This register contains the destination address (RC buffer address) for
 the COPY/WRITE command.
 
-*) PCI_ENDPOINT_TEST_IRQ_TYPE
+* PCI_ENDPOINT_TEST_IRQ_TYPE
 
 This register contains the interrupt type (Legacy/MSI) triggered
 for the READ/WRITE/COPY and raise IRQ (Legacy/MSI) commands.
@@ -77,7 +83,7 @@ Possible types:
  - MSI		: 1
  - MSI-X	: 2
 
-*) PCI_ENDPOINT_TEST_IRQ_NUMBER
+* PCI_ENDPOINT_TEST_IRQ_NUMBER
 
 This register contains the triggered ID interrupt.
 
-- 
2.20.1

