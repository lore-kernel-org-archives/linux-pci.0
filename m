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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEBC4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AB3206DF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk/5pGHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDCPu5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37957 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfDCPuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 11:50:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so8535011pgl.5;
        Wed, 03 Apr 2019 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rn1yKwWApz1E/GFrtv84SjK3Ru8U6R38N33rmgCr4mM=;
        b=bk/5pGHmSQmnD8XHAnqz5iL2Rc/CLWMKMcnOWWwMYbpCH+4lhqwHx1FLsQpqq66pXI
         R4e/Z67+TUPXauiIQhcTRhpxqU+rub85+EWafkP4Gbzl7GaMjFs2IfaF0/Bfm+VS7qjE
         SlqSpUuEV0GUfaN3mxBXMGRiIwMnyPBmG7dgYVNURizaoWPa2CGaPm3TLrwSAYKYzEJw
         1pp+FizE75u2akZvy9hbs4SCXiYBgHJ+wuwAEI6TY0q1vK1pGVV3SWBJkRuFj5q9GU5Z
         kbv8ZQpCcCl+jK2axm9M6gF7KGqJUvthIb6jzDuUM7rz4ZKt2XW1Q9zMqJqqVLQ1WtQ5
         a9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rn1yKwWApz1E/GFrtv84SjK3Ru8U6R38N33rmgCr4mM=;
        b=HbRYqzX8AgW/+JVbceEr85asT/63Abfa0dS7b5e75cful1j8mPLccnzge7Oxv7L/Vl
         Bd3cNii8KeXJoH7gR5fFHq5Juj0j/vTXkZlL0gKSbSejyZMewQTSuzafj2ysMUOLC0r6
         U2bbZgGng25AXz84Q124XHsuitGNaWAsF281vBTtzujbL8meHkrQIBPlO9dHEzZyxxrw
         gYk367zfCo3R5mTwmBWO/O/KkxyGF1VmcrPQhN2tCLbMxEk08wzEyAkAJj5ezmjhNVQ3
         /BB1CGHy0LhYiX/+A7aZwh7MJKyB8rjTJNzwEw9dwoB+H6QnSVN2YMx2hsToiGuPC51+
         YPoA==
X-Gm-Message-State: APjAAAVcNxaz89X3RY058sMQ1OpnTGOdmUCsr9t03ORYfxE4D7cIujJU
        451IL/2BAuEYICKPA4DDucY=
X-Google-Smtp-Source: APXvYqylO0Q7CxHCu7JBXhVQ16nCiHuh9FNDZmamMkLO8rnHPUip2OkDhycKVCyS/lVRCvhpHr5TlA==
X-Received: by 2002:a63:f444:: with SMTP id p4mr444669pgk.32.1554306653948;
        Wed, 03 Apr 2019 08:50:53 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b8sm18906922pgq.33.2019.04.03.08.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:50:52 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 10/12] Documentation: PCI: convert PCI/endpoint/pci-endpoint-cfs.txt to reST format
Date:   Wed,  3 Apr 2019 23:49:53 +0800
Message-Id: <20190403154955.12096-11-changbin.du@gmail.com>
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
 ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} | 99 +++++++++++--------
 2 files changed, 57 insertions(+), 43 deletions(-)
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 0db4f2fcd7f0..3951de9f923c 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -8,3 +8,4 @@ PCI Endpoint Framework
    :maxdepth: 2
 
    pci-endpoint
+   pci-endpoint-cfs
diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
similarity index 64%
rename from Documentation/PCI/endpoint/pci-endpoint-cfs.txt
rename to Documentation/PCI/endpoint/pci-endpoint-cfs.rst
index d740f29960a4..b6d39cdec56e 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -1,41 +1,51 @@
-                   CONFIGURING PCI ENDPOINT USING CONFIGFS
-                    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Configuring PCI Endpoint Using CONFIGFS
+=======================================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 The PCI Endpoint Core exposes configfs entry (pci_ep) to configure the
 PCI endpoint function and to bind the endpoint function
 with the endpoint controller. (For introducing other mechanisms to
 configure the PCI Endpoint Function refer to [1]).
 
