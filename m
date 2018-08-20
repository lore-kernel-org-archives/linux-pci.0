Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Message-ID: <fa217fe562df74980febdd57e8e3361c2ece2ae2.camel@kernel.crashing.org>
Subject: PATCH] Partial revert of "PCI/AER: Handle ERR_FATAL with removal
 and re-enumeration of devices"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: poza@codeaurora.org, Thomas Tai <thomas.tai@oracle.com>,
        bhelgaas@google.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Mon, 20 Aug 2018 14:39:04 +1000
In-Reply-To: <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
	 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
	 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
	 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
	 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
	 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
	 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
	 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
	 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

This partially reverts commit 7e9084b36740b2ec263ea35efb203001f755e1d8.

This only reverts the Documentation/PCI/pci-error-recovery.txt changes

Those changes are incorrect, they change the documentation to adapt
to the (imho incorrect) AER implementation, and as a result making
it no longer match the EEH implementation.

I believe the policy described originally in this document is what
should be implemented by everybody and the changes done by that commit
would compromise, among others, the ability to recover from errors with
storage devices.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 Documentation/PCI/pci-error-recovery.txt | 35 +++++++-----------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.txt
index 688b69121e82..0b6bb3ef449e 100644
--- a/Documentation/PCI/pci-error-recovery.txt
+++ b/Documentation/PCI/pci-error-recovery.txt
@@ -110,7 +110,7 @@ The actual steps taken by a platform to recover from a PCI error
 event will be platform-dependent, but will follow the general
 sequence described below.
 
-STEP 0: Error Event: ERR_NONFATAL
+STEP 0: Error Event
 -------------------
 A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
 is isolated, in that all I/O is blocked: all reads return 0xffffffff,
@@ -228,7 +228,13 @@ proceeds to either STEP3 (Link Reset) or to STEP 5 (Resume Operations).
 If any driver returned PCI_ERS_RESULT_NEED_RESET, then the platform
 proceeds to STEP 4 (Slot Reset)
 
-STEP 3: Slot Reset
+STEP 3: Link Reset
+------------------
+The platform resets the link.  This is a PCI-Express specific step
+and is done whenever a fatal error has been detected that can be
+"solved" by resetting the link.
+
+STEP 4: Slot Reset
 ------------------
 
 In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
@@ -314,7 +320,7 @@ Failure).
 >>> However, it probably should.
 
 
-STEP 4: Resume Operations
+STEP 5: Resume Operations
 -------------------------
 The platform will call the resume() callback on all affected device
 drivers if all drivers on the segment have returned
@@ -326,7 +332,7 @@ a result code.
 At this point, if a new error happens, the platform will restart
 a new error recovery sequence.
 
-STEP 5: Permanent Failure
+STEP 6: Permanent Failure
 -------------------------
 A "permanent failure" has occurred, and the platform cannot recover
 the device.  The platform will call error_detected() with a
@@ -349,27 +355,6 @@ errors. See the discussion in powerpc/eeh-pci-error-recovery.txt
 for additional detail on real-life experience of the causes of
 software errors.
 
-STEP 0: Error Event: ERR_FATAL
--------------------
-PCI bus error is detected by the PCI hardware. On powerpc, the slot is
-isolated, in that all I/O is blocked: all reads return 0xffffffff, all
-writes are ignored.
-
-STEP 1: Remove devices
---------------------
-Platform removes the devices depending on the error agent, it could be
-this port for all subordinates or upstream component (likely downstream
-port)
-
-STEP 2: Reset link
---------------------
-The platform resets the link.  This is a PCI-Express specific step and is
-done whenever a fatal error has been detected that can be "solved" by
-resetting the link.
-
-STEP 3: Re-enumerate the devices
---------------------
-Initiates the re-enumeration.
 
 Conclusion; General Remarks
 ---------------------------
