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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14ADC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F412084F
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyQmYhPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfDIP4x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:56:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34691 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDIP4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 11:56:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so9657141plt.1;
        Tue, 09 Apr 2019 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5HFAKWUCr5U5uYHe5yyobnPaLvGutqLb7zNlZCPKwM=;
        b=gyQmYhPwEDG0ycbcusRQvumZALLRNKitRCHTbO1qYrZJDax/zijcxQZ2ePTyZ9i++x
         KjH2RGkPAJ6lrNTT6yb8oRK1YfbfFEMlOwrJFWIskalNBUv6exbpAqGjoJm3TZwYtley
         fZJo9a2uvqMaZJwebeJIaTjoB6W37ERtIss0VDv3nohJdOkp+VUFcMdadrF1sY+A2syN
         yKd6oCTkWsJJJ/1mzCxuOzi69QI52PAFKNaHgIYCZeGSOtKsVo0LKXfe7WR0H/g9RgUx
         XkYk10775fxw+xOTQmbxsf3ao5rm1epqJBHTzEC75Ukg6hx29k2fVuGqVFUXklw0YRpp
         wcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5HFAKWUCr5U5uYHe5yyobnPaLvGutqLb7zNlZCPKwM=;
        b=l0+sfhWT1+Oh5HO5kTDdGqOfqMr+JoAcS3a6N1w4H+NaQUk8zYAVQK5VL+wkIXLpQF
         zQgyBFBSAHU2VJfYyVO4QEaCryjX2F+DfXz8qXovca3rxo+JuhJYv4pZ2oRcrCTamC6K
         HJaKDegvkFnDTN2oZszKKVn2Ktg2TmRejxhwGWa9qotdrRI1rrfIQEMYNJuyRw/xZy+A
         PkvAW+L/ghZEeDuLrtPTateXTPcM7mCTbX5SuAcxQZ9IDfKSycekRttlfJoTIeqWhxCf
         mo5xC0jYOSWRXI3Hbf8MzHjMrFAmEB74vTe0S6DlkpuQ0zaOMzxBRLVH29vqb6Zd6YVZ
         wMbQ==
X-Gm-Message-State: APjAAAXxipUH5y6aEFC6uci/7hGOvnA1a/vROth8HgV46JK+cwY90idz
        2U1D7ORWrU8NqohwUf+6igPmYKSt
X-Google-Smtp-Source: APXvYqx9aeSrrpNGAv8AFC/Ritsby4txL0TbXoHOcufDOAFYQG25tRRThOpKC6EFr3b4iw4H2xuLRw==
X-Received: by 2002:a17:902:a506:: with SMTP id s6mr36630652plq.164.1554825412030;
        Tue, 09 Apr 2019 08:56:52 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b72sm70383560pga.86.2019.04.09.08.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:56:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 03/12] Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
Date:   Tue,  9 Apr 2019 23:56:17 +0800
Message-Id: <20190409155626.6049-4-changbin.du@gmail.com>
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
 .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 140 ++++++++++--------
 Documentation/PCI/index.rst                   |   1 +
 2 files changed, 82 insertions(+), 59 deletions(-)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (70%)

diff --git a/Documentation/PCI/PCIEBUS-HOWTO.txt b/Documentation/PCI/PCIEBUS-HOWTO.rst
similarity index 70%
rename from Documentation/PCI/PCIEBUS-HOWTO.txt
rename to Documentation/PCI/PCIEBUS-HOWTO.rst
index 15f0bb3b5045..f882ff62c51f 100644
--- a/Documentation/PCI/PCIEBUS-HOWTO.txt
+++ b/Documentation/PCI/PCIEBUS-HOWTO.rst
@@ -1,16 +1,23 @@
-		The PCI Express Port Bus Driver Guide HOWTO
-	Tom L Nguyen tom.l.nguyen@intel.com
-			11/03/2004
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-1. About this guide
+===========================================
+The PCI Express Port Bus Driver Guide HOWTO
+===========================================
+
+:Author: Tom L Nguyen tom.l.nguyen@intel.com 11/03/2004
+:Copyright: |copy| 2004 Intel Corporation
+
+About this guide
+================
 
 This guide describes the basics of the PCI Express Port Bus driver
 and provides information on how to enable the service drivers to
 register/unregister with the PCI Express Port Bus Driver.
 
