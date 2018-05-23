Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42255 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933891AbeEWR6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 13:58:55 -0400
Received: by mail-pg0-f65.google.com with SMTP id p9-v6so9746667pgc.9
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 10:58:55 -0700 (PDT)
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
Subject: [PATCH v2 5/5] Documentation/ABI: Add details of PCI AER statistics
Date: Wed, 23 May 2018 10:58:08 -0700
Message-Id: <20180523175808.28030-6-rajatja@google.com>
In-Reply-To: <20180523175808.28030-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the PCI AER statistics details to
Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
and provide a pointer to it in
Documentation/PCI/pcieaer-howto.txt

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Move the documentation to Documentation/ABI/

 .../testing/sysfs-bus-pci-devices-aer_stats   | 103 ++++++++++++++++++
 Documentation/PCI/pcieaer-howto.txt           |   5 +
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
new file mode 100644
index 000000000000..f55c389290ac
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -0,0 +1,103 @@
+==========================
+PCIe Device AER statistics
+==========================
+These attributes show up under all the devices that are AER capable. These
+statistical counters indicate the errors "as seen/reported by the device".
+Note that this may mean that if an end point is causing problems, the AER
+counters may increment at its link partner (e.g. root port) because the
+errors will be "seen" / reported by the link partner and not the the
+problematic end point itself (which may report all counters as 0 as it never
+saw any problems).
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_cor_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of correctable errors seen and reported by this
+		PCI device using ERR_COR.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_fatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of uncorrectable fatal errors seen and reported
+		by this PCI device using ERR_FATAL.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_nonfatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of uncorrectable non-fatal errors seen and reported
+		by this PCI device using ERR_NONFATAL.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_correctable
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Breakdown of of correctable errors seen and reported by this
+		PCI device using ERR_COR. A sample result looks like this:
+-----------------------------------------
+Receiver Error = 0x174
+Bad TLP = 0x19
+Bad DLLP = 0x3
+RELAY_NUM Rollover = 0x0
+Replay Timer Timeout = 0x1
+Advisory Non-Fatal = 0x0
+Corrected Internal Error = 0x0
+Header Log Overflow = 0x0
+-----------------------------------------
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_uncorrectable
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Breakdown of of correctable errors seen and reported by this
+		PCI device using ERR_FATAL or ERR_NONFATAL. A sample result
+		looks like this:
+-----------------------------------------
+Undefined = 0x0
+Data Link Protocol = 0x0
+Surprise Down Error = 0x0
+Poisoned TLP = 0x0
+Flow Control Protocol = 0x0
+Completion Timeout = 0x0
+Completer Abort = 0x0
+Unexpected Completion = 0x0
+Receiver Overflow = 0x0
+Malformed TLP = 0x0
+ECRC = 0x0
+Unsupported Request = 0x0
+ACS Violation = 0x0
+Uncorrectable Internal Error = 0x0
+MC Blocked TLP = 0x0
+AtomicOp Egress Blocked = 0x0
+TLP Prefix Blocked Error = 0x0
+-----------------------------------------
+
+============================
+PCIe Rootport AER statistics
+============================
+These attributes showup under only the rootports that are AER capable. These
+indicate the number of error messages as "reported to" the rootport. Please note
+that the rootports also transmit (internally) the ERR_* messages for errors seen
+by the internal rootport PCI device, so these counters includes them and are
+thus cumulative of all the error messages on the PCI hierarchy originating
+at that root port.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/rootport_total_cor_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_COR messages reported to rootport.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/rootport_total_fatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_FATAL messages reported to rootport.
+
+Where:	    /sys/bus/pci/devices/<dev>/aer_stats/rootport_total_nonfatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_NONFATAL messages reported to rootport.
diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
index acd0dddd6bb8..91b6e677cb8c 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.txt
@@ -73,6 +73,11 @@ In the example, 'Requester ID' means the ID of the device who sends
 the error message to root port. Pls. refer to pci express specs for
 other fields.
 
+2.4 AER Statistics / Counters
+
+When PCIe AER errors are captured, the counters / statistics are also exposed
+in form of sysfs attributes which are documented at
+Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 
 3. Developer Guide
 
-- 
2.17.0.441.gb46fe60e1d-goog
