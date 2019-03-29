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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D9C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A31218A5
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8xgbg61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfC2QFU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:05:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40262 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfC2QFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:05:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so1424309pgo.7;
        Fri, 29 Mar 2019 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DTs2F3TYidZr7cje60otCadEG79AP9K4JDvwsoCDmg=;
        b=s8xgbg61qP+b5fLqlyh36+gCdLHx3I43xj2CGniLBbYFpQgQqRIowDJ16Pnb//yp3X
         4+trdl2ZUFkRjswlGS3xMupZgifWKpQiTkkii1AIqh9Knfrr0OXjMZcb4btkPdzT4XzC
         Rt/q0EcsF3mwTIRdjj+a01JMYjQ0rCQ2AWgkrsCJU+VHFkxZF4z+3v6EFjyUse2ytuV4
         94K+3w3O5yMpMObQyZ1E7m6Mt9y+9W1jF9RB6DURJ+FHeEuMSXl0/GBI7Ao0/5ofv5G0
         U0WctpeAVnd6t9w6r7eBqtL2pFkWqAe0HDS/uJ5wg80EJXcqQG3y8DvBizntbuh63him
         f/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DTs2F3TYidZr7cje60otCadEG79AP9K4JDvwsoCDmg=;
        b=OubA9dhxexHp1KlsdmzMfUeKKJfPauDmjmwkx013yjF/Ivv81e8PLYGQPkVcnw4P8F
         jJjlR+cpXS+9A1MzFa0LibySTcwnln9/g63nIt/LmzJVrHdKENRK3u8KZk5/Hny1tFta
         vfciHBCSbhNJk9ZzWSMXy4+GfKCL91F5XwIRDdEmjBUu2tspbxtJRzfQ7erHac6Iczo/
         16oL4bQ8E2yyamVqC2HMZztwxLOMBxi8i8+sCk7trkMiF7gmtdsy3LjflGNdGdfMW+RM
         J4YaLvnqBcBuWJoG9IIaWY4v/Q/rMTFgTKG/H8GHFSRxyHSwcQo0BsGFbwVmi0vaynz2
         4j4Q==
X-Gm-Message-State: APjAAAVcmAtM47x2ABSpKK4oyX/TCrf08CRpOJhmwz5i5ov5gXxeurvu
        yXVkmj1CcfY0ITvlVKGtnkc=
X-Google-Smtp-Source: APXvYqzEokN1Ft8omYYxMYEwFZ/sj5QePtEKPLeHQddVC2bl4U7+jwn+Va5uTvYFIeXZ9ojzTAQOlQ==
X-Received: by 2002:aa7:83ca:: with SMTP id j10mr47488716pfn.50.1553875517288;
        Fri, 29 Mar 2019 09:05:17 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:05:16 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 12/12] pci doc: convert PCI/endpoint/pci-test-howto.txt to rst format
Date:   Sat, 30 Mar 2019 00:04:13 +0800
Message-Id: <20190329160413.4293-13-changbin.du@gmail.com>
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
 ...{pci-test-howto.txt => pci-test-howto.rst} | 51 +++++++++++++------
 2 files changed, 37 insertions(+), 15 deletions(-)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (83%)

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
similarity index 83%
rename from Documentation/PCI/endpoint/pci-test-howto.txt
rename to Documentation/PCI/endpoint/pci-test-howto.rst
index 040479f437a5..a81ae7daafa0 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.txt
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -1,38 +1,49 @@
-			    PCI TEST USERGUIDE
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+PCI TEST USERGUIDE
+==================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 This document is a guide to help users use pci-epf-test function driver
 and pci_endpoint_test host driver for testing PCI. The list of steps to
 be followed in the host side and EP side is given below.
 
 1. Endpoint Device
+==================
 
 1.1 Endpoint Controller Devices
+-------------------------------
 
-To find the list of endpoint controller devices in the system:
+To find the list of endpoint controller devices in the system::
 
 	# ls /sys/class/pci_epc/
 	  51000000.pcie_ep
 
-If PCI_ENDPOINT_CONFIGFS is enabled
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
 	# ls /sys/kernel/config/pci_ep/controllers
 	  51000000.pcie_ep
 
 1.2 Endpoint Function Drivers
