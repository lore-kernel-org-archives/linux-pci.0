Return-Path: <SRS0=hoBd=JG=flex--rajatja.bounces.google.com=3_6kpWwcKB9gL4D4ND4AIIAF8.6IGB8FA44ME8LH8F.ILA@kernel.org>
Return-Path: <SRS0=hoBd=JG=flex--rajatja.bounces.google.com=3_6kpWwcKB9gL4D4ND4AIIAF8.6IGB8FA44ME8LH8F.ILA@kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Jun 2018 18:12:10 -0700
In-Reply-To: <20180620011210.254601-1-rajatja@google.com>
Message-Id: <20180620011210.254601-5-rajatja@google.com>
References: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com> <20180620011210.254601-1-rajatja@google.com>
Subject: [PATCH v3 5/5] Documentation/ABI: Add details of PCI AER statistics
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com, helgaas@kernel.org
Cc: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Add the PCI AER statistics details to
Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
and provide a pointer to it in
Documentation/PCI/pcieaer-howto.txt

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: Add some more details, use decimal instead of hex

 .../testing/sysfs-bus-pci-devices-aer_stats   | 111 ++++++++++++++++++
 Documentation/PCI/pcieaer-howto.txt           |   5 +
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
new file mode 100644
index 000000000000..3ed5a682be87
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -0,0 +1,111 @@
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
+Description:	Breakdown of correctable errors seen and reported by this
+		PCI device using ERR_COR. Note that the sum total of all errors
+		in dev_breakdown_correctable may exceed dev_total_cor_errs
+		because a device is allowed to merge multiple correctable and
+		send a single ERR_COR for them (which is what dev_total_cor_errs
+		counts). A sample output for this attribute looks like this:
+-----------------------------------------
+Receiver Error = 174
+Bad TLP = 19
+Bad DLLP = 3
+RELAY_NUM Rollover = 0
+Replay Timer Timeout = 1
+Advisory Non-Fatal = 0
+Corrected Internal Error = 0
+Header Log Overflow = 0
+-----------------------------------------
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_uncorrectable
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Breakdown of of correctable errors seen and reported by this
+		PCI device using ERR_FATAL or ERR_NONFATAL. Note that the sum
+		total of all errors in dev_breakdown_uncorrectable may exceed
+		(dev_total_fatal_errs + dev_total_nonfatal_errs) because a
+		device is allowed to merge multiple errors at the same severity
+		and send a single ERR_FATAL/ERR_NON_FATAL for them.
+		A sample output for this attribute looks like this:
+-----------------------------------------
+Undefined = 0
+Data Link Protocol = 0
+Surprise Down Error = 0
+Poisoned TLP = 0
+Flow Control Protocol = 0
+Completion Timeout = 0
+Completer Abort = 0
+Unexpected Completion = 0
+Receiver Overflow = 0
+Malformed TLP = 0
+ECRC = 0
+Unsupported Request = 0
+ACS Violation = 0
+Uncorrectable Internal Error = 0
+MC Blocked TLP = 0
+AtomicOp Egress Blocked = 0
+TLP Prefix Blocked Error = 0
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
2.18.0.rc1.244.gcf134e6275-goog
