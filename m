Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE179C282E1
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E820643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNJXAzLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDWQfe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:35:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46813 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfDWQfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:35:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so7748104pfj.13;
        Tue, 23 Apr 2019 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v+zgnn47uLdn+X54RP5MgjyfKDn3nQHf0IpsX4yrTDc=;
        b=lNJXAzLxGOpb2+KvjUGBMe3jbPKrILIyMEPZyAnvquuyaSrfmqpOusj3sCEO+0Bk+F
         q45A+O6ef8RA1tDEBw3tosBB06ZpcmK01GJ55CJWB5No1HZaPg6hBw5HgeJ4Lxnxm+fL
         xAIpqFQOwib74pE+hQOs7/ADjrSTBCnFXGVyzTlGYy5xxmar/B6bSy/4wwyFkYsYhsR5
         3rbLglBAIMm0EAzD8SbZAfIrV7rUQ5dXdxjsRYZGbpZXXfE2JOd1NJWyM7VPsKWsWov5
         7m3HU+uj+OjQwMxOSIWH+/VSqpEq4hmT5ZCNJ4b/XbxZ25O5A7hVecu1ifEsJfDn0oY7
         qu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+zgnn47uLdn+X54RP5MgjyfKDn3nQHf0IpsX4yrTDc=;
        b=JCWkT5pr0Uoep9CYGyUjlLV5Xba/6CyMqamDpMOu+ejYO9PEC7/W3gdFVB0d5f56KG
         NyZZSF1QVX04L1VfzhqOKbwXzC4vsOybHDIbkqu5748o4OFSezU1k1pdZvzCByp5BVq6
         QzeU6liRHVqvI0maEmqi47nHxm+35p5YYC040gs5Ik9Wu+9QbeAW9OJnRBKbRZM6GP6A
         mwqETZhUfqKytjZyAwq4Jqax8OWUtG5SE6U9v4RG0jaBSZ9uUm+ZVRpwUXfQSL3MHSjC
         NM/eQAqlzWHiRXBR3PnKdhCdPNHUd6jDXft/J5nXzRQPswn2A+d1LXhiFB/pe8eJznyw
         lZVA==
X-Gm-Message-State: APjAAAVczqikIdHBAmXsGE7Yj1Q303JreNl8se0zgNnIQkuuSnIsubQx
        OvrICaQYfMiCESCw9Gtb3Nk=
X-Google-Smtp-Source: APXvYqzNSxwoDLEdYAmMIVHzmxD8ogIEeOAJHKYUKX7q1Es7HG/85lpBe/bBzFw/l/l/XwQTraXFxw==
X-Received: by 2002:a63:6907:: with SMTP id e7mr24905722pgc.209.1556037332097;
        Tue, 23 Apr 2019 09:35:32 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:35:31 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 31/63] Documentation: PCI: convert pci-error-recovery.txt to reST
Date:   Wed, 24 Apr 2019 00:29:00 +0800
Message-Id: <20190423162932.21428-32-changbin.du@gmail.com>
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
 ...or-recovery.txt => pci-error-recovery.rst} | 178 +++++++++---------
 MAINTAINERS                                   |   2 +-
 3 files changed, 94 insertions(+), 87 deletions(-)
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index c877a369481d..5ee4dba07116 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -13,3 +13,4 @@ Linux PCI Bus Subsystem
    pci-iov-howto
    MSI-HOWTO
    acpi-info
+   pci-error-recovery
diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.rst
similarity index 80%
rename from Documentation/PCI/pci-error-recovery.txt
rename to Documentation/PCI/pci-error-recovery.rst
index 0b6bb3ef449e..533ec4035bf5 100644
--- a/Documentation/PCI/pci-error-recovery.txt
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -1,12 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-                       PCI Error Recovery
-                       ------------------
-                        February 2, 2006
+==================
+PCI Error Recovery
+==================
 
-                 Current document maintainer:
-             Linas Vepstas <linasvepstas@gmail.com>
-          updated by Richard Lary <rlary@us.ibm.com>
-       and Mike Mason <mmlnx@us.ibm.com> on 27-Jul-2009
+
+:Authors: - Linas Vepstas <linasvepstas@gmail.com>
+          - Richard Lary <rlary@us.ibm.com>
+          - Mike Mason <mmlnx@us.ibm.com>
 
 
 Many PCI bus controllers are able to detect a variety of hardware
@@ -63,7 +64,8 @@ mechanisms for dealing with SCSI bus errors and SCSI bus resets.
 
 
 Detailed Design
----------------
+===============
+
 Design and implementation details below, based on a chain of
 public email discussions with Ben Herrenschmidt, circa 5 April 2005.
 