-*) Mounting configfs
+Mounting configfs
+=================
 
 The PCI Endpoint Core layer creates pci_ep directory in the mounted configfs
-directory. configfs can be mounted using the following command.
+directory. configfs can be mounted using the following command::
 
 	mount -t configfs none /sys/kernel/config
 
-*) Directory Structure
+Directory Structure
+===================
 
 The pci_ep configfs has two directories at its root: controllers and
 functions. Every EPC device present in the system will have an entry in
 the *controllers* directory and and every EPF driver present in the system
 will have an entry in the *functions* directory.
+::
 
-/sys/kernel/config/pci_ep/
-	.. controllers/
-	.. functions/
+	/sys/kernel/config/pci_ep/
+		.. controllers/
+		.. functions/
 
-*) Creating EPF Device
+Creating EPF Device
+===================
 
 Every registered EPF driver will be listed in controllers directory. The
 entries corresponding to EPF driver will be created by the EPF core.
+::
 
-/sys/kernel/config/pci_ep/functions/
-	.. <EPF Driver1>/
-		... <EPF Device 11>/
-		... <EPF Device 21>/
-	.. <EPF Driver2>/
-		... <EPF Device 12>/
-		... <EPF Device 22>/
+	/sys/kernel/config/pci_ep/functions/
+		.. <EPF Driver1>/
+			... <EPF Device 11>/
+			... <EPF Device 21>/
+		.. <EPF Driver2>/
+			... <EPF Device 12>/
+			... <EPF Device 22>/
 
 In order to create a <EPF device> of the type probed by <EPF Driver>, the
 user has to create a directory inside <EPF DriverN>.
@@ -44,34 +54,37 @@ Every <EPF device> directory consists of the following entries that can be
 used to configure the standard configuration header of the endpoint function.
 (These entries are created by the framework when any new <EPF Device> is
 created)
-
-	.. <EPF Driver1>/
-		... <EPF Device 11>/
-			... vendorid
-			... deviceid
-			... revid
-			... progif_code
-			... subclass_code
-			... baseclass_code
-			... cache_line_size
-			... subsys_vendor_id
-			... subsys_id
-			... interrupt_pin
-
-*) EPC Device
+::
+
+		.. <EPF Driver1>/
+			... <EPF Device 11>/
+				... vendorid
+				... deviceid
+				... revid
+				... progif_code
+				... subclass_code
+				... baseclass_code
+				... cache_line_size
+				... subsys_vendor_id
+				... subsys_id
+				... interrupt_pin
+
+EPC Device
+==========
 
 Every registered EPC device will be listed in controllers directory. The
 entries corresponding to EPC device will be created by the EPC core.
-
-/sys/kernel/config/pci_ep/controllers/
-	.. <EPC Device1>/
-		... <Symlink EPF Device11>/
-		... <Symlink EPF Device12>/
-		... start
-	.. <EPC Device2>/
-		... <Symlink EPF Device21>/
-		... <Symlink EPF Device22>/
-		... start
+::
+
+	/sys/kernel/config/pci_ep/controllers/
+		.. <EPC Device1>/
+			... <Symlink EPF Device11>/
+			... <Symlink EPF Device12>/
+			... start
+		.. <EPC Device2>/
+			... <Symlink EPF Device21>/
+			... <Symlink EPF Device22>/
+			... start
 
 The <EPC Device> directory will have a list of symbolic links to
 <EPF Device>. These symbolic links should be created by the user to
@@ -81,7 +94,7 @@ The <EPC Device> directory will also have a *start* field. Once
 "1" is written to this field, the endpoint device will be ready to
 establish the link with the host. This is usually done after
 all the EPF devices are created and linked with the EPC device.
-
+::
 
 			 | controllers/
 				| <Directory: EPC name>/
@@ -102,4 +115,4 @@ all the EPF devices are created and linked with the EPC device.
 						| interrupt_pin
 						| function
 
-[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
+[1] :doc:`pci-endpoint`
-- 
2.20.1

