Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5683EC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD5B218D0
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QReLzJfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfC2QFE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:05:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46461 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfC2QFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:05:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so1412005pgv.13;
        Fri, 29 Mar 2019 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4hSXmGqwPQU1xe5RNxceWJ8ZqdYqyVPInAzPVs6gJM=;
        b=QReLzJfeho8GoOBuxYlYxCEgq76XzJ4NEliqBQnqKNusw2ivNidgVXjFEEDkkwcV85
         7xayDoiMHnwZH3s4kAlCDbw1/LXmh1WpSeDosB21FTs2jQF5VBkKmLvNSyj4HvC8llSy
         Q/2Na4Z//dawVwNH1uF7oQqJviBoFrV7A5oQOl+C+Kjy4+9jpxq1xJzcmqlVxB8P9Cm3
         HFzNH/f2hbC6jYKboPD6jZcNS4fYtdFWpFEAgAayPHPvYaqYia5jp+DmkF+HlnxZxFJT
         f799C4JBoWdIYnFW/E/i4MhM4n3t5vmSIhbCw3DShKOQXtsHQnfhMtu1sPs79REOStNT
         Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4hSXmGqwPQU1xe5RNxceWJ8ZqdYqyVPInAzPVs6gJM=;
        b=iVJAVtpW1ajhmrM1OtpTgoRkuNYFDF9DAnwh+xhimRB0qygZX1SqOh3FXTxz3SJUQb
         CRExo4tyfNOoyDg//0K+FM4SKXrI4v+64tGa8vqV+HE6DTwXndyt4Lugotyp71qKs3qw
         dnAvhiKyRJaFv7IOwLZ6MuNvLvBitdKYh5rT4E6/EavmQURc4q77cwTTLSZ0BEiXh2Wy
         Mn+xog7NmXgkl69ANM4m7vQh/qhTfQgesqENk5yYzeZmJNsf8qzg+50uQSakPqrTwLg2
         h1GLr1uivGnLqQA9Wf6o22zQ9Rv7XNfzWZ0M3oXpLcprrKa2WKTk/RH9SFJyb63m+/Va
         xM+Q==
X-Gm-Message-State: APjAAAUQ6aPtXwZBKNKj/OM3kNMPz+c7XuT5m8Xp/9A2MUBToGMjVr5q
        Wq/i1mhHVt1yoQIWgCmy5WE=
X-Google-Smtp-Source: APXvYqzDg5SMG52i6zNi/3qyGEgsrL/ibRTzbOLPSGQMnYCer2o8I9Q8Rs4ySGKDL9fgYe8W9l6B+w==
X-Received: by 2002:a62:458a:: with SMTP id n10mr49030415pfi.136.1553875502469;
        Fri, 29 Mar 2019 09:05:02 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:05:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 08/12] pci doc: convert PCI/pcieaer-howto.txt to rst format
