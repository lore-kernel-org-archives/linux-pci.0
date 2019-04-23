Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFD8C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7B020643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJwohfyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDWQgU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:36:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34089 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfDWQgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:36:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so7781291pfd.1;
        Tue, 23 Apr 2019 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70bPnOCiyT/McnTHJ3/ThQzEgD9Y96j/IQ+8yT0RXAA=;
        b=CJwohfyNyOcOjrjBjfqlgtXEtrh3HEgUIhaCB7eOoSsngkvWRBN/stGF4CxSYdf8n8
         W4xLZIq8lBL0opyHWnQHLZ3+/6uSDT5CnMMWpV2hpYFU3qOgpTUVK3SKaqcdlJ0djgDf
         l52qORM1S3r14SJG84sq4Sv+saCezWfSnXyCvCtRDjjg/9lxylB9EVxB0qt4rx3VDekS
         FBZGKSRwlSRO3Z+iuXqg84Xz0unWOzkTZQD9BOqoNYb+vHDBXc6I/OyxI08iPwLszEK8
         ZTrYTh9YEopCHRBzIjBkOdCiBqMCNzyjuH97O5bZC4n0Mq5+IhLPJo7/v1TD/3tRL2EH
         hcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70bPnOCiyT/McnTHJ3/ThQzEgD9Y96j/IQ+8yT0RXAA=;
        b=C29Dd3yvRmH3SqsMXV1sgYtwWKd+hfxiJPpS4zeQkmsyK+R+B0LvYktHs8h7UEZvdb
         CbLQwsmlDpA+wleRf97N8iZp+IyWPWjBSNR9VXOSilzH4DmJY77pzKm158PrPFhzJxR+
         IVKxgjU+e+WWuHioLVaJa/mhkOBHiTeWwNwiPvDxyUnCI9DdYtt6cB/PpnpwSqQ6gK1t
         oh/0KmKuCtuPYmgMnR+vAM+kJ8Fdv+WdpqvOpHBqCluGi1lUEiFqFdWXXu2b59f7j1ni
         BENHqTxKO28UrjtpI5G4cP5VihlEUt0uZGuk1OugED92oEDPyt0TP5IOUIg3gh8uuD7C
         emkw==
X-Gm-Message-State: APjAAAV4Djc/MDegOmrkgv8A/lH7cPYbAIVpXfawO+95Vq2CXRP+9eTy
        2f5hRZL5d5CP+4csORVwaR4=
X-Google-Smtp-Source: APXvYqyzYVFHjkceIrTiQEx2z3mbLQ+/fQbI2/w9YJ4ZyIKIQIcufmggM48AcwnhjyRrUEcdaqQHeA==
X-Received: by 2002:a63:de0a:: with SMTP id f10mr15882421pgg.418.1556037379239;
        Tue, 23 Apr 2019 09:36:19 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:36:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 36/63] Documentation: PCI: convert endpoint/pci-test-howto.txt to reST
Date:   Wed, 24 Apr 2019 00:29:05 +0800
Message-Id: <20190423162932.21428-37-changbin.du@gmail.com>
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
 ...{pci-test-howto.txt => pci-test-howto.rst} | 81 +++++++++++++------
 2 files changed, 56 insertions(+), 26 deletions(-)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index b680a3fc4fec..d114ea74b444 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -10,3 +10,4 @@ PCI Endpoint Framework
    pci-endpoint
    pci-endpoint-cfs
    pci-test-function
+   pci-test-howto
diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.rst
similarity index 78%
rename from Documentation/PCI/endpoint/pci-test-howto.txt
rename to Documentation/PCI/endpoint/pci-test-howto.rst
index 040479f437a5..909f770a07d6 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.txt
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -1,38 +1,51 @@
-			    PCI TEST USERGUIDE
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+PCI Test User Guide
+===================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 This document is a guide to help users use pci-epf-test function driver
 and pci_endpoint_test host driver for testing PCI. The list of steps to
 be followed in the host side and EP side is given below.
 
-1. Endpoint Device
+Endpoint Device
+===============
 
-1.1 Endpoint Controller Devices
+Endpoint Controller Devices
+---------------------------
 
-To find the list of endpoint controller devices in the system:
+To find the list of endpoint controller devices in the system::
 
 	# ls /sys/class/pci_epc/
 	  51000000.pcie_ep
 
