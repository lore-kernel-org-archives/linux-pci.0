Return-Path: <SRS0=QfGx=76=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=QfGx=76=free.fr=slash.tmp@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
 <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
Date: Mon, 28 Aug 2017 16:40:39 +0200
MIME-Version: 1.0
In-Reply-To: <59A3D6BF.7010400@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 28/08/2017 10:39, Mathias Nyman wrote:

> Could you take a log with the following added debug, without
> your extra delays, It should show a bit more about the state
> of the controller when we read 0xffffffff

I applied the following patch on top of v4.12-rc1

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 5e3e9d4c6956..c7ea7d4c801f 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -23,6 +23,7 @@
 
 #include <linux/slab.h>
 #include <asm/unaligned.h>
+#include <linux/pci.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -1268,7 +1269,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		wIndex--;
 		temp = readl(port_array[wIndex]);
 		if (temp == ~(u32)0) {
-			xhci_hc_died(xhci);
+			struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+			xhci_err(xhci, "ClearPortFeat port%d @%p=%x, hcd->state:0x%x hcd->flags:0x%x, pci_state 0x%x\n",
+					wIndex, port_array[wIndex], temp, hcd->state, hcd->flags, pdev->current_state);
+			WARN_ON(1);
 			retval = -ENODEV;
 			break;
 		}


And here are logs I get when I plug/unplug my USB3 device.

[   14.970148] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[   15.003487] usb 2-2: New USB device found, idVendor=0951, idProduct=1666
[   15.010237] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   15.017483] usb 2-2: Product: DataTraveler 3.0
[   15.021990] usb 2-2: Manufacturer: Kingston
[   15.026234] usb 2-2: SerialNumber: 002618887865F0C0F8646BFA
[   15.034830] usb-storage 2-2:1.0: USB Mass Storage device detected
[   15.041269] scsi host0: usb-storage 2-2:1.0
[   16.056140] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   16.064979] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   16.072978] sd 0:0:0:0: [sda] Write Protect is off
[   16.078076] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   16.089417]  sda: sda1
[   16.093050] sd 0:0:0:0: [sda] Attached SCSI removable disk


