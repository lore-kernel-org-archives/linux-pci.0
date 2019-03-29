Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CEAC4360F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36AF218A2
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c48WLe0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfC2QEq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:04:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43189 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbfC2QEp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:04:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so1422072pgu.10;
        Fri, 29 Mar 2019 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfLHZRyXVpnVjAvzJ43Ia9/54FDDh56whR+hIcoeYQ4=;
        b=c48WLe0OxtWOIXfJg6KR3ToRvBjl87odhb6XpiWGsRKSpQT0lHIv0Hoz/HhANo/L9u
         pHNA+GqAAv1kAzInJ1SCiP/M7rXxJCPupw5JbRPeMXy7MY9OR2ZcdukCUCoD5zRyZm2E
         zVSsZs9ReQ6BCMyrgFSplOzawNZNGC5qz82twsM4Dk3RUpJZcSJg+loeCLxjJAhoDrVn
         scG/cVWPltLqukY6tcsyTeVF/Rysb41bWTpLDAgg8Z73gpmBh52fRyjLx1m4H3JzFeMI
         s2XFLyuBePIvxYng16zRzi06RkACljOgpnyJ65rXHHFsnodp0AYn+O/iSoXoddCton1b
         yWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfLHZRyXVpnVjAvzJ43Ia9/54FDDh56whR+hIcoeYQ4=;
        b=kM2kX7JRx16CnMA0gnHQWspZON+GJ10yU5NuoUVcctJ/I1qQUSxW+dq4AVpWph0693
         iE3LzgcaGSpGeV67jFlFDPSwT8vWOV/jD9cuPkajQ1O8fwhQ/Lmm1SiZUUOaru4YdC/0
         QoTmyFew4DLNQiAUWcMTUWvJ02nODXxptWek0OCXh50pUHVbswNfmzJBO8Jyww/zTMt/
         KDtQashMcIZyDVXQ7GOjbHgNHzeCzjrpkSy+D+KD+DEbzF/tWvaSvAOwpNQTcXbl8mrR
         rM5YTZbDeNzCT8QtaP3xXtu0hbe6CukaUUp25Or2hY7xwGYgzt/CRFL/9FBrF0G7kbKc
         RZlA==
X-Gm-Message-State: APjAAAVCZh0Y6bR+/81opwHc4jujmyqm/QeQj79OGQ+F/5vdva8OcNGz
        FlP2DW/eDPj/MzlEaz1lKLE=
X-Google-Smtp-Source: APXvYqw4nO+dsWnO6+pw56C6+filjsDiZg29NxeZjCq4bQmIZXKFJ9J7/ui9y17xlMJivPiPHPVDvQ==
X-Received: by 2002:a62:305:: with SMTP id 5mr26894183pfd.65.1553875483551;
        Fri, 29 Mar 2019 09:04:43 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:04:42 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 03/12] pci doc: convert PCI/PCIEBUS-HOWTO.txt to rst format
Date:   Sat, 30 Mar 2019 00:04:04 +0800
Message-Id: <20190329160413.4293-4-changbin.du@gmail.com>
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
 .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 112 +++++++++++-------
 Documentation/PCI/index.rst                   |   1 +
 2 files changed, 68 insertions(+), 45 deletions(-)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (75%)

diff --git a/Documentation/PCI/PCIEBUS-HOWTO.txt b/Documentation/PCI/PCIEBUS-HOWTO.rst
similarity index 75%
rename from Documentation/PCI/PCIEBUS-HOWTO.txt
rename to Documentation/PCI/PCIEBUS-HOWTO.rst
index 15f0bb3b5045..bde6530689a6 100644
--- a/Documentation/PCI/PCIEBUS-HOWTO.txt
+++ b/Documentation/PCI/PCIEBUS-HOWTO.rst
@@ -1,16 +1,23 @@
-		The PCI Express Port Bus Driver Guide HOWTO
-	Tom L Nguyen tom.l.nguyen@intel.com
-			11/03/2004
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+The PCI Express Port Bus Driver Guide HOWTO
+===========================================
+
+:Author: Tom L Nguyen tom.l.nguyen@intel.com 11/03/2004
 
 1. About this guide