-If PCI_ENDPOINT_CONFIGFS is enabled
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
 	# ls /sys/kernel/config/pci_ep/controllers
 	  51000000.pcie_ep
 
-1.2 Endpoint Function Drivers
 
-To find the list of endpoint function drivers in the system:
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
 
 	# ls /sys/bus/pci-epf/drivers
 	  pci_epf_test
 
-If PCI_ENDPOINT_CONFIGFS is enabled
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
 	# ls /sys/kernel/config/pci_ep/functions
 	  pci_epf_test
 
-1.3 Creating pci-epf-test Device
+
+Creating pci-epf-test Device
+----------------------------
 
 PCI endpoint function device can be created using the configfs. To create
-pci-epf-test device, the following commands can be used
+pci-epf-test device, the following commands can be used::
 
 	# mount -t configfs none /sys/kernel/config
 	# cd /sys/kernel/config/pci_ep/
@@ -42,7 +55,7 @@ The "mkdir func1" above creates the pci-epf-test function device that will
 be probed by pci_epf_test driver.
 
 The PCI endpoint framework populates the directory with the following
-configurable fields.
+configurable fields::
 
 	# ls functions/pci_epf_test/func1
 	  baseclass_code	interrupt_pin	progif_code	subsys_id
@@ -51,67 +64,83 @@ configurable fields.
 
 The PCI endpoint function driver populates these entries with default values
 when the device is bound to the driver. The pci-epf-test driver populates
-vendorid with 0xffff and interrupt_pin with 0x0001
+vendorid with 0xffff and interrupt_pin with 0x0001::
 
 	# cat functions/pci_epf_test/func1/vendorid
 	  0xffff
 	# cat functions/pci_epf_test/func1/interrupt_pin
 	  0x0001
 
-1.4 Configuring pci-epf-test Device
+
+Configuring pci-epf-test Device
+-------------------------------
 
 The user can configure the pci-epf-test device using configfs entry. In order
 to change the vendorid and the number of MSI interrupts used by the function
-device, the following commands can be used.
+device, the following commands can be used::
 
 	# echo 0x104c > functions/pci_epf_test/func1/vendorid
 	# echo 0xb500 > functions/pci_epf_test/func1/deviceid
 	# echo 16 > functions/pci_epf_test/func1/msi_interrupts
 	# echo 8 > functions/pci_epf_test/func1/msix_interrupts
 
-1.5 Binding pci-epf-test Device to EP Controller
+
+Binding pci-epf-test Device to EP Controller
+--------------------------------------------
 
 In order for the endpoint function device to be useful, it has to be bound to
 a PCI endpoint controller driver. Use the configfs to bind the function
-device to one of the controller driver present in the system.
+device to one of the controller driver present in the system::
 
 	# ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
 
 Once the above step is completed, the PCI endpoint is ready to establish a link
 with the host.
 
-1.6 Start the Link
+
+Start the Link
+--------------
 
 In order for the endpoint device to establish a link with the host, the _start_
-field should be populated with '1'.
+field should be populated with '1'::
 
 	# echo 1 > controllers/51000000.pcie_ep/start
 
-2. RootComplex Device
 
-2.1 lspci Output
+RootComplex Device
+==================
+
+lspci Output
+------------
 
-Note that the devices listed here correspond to the value populated in 1.4 above
+Note that the devices listed here correspond to the value populated in 1.4
+above::
 
 	00:00.0 PCI bridge: Texas Instruments Device 8888 (rev 01)
 	01:00.0 Unassigned class [ff00]: Texas Instruments Device b500
 
-2.2 Using Endpoint Test function Device
+
+Using Endpoint Test function Device
+-----------------------------------
 
 pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
-tests. To compile this tool the following commands should be used:
+tests. To compile this tool the following commands should be used::
 
 	# cd <kernel-dir>
 	# make -C tools/pci
 
-or if you desire to compile and install in your system:
+or if you desire to compile and install in your system::
 
 	# cd <kernel-dir>
 	# make -C tools/pci install
 
 The tool and script will be located in <rootfs>/usr/bin/
 
-2.2.1 pcitest.sh Output
+
+pcitest.sh Output
+~~~~~~~~~~~~~~~~~
+::
+
 	# pcitest.sh
 	BAR tests
 
-- 
2.20.1

