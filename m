Return-Path: <SRS0=mwJF=76=linux.intel.com=mathias.nyman@kernel.org>
Return-Path: <SRS0=mwJF=76=linux.intel.com=mathias.nyman@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
To: Mason <slash.tmp@free.fr>, Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
 <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <59A3D6BF.7010400@linux.intel.com>
Date: Mon, 28 Aug 2017 11:39:27 +0300
MIME-Version: 1.0
In-Reply-To: <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 23.08.2017 17:30, Mason wrote:
> On 23/08/2017 14:41, Mason wrote:
>
>> I compiled a minimal kernel, with lots of irrelevant drivers and
>> frameworks left out, including power management. I still get the
>> "xHCI host controller not responding, assume dead" issue.
>
> The problem seems to have a timing-related aspect.
>
> I added a bunch of logs (to a slow serial console) and the HC was
> not killed. I was able to plug the Flash drive a second time.
> (I am logging config space reads and writes.)


Could you take a log with the following added debug, without
your extra delays, It should show a bit more about the state
of the controller when we read 0xffffffff


diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 4bc6f42..a124c3d 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -23,6 +23,7 @@
  
  #include <linux/slab.h>
  #include <asm/unaligned.h>
+#include <linux/pci.h>
  
  #include "xhci.h"
  #include "xhci-trace.h"
@@ -1280,7 +1281,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
                 wIndex--;
                 temp = readl(port_array[wIndex]);
                 if (temp == ~(u32)0) {
-                       xhci_hc_died(xhci);
+                       struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+                       xhci_err(xhci, "ClearPortFeat port%d @%p=%x, hcd->state:0x%x hcd->flags:0x%x, pci_state 0x%x\n",
+                                wIndex, port_array[wIndex], temp, hcd->state, hcd->flags, pdev->current_state);
+
+                       WARN_ON(1);
                         retval = -ENODEV;
                         break;
                 }

Thanks
-Mathias
