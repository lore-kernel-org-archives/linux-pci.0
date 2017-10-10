Return-Path: <SRS0=1aDn=BJ=linux.intel.com=mathias.nyman@kernel.org>
Return-Path: <SRS0=1aDn=BJ=linux.intel.com=mathias.nyman@kernel.org>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 197159] New: Xhci host
 controller not responding starting kernel 4.13]
To: Bjorn Helgaas <helgaas@kernel.org>, Mason <slash.tmp@free.fr>
References: <20171009170108.GK25517@bhelgaas-glaptop.roam.corp.google.com>
 <50d880c5-f76b-cb15-0faa-af9fa617ea9a@free.fr>
 <20171009233852.GO25517@bhelgaas-glaptop.roam.corp.google.com>
Cc: Niklas <niklas@vividvisions.se>, linux-pci <linux-pci@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Lukas Wunner <lukas@wunner.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <59DC8418.2050808@linux.intel.com>
Date: Tue, 10 Oct 2017 11:26:00 +0300
MIME-Version: 1.0
In-Reply-To: <20171009233852.GO25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10.10.2017 02:38, Bjorn Helgaas wrote:
> On Mon, Oct 09, 2017 at 10:45:39PM +0200, Mason wrote:
>> On 09/10/2017 19:01, Bjorn Helgaas wrote:
>> ...
>
>>> In that thread, Mason reported a regression that looks similar, but as
>>> far as I can tell, we never identified a root cause.
>>>
>>>    1) The problem Mason reported was on a Tango platform, which has a
>>>       known hardware issue that corrupts data when simultaneous config
>>>       and MMIO accesses occur.  You're seeing the problem on a
>>>       different platform, which is very helpful.
>>
>> As mentioned here:
>> https://www.mail-archive.com/linux-usb@vger.kernel.org/msg94020.html
>>
>> When I disable the AER driver, not a single config space access
>> occurs when a USB drive is unplugged. So I'm 99.99% sure that
>> the issue is NOT caused by tango's bad design. (I got the vibe
>> that nobody cared about tango's issue because it was assumed
>> that the design flaw was responsible for it.)
>
> I agree; I don't think this is Tango's fault.
>
> Can you test fe190ed0d602 and d9f11ba9f107 to determine whether
> d9f11ba9f107 is the culprit?  If it is the culprit, can you try reverting
> it on a current kernel to see if that fixes it?
>
> If d9f11ba9f107 is not the culprit, can you bisect to discover exactly
> where it broke?
>

If possible could the bug reporter add the same WARN is Mason to see
when xhci reads 0xffffffff, or if something else triggers xhci_hc_died()

In the Tango case it was the hub thread clearing a port reset change event.

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 82c746e..cd3a420 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -908,6 +908,8 @@ void xhci_hc_died(struct xhci_hcd *xhci)
  {
         int i, j;
  
+       WARN_ON(1);
         if (xhci->xhc_state & XHCI_STATE_DYING)
                 return;
  
Thanks
Mathias
