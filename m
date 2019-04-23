Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80744C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514CA20643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7xjiwdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfDWQfm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:35:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39920 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfDWQfm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:35:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so7762898pfo.6;
        Tue, 23 Apr 2019 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPBWtsg+36gllYWhNGP3v3p3CvhW7bWaWVSWgF9mrKc=;
        b=a7xjiwdukx1txes2GCAEp/0sbb5II3pPjMv+S1nCE1E7tKDRIjUpXHY7UmF8doVfXz
         TstxUx2ZM+Seis6+eAI28uSYrdbvZPWQuhN+JR1o7nPaEpk1K43HqVFB4hL+CYAlFJ/J
         /ub/YMbxljPqMbd93uecE6EK36RrZHUagDijCZlrJq3yDmLDoeQeSxRM5P4W0rhHZO2w
         aiWJNTCnxGfCoNUwgT7UXTXm+9rYzG4pXSCv4SFeFcEHvlhuhrZy9DiSQfWj8zvBsR/n
         MwbvayR8NDbbSd9JO/FKPWq2gYdCZHd4c9yHhthnjIShdj0B6ZDLi9CdQDQs2dZxUPkT
         9ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPBWtsg+36gllYWhNGP3v3p3CvhW7bWaWVSWgF9mrKc=;
        b=of06s62+k8Izw9uJnJ1ko6lWGZuuDl3aSf+lS0Yu7BHfwFL9W3jR+R5DNMCqY2C97s
         eBZWCB7R9+ZOFWpTXzDlBFk6M4KgGtJVE/tnyP833oXmDR6ixlfePs8sULHPRM5wUpxY
         N2bORnMVznkG4m9DSAc29t0DvrmxsoRTqht4qs5CQhRptAWynHlUgTVs0m2tOsTE4AYU
         ET7oRyfmBsHwrsyo2SrSFkvk+TTqULbuq3klEzBhZA7p3BjRomz86VpO4R32PSksV7Oh
         UkYoFBen0aDI+Z+wXdSLGVr2x/cL8b5WVXI+udcqa7qGH85MoGRDRcJKE5YT6d5uv+p1
         jZQQ==
X-Gm-Message-State: APjAAAVhE3GC6RfIldYibnmSmMgN+z1WerAdP9aK4RGziYCYD7aizIvS
        0ZwREdD/86FO+P5nu2DlKe0=
X-Google-Smtp-Source: APXvYqywQt9PWsj5libo9gUYJqiURxkx9D+oM7RuaaTKo3OaofU9F7rZP5zVx7S6irj5fkaWEPmx/g==
X-Received: by 2002:a63:5953:: with SMTP id j19mr25396511pgm.260.1556037340388;
        Tue, 23 Apr 2019 09:35:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:35:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 32/63] Documentation: PCI: convert pcieaer-howto.txt to reST