@@ -73,30 +75,33 @@ pci_driver. A driver that fails to provide the structure is "non-aware",
 and the actual recovery steps taken are platform dependent.  The
 arch/powerpc implementation will simulate a PCI hotplug remove/add.
 
-This structure has the form:
-struct pci_error_handlers
-{
-	int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
-	int (*mmio_enabled)(struct pci_dev *dev);
-	int (*slot_reset)(struct pci_dev *dev);
-	void (*resume)(struct pci_dev *dev);
-};
-
-The possible channel states are:
-enum pci_channel_state {
-	pci_channel_io_normal,  /* I/O channel is in normal state */
-	pci_channel_io_frozen,  /* I/O to channel is blocked */
-	pci_channel_io_perm_failure, /* PCI card is dead */
-};
-
-Possible return values are:
-enum pci_ers_result {
-	PCI_ERS_RESULT_NONE,        /* no result/none/not supported in device driver */
-	PCI_ERS_RESULT_CAN_RECOVER, /* Device driver can recover without slot reset */
-	PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
-	PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
-	PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
-};
+This structure has the form::
+
+	struct pci_error_handlers
+	{
+		int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
+		int (*mmio_enabled)(struct pci_dev *dev);
+		int (*slot_reset)(struct pci_dev *dev);
+		void (*resume)(struct pci_dev *dev);
+	};
+
+The possible channel states are::
+
+	enum pci_channel_state {
+		pci_channel_io_normal,  /* I/O channel is in normal state */
+		pci_channel_io_frozen,  /* I/O to channel is blocked */
+		pci_channel_io_perm_failure, /* PCI card is dead */
+	};
+
+Possible return values are::
+
+	enum pci_ers_result {
+		PCI_ERS_RESULT_NONE,        /* no result/none/not supported in device driver */
+		PCI_ERS_RESULT_CAN_RECOVER, /* Device driver can recover without slot reset */
+		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
+		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
+		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
+	};
 
 A driver does not have to implement all of these callbacks; however,
 if it implements any, it must implement error_detected(). If a callback
@@ -134,16 +139,17 @@ shouldn't do any new IOs. Called in task context. This is sort of a
 
 All drivers participating in this system must implement this call.
 The driver must return one of the following result codes:
-		- PCI_ERS_RESULT_CAN_RECOVER:
-		  Driver returns this if it thinks it might be able to recover
-		  the HW by just banging IOs or if it wants to be given
-		  a chance to extract some diagnostic information (see
-		  mmio_enable, below).
-		- PCI_ERS_RESULT_NEED_RESET:
-		  Driver returns this if it can't recover without a
-		  slot reset.
-		- PCI_ERS_RESULT_DISCONNECT:
-		  Driver returns this if it doesn't want to recover at all.
+
+  - PCI_ERS_RESULT_CAN_RECOVER:
+    Driver returns this if it thinks it might be able to recover
+    the HW by just banging IOs or if it wants to be given
+    a chance to extract some diagnostic information (see
+    mmio_enable, below).
+  - PCI_ERS_RESULT_NEED_RESET:
+    Driver returns this if it can't recover without a
+    slot reset.
+  - PCI_ERS_RESULT_DISCONNECT:
+    Driver returns this if it doesn't want to recover at all.
 
 The next step taken will depend on the result codes returned by the
 drivers.
@@ -177,7 +183,7 @@ is STEP 6 (Permanent Failure).
 >>> get the device working again.
 
 STEP 2: MMIO Enabled
--------------------
+--------------------
 The platform re-enables MMIO to the device (but typically not the
 DMA), and then calls the mmio_enabled() callback on all affected
 device drivers.
@@ -203,23 +209,23 @@ instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
 >>> into one of the next states, that is, link reset or slot reset.
 
 The driver should return one of the following result codes:
-		- PCI_ERS_RESULT_RECOVERED
-		  Driver returns this if it thinks the device is fully
-		  functional and thinks it is ready to start
-		  normal driver operations again. There is no
-		  guarantee that the driver will actually be
-		  allowed to proceed, as another driver on the
-		  same segment might have failed and thus triggered a
-		  slot reset on platforms that support it.
-
-		- PCI_ERS_RESULT_NEED_RESET
-		  Driver returns this if it thinks the device is not
-		  recoverable in its current state and it needs a slot
-		  reset to proceed.
-
-		- PCI_ERS_RESULT_DISCONNECT
-		  Same as above. Total failure, no recovery even after
-		  reset driver dead. (To be defined more precisely)
+  - PCI_ERS_RESULT_RECOVERED
+    Driver returns this if it thinks the device is fully
+    functional and thinks it is ready to start
+    normal driver operations again. There is no
+    guarantee that the driver will actually be
+    allowed to proceed, as another driver on the
+    same segment might have failed and thus triggered a
+    slot reset on platforms that support it.
+
+  - PCI_ERS_RESULT_NEED_RESET
+    Driver returns this if it thinks the device is not
+    recoverable in its current state and it needs a slot
+    reset to proceed.
+
+  - PCI_ERS_RESULT_DISCONNECT
+    Same as above. Total failure, no recovery even after
+    reset driver dead. (To be defined more precisely)
 
 The next step taken depends on the results returned by the drivers.
 If all drivers returned PCI_ERS_RESULT_RECOVERED, then the platform
