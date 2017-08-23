Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
To: Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
 <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
Date: Wed, 23 Aug 2017 11:31:29 +0200
MIME-Version: 1.0
In-Reply-To: <599D3410.9050504@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 23/08/2017 09:51, Mathias Nyman wrote:

> very likely cause is the more aggressive detection of pci removed xhci hosts
> 
> See commit d9f11ba9f107aa335091ab8d7ba5eea714e46e8b
>      xhci: Rework how we handle unresponsive or hoptlug removed hosts
> 
> It checks if a xhci register reads returns 0xffffffff and assumes xhci
> died in that case.
> 
> Could you add something like the below to check which what is killing the host?
> Or a BUG()/WARN() in xhci_hc_died() to get a backtrace of who called it.

[   46.525247] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[   46.565496] usb-storage 2-2:1.0: USB Mass Storage device detected
[   46.571934] scsi host0: usb-storage 2-2:1.0
[   47.601227] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   47.611340] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   47.621624] sd 0:0:0:0: [sda] Write Protect is off
[   47.627131] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   47.639637]  sda: sda1
[   47.648091] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   58.100306] xhci_hcd 0000:01:00.0: xHCI host controller not responding, assume dead
[   58.108021] CPU: 0 PID: 939 Comm: kworker/0:2 Tainted: G         C      4.13.0-rc6 #11
[   58.115976] Hardware name: Sigma Tango DT
[   58.120016] Workqueue: usb_hub_wq hub_event
[   58.124241] [<c010f288>] (unwind_backtrace) from [<c010af58>] (show_stack+0x10/0x14)
[   58.132033] [<c010af58>] (show_stack) from [<c049d714>] (dump_stack+0x84/0x98)
[   58.139302] [<c049d714>] (dump_stack) from [<c03b090c>] (xhci_hc_died.part.9+0x50/0x23c)
[   58.147438] [<c03b090c>] (xhci_hc_died.part.9) from [<c03b5d80>] (xhci_hub_control+0xf3c/0x175c)
[   58.156273] [<c03b5d80>] (xhci_hub_control) from [<c03934a4>] (usb_hcd_submit_urb+0x264/0x814)
[   58.164932] [<c03934a4>] (usb_hcd_submit_urb) from [<c0394fa4>] (usb_start_wait_urb+0x4c/0xbc)
[   58.173591] [<c0394fa4>] (usb_start_wait_urb) from [<c03950b4>] (usb_control_msg+0xa0/0xcc)
[   58.181985] [<c03950b4>] (usb_control_msg) from [<c038bf54>] (usb_clear_port_feature+0x44/0x4c)
[   58.190730] [<c038bf54>] (usb_clear_port_feature) from [<c038c320>] (hub_port_reset+0x228/0x51c)
[   58.199561] [<c038c320>] (hub_port_reset) from [<c038fd68>] (hub_event+0x87c/0x108c)
[   58.207349] [<c038fd68>] (hub_event) from [<c012ecc4>] (process_one_work+0x1d8/0x3f0)
[   58.215220] [<c012ecc4>] (process_one_work) from [<c012f8d8>] (worker_thread+0x38/0x554)
[   58.223354] [<c012f8d8>] (worker_thread) from [<c01347d0>] (kthread+0x108/0x138)
[   58.230789] [<c01347d0>] (kthread) from [<c01076d8>] (ret_from_fork+0x14/0x3c)
[   58.238056] xhci_hcd 0000:01:00.0: HC died; cleaning up
[   58.243391] usb 2-2: USB disconnect, device number 2