+-----------------------------
 
-To find the list of endpoint function drivers in the system:
+To find the list of endpoint function drivers in the system::
 
 	# ls /sys/bus/pci-epf/drivers
 	  pci_epf_test
 
-If PCI_ENDPOINT_CONFIGFS is enabled
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
 	# ls /sys/kernel/config/pci_ep/functions
 	  pci_epf_test
 
 1.3 Creating pci-epf-test Device
+--------------------------------
 
 PCI endpoint function device can be created using the configfs. To create
-pci-epf-test device, the following commands can be used
+pci-epf-test device, the following commands can be used::
 
 	# mount -t configfs none /sys/kernel/config
 	# cd /sys/kernel/config/pci_ep/
@@ -42,7 +53,7 @@ The "mkdir func1" above creates the pci-epf-test function device that will
 be probed by pci_epf_test driver.
 
 The PCI endpoint framework populates the directory with the following
-configurable fields.
+configurable fields::
 
 	# ls functions/pci_epf_test/func1
 	  baseclass_code	interrupt_pin	progif_code	subsys_id
@@ -51,7 +62,7 @@ configurable fields.
 
 The PCI endpoint function driver populates these entries with default values
 when the device is bound to the driver. The pci-epf-test driver populates
-vendorid with 0xffff and interrupt_pin with 0x0001
+vendorid with 0xffff and interrupt_pin with 0x0001::
 
 	# cat functions/pci_epf_test/func1/vendorid
 	  0xffff
@@ -59,10 +70,11 @@ vendorid with 0xffff and interrupt_pin with 0x0001
 	  0x0001
 
 1.4 Configuring pci-epf-test Device
+-----------------------------------
 
 The user can configure the pci-epf-test device using configfs entry. In order
 to change the vendorid and the number of MSI interrupts used by the function
-device, the following commands can be used.
+device, the following commands can be used::
 
 	# echo 0x104c > functions/pci_epf_test/func1/vendorid
 	# echo 0xb500 > functions/pci_epf_test/func1/deviceid
@@ -70,10 +82,11 @@ device, the following commands can be used.
 	# echo 8 > functions/pci_epf_test/func1/msix_interrupts
 
 1.5 Binding pci-epf-test Device to EP Controller
+------------------------------------------------
 
 In order for the endpoint function device to be useful, it has to be bound to
 a PCI endpoint controller driver. Use the configfs to bind the function
-device to one of the controller driver present in the system.
+device to one of the controller driver present in the system::
 
 	# ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
 
@@ -81,30 +94,35 @@ Once the above step is completed, the PCI endpoint is ready to establish a link
 with the host.
 
 1.6 Start the Link
+------------------
 
 In order for the endpoint device to establish a link with the host, the _start_
-field should be populated with '1'.
+field should be populated with '1'::
 
 	# echo 1 > controllers/51000000.pcie_ep/start
 
 2. RootComplex Device
+=====================
 
 2.1 lspci Output
+----------------
 
-Note that the devices listed here correspond to the value populated in 1.4 above
+Note that the devices listed here correspond to the value populated in 1.4
+above::
 
 	00:00.0 PCI bridge: Texas Instruments Device 8888 (rev 01)
 	01:00.0 Unassigned class [ff00]: Texas Instruments Device b500
 
 2.2 Using Endpoint Test function Device
+---------------------------------------
 
 pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
-tests. To compile this tool the following commands should be used:
+tests. To compile this tool the following commands should be used::
 
 	# cd <kernel-dir>
 	# make -C tools/pci
 
-or if you desire to compile and install in your system:
+or if you desire to compile and install in your system::
 
 	# cd <kernel-dir>
 	# make -C tools/pci install
@@ -112,6 +130,9 @@ or if you desire to compile and install in your system:
 The tool and script will be located in <rootfs>/usr/bin/
 
 2.2.1 pcitest.sh Output
+~~~~~~~~~~~~~~~~~~~~~~~
+::
+
 	# pcitest.sh
 	BAR tests
 
-- 
2.20.1