@@ -293,24 +299,24 @@ device will be considered "dead" in this case.
 Drivers for multi-function cards will need to coordinate among
 themselves as to which driver instance will perform any "one-shot"
 or global device initialization. For example, the Symbios sym53cxx2
-driver performs device init only from PCI function 0:
+driver performs device init only from PCI function 0::
 
-+       if (PCI_FUNC(pdev->devfn) == 0)
-+               sym_reset_scsi_bus(np, 0);
+	+       if (PCI_FUNC(pdev->devfn) == 0)
+	+               sym_reset_scsi_bus(np, 0);
 
-	Result codes:
-		- PCI_ERS_RESULT_DISCONNECT
-		Same as above.
+Result codes:
+	- PCI_ERS_RESULT_DISCONNECT
+	  Same as above.
 
 Drivers for PCI Express cards that require a fundamental reset must
 set the needs_freset bit in the pci_dev structure in their probe function.
 For example, the QLogic qla2xxx driver sets the needs_freset bit for certain
-PCI card types:
+PCI card types::
 
-+	/* Set EEH reset type to fundamental if required by hba  */
-+	if (IS_QLA24XX(ha) || IS_QLA25XX(ha) || IS_QLA81XX(ha))
-+		pdev->needs_freset = 1;
-+
+	+	/* Set EEH reset type to fundamental if required by hba  */
+	+	if (IS_QLA24XX(ha) || IS_QLA25XX(ha) || IS_QLA81XX(ha))
+	+		pdev->needs_freset = 1;
+	+
 
 Platform proceeds either to STEP 5 (Resume Operations) or STEP 6 (Permanent
 Failure).
@@ -370,23 +376,23 @@ The current policy is to turn this into a platform policy.
 That is, the recovery API only requires that:
 
  - There is no guarantee that interrupt delivery can proceed from any
-device on the segment starting from the error detection and until the
-slot_reset callback is called, at which point interrupts are expected
-to be fully operational.
+   device on the segment starting from the error detection and until the
+   slot_reset callback is called, at which point interrupts are expected
+   to be fully operational.
 
  - There is no guarantee that interrupt delivery is stopped, that is,
-a driver that gets an interrupt after detecting an error, or that detects
-an error within the interrupt handler such that it prevents proper
-ack'ing of the interrupt (and thus removal of the source) should just
-return IRQ_NOTHANDLED. It's up to the platform to deal with that
-condition, typically by masking the IRQ source during the duration of
-the error handling. It is expected that the platform "knows" which
-interrupts are routed to error-management capable slots and can deal
-with temporarily disabling that IRQ number during error processing (this
-isn't terribly complex). That means some IRQ latency for other devices
-sharing the interrupt, but there is simply no other way. High end
-platforms aren't supposed to share interrupts between many devices
-anyway :)
+   a driver that gets an interrupt after detecting an error, or that detects
+   an error within the interrupt handler such that it prevents proper
+   ack'ing of the interrupt (and thus removal of the source) should just
+   return IRQ_NOTHANDLED. It's up to the platform to deal with that
+   condition, typically by masking the IRQ source during the duration of
+   the error handling. It is expected that the platform "knows" which
+   interrupts are routed to error-management capable slots and can deal
+   with temporarily disabling that IRQ number during error processing (this
+   isn't terribly complex). That means some IRQ latency for other devices
+   sharing the interrupt, but there is simply no other way. High end
+   platforms aren't supposed to share interrupts between many devices
+   anyway :)
 
 >>> Implementation details for the powerpc platform are discussed in
 >>> the file Documentation/powerpc/eeh-pci-error-recovery.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 87f930bf32ad..403178958b05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11965,7 +11965,7 @@ M:	Sam Bobroff <sbobroff@linux.ibm.com>
 M:	Oliver O'Halloran <oohall@gmail.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-F:	Documentation/PCI/pci-error-recovery.txt
+F:	Documentation/PCI/pci-error-recovery.rst
 F:	drivers/pci/pcie/aer.c
 F:	drivers/pci/pcie/dpc.c
 F:	drivers/pci/pcie/err.c
-- 
2.20.1

