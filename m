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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66549C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3355F217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg0maRVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfDWQgJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:36:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41697 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfDWQgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:36:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so1866570pls.8;
        Tue, 23 Apr 2019 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZoOi3gjYzHlDUOBEGGuuoJVMVf6l/Y8bQIXb5bl+VQ=;
        b=Fg0maRVYAiRZUevRKAoGru6Ufc6JfB3PApo5YdqpTWCI71CMI2RI7lY5qvB08uoZJA
         HOAPPQuuxDpvnYcj5+69IBDV4LcoylHiPjf5LpI6TPWpJly+I0ZBlgQW9a0kkZiFX155
         undY4/a9/OP7lNg0rPT9fV0MuzcgALavj3tIge9eqb6PrKxyv0ZQTrYqi/CcILSTh1ZE
         7kFsaCCgtnOfcrNOWBtbHF93BZT3oCeALbAUfb6n2KZhAlPcNBcPRfjXM7gS6+SBqwN8
         VGS51SVl6L2fyHw+O3fCj/PNBWDsBvCqCLdru9AK5gxRCCoGTzrCeAyCqaPj0ZxnvqO9
         sQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZoOi3gjYzHlDUOBEGGuuoJVMVf6l/Y8bQIXb5bl+VQ=;
        b=IyXtYpxTCHYpTHCAt5g8rtYF4jFPudGl7HJrswYEbqxaI/0wUdNts5yAiGDLVrtrsk
         EN0qBav0aw+YTpWcqoR05gKVjkSItW/AwVNEI1B6BJIE5Nf8U+7R9S1mPPZA8k5kdfYM
         ap78eMMk3n6aoueTGBXLWS5EF7kPO8ddahuai9pBriNXvgq1x9mWZpYuSDm2abTw8hih
         cDbCMGarrWpXXsDs43es0nEktTMR78mfRT8WmXFOQghb2eHLI7P8J9YE31z2gypopoOj
         SxppmArMo3Z188jOfw8YVwQ8Z6XJ3KJm7p5gJedKtOkhCBkiB70K02Pnlz8xkHhhF4MM
         NtyQ==
X-Gm-Message-State: APjAAAW5AEOyl5v1RopQWp8sPV/K24E/FEfbvy4BQsOrPGDZUcHCUAm5
        jyI+u6gsR+DBdvIz4HpWK7Xy5e5/
X-Google-Smtp-Source: APXvYqw5BxmcKTwi/BdJOlWbGONwAxSMUEOwrhPrn2KHdeSYn0+m/wgXdgpSgOMKmvAtLVD9HXah9A==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr27516465pla.311.1556037368535;
        Tue, 23 Apr 2019 09:36:08 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:36:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 35/63] Documentation: PCI: convert endpoint/pci-test-function.txt to reST
Date:   Wed, 24 Apr 2019 00:29:04 +0800
Message-Id: <20190423162932.21428-36-changbin.du@gmail.com>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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

