Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C831C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31217218A5
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATc03wm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfC2QFJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:05:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36657 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbfC2QFH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:05:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so1436315pgc.3;
        Fri, 29 Mar 2019 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MRrCatx5SOX7CjqyP9klqOabLtig8LFqVl/pQ0F3tE=;
        b=ATc03wm8D52YupeWDdYwmZe94SCpwAiOSvInW4vtynGVdO8yo7jHdaEAotZxrlXjAX
         /5ushuGjm+XxbP/94t9196eE4Q3gb68CwzqMiPcyAiKcM81E6BXx7qqr3XvCm+bis6PP
         MN/HiTOW06zxKuHFXAfOQQ+Jeo77b7fjHSNnB/ckDbyjLP383hNnmNAG2Bahbs3USxZO
         ZY7QGYCoFmysMTGSbBwwZap8iDjVkzl1YZ1xk2x96rElGdQ6MPQdJkFGVKpCVRNJRNd8
         4494UOU/vL+oPoY3Ulu4xTQe456Yflp+7dvIhP/5XKPg+4Zw/Tnr+S9Fh8ZfSJi/6iTS
         RZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MRrCatx5SOX7CjqyP9klqOabLtig8LFqVl/pQ0F3tE=;
        b=tO4XUXH5pVsI8x7ebD3+bAKax0v2E6mqWKeHqJOD/L3kumpXs7pRnCVAqVHoNVM1TS
         FUvgfJtoTsbhk+C/XJs/S/XtnicTWykJRYsEgsN56sbGKTxQWSYcEk0NVYlokSMgdxEm
         IA+qNzCn2eyal5xTItkZbIIaTswp9BVvF8xjcvhMfolQhKRp9uB/S45euwOrjAbgTF6Y
         yId31/G+zG7pTvNj7U2MEer0WUA87G98Bzr6VGXiDqzdTam/WQb/aScuvZL1jaSst+jt
         u8hmui3mysw+4g2up/zT+YJTGDvcj2apdPHHSdrbEmzdZb5i0lTGRcQYd3TEJPg2fz9B
         4rMw==
X-Gm-Message-State: APjAAAXBvwJhcp8D4Hsi1i2t/eUIuQUHInCmJT8KlvrZ63I8cwSclz+w
        Pv/a3GPrbcnQ5A05+Rkx5bmjaMbjn/k=
X-Google-Smtp-Source: APXvYqxV3hjonvQWLghcNv/KrcIab9VcLLVYYdOWd/ZrPIMDOgnQ6/hCC2nJEc+AMPCiT8iNg2hjvg==
X-Received: by 2002:a63:68c9:: with SMTP id d192mr47895339pgc.264.1553875506441;
        Fri, 29 Mar 2019 09:05:06 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:05:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 09/12] pci doc: convert PCI/endpoint/pci-endpoint.txt to rst format
Date:   Sat, 30 Mar 2019 00:04:10 +0800
Message-Id: <20190329160413.4293-10-changbin.du@gmail.com>
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
 Documentation/PCI/endpoint/index.rst          | 10 +++
 .../{pci-endpoint.txt => pci-endpoint.rst}    | 74 +++++++++++--------
 Documentation/PCI/index.rst                   |  1 +
 3 files changed, 56 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (86%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
new file mode 100644
index 000000000000..0db4f2fcd7f0
--- /dev/null
+++ b/Documentation/PCI/endpoint/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+PCI Endpoint Framework
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   pci-endpoint
diff --git a/Documentation/PCI/endpoint/pci-endpoint.txt b/Documentation/PCI/endpoint/pci-endpoint.rst
similarity index 86%
rename from Documentation/PCI/endpoint/pci-endpoint.txt
rename to Documentation/PCI/endpoint/pci-endpoint.rst
index e86a96b66a6a..81ccbe1cd577 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -1,11 +1,17 @@
-			    PCI ENDPOINT FRAMEWORK
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+PCI ENDPOINT FRAMEWORK
+======================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 This document is a guide to use the PCI Endpoint Framework in order to create
 endpoint controller driver, endpoint function driver, and using configfs
 interface to bind the function driver to the controller driver.
 
 1. Introduction
+===============
 
 Linux has a comprehensive PCI subsystem to support PCI controllers that
 operates in Root Complex mode. The subsystem has capability to scan PCI bus,
@@ -20,23 +26,26 @@ EP system which can have a wide variety of use cases from testing or
 validation, co-processor accelerator, etc.
 
 2. PCI Endpoint Core
+====================
 
 The PCI Endpoint Core layer comprises 3 components: the Endpoint Controller
 library, the Endpoint Function library, and the configfs layer to bind the
 endpoint function with the endpoint controller.
 
 2.1 PCI Endpoint Controller(EPC) Library
+----------------------------------------
 
 The EPC library provides APIs to be used by the controller that can operate
 in endpoint mode. It also provides APIs to be used by function driver/library
 in order to implement a particular endpoint function.
 
 2.1.1 APIs for the PCI controller Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI controller driver.
 
-*) devm_pci_epc_create()/pci_epc_create()
+* devm_pci_epc_create()/pci_epc_create()
 
    The PCI controller driver should implement the following ops:
 	 * write_header: ops to populate configuration space header
@@ -51,23 +60,23 @@ by the PCI controller driver.
    The PCI controller driver can then create a new EPC device by invoking
    devm_pci_epc_create()/pci_epc_create().
 
-*) devm_pci_epc_destroy()/pci_epc_destroy()
+* devm_pci_epc_destroy()/pci_epc_destroy()
 
    The PCI controller driver can destroy the EPC device created by either
    devm_pci_epc_create() or pci_epc_create() using devm_pci_epc_destroy() or
    pci_epc_destroy().
 
