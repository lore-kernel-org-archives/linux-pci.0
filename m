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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F6AC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893092084C
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPB16sTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDIP52 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:57:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40035 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfDIP51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 11:57:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so5004717pgl.7;
        Tue, 09 Apr 2019 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70bPnOCiyT/McnTHJ3/ThQzEgD9Y96j/IQ+8yT0RXAA=;
        b=SPB16sTCvMJPQO9GdrEhPEsKQ3jc6/0SHl1bV9/1wBiM6pW5RaZF1ohRngkdAwiJAW
         2OGEqTIB2IkZ+YM3vZkZUC7mn22xmQH5+Hl9PsTjrQCNtAvWMPtiFSoY5KvpBJWPL0p1
         zFrDYRON5oGTvBcakTPiah0WktIYsEi4xDGfbsFykYVJxFYgrONB+nuM3MwXQlIzDOPa
         ZUQvVcOqIEw8VnKPQxd4DXJcndL4n1Tlj0bWDHOsJJ2kgoNj0pjlyJKwjLcXdVCfVLXX
         6o4fHsqbpfuy0++ZoE8RdZ9ppiWaTGL3amjYvYPTvPpqV8zLuURxKXwpRwm3gnn6OkQY
         4aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70bPnOCiyT/McnTHJ3/ThQzEgD9Y96j/IQ+8yT0RXAA=;
        b=LGNZENurRTSx2kmUK1cs3nUXOpmL3eTosmC3MY0LsyJ+vJODxlpL+FR9cxR79Z7RNK
         G0BuoqHtIVxGI8xDESMtyUpgu37ltwQpPmrlfxjcZ0xcwSzzoktY7735+x0d07IvO2RL
         fIEO9JsZcp1+4lnxmzKdp4uNNcNMoAvXKXrAlqmhU01cdQxKHrazw2LEpPqxmdt9F4ar
         5E6auyG1pMzJlvEAGiP0in4eG3y4Hqadg9CHia6AyCr81vwaghoRAlrpqtsJpEJ1xdgB
         vdFLszFVm1OCQcwgjGZn6+tmsR7LgFpb8ct2PqALcHnGsOzRIV1rNPhl28+5uIr4kZ7q
         UDZQ==
X-Gm-Message-State: APjAAAX8LErFaksxtg7wu7cfSzLWwvDjT04q/J/2xpRDv8+eSvd/doHE
        9UaUJmMqLcuPNtt4EZS4L4A=
X-Google-Smtp-Source: APXvYqxgscPMjcN8Wqt3u/bC0HtMPqhOVDlke3DBjdczX6Y9h2Z6lbf4gmh5P7SCXfvlQo3A332vFA==
X-Received: by 2002:a62:7648:: with SMTP id r69mr18322984pfc.114.1554825446239;
        Tue, 09 Apr 2019 08:57:26 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b72sm70383560pga.86.2019.04.09.08.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:57:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 12/12] Documentation: PCI: convert endpoint/pci-test-howto.txt to reST
Date:   Tue,  9 Apr 2019 23:56:26 +0800
Message-Id: <20190409155626.6049-13-changbin.du@gmail.com>
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