[   22.152078] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   22.160157] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   22.172051] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   22.180493] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   22.187368] pcieport 0000:00:00.0: AER: Device recovery failed
[   22.885269] xhci_hcd 0000:01:00.0: ClearPortFeat port1 @e0852430=ffffffff, hcd->state:0x1 hcd->flags:0x1a5, pci_state 0x0
[   22.896284] ------------[ cut here ]------------
[   22.900938] WARNING: CPU: 0 PID: 127 at drivers/usb/host/xhci-hub.c:1275 xhci_hub_control+0x10f4/0x1778
[   22.910377] Modules linked in:
[   22.913447] CPU: 0 PID: 127 Comm: kworker/0:1 Tainted: G         C      4.12.0-rc1 #4
[   22.921314] Hardware name: Sigma Tango DT
[   22.925342] Workqueue: usb_hub_wq hub_event
[   22.929564] [<c010e8b4>] (unwind_backtrace) from [<c010ac00>] (show_stack+0x10/0x14)
[   22.937353] [<c010ac00>] (show_stack) from [<c0257a30>] (dump_stack+0x84/0x98)
[   22.944617] [<c0257a30>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x100)
[   22.951616] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+0x20/0x28)
[   22.959227] [<c0118498>] (warn_slowpath_null) from [<c031ad90>] (xhci_hub_control+0x10f4/0x1778)
[   22.968062] [<c031ad90>] (xhci_hub_control) from [<c02fbb4c>] (usb_hcd_submit_urb+0x264/0x810)
[   22.976719] [<c02fbb4c>] (usb_hcd_submit_urb) from [<c02fccec>] (usb_submit_urb+0x2b0/0x4b4)
[   22.985201] [<c02fccec>] (usb_submit_urb) from [<c02fd3c4>] (usb_start_wait_urb+0x4c/0xbc)
[   22.993509] [<c02fd3c4>] (usb_start_wait_urb) from [<c02fd4d4>] (usb_control_msg+0xa0/0xcc)
[   23.001904] [<c02fd4d4>] (usb_control_msg) from [<c02f5718>] (usb_clear_port_feature+0x44/0x4c)
[   23.010648] [<c02f5718>] (usb_clear_port_feature) from [<c02f60fc>] (hub_port_reset+0x228/0x51c)
[   23.019479] [<c02f60fc>] (hub_port_reset) from [<c02f82f0>] (hub_event+0x1f4/0xe64)
[   23.027177] [<c02f82f0>] (hub_event) from [<c012d398>] (process_one_work+0x1d4/0x3ec)
[   23.035049] [<c012d398>] (process_one_work) from [<c012dfb4>] (worker_thread+0x38/0x554)
[   23.043185] [<c012dfb4>] (worker_thread) from [<c0132c84>] (kthread+0x108/0x138)
[   23.050620] [<c0132c84>] (kthread) from [<c01076f8>] (ret_from_fork+0x14/0x3c)
[   23.057877] ---[ end trace 5e4494cf1f6e3761 ]---
[   23.062691] xhci_hcd 0000:01:00.0: ClearPortFeat port1 @e0852430=ffffffff, hcd->state:0x1 hcd->flags:0x1a5, pci_state 0x0
[   23.073707] ------------[ cut here ]------------
[   23.078349] WARNING: CPU: 0 PID: 127 at drivers/usb/host/xhci-hub.c:1275 xhci_hub_control+0x10f4/0x1778
[   23.087787] Modules linked in:
[   23.090854] CPU: 0 PID: 127 Comm: kworker/0:1 Tainted: G        WC      4.12.0-rc1 #4
[   23.098720] Hardware name: Sigma Tango DT
[   23.102745] Workqueue: usb_hub_wq hub_event
[   23.106953] [<c010e8b4>] (unwind_backtrace) from [<c010ac00>] (show_stack+0x10/0x14)
[   23.114737] [<c010ac00>] (show_stack) from [<c0257a30>] (dump_stack+0x84/0x98)
[   23.121998] [<c0257a30>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x100)
[   23.128996] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+0x20/0x28)
[   23.136606] [<c0118498>] (warn_slowpath_null) from [<c031ad90>] (xhci_hub_control+0x10f4/0x1778)
[   23.145439] [<c031ad90>] (xhci_hub_control) from [<c02fbb4c>] (usb_hcd_submit_urb+0x264/0x810)
[   23.154095] [<c02fbb4c>] (usb_hcd_submit_urb) from [<c02fccec>] (usb_submit_urb+0x2b0/0x4b4)
[   23.162577] [<c02fccec>] (usb_submit_urb) from [<c02fd3c4>] (usb_start_wait_urb+0x4c/0xbc)
[   23.170884] [<c02fd3c4>] (usb_start_wait_urb) from [<c02fd4d4>] (usb_control_msg+0xa0/0xcc)
[   23.179278] [<c02fd4d4>] (usb_control_msg) from [<c02f5718>] (usb_clear_port_feature+0x44/0x4c)
[   23.188021] [<c02f5718>] (usb_clear_port_feature) from [<c02f611c>] (hub_port_reset+0x248/0x51c)
[   23.196851] [<c02f611c>] (hub_port_reset) from [<c02f82f0>] (hub_event+0x1f4/0xe64)
[   23.204547] [<c02f82f0>] (hub_event) from [<c012d398>] (process_one_work+0x1d4/0x3ec)
[   23.212418] [<c012d398>] (process_one_work) from [<c012dfb4>] (worker_thread+0x38/0x554)
[   23.220551] [<c012dfb4>] (worker_thread) from [<c0132c84>] (kthread+0x108/0x138)
[   23.227986] [<c0132c84>] (kthread) from [<c01076f8>] (ret_from_fork+0x14/0x3c)
[   23.235242] ---[ end trace 5e4494cf1f6e3762 ]---
[   23.239953] xhci_hcd 0000:01:00.0: Cannot set link state.
[   23.245403] usb usb2-port2: cannot disable (err = -32)
[   23.250575] usb 2-2: USB disconnect, device number 2
[   23.255724] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   23.264048] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   23.275985] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   23.284417] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   23.291256] pcieport 0000:00:00.0: AER: Device recovery failed
[   23.297144] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   23.305218] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   23.317047] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   23.325467] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   23.332309] pcieport 0000:00:00.0: AER: Device recovery failed
[   23.338188] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   23.346273] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   23.358093] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   23.366518] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   23.373357] pcieport 0000:00:00.0: AER: Device recovery failed
[   23.379229] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   23.387287] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   23.399101] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   23.407504] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   23.414344] pcieport 0000:00:00.0: AER: Device recovery failed
[   23.434143] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   23.442263] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   23.454100] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   23.462542] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   23.469427] pcieport 0000:00:00.0: AER: Device recovery failed


Regards.
