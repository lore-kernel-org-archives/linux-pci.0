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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F6C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4224D218DA
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3xeiXnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfDWQcm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:32:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35343 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfDWQcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:32:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so7796269plp.2;
        Tue, 23 Apr 2019 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Kb3yhKuecaH+tPIFeyKoNCy2Q2HKYqzIlny4c2UXFY=;
        b=L3xeiXnpEXxmenNLrs3YPDFeZpH9FfZiKFIk4GYjcLhr2xZro8lXD4MaVnNqw7+jN7
         +J2IpkhfT5PSmtMDaP4aHuZcPdpjSyAcRtcPy+4/2YeedvJAajM4WtMkuU6OafogY3Sk
         FFQwZ6w+rtnQ1lAE/l0vN8BawDclFuInn33NfUGeFTZ0hsY5fOoUJdexuV4rIahaeoje
         5m8SP4/I7OsWUcU2OnSwVsQgJPnuW7AF4GepHV8TUSXtavc7GS53blGwnwMpYxhHTkP2
         9At0PSe0cpVBGpEQto0JOcGB1xmA2xGOwJD7dr79wAjsa7agDRnkQKXq3jYEtHSRoccZ
         yr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Kb3yhKuecaH+tPIFeyKoNCy2Q2HKYqzIlny4c2UXFY=;
        b=cPj/IZlpca685pN21K4m16xo6gCW4NGiPPN/hntaxnyS3WXfGVUbav1G+xjD+7k9Po
         FYe1F9S0KFMpRnlMkqMUnWR0MtkM4pX0P16mx+9Umf+/KT6dMBILxOKQUwbnh6RrDpiU
         TRFhbQ8YuvYxCfV7mYKdrjJip0sFETPigKI/fDPLliaoSUUBz1hKUjdyjBWO0cW/zeLr
         CI74rNDQ+pA/mBxcJiWq1W5mseMpIUU1jJrXJngrxEF+6cizYYH9PtABCL5Zfp75sGO6
         bP1dX6WtBEDWJ/NCbLIH085KVRUlk7u/+HsnREYfJCAyYWQD0KZCwNbCsLpMJX0WzZrS
         eGqA==
X-Gm-Message-State: APjAAAVhtT06xxOaQevO+7/qo5xM7S1AQp+G7f9Lb42A0eVThqtDVm67
        gEXjoiqzA7MOI9OnPIaffd0=
X-Google-Smtp-Source: APXvYqzuFBXtP4aSifoDWH3IVT1QXDqLt0k1TlsPXALgdM6up9DM5f8I9lUgUEZLrb7aoOMVFUnFqA==
X-Received: by 2002:a17:902:e490:: with SMTP id cj16mr27286585plb.156.1556037161684;
        Tue, 23 Apr 2019 09:32:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:32:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 15/63] Documentation: ACPI: move dsd/data-node-references.txt to firmware-guide/acpi and convert to reST
Date:   Wed, 24 Apr 2019 00:28:44 +0800
Message-Id: <20190423162932.21428-16-changbin.du@gmail.com>
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
 .../acpi/dsd/data-node-references.rst}        | 28 +++++++++++--------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 17 insertions(+), 12 deletions(-)
 rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (79%)

diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
similarity index 79%
rename from Documentation/acpi/dsd/data-node-references.txt
rename to Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index c3871565c8cf..79c5368eaecf 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -1,9 +1,12 @@
-Copyright (C) 2018 Intel Corporation
-Author: Sakari Ailus <sakari.ailus@linux.intel.com>
-
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
+===================================
 Referencing hierarchical data nodes
------------------------------------
+===================================
+
+:Copyright: |copy| 2018 Intel Corporation
+:Author: Sakari Ailus <sakari.ailus@linux.intel.com>
 
 ACPI in general allows referring to device objects in the tree only.
 Hierarchical data extension nodes may not be referred to directly, hence this
@@ -28,13 +31,14 @@ extension key.
 
 
 Example
--------
+=======
 
-	In the ASL snippet below, the "reference" _DSD property [2] contains a
-	device object reference to DEV0 and under that device object, a
-	hierarchical data extension key "node@1" referring to the NOD1 object
-	and lastly, a hierarchical data extension key "anothernode" referring to
-	the ANOD object which is also the final target node of the reference.
+In the ASL snippet below, the "reference" _DSD property [2] contains a
+device object reference to DEV0 and under that device object, a
+hierarchical data extension key "node@1" referring to the NOD1 object
+and lastly, a hierarchical data extension key "anothernode" referring to
+the ANOD object which is also the final target node of the reference.
+::
 
 	Device (DEV0)
 	{
@@ -75,10 +79,10 @@ Example
 	    })
 	}
 
-Please also see a graph example in graph.txt .
+Please also see a graph example in :doc:`graph`.
 
 References
-----------
+==========
 
 [1] Hierarchical Data Extension UUID For _DSD.
     <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index f81cfbcb6878..6d4e0df4f063 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -9,6 +9,7 @@ ACPI Support
 
    namespace
    dsd/graph
+   dsd/data-node-references
    enumeration
    osi
    method-customizing
-- 
2.20.1