Date:   Wed, 24 Apr 2019 00:29:01 +0800
Message-Id: <20190423162932.21428-33-changbin.du@gmail.com>
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
 Documentation/PCI/index.rst                   |   1 +
 .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 110 ++++++++++++------
 2 files changed, 74 insertions(+), 37 deletions(-)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (81%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5ee4dba07116..86c76c22810b 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -14,3 +14,4 @@ Linux PCI Bus Subsystem
    MSI-HOWTO
    acpi-info
    pci-error-recovery
+   pcieaer-howto
diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.rst
similarity index 81%
rename from Documentation/PCI/pcieaer-howto.txt
rename to Documentation/PCI/pcieaer-howto.rst
index 48ce7903e3c6..67f77ff76865 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -1,21 +1,29 @@
-   The PCI Express Advanced Error Reporting Driver Guide HOWTO
-		T. Long Nguyen	<tom.l.nguyen@intel.com>
-		Yanmin Zhang	<yanmin.zhang@intel.com>
-				07/29/2006
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
+===========================================================
+The PCI Express Advanced Error Reporting Driver Guide HOWTO
+===========================================================
 
-1. Overview
+:Authors: - T. Long Nguyen <tom.l.nguyen@intel.com>
+          - Yanmin Zhang <yanmin.zhang@intel.com>
 
-1.1 About this guide
+:Copyright: |copy| 2006 Intel Corporation
+
+Overview
+===========
+
+About this guide
+----------------
 
 This guide describes the basics of the PCI Express Advanced Error
 Reporting (AER) driver and provides information on how to use it, as
 well as how to enable the drivers of endpoint devices to conform with
 PCI Express AER driver.
 
-1.2 Copyright (C) Intel Corporation 2006.
 
-1.3 What is the PCI Express AER Driver?
+What is the PCI Express AER Driver?
+-----------------------------------
 
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
 
 
-2. User Guide
+User Guide
+==========
 
-2.1 Include the PCI Express AER Root Driver into the Linux Kernel
+Include the PCI Express AER Root Driver into the Linux Kernel
+-------------------------------------------------------------
 
 The PCI Express AER Root driver is a Root Port service driver attached
 to the PCI Express Port Bus driver. If a user wants to use it, the driver
@@ -48,7 +58,8 @@ has to be compiled. Option CONFIG_PCIEAER supports this capability. It
 depends on CONFIG_PCIEPORTBUS, so pls. set CONFIG_PCIEPORTBUS=y and
 CONFIG_PCIEAER = y.
 
-2.2 Load PCI Express AER Root Driver
+Load PCI Express AER Root Driver
+--------------------------------
 
 Some systems have AER support in firmware. Enabling Linux AER support at
 the same time the firmware handles AER may result in unpredictable
@@ -56,30 +67,34 @@ behavior. Therefore, Linux does not handle AER events unless the firmware
 grants AER control to the OS via the ACPI _OSC method. See the PCI FW 3.0
 Specification for details regarding _OSC usage.
 
-2.3 AER error output
+AER error output
+----------------
 
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
 
-2.4 AER Statistics / Counters
+AER Statistics / Counters
+-------------------------
 
 When PCIe AER errors are captured, the counters / statistics are also exposed
 in the form of sysfs attributes which are documented at
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 
-3. Developer Guide
+Developer Guide
+===============
 
 To enable AER aware support requires a software driver to configure
 the AER capability structure within its device and to provide callbacks.
@@ -120,7 +135,8 @@ hierarchy and links. These errors do not include any device specific
 errors because device specific errors will still get sent directly to
 the device driver.
 
-3.1 Configure the AER capability structure
+Configure the AER capability structure
+--------------------------------------
 
 AER aware drivers of PCI Express component need change the device
 control registers to enable AER. They also could change AER registers,
@@ -128,9 +144,11 @@ including mask and severity registers. Helper function
 pci_enable_pcie_error_reporting could be used to enable AER. See
 section 3.3.
 
-3.2. Provide callbacks
+Provide callbacks
+-----------------
 
-3.2.1 callback reset_link to reset pci express link
+callback reset_link to reset pci express link
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
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
 
-3.2.2 PCI error-recovery callbacks
+PCI error-recovery callbacks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The PCI Express AER Root driver uses error callbacks to coordinate
 with downstream device drivers associated with a hierarchy in question
@@ -161,7 +181,8 @@ definitions of the callbacks.
 
 Below sections specify when to call the error callback functions.
 
-3.2.2.1 Correctable errors
+Correctable errors
+~~~~~~~~~~~~~~~~~~
 
 Correctable errors pose no impacts on the functionality of
 the interface. The PCI Express protocol can recover without any
@@ -169,13 +190,16 @@ software intervention or any loss of data. These errors do not
 require any recovery actions. The AER driver clears the device's
 correctable error status register accordingly and logs these errors.
 
-3.2.2.2 Non-correctable (non-fatal and fatal) errors
+Non-correctable (non-fatal and fatal) errors
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
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
 
@@ -199,23 +223,33 @@ function. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER and
 reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
 to mmio_enabled.
 
-3.3 helper functions
+helper functions
+----------------
+::
+
+  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 
-3.3.1 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 pci_enable_pcie_error_reporting enables the device to send error
 messages to root port when an error is detected. Note that devices
 don't enable the error reporting by default, so device drivers need
 call this function to enable it.
 
-3.3.2 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+::
+
+  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+
 pci_disable_pcie_error_reporting disables the device to send error
 messages to root port when an error is detected.
 
-3.3.3 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+::
+
+  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
+
 pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
 error status register.
 
-3.4 Frequent Asked Questions
+Frequent Asked Questions
+------------------------
 
 Q: What happens if a PCI Express device driver does not provide an
 error recovery handler (pci_driver->err_handler is equal to NULL)?
@@ -245,7 +279,8 @@ A: It could call the helper functions to enable AER in devices and
 cleanup uncorrectable status register. Pls. refer to section 3.3.
 
 
-4. Software error injection
+Software error injection
+========================
 
 Debugging PCIe AER error recovery code is quite difficult because it
 is hard to trigger real hardware errors. Software based error
@@ -261,6 +296,7 @@ After reboot with new kernel or insert the module, a device file named
 
 Then, you need a user space tool named aer-inject, which can be gotten
 from:
+
     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
 More information about aer-inject can be found in the document comes
-- 
2.20.1

