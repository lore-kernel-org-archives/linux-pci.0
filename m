Return-Path: <SRS0=Q9bd=77=linux.intel.com=mathias.nyman@kernel.org>
Return-Path: <SRS0=Q9bd=77=linux.intel.com=mathias.nyman@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
To: Mason <slash.tmp@free.fr>, Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
 <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <59A56C15.2000403@linux.intel.com>
Date: Tue, 29 Aug 2017 16:28:53 +0300
MIME-Version: 1.0
In-Reply-To: <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 28.08.2017 17:40, Mason wrote:
> On 28/08/2017 10:39, Mathias Nyman wrote:
>
>> Could you take a log with the following added debug, without
>> your extra delays, It should show a bit more about the state
>> of the controller when we read 0xffffffff
>
> I applied the following patch on top of v4.12-rc1
>
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 5e3e9d4c6956..c7ea7d4c801f 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -23,6 +23,7 @@
>
>   #include <linux/slab.h>
>   #include <asm/unaligned.h>
> +#include <linux/pci.h>
>
>   #include "xhci.h"
>   #include "xhci-trace.h"
> @@ -1268,7 +1269,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   		wIndex--;
>   		temp = readl(port_array[wIndex]);
>   		if (temp == ~(u32)0) {
> -			xhci_hc_died(xhci);
> +			struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
> +			xhci_err(xhci, "ClearPortFeat port%d @%p=%x, hcd->state:0x%x hcd->flags:0x%x, pci_state 0x%x\n",
> +					wIndex, port_array[wIndex], temp, hcd->state, hcd->flags, pdev->current_state);
> +			WARN_ON(1);
>   			retval = -ENODEV;
>   			break;
>   		}
>
>
> And here are logs I get when I plug/unplug my USB3 device.
>
> [   14.970148] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
> [   15.003487] usb 2-2: New USB device found, idVendor=0951, idProduct=1666
> [   15.010237] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   15.017483] usb 2-2: Product: DataTraveler 3.0
> [   15.021990] usb 2-2: Manufacturer: Kingston
> [   15.026234] usb 2-2: SerialNumber: 002618887865F0C0F8646BFA
> [   15.034830] usb-storage 2-2:1.0: USB Mass Storage device detected
> [   15.041269] scsi host0: usb-storage 2-2:1.0
> [   16.056140] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
> [   16.064979] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
> [   16.072978] sd 0:0:0:0: [sda] Write Protect is off
> [   16.078076] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [   16.089417]  sda: sda1
> [   16.093050] sd 0:0:0:0: [sda] Attached SCSI removable disk
>
>
> [   22.152078] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
> [   22.160157] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
> [   22.172051] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
> [   22.180493] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
> [   22.187368] pcieport 0000:00:00.0: AER: Device recovery failed
> [   22.885269] xhci_hcd 0000:01:00.0: ClearPortFeat port1 @e0852430=ffffffff, hcd->state:0x1 hcd->flags:0x1a5, pci_state 0x0

State is HC_STATE_RUNNING,

Flags bits 0,2,5,7,8 set:
#define HCD_FLAG_HW_ACCESSIBLE          0       /* at full power */
#define HCD_FLAG_POLL_RH                2       /* poll for rh status? */
#define HCD_FLAG_RH_RUNNING             5       /* root hub is running? */
#define HCD_FLAG_INTF_AUTHORIZED        7       /* authorize interfaces? */
#define HCD_FLAG_DEV_AUTHORIZED         8       /* authorize devices? */

And pci state seems to be D0 (according to driver, pdev->current_state)

I can't see anything wrong from xhci/usb point of view.
I'd focus more on the PCI errors in the logs as the cause for reading 0xffffffff from xhci mmio.

Then again it might be a bit too drastic to kill xhci just because we read 0xffffffff once
from a mmio xhci register. Maybe we should return an error a couple times before actually
tearing down xhci.

This tight check was originally done to detect pci hotplug removed hosts as soon as possible.

-Mathias  
