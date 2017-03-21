Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linasvepstas@gmail.com>, <bhelgaas@google.com>, <corbet@lwn.net>
Subject: [PATCH] pci-error-recovery: doc cleanup
Date: Tue, 21 Mar 2017 21:24:18 +0800
Message-ID: <1490102658-22768-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Include whitespace shooting; correction; typo fix; superfluous word
dropping.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
This patch was sent in last December, which is not quite suitable at that time,
because link reset is not clear. Now the section "Link Reset" has been cleaned,
submit this patch again.

 Documentation/PCI/pci-error-recovery.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.txt
index da3b217..0b6bb3e 100644
--- a/Documentation/PCI/pci-error-recovery.txt
+++ b/Documentation/PCI/pci-error-recovery.txt
@@ -11,7 +11,7 @@
 
 Many PCI bus controllers are able to detect a variety of hardware
 PCI errors on the bus, such as parity errors on the data and address
-busses, as well as SERR and PERR errors.  Some of the more advanced
+buses, as well as SERR and PERR errors.  Some of the more advanced
 chipsets are able to deal with these errors; these include PCI-E chipsets,
 and the PCI-host bridges found on IBM Power4, Power5 and Power6-based
 pSeries boxes. A typical action taken is to disconnect the affected device,
@@ -173,7 +173,7 @@ is STEP 6 (Permanent Failure).
 >>> a value of 0xff on read, and writes will be dropped. If more than
 >>> EEH_MAX_FAILS I/O's are attempted to a frozen adapter, EEH
 >>> assumes that the device driver has gone into an infinite loop
->>> and prints an error to syslog.  A reboot is then required to 
+>>> and prints an error to syslog.  A reboot is then required to
 >>> get the device working again.
 
 STEP 2: MMIO Enabled
@@ -231,14 +231,14 @@ proceeds to STEP 4 (Slot Reset)
 STEP 3: Link Reset
 ------------------
 The platform resets the link.  This is a PCI-Express specific step
-and is done whenever a non-fatal error has been detected that can be
+and is done whenever a fatal error has been detected that can be
 "solved" by resetting the link.
 
 STEP 4: Slot Reset
 ------------------
 
 In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
-the platform will perform a slot reset on the requesting PCI device(s). 
+the platform will perform a slot reset on the requesting PCI device(s).
 The actual steps taken by a platform to perform a slot reset
 will be platform-dependent. Upon completion of slot reset, the
 platform will call the device slot_reset() callback.
@@ -258,7 +258,7 @@ configuration registers to initialize to their default conditions.
 
 For most PCI devices, a soft reset will be sufficient for recovery.
 Optional fundamental reset is provided to support a limited number
-of PCI Express PCI devices  for which a soft reset is not sufficient
+of PCI Express devices for which a soft reset is not sufficient
 for recovery.
 
 If the platform supports PCI hotplug, then the reset might be
@@ -303,7 +303,7 @@ driver performs device init only from PCI function 0:
 		Same as above.
 
 Drivers for PCI Express cards that require a fundamental reset must
-set the needs_freset bit in the pci_dev structure in their probe function.  
+set the needs_freset bit in the pci_dev structure in their probe function.
 For example, the QLogic qla2xxx driver sets the needs_freset bit for certain
 PCI card types:
 
-- 
2.1.0