Date:   Sat, 30 Mar 2019 00:04:09 +0800
Message-Id: <20190329160413.4293-9-changbin.du@gmail.com>
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
 Documentation/PCI/index.rst                   |  1 +
 .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 67 ++++++++++++++-----
 2 files changed, 50 insertions(+), 18 deletions(-)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (83%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index e545460f5b3b..44b7f9ca039e 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -13,3 +13,4 @@ Linux PCI Bus Subsystem
    MSI-HOWTO
    acpi-info
    pci-error-recovery
+   pcieaer-howto
diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.rst
similarity index 83%
rename from Documentation/PCI/pcieaer-howto.txt
rename to Documentation/PCI/pcieaer-howto.rst
index 48ce7903e3c6..b471ca9dde2f 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -1,12 +1,18 @@
-   The PCI Express Advanced Error Reporting Driver Guide HOWTO
-		T. Long Nguyen	<tom.l.nguyen@intel.com>
-		Yanmin Zhang	<yanmin.zhang@intel.com>
-				07/29/2006
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+The PCI Express Advanced Error Reporting Driver Guide HOWTO
+===========================================================
+
+:Authors: - T. Long Nguyen <tom.l.nguyen@intel.com>
+	  - Yanmin Zhang <yanmin.zhang@intel.com> 7/29/2006
 
 
 1. Overview
+===========
 
 1.1 About this guide
+--------------------
 
 This guide describes the basics of the PCI Express Advanced Error
 Reporting (AER) driver and provides information on how to use it, as
@@ -14,8 +20,10 @@ well as how to enable the drivers of endpoint devices to conform with
 PCI Express AER driver.
 
 1.2 Copyright (C) Intel Corporation 2006.
+-----------------------------------------
 
 1.3 What is the PCI Express AER Driver?
+---------------------------------------
 
 PCI Express error signaling can occur on the PCI Express link itself
 or on behalf of transactions initiated on the link. PCI Express
@@ -30,17 +38,19 @@ The PCI Express AER driver provides the infrastructure to support PCI
 Express Advanced Error Reporting capability. The PCI Express AER
 driver provides three basic functions:
 
--	Gathers the comprehensive error information if errors occurred.
--	Reports error to the users.
--	Performs error recovery actions.
+  - Gathers the comprehensive error information if errors occurred.
+  - Reports error to the users.
+  - Performs error recovery actions.
 
 AER driver only attaches root ports which support PCI-Express AER
 capability.
 
 
 2. User Guide
+=============
 
 2.1 Include the PCI Express AER Root Driver into the Linux Kernel
+-----------------------------------------------------------------
 
 The PCI Express AER Root driver is a Root Port service driver attached
 to the PCI Express Port Bus driver. If a user wants to use it, the driver
@@ -49,6 +59,7 @@ depends on CONFIG_PCIEPORTBUS, so pls. set CONFIG_PCIEPORTBUS=y and
 CONFIG_PCIEAER = y.
 
 2.2 Load PCI Express AER Root Driver
+------------------------------------
 
 Some systems have AER support in firmware. Enabling Linux AER support at
 the same time the firmware handles AER may result in unpredictable
@@ -57,29 +68,33 @@ grants AER control to the OS via the ACPI _OSC method. See the PCI FW 3.0
 Specification for details regarding _OSC usage.
 
 2.3 AER error output
+--------------------
 
 When a PCIe AER error is captured, an error message will be output to
 console. If it's a correctable error, it is output as a warning.
 Otherwise, it is printed as an error. So users could choose different
 log level to filter out correctable error messages.
 
-Below shows an example:
-0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
-0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
-0000:50:00.0:    [20] Unsupported Request    (First)
-0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
+Below shows an example::
+
+  0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
+  0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
+  0000:50:00.0:    [20] Unsupported Request    (First)
+  0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
 
 In the example, 'Requester ID' means the ID of the device who sends
 the error message to root port. Pls. refer to pci express specs for
 other fields.
 
 2.4 AER Statistics / Counters
+-----------------------------
 
 When PCIe AER errors are captured, the counters / statistics are also exposed
 in the form of sysfs attributes which are documented at
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 
 3. Developer Guide
+==================
 
 To enable AER aware support requires a software driver to configure
 the AER capability structure within its device and to provide callbacks.
@@ -121,6 +136,7 @@ errors because device specific errors will still get sent directly to
 the device driver.
 
 3.1 Configure the AER capability structure
+------------------------------------------
 
 AER aware drivers of PCI Express component need change the device
 control registers to enable AER. They also could change AER registers,
@@ -129,8 +145,10 @@ pci_enable_pcie_error_reporting could be used to enable AER. See
 section 3.3.
 
 3.2. Provide callbacks
+----------------------
 
 3.2.1 callback reset_link to reset pci express link
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This callback is used to reset the pci express physical link when a
 fatal error happens. The root port aer service driver provides a
@@ -140,13 +158,15 @@ upstream ports should provide their own reset_link functions.
 
 In struct pcie_port_service_driver, a new pointer, reset_link, is
 added.
+::
 
-pci_ers_result_t (*reset_link) (struct pci_dev *dev);
+	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
 
 Section 3.2.2.2 provides more detailed info on when to call
 reset_link.
 
 3.2.2 PCI error-recovery callbacks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The PCI Express AER Root driver uses error callbacks to coordinate
 with downstream device drivers associated with a hierarchy in question
@@ -162,6 +182,7 @@ definitions of the callbacks.
 Below sections specify when to call the error callback functions.
 
 3.2.2.1 Correctable errors
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Correctable errors pose no impacts on the functionality of
 the interface. The PCI Express protocol can recover without any
@@ -170,12 +191,15 @@ require any recovery actions. The AER driver clears the device's
 correctable error status register accordingly and logs these errors.
 
 3.2.2.2 Non-correctable (non-fatal and fatal) errors
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If an error message indicates a non-fatal error, performing link reset
 at upstream is not required. The AER driver calls error_detected(dev,
 pci_channel_io_normal) to all drivers associated within a hierarchy in
-question. for example,
-EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort.
+question. for example::
+
+  EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort
+
 If Upstream port A captures an AER error, the hierarchy consists of
 Downstream port B and EndPoint.
 
@@ -200,22 +224,27 @@ reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
 to mmio_enabled.
 
 3.3 helper functions
+--------------------
 
-3.3.1 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
+3.3.1 `int pci_enable_pcie_error_reporting(struct pci_dev *dev);`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 pci_enable_pcie_error_reporting enables the device to send error
 messages to root port when an error is detected. Note that devices
 don't enable the error reporting by default, so device drivers need
 call this function to enable it.
 
-3.3.2 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+3.3.2 `int pci_disable_pcie_error_reporting(struct pci_dev *dev);`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 pci_disable_pcie_error_reporting disables the device to send error
 messages to root port when an error is detected.
 
-3.3.3 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+3.3.3 `int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
 error status register.
 
 3.4 Frequent Asked Questions
+----------------------------
 
 Q: What happens if a PCI Express device driver does not provide an
 error recovery handler (pci_driver->err_handler is equal to NULL)?
@@ -246,6 +275,7 @@ cleanup uncorrectable status register. Pls. refer to section 3.3.
 
 
 4. Software error injection
+===========================
 
 Debugging PCIe AER error recovery code is quite difficult because it
 is hard to trigger real hardware errors. Software based error
@@ -261,6 +291,7 @@ After reboot with new kernel or insert the module, a device file named
 
 Then, you need a user space tool named aer-inject, which can be gotten
 from:
+
     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
 More information about aer-inject can be found in the document comes
-- 
2.20.1

