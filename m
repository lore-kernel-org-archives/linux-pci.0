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
Message-ID: <2131ff31-09f8-6955-502d-a3fce031c31e@free.fr>
Date: Wed, 23 Aug 2017 11:18:36 +0200
MIME-Version: 1.0
In-Reply-To: <599D3410.9050504@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 23/08/2017 09:51, Mathias Nyman wrote:

> On 23.08.2017 09:07, Felipe Balbi wrote:
>
>> Mason writes:
>>
>>> Any idea what could have changed between 4.9 and 4.13 ?
>>
>> Quite a bit:
>>
>> $ git rev-list --no-merges  --count v4.13-rc6 ^v4.9 -- drivers/usb/host/xhci drivers/usb/core/
>> 58
> 
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
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 51cd4b8..ade2ad6 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -922,7 +922,8 @@ void xhci_hc_died(struct xhci_hcd *xhci)
>          if (xhci->xhc_state & XHCI_STATE_DYING)
>                  return;
>   
> -       xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
> +       xhci_err(xhci, "xHC not responding in %pf, assume controller is dead\n",
> +                __builtin_return_address(0));
>          xhci->xhc_state |= XHCI_STATE_DYING;
>   
>          xhci_cleanup_command_queue(xhci);

I'll try some coarse bisection to narrow it down.

$ git describe --contains d9f11ba9f107aa335091ab8d7ba5eea714e46e8b
v4.12-rc1~97^2~39

I'll check 4.11 first.

I wanted to mention that the XHCI setup on 4.9 and 4.13 print
slightly different things (at the beginning).

On 4.9
[    1.240322] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.245617] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.258691] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    1.268090] hub 1-0:1.0: USB hub found
[    1.271905] hub 1-0:1.0: 4 ports detected
[    1.276372] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.281645] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    1.289173] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.297775] hub 2-0:1.0: USB hub found
[    1.301577] hub 2-0:1.0: 4 ports detected
[    1.306194] usbcore: registered new interface driver usb-storage

On 4.13
[    1.222471] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[    1.229156] xhci_hcd 0000:01:00.0: Resetting
[    2.268836] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.274126] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    2.287222] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    2.296653] hub 1-0:1.0: USB hub found
[    2.300478] hub 1-0:1.0: 4 ports detected
[    2.304962] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.310246] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    2.317776] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.326419] hub 2-0:1.0: USB hub found
[    2.330229] hub 2-0:1.0: 4 ports detected
[    2.334869] usbcore: registered new interface driver usb-storage

FWIW, "of_irq_parse_pci: failed with rc=-22"
seems to come from:

[    1.257411] [<c03d80c8>] (of_irq_parse_pci) from [<c03d8270>] (of_irq_parse_and_map_pci+0x10/0x2c)
[    1.266420] [<c03d8270>] (of_irq_parse_and_map_pci) from [<c03100a8>] (pci_assign_irq+0x78/0xb0)
[    1.275254] [<c03100a8>] (pci_assign_irq) from [<c030a1c8>] (pci_device_probe+0x18/0x128)
[    1.283476] [<c030a1c8>] (pci_device_probe) from [<c0357864>] (driver_probe_device+0x244/0x2c8)

The error logging was added by f1aa54840657f
No, that just turned one specific error into a warning.
Need to dig a bit more.

Regards.
