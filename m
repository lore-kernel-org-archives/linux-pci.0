Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514AAC10F06
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB00206BA
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E35noDPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfDCPu7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41129 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfDCPu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 11:50:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so8527721pgs.8;
        Wed, 03 Apr 2019 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEZfO8Qu7It4AB6pzTfMyN1pmJD5Tm42+njWF0/CfxE=;
        b=E35noDPkPqK8EOOg1lo+HRhuGmFLVJoBf0v9JXUjuXDfRhCKR8RnzLslW0BUlnJE1K
         BfR3Ct1hak5UILnLSO1mGxp3xctuLpt5VhtIJzdPYENLG0fVKc2iCzpmvTw1eZHiSk1B
         i/Zi/FybetTqdLRU+n3yPhgfO4y/2EvpIXVj2+CWgUyCkbsWXfVn0D7yYhHIz5kdOSCX
         cc7b/Vtqt0/b64I6pdA5tmGRh+fradCTPUHMQVr+K8ZnoVGOVcXYFyo1dfZTAdSnOP0C
         IDO8LsB08i8P5pl2uAcmaj4bkMFL8rld5AF9DiFaw2WLY2cvTRaNxfhINY7Uhdb0yRkF
         edpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEZfO8Qu7It4AB6pzTfMyN1pmJD5Tm42+njWF0/CfxE=;
        b=muXo1iig0QKVCl5WZJbJ/NEcgGib25okoquNGU1X7lE5/e/HyS6YxtzMgATEohfbiK
         EYfIKKD38vuitRvplbq4DeIh1Ld6t0CudwzmZwSkDdeH7qRDlftEqLWxRcOOVDntPikI
         5BlAhVA8nTifbx7N7zqVH5Oe0O724uZ9/7iLFEZGx5f4Pv2vEIlXGJ9mpX9inUhFdrZS
         aSYL8zEK88hmdK0HjwCmpknPFQtRHjTAHyiwvBW7emegOOMePCYIOcH0rAEHXWy3AuTR
         My0HTMsHvtNLEzwLL5ZvP64nHjgsr2Dm5MqqlP83TDs/s1vyjW2uSU1PlFBkN+GK9kDq
         9tJw==
X-Gm-Message-State: APjAAAVLsY2RDRZP7YCIXz4KMEcgyTw+i33Pbde1USxsJ/Z/JAK59nss
        tX/sJwO3Lxfl4IDYjZi+2Lc=
X-Google-Smtp-Source: APXvYqzzmJ6+YsAtkUXagAQXK2kYsC23rzJwwyLBIDdVDIOp5r1x42fLaVOQuxAFO3rcjW/EWTfQHg==
X-Received: by 2002:a63:384:: with SMTP id 126mr306518pgd.341.1554306658018;
        Wed, 03 Apr 2019 08:50:58 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b8sm18906922pgq.33.2019.04.03.08.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:50:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 11/12] Documentation: PCI: convert PCI/endpoint/pci-test-function.txt to reST format
Date:   Wed,  3 Apr 2019 23:49:54 +0800
Message-Id: <20190403154955.12096-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403154955.12096-1-changbin.du@gmail.com>
References: <20190403154955.12096-1-changbin.du@gmail.com>
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
index 5916f1f592bb..ba02cddcec37 100644
--- a/Documentation/PCI/endpoint/pci-test-function.txt
+++ b/Documentation/PCI/endpoint/pci-test-function.rst
@@ -1,5 +1,10 @@
-				PCI TEST
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PCI Test Function
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