-2. Copyright 2004 Intel Corporation
 
-3. What is the PCI Express Port Bus Driver
+What is the PCI Express Port Bus Driver
+=======================================
 
 A PCI Express Port is a logical PCI-PCI Bridge structure. There
 are two types of PCI Express Port: the Root Port and the Switch
@@ -30,7 +37,8 @@ support (AER), and virtual channel support (VC). These services may
 be handled by a single complex driver or be individually distributed
 and handled by corresponding service drivers.
 
-4. Why use the PCI Express Port Bus Driver?
+Why use the PCI Express Port Bus Driver?
+========================================
 
 In existing Linux kernels, the Linux Device Driver Model allows a
 physical device to be handled by only a single driver. The PCI
@@ -51,28 +59,31 @@ PCI Express Ports and distributes all provided service requests
 to the corresponding service drivers as required. Some key
 advantages of using the PCI Express Port Bus driver are listed below:
 
-	- Allow multiple service drivers to run simultaneously on
-	  a PCI-PCI Bridge Port device.
+  - Allow multiple service drivers to run simultaneously on
+    a PCI-PCI Bridge Port device.
 
-	- Allow service drivers implemented in an independent
-	  staged approach.
+  - Allow service drivers implemented in an independent
+    staged approach.
 
-	- Allow one service driver to run on multiple PCI-PCI Bridge
-	  Port devices.
+  - Allow one service driver to run on multiple PCI-PCI Bridge
+    Port devices.
 
-	- Manage and distribute resources of a PCI-PCI Bridge Port
-	  device to requested service drivers.
+  - Manage and distribute resources of a PCI-PCI Bridge Port
+    device to requested service drivers.
 
-5. Configuring the PCI Express Port Bus Driver vs. Service Drivers
+Configuring the PCI Express Port Bus Driver vs. Service Drivers
+===============================================================
 
-5.1 Including the PCI Express Port Bus Driver Support into the Kernel
+Including the PCI Express Port Bus Driver Support into the Kernel
+-----------------------------------------------------------------
 
 Including the PCI Express Port Bus driver depends on whether the PCI
 Express support is included in the kernel config. The kernel will
 automatically include the PCI Express Port Bus driver as a kernel
 driver when the PCI Express support is enabled in the kernel.
 
-5.2 Enabling Service Driver Support
+Enabling Service Driver Support
+-------------------------------
 
 PCI device drivers are implemented based on Linux Device Driver Model.
 All service drivers are PCI device drivers. As discussed above, it is
@@ -89,9 +100,11 @@ header file /include/linux/pcieport_if.h, before calling these APIs.
 Failure to do so will result an identity mismatch, which prevents
 the PCI Express Port Bus driver from loading a service driver.
 
-5.2.1 pcie_port_service_register
+pcie_port_service_register
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+::
 
-int pcie_port_service_register(struct pcie_port_service_driver *new)
+  int pcie_port_service_register(struct pcie_port_service_driver *new)
 
 This API replaces the Linux Driver Model's pci_register_driver API. A
 service driver should always calls pcie_port_service_register at
@@ -99,69 +112,76 @@ module init. Note that after service driver being loaded, calls
 such as pci_enable_device(dev) and pci_set_master(dev) are no longer
 necessary since these calls are executed by the PCI Port Bus driver.
 
-5.2.2 pcie_port_service_unregister
+pcie_port_service_unregister
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+::
 
-void pcie_port_service_unregister(struct pcie_port_service_driver *new)
+  void pcie_port_service_unregister(struct pcie_port_service_driver *new)
 
 pcie_port_service_unregister replaces the Linux Driver Model's
 pci_unregister_driver. It's always called by service driver when a
 module exits.
 
