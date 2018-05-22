Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42677 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeEVW2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 18:28:30 -0400
Received: by mail-pl0-f67.google.com with SMTP id u6-v6so11727618pls.9
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2018 15:28:30 -0700 (PDT)
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
Subject: [PATCH 5/5] Documentation/PCI: Add details of PCI AER statistics
Date: Tue, 22 May 2018 15:28:05 -0700
Message-Id: <20180522222805.80314-6-rajatja@google.com>
In-Reply-To: <20180522222805.80314-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the PCI AER statistics details to
Documentation/PCI/pcieaer-howto.txt

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 Documentation/PCI/pcieaer-howto.txt | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
index acd0dddd6bb8..86ee9f9ff5e1 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.txt
@@ -73,6 +73,41 @@ In the example, 'Requester ID' means the ID of the device who sends
 the error message to root port. Pls. refer to pci express specs for
 other fields.
 
+2.4 AER statistics
+
+When AER messages are captured, the statistics are exposed via the following
+sysfs attributes under the "aer_stats" folder for the device:
+
+2.4.1 Device sysfs Attributes
+
+These attributes show up under all the devices that are AER capable. These
+indicate the errors "as seen by the device". Note that this may mean that if
+an end point is causing problems, the AER counters may increment at its link
+partner (e.g. root port) because the errors will be "seen" by the link partner
+and not the the problematic end point itself (which may report all counters
+as 0 as it never saw any problems).
+
+ * dev_total_cor_errs: number of correctable errors seen by the device.
+ * dev_total_fatal_errs: number of fatal uncorrectable errors seen by the device.
+ * dev_total_nonfatal_errs: number of nonfatal uncorr errors seen by the device.
+ * dev_breakdown_correctable: Provides a breakdown of different type of
+                              correctable errors seen.
+ * dev_breakdown_uncorrectable: Provides a breakdown of different type of
+                              uncorrectable errors seen.
+
+2.4.1 Rootport sysfs Attributes
+
+These attributes showup under only the rootports that are AER capable. These
+indicate the number of error messages as "reported to" the rootport. Please note
+that the rootports also transmit (internally) the ERR_* messages for errors seen
+by the internal rootport PCI device, so these counters includes them and are
+thus cumulative of all the error messages on the PCI hierarchy originating
+at that root port.
+
+ * rootport_total_cor_errs: number of ERR_COR messages reported to rootport.
+ * rootport_total_fatal_errs: number of ERR_FATAL messages reported to rootport.
+ * rootport_total_nonfatal_errs: number of ERR_NONFATAL messages reporeted to
+                                 rootport.
 
 3. Developer Guide
 
-- 
2.17.0.441.gb46fe60e1d-goog
