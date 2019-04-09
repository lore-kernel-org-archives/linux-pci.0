Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5EC282DA
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD2D2084C
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDQsclKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDIP5U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:57:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44277 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfDIP5T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 11:57:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so9946056pfm.11;
        Tue, 09 Apr 2019 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Gd8uAluhwpSrTMHyHIeaXrT2bcwIAaHkdeZrwzi8Fk=;
        b=BDQsclKtFO0FELYk0g+0O9d4ojJ6XFTSXVFeaWckDbfucFZkUg54tdbQx7gwjtObDv
         xGyTvwurSX83XlBSeAfepVddg4pnw+Brka69TiEOVxGBoe3lmSNE9waz2mdZ3j7iYPC8
         CfAPJfe1KgLTcDHFvW4JSnYN5GEktXqBWuf8UJ1Ao8FSlZtBMYyhvX51k0RSk5KD61PX
         wqrpPpid4mvrQFN0s6wU4++CLMjLq5JjhiMIrXeuI0WWNrH74D/oSh9mg7ptyDalIw+q
         IPer2iOToquV2LsPp9qhSNihymIbV0L8xgVqrqtsS/kPqfIhj/MHSZWyCSpr6/i64ynR
         3+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Gd8uAluhwpSrTMHyHIeaXrT2bcwIAaHkdeZrwzi8Fk=;
        b=d7BD3//0At8l9iTEmtpjjqS41OCakerV/HLuGCjlxvu0wIe0lO+Mh6N79nGukXVn2L
         m4hRPC3tthOAV6etSj0z2eBsMJ5INH6ghFHjFtR/lrwetJRmV+uklY9v/EWz7NI41S78
         xmgqjVDL5qNyFOpzUAWXjEIfheEFDxu0SMX7fS8m0rpeOCSXcuzYrlooWFMHemK+h+9n
         ZMve6EWRcxI6jyNjZXTH5KjfrADfHMNvxXhScQYKwv1eGXkP1WudGRS5EMNAjY6QTn7h
         mQvMd3HSSOu2lot86vkifdA/wG5Bp6oLyS3Flreq5SX0vYhQRkgV6yVo9ksIaR7ZYOn4
         vm9Q==
X-Gm-Message-State: APjAAAWU+e5aU1TQlOtDs0VqypV047JYzoSrHE7Gl9v15+hzUhEcFx70
        5hp7hrWbpgmidqLwcG1stMg=
X-Google-Smtp-Source: APXvYqypUJ8djJLH5rqQAzR+zxS4PnKh3aTp5YVpVvNNLqk9PEBlvATvhJOepCGDBjSVj3GSj1u3Ug==
X-Received: by 2002:a62:424f:: with SMTP id p76mr37589822pfa.141.1554825438910;
        Tue, 09 Apr 2019 08:57:18 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b72sm70383560pga.86.2019.04.09.08.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:57:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 10/12] Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
Date:   Tue,  9 Apr 2019 23:56:24 +0800
Message-Id: <20190409155626.6049-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409155626.6049-1-changbin.du@gmail.com>
References: <20190409155626.6049-1-changbin.du@gmail.com>
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

