Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sun, 17 Jun 2018 10:54:41 +0530
From: poza@codeaurora.org
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH v2 5/5] Documentation/ABI: Add details of PCI AER
 statistics
In-Reply-To: <20180523175808.28030-6-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
 <20180523175808.28030-6-rajatja@google.com>
Message-ID: <c27290dd401bb2954db4959559c39a00@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-23 23:28, Rajat Jain wrote:
> Add the PCI AER statistics details to
> Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> and provide a pointer to it in
> Documentation/PCI/pcieaer-howto.txt
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: Move the documentation to Documentation/ABI/
> 
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 103 ++++++++++++++++++
>  Documentation/PCI/pcieaer-howto.txt           |   5 +
>  2 files changed, 108 insertions(+)
>  create mode 100644 
> Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> new file mode 100644
> index 000000000000..f55c389290ac
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> @@ -0,0 +1,103 @@
> +==========================
> +PCIe Device AER statistics
> +==========================
> +These attributes show up under all the devices that are AER capable. 
> These
> +statistical counters indicate the errors "as seen/reported by the 
> device".
> +Note that this may mean that if an end point is causing problems, the 
> AER
> +counters may increment at its link partner (e.g. root port) because 
> the
> +errors will be "seen" / reported by the link partner and not the the
> +problematic end point itself (which may report all counters as 0 as it 
> never
> +saw any problems).
> +
> +Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_cor_errs
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Total number of correctable errors seen and reported by 
> this
> +		PCI device using ERR_COR.
> +
> +Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_fatal_errs
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Total number of uncorrectable fatal errors seen and 
> reported
> +		by this PCI device using ERR_FATAL.
> +
> +Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_nonfatal_errs
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Total number of uncorrectable non-fatal errors seen and 
> reported
> +		by this PCI device using ERR_NONFATAL.
> +
> +Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_correctable
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Breakdown of of correctable errors seen and reported by 
> this
> +		PCI device using ERR_COR. A sample result looks like this:
> +-----------------------------------------
> +Receiver Error = 0x174
> +Bad TLP = 0x19
> +Bad DLLP = 0x3
> +RELAY_NUM Rollover = 0x0
> +Replay Timer Timeout = 0x1
> +Advisory Non-Fatal = 0x0
> +Corrected Internal Error = 0x0
> +Header Log Overflow = 0x0
> +-----------------------------------------
why hex display ? decimal is easy to read as these are counters.
> +
> +Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_uncorrectable
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Breakdown of of correctable errors seen and reported by 
> this
> +		PCI device using ERR_FATAL or ERR_NONFATAL. A sample result
> +		looks like this:
> +-----------------------------------------
> +Undefined = 0x0
> +Data Link Protocol = 0x0
> +Surprise Down Error = 0x0
> +Poisoned TLP = 0x0
> +Flow Control Protocol = 0x0
> +Completion Timeout = 0x0
> +Completer Abort = 0x0
> +Unexpected Completion = 0x0
> +Receiver Overflow = 0x0
> +Malformed TLP = 0x0
> +ECRC = 0x0
> +Unsupported Request = 0x0
> +ACS Violation = 0x0
> +Uncorrectable Internal Error = 0x0
> +MC Blocked TLP = 0x0
> +AtomicOp Egress Blocked = 0x0
> +TLP Prefix Blocked Error = 0x0
> +-----------------------------------------
> +
> +============================
> +PCIe Rootport AER statistics
> +============================
> +These attributes showup under only the rootports that are AER capable. 
> These
> +indicate the number of error messages as "reported to" the rootport.
> Please note
> +that the rootports also transmit (internally) the ERR_* messages for
> errors seen
> +by the internal rootport PCI device, so these counters includes them 
> and are
> +thus cumulative of all the error messages on the PCI hierarchy 
> originating
> +at that root port.

what about switches and bridges ?
Also Can you give some idea as e.g what is the difference between
dev_total_fatal_errs and rootport_total_fatal_errs  (assuming that both 
are same pci_dev.

rootport_total_fatal_errs gives me an idea that how many times things 
have been failed under this pci_dev ?
which means num of downstream link problems. but I am still trying to 
make sense as how it could be used,
since we dont have BDF information associated with the number of errors 
anywhere (except these AER print messages)


and dev_total_fatal_errs as you mentioned above that problematic EP, 
then say root-port will report it and increment
dev_total_fatal_errs ++
does it also increment root-port_total_fatal_errs ++ in above scenario ?

> +
> +Where:		/sys/bus/pci/devices/<dev>/aer_stats/rootport_total_cor_errs
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Total number of ERR_COR messages reported to rootport.
> +
> +Where:		/sys/bus/pci/devices/<dev>/aer_stats/rootport_total_fatal_errs
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Total number of ERR_FATAL messages reported to rootport.
> +
> +Where:	    
> /sys/bus/pci/devices/<dev>/aer_stats/rootport_total_nonfatal_errs
> +Date:		May 2018
> +Kernel Version: 4.17.0
> +Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> +Description:	Total number of ERR_NONFATAL messages reported to 
> rootport.
> diff --git a/Documentation/PCI/pcieaer-howto.txt
> b/Documentation/PCI/pcieaer-howto.txt
> index acd0dddd6bb8..91b6e677cb8c 100644
> --- a/Documentation/PCI/pcieaer-howto.txt
> +++ b/Documentation/PCI/pcieaer-howto.txt
> @@ -73,6 +73,11 @@ In the example, 'Requester ID' means the ID of the
> device who sends
>  the error message to root port. Pls. refer to pci express specs for
>  other fields.
> 
> +2.4 AER Statistics / Counters
> +
> +When PCIe AER errors are captured, the counters / statistics are also 
> exposed
> +in form of sysfs attributes which are documented at
> +Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> 
>  3. Developer Guide