-*) pci_epc_linkup()
+* pci_epc_linkup()
 
    In order to notify all the function devices that the EPC device to which
    they are linked has established a link with the host, the PCI controller
    driver should invoke pci_epc_linkup().
 
-*) pci_epc_mem_init()
+* pci_epc_mem_init()
 
    Initialize the pci_epc_mem structure used for allocating EPC addr space.
 
-*) pci_epc_mem_exit()
+* pci_epc_mem_exit()
 
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
@@ -76,85 +85,88 @@ by the PCI controller driver.
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
 
-*) pci_epc_write_header()
+* pci_epc_write_header()
 
    The PCI endpoint function driver should use pci_epc_write_header() to
    write the standard configuration header to the endpoint controller.
 
-*) pci_epc_set_bar()
+* pci_epc_set_bar()
 
    The PCI endpoint function driver should use pci_epc_set_bar() to configure
    the Base Address Register in order for the host to assign PCI addr space.
    Register space of the function driver is usually configured
    using this API.
 
-*) pci_epc_clear_bar()
+* pci_epc_clear_bar()
 
    The PCI endpoint function driver should use pci_epc_clear_bar() to reset
    the BAR.
 
-*) pci_epc_raise_irq()
+* pci_epc_raise_irq()
 
    The PCI endpoint function driver should use pci_epc_raise_irq() to raise
    Legacy Interrupt, MSI or MSI-X Interrupt.
 
-*) pci_epc_mem_alloc_addr()
+* pci_epc_mem_alloc_addr()
 
    The PCI endpoint function driver should use pci_epc_mem_alloc_addr(), to
    allocate memory address from EPC addr space which is required to access
    RC's buffer
 
-*) pci_epc_mem_free_addr()
+* pci_epc_mem_free_addr()
 
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
 2.1.3 Other APIs
+~~~~~~~~~~~~~~~~
 
 There are other APIs provided by the EPC library. These are used for binding
 the EPF device with EPC device. pci-ep-cfs.c can be used as reference for
 using these APIs.
 
-*) pci_epc_get()
+* pci_epc_get()
 
    Get a reference to the PCI endpoint controller based on the device name of
    the controller.
 
-*) pci_epc_put()
+* pci_epc_put()
 
    Release the reference to the PCI endpoint controller obtained using
    pci_epc_get()
 
-*) pci_epc_add_epf()
+* pci_epc_add_epf()
 
    Add a PCI endpoint function to a PCI endpoint controller. A PCIe device
    can have up to 8 functions according to the specification.
 
-*) pci_epc_remove_epf()
+* pci_epc_remove_epf()
 
    Remove the PCI endpoint function from PCI endpoint controller.
 
-*) pci_epc_start()
+* pci_epc_start()
 
    The PCI endpoint function driver should invoke pci_epc_start() once it
    has configured the endpoint function and wants to start the PCI link.
 
-*) pci_epc_stop()
+* pci_epc_stop()
 
    The PCI endpoint function driver should invoke pci_epc_stop() to stop
    the PCI LINK.
 
 2.2 PCI Endpoint Function(EPF) Library
+--------------------------------------
 
 The EPF library provides APIs to be used by the function driver and the EPC
 library to provide endpoint mode functionality.
 
 2.2.1 APIs for the PCI Endpoint Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
 
-*) pci_epf_register_driver()
+* pci_epf_register_driver()
 
    The PCI Endpoint Function driver should implement the following ops:
 	 * bind: ops to perform when a EPC device has been bound to EPF device
@@ -166,50 +178,54 @@ by the PCI endpoint function driver.
   The PCI Function driver can then register the PCI EPF driver by using
   pci_epf_register_driver().
 
-*) pci_epf_unregister_driver()
+* pci_epf_unregister_driver()
 
   The PCI Function driver can unregister the PCI EPF driver by using
   pci_epf_unregister_driver().
 
-*) pci_epf_alloc_space()
+* pci_epf_alloc_space()
 
   The PCI Function driver can allocate space for a particular BAR using
   pci_epf_alloc_space().
 
-*) pci_epf_free_space()
+* pci_epf_free_space()
 
   The PCI Function driver can free the allocated space
   (using pci_epf_alloc_space) by invoking pci_epf_free_space().
 
 2.2.2 APIs for the PCI Endpoint Controller Library
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint controller library.
 
-*) pci_epf_linkup()
+* pci_epf_linkup()
 
    The PCI endpoint controller library invokes pci_epf_linkup() when the
    EPC device has established the connection to the host.
 
-2.2.2 Other APIs
+2.2.3 Other APIs
+~~~~~~~~~~~~~~~~
+
 There are other APIs provided by the EPF library. These are used to notify
 the function driver when the EPF device is bound to the EPC device.
 pci-ep-cfs.c can be used as reference for using these APIs.
 
-*) pci_epf_create()
+* pci_epf_create()
 
    Create a new PCI EPF device by passing the name of the PCI EPF device.
    This name will be used to bind the the EPF device to a EPF driver.
 
-*) pci_epf_destroy()
+* pci_epf_destroy()
 
    Destroy the created PCI EPF device.
 
-*) pci_epf_bind()
+* pci_epf_bind()
 
    pci_epf_bind() should be invoked when the EPF device has been bound to
    a EPC device.
 
-*) pci_epf_unbind()
+* pci_epf_unbind()
 
    pci_epf_unbind() should be invoked when the binding between EPC device
    and EPF device is lost.
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 44b7f9ca039e..72a0668ccfc4 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -14,3 +14,4 @@ Linux PCI Bus Subsystem
    acpi-info
    pci-error-recovery
    pcieaer-howto
+   endpoint/index
-- 
2.20.1