+===================
 
 This guide describes the basics of the PCI Express Port Bus driver
 and provides information on how to enable the service drivers to
 register/unregister with the PCI Express Port Bus Driver.
 
 2. Copyright 2004 Intel Corporation
+===================================
 
 3. What is the PCI Express Port Bus Driver
+==========================================
 
 A PCI Express Port is a logical PCI-PCI Bridge structure. There
 are two types of PCI Express Port: the Root Port and the Switch
@@ -31,6 +38,7 @@ be handled by a single complex driver or be individually distributed
 and handled by corresponding service drivers.
 
 4. Why use the PCI Express Port Bus Driver?
+===========================================
 
 In existing Linux kernels, the Linux Device Driver Model allows a
 physical device to be handled by only a single driver. The PCI
@@ -51,21 +59,23 @@ PCI Express Ports and distributes all provided service requests
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
 
 5. Configuring the PCI Express Port Bus Driver vs. Service Drivers
+==================================================================
 
 5.1 Including the PCI Express Port Bus Driver Support into the Kernel
+---------------------------------------------------------------------
 
 Including the PCI Express Port Bus driver depends on whether the PCI
 Express support is included in the kernel config. The kernel will
@@ -73,6 +83,7 @@ automatically include the PCI Express Port Bus driver as a kernel
 driver when the PCI Express support is enabled in the kernel.
 
 5.2 Enabling Service Driver Support
+-----------------------------------
 
 PCI device drivers are implemented based on Linux Device Driver Model.
 All service drivers are PCI device drivers. As discussed above, it is
@@ -90,8 +101,10 @@ Failure to do so will result an identity mismatch, which prevents
 the PCI Express Port Bus driver from loading a service driver.
 
 5.2.1 pcie_port_service_register
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+::
 
-int pcie_port_service_register(struct pcie_port_service_driver *new)
+  int pcie_port_service_register(struct pcie_port_service_driver *new)
 
 This API replaces the Linux Driver Model's pci_register_driver API. A
 service driver should always calls pcie_port_service_register at
@@ -100,68 +113,75 @@ such as pci_enable_device(dev) and pci_set_master(dev) are no longer
 necessary since these calls are executed by the PCI Port Bus driver.
 
 5.2.2 pcie_port_service_unregister
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+::
 
-void pcie_port_service_unregister(struct pcie_port_service_driver *new)
+  void pcie_port_service_unregister(struct pcie_port_service_driver *new)
 
 pcie_port_service_unregister replaces the Linux Driver Model's
 pci_unregister_driver. It's always called by service driver when a
 module exits.
 
 5.2.3 Sample Code
+~~~~~~~~~~~~~~~~~
 
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
 
 6. Possible Resource Conflicts
+==============================
 
 Since all service drivers of a PCI-PCI Bridge Port device are
 allowed to run simultaneously, below lists a few of possible resource
 conflicts with proposed solutions.
 
 6.1 MSI and MSI-X Vector Resource
+---------------------------------
 
 Once MSI or MSI-X interrupts are enabled on a device, it stays in this
 mode until they are disabled again.  Since service drivers of the same
@@ -180,6 +200,7 @@ call request_irq/free_irq. In addition, the interrupt mode is stored
 in the field interrupt_mode of struct pcie_device.
 
 6.3 PCI Memory/IO Mapped Regions
+--------------------------------
 
 Service drivers for PCI Express Power Management (PME), Advanced
 Error Reporting (AER), Hot-Plug (HP) and Virtual Channel (VC) access
@@ -189,6 +210,7 @@ that all service drivers will be well behaved and not overwrite
 other service driver's configuration settings.
 
 6.4 PCI Config Registers
+------------------------
 
 Each service driver runs its PCI config operations on its own
 capability structure except the PCI Express capability structure, in
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 06fce3d3c7da..58ce08f14f33 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -8,3 +8,4 @@ Linux PCI Bus Subsystem
    :maxdepth: 2
 
    pci
+   PCIEBUS-HOWTO
-- 
2.20.1