-5.2.3 Sample Code
+Sample Code
+~~~~~~~~~~~
 
 Below is sample service driver code to initialize the port service
 driver data structure.
+::
 
-static struct pcie_port_service_id service_id[] = { {
-	.vendor = PCI_ANY_ID,
-	.device = PCI_ANY_ID,
-	.port_type = PCIE_RC_PORT,
-	.service_type = PCIE_PORT_SERVICE_AER,
-	}, { /* end: all zeroes */ }
-};
+  static struct pcie_port_service_id service_id[] = { {
+    .vendor = PCI_ANY_ID,
+    .device = PCI_ANY_ID,
+    .port_type = PCIE_RC_PORT,
+    .service_type = PCIE_PORT_SERVICE_AER,
+    }, { /* end: all zeroes */ }
+  };
 
-static struct pcie_port_service_driver root_aerdrv = {
-	.name		= (char *)device_name,
-	.id_table	= &service_id[0],
+  static struct pcie_port_service_driver root_aerdrv = {
+    .name		= (char *)device_name,
+    .id_table	= &service_id[0],
 
-	.probe		= aerdrv_load,
-	.remove		= aerdrv_unload,
+    .probe		= aerdrv_load,
+    .remove		= aerdrv_unload,
 
-	.suspend	= aerdrv_suspend,
-	.resume		= aerdrv_resume,
-};
+    .suspend	= aerdrv_suspend,
+    .resume		= aerdrv_resume,
+  };
 
 Below is a sample code for registering/unregistering a service
 driver.
+::
 
-static int __init aerdrv_service_init(void)
-{
-	int retval = 0;
+  static int __init aerdrv_service_init(void)
+  {
+    int retval = 0;
 
-	retval = pcie_port_service_register(&root_aerdrv);
-	if (!retval) {
-		/*
-		 * FIX ME
-		 */
-	}
-	return retval;
-}
+    retval = pcie_port_service_register(&root_aerdrv);
+    if (!retval) {
+      /*
+      * FIX ME
+      */
+    }
+    return retval;
+  }
 
-static void __exit aerdrv_service_exit(void)
-{
-	pcie_port_service_unregister(&root_aerdrv);
-}
+  static void __exit aerdrv_service_exit(void)
+  {
+    pcie_port_service_unregister(&root_aerdrv);
+  }
 
-module_init(aerdrv_service_init);
-module_exit(aerdrv_service_exit);
+  module_init(aerdrv_service_init);
+  module_exit(aerdrv_service_exit);
 
-6. Possible Resource Conflicts
+Possible Resource Conflicts
+===========================
 
 Since all service drivers of a PCI-PCI Bridge Port device are
 allowed to run simultaneously, below lists a few of possible resource
 conflicts with proposed solutions.
 
-6.1 MSI and MSI-X Vector Resource
+MSI and MSI-X Vector Resource
+-----------------------------
 
 Once MSI or MSI-X interrupts are enabled on a device, it stays in this
 mode until they are disabled again.  Since service drivers of the same
@@ -179,7 +199,8 @@ driver. Service drivers should use (struct pcie_device*)dev->irq to
 call request_irq/free_irq. In addition, the interrupt mode is stored
 in the field interrupt_mode of struct pcie_device.
 
-6.3 PCI Memory/IO Mapped Regions
+PCI Memory/IO Mapped Regions
+----------------------------
 
 Service drivers for PCI Express Power Management (PME), Advanced
 Error Reporting (AER), Hot-Plug (HP) and Virtual Channel (VC) access
@@ -188,7 +209,8 @@ registers accessed are independent of each other. This patch assumes
 that all service drivers will be well behaved and not overwrite
 other service driver's configuration settings.
 
-6.4 PCI Config Registers
+PCI Config Registers
+--------------------
 
 Each service driver runs its PCI config operations on its own
 capability structure except the PCI Express capability structure, in
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 7babf43709b0..452723318405 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -9,3 +9,4 @@ Linux PCI Bus Subsystem
    :numbered:
 
    pci
+   PCIEBUS-HOWTO
-- 
2.20.1

