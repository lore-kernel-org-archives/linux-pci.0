Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28226C10F05
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E296C218A2
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/WtR/HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfC2QFA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:05:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42455 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfC2QE7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:04:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so1259915pfn.9;
        Fri, 29 Mar 2019 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70uFyYUTHK2HUyIxh1jdXAqC7VTLnqnIpLrU+Z8D6QY=;
        b=R/WtR/HQeEXzxD8wOOlurk1/5fTLqcfJAFOmXd/SOPyrFAF0z/UHi4gLud/GSbfdRo
         bgbSEe23mfMtHeFF0BvrRB14hftkdsJccrYPgf4oA8u1zvmV7yT/AjbuV6E4Xb1kdTgU
         RU0MtPSjIQWrNJYoJOdTAtTSqY2He8AGdrihvg/Zs/sV31lvOmzt6qhhqlXvdAMagovD
         5TglJa7cVvVEYuTc6tI02rASeEOPBOzAPd1bugOCOLHaxzVZxmPvJWfQSVgunJhZczql
         YmZ8m84NxCB3ezztJ5W4D3v+hdgeJ1Pra0L8YwTz6IzM+UANyXPMpRtq8uOqrm1DIuT2
         STbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70uFyYUTHK2HUyIxh1jdXAqC7VTLnqnIpLrU+Z8D6QY=;
        b=iW4Uqt9X6T5LTxfol81MWutUY/VJNZEVTk/SPDLBxNsP7gxxVeZX9p/o9j3MK8fp0a
         Mgf/EigZoHtBWUIzKmiM53xa1yumt40ryRpiRsYckVu/tw/6QbjnkRE6cbbtfuotld1+
         M8YYJWcjIBvmwH/NBypZrCFJmIwmAj0I7dmBoBeqdE4Xme5p6bwDD/FztMDXrtflNvfd
         AiYbJCzqNsuVWhybJhNStD2Z89Cs7DurYdaui5HgLQeESNvlx/qq3ayqBUUi6dYxCeE/
         SVpcdKbN66voJNqW9f3dXcWZjlKBIyEkzmkXu1NXRdPmOBI5GDhzuuEKdZviWgkMu+nK
         sEoA==
X-Gm-Message-State: APjAAAXTF1xEN6fGuLVlinTdvETAEMyV4DaogxZJmYZKhVNLA/qSgztP
        eA12cECk2MdEUdFutvSmxstSmheOYHU=
X-Google-Smtp-Source: APXvYqy0u1WmYPP5ODajWQ4yqjqvB/BfJ7VIHlclQJK1+ERpCyCdVwH1ShdqnkiDSpQeMY4vNe7VjA==
X-Received: by 2002:a62:4815:: with SMTP id v21mr46513797pfa.167.1553875498426;
        Fri, 29 Mar 2019 09:04:58 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:04:57 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 07/12] pci doc: convert PCI/pci-error-recovery.txt to rst format
Date:   Sat, 30 Mar 2019 00:04:08 +0800
Message-Id: <20190329160413.4293-8-changbin.du@gmail.com>
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
 Documentation/PCI/index.rst                   |   1 +
 ...or-recovery.txt => pci-error-recovery.rst} | 180 +++++++++---------
 MAINTAINERS                                   |   2 +-
 3 files changed, 96 insertions(+), 87 deletions(-)
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 6e608afa55c1..e545460f5b3b 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -12,3 +12,4 @@ Linux PCI Bus Subsystem
    pci-iov-howto
    MSI-HOWTO
    acpi-info
+   pci-error-recovery
diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.rst
similarity index 80%
rename from Documentation/PCI/pci-error-recovery.txt
rename to Documentation/PCI/pci-error-recovery.rst
index 0b6bb3ef449e..ee74b0013c16 100644
--- a/Documentation/PCI/pci-error-recovery.txt
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -1,12 +1,15 @@
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
+February 2, 2006
+
+Current document maintainer:
+  - Linas Vepstas <linasvepstas@gmail.com>
+  - updated by Richard Lary <rlary@us.ibm.com>
+  - and Mike Mason <mmlnx@us.ibm.com> on 27-Jul-2009
 
 
 Many PCI bus controllers are able to detect a variety of hardware
@@ -63,7 +66,8 @@ mechanisms for dealing with SCSI bus errors and SCSI bus resets.
 
 
 Detailed Design
----------------
+===============
+
 Design and implementation details below, based on a chain of
 public email discussions with Ben Herrenschmidt, circa 5 April 2005.
 
@@ -73,30 +77,33 @@ pci_driver. A driver that fails to provide the structure is "non-aware",
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
@@ -134,16 +141,17 @@ shouldn't do any new IOs. Called in task context. This is sort of a
 
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
@@ -177,7 +185,7 @@ is STEP 6 (Permanent Failure).
 >>> get the device working again.
 
 STEP 2: MMIO Enabled
--------------------
+--------------------
 The platform re-enables MMIO to the device (but typically not the
 DMA), and then calls the mmio_enabled() callback on all affected
 device drivers.
@@ -203,23 +211,23 @@ instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
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
@@ -293,24 +301,24 @@ device will be considered "dead" in this case.
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
@@ -370,23 +378,23 @@ The current policy is to turn this into a platform policy.
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
index 718890f348d4..994e849d56ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11966,7 +11966,7 @@ M:	Sam Bobroff <sbobroff@linux.ibm.com>
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

