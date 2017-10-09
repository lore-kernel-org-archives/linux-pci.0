Return-Path: <SRS0=vWBP=BI=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=vWBP=BI=free.fr=slash.tmp@kernel.org>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 197159] New: Xhci host
 controller not responding starting kernel 4.13]
To: Bjorn Helgaas <helgaas@kernel.org>, Niklas <niklas@vividvisions.se>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Lukas Wunner <lukas@wunner.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
References: <20171009170108.GK25517@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <50d880c5-f76b-cb15-0faa-af9fa617ea9a@free.fr>
Date: Mon, 9 Oct 2017 22:45:39 +0200
MIME-Version: 1.0
In-Reply-To: <20171009170108.GK25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 09/10/2017 19:01, Bjorn Helgaas wrote:

> [+cc linux-pci, linux-usb, Mason, Mathias, Lukas, Greg, Felipe, Alan]
> 
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
>>
>> Date: Sun, 08 Oct 2017 13:28:13 +0000
>> From: bugzilla-daemon@bugzilla.kernel.org
>> To: bugzilla.pci@gmail.com
>> Subject: [Bug 197159] New: Xhci host controller not responding starting kernel 4.13
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=197159
>>
>>             Bug ID: 197159
>>            Summary: Xhci host controller not responding starting kernel
>>                     4.13
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 4.13
>>           Hardware: Intel
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: blocking
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: niklas@vividvisions.se
>>         Regression: No
>>
>> When booting with a Expresscard USB 3.0 adapter (NEC UPD720202 Chip), the
>> following error is generated:
>>
>> "xhci_hcd 0000:05:00.0: xHCI host controller not responding, assumed dead"
>>
>> This card still works fine with kernel 4.9.
> 
> Thanks very much for the bug report, and sorry for the regression.
> 
> Can you please collect the complete dmesg log and "lspci -vv" output
> and attach them to the bugzilla?
> 
>> Additionally, for some reason this also interferes with LUKS on an LVM
>> partition; password does not work and computer becomes stuck at this point.
>> This works as normal if card is removed and computer is rebooted.
>>
>> Can we please have Expresscard USB 3.0 functionality back in the kernel?
>>
>> This problem has been described elsewhere, but couldn't find any kernel bug
>> report for it. See this link for further information:
>>
>> http://patchwork.ozlabs.org/patch/804867/

Alternate links:
https://www.spinics.net/lists/linux-pci/msg64202.html
https://www.mail-archive.com/linux-usb@vger.kernel.org/msg93821.html

> In that thread, Mason reported a regression that looks similar, but as
> far as I can tell, we never identified a root cause.
> 
>   1) The problem Mason reported was on a Tango platform, which has a
>      known hardware issue that corrupts data when simultaneous config
>      and MMIO accesses occur.  You're seeing the problem on a
>      different platform, which is very helpful.

As mentioned here:
https://www.mail-archive.com/linux-usb@vger.kernel.org/msg94020.html

When I disable the AER driver, not a single config space access
occurs when a USB drive is unplugged. So I'm 99.99% sure that
the issue is NOT caused by tango's bad design. (I got the vibe
that nobody cared about tango's issue because it was assumed
that the design flaw was responsible for it.)

>   2) Mathias suggested d9f11ba9f107 ("xhci: Rework how we handle
>      unresponsive or hoptlug removed hosts"), which appeared in
>      v4.12-rc1, as a possible culprit, but I don't see a bisection
>      that definitively identifies this commit.
> 
>      Is it possible for you to test both fe190ed0d602 ("xhci: Do not
>      halt the host until both HCD have disconnected their devices.")
>      and d9f11ba9f107 ("xhci: Rework how we handle unresponsive or
>      hoptlug removed hosts") so we can tell for sure whether
>      d9f11ba9f107 broke it?
> 
>   3) Mason did report:
>        v4.11.12 OK
>        v4.12-rc1 KO
>      I assume "KO" means broken (unless that's a typo for "OK"?).  If
>      it means "broken", he did at least confirm that the problem first
>      appeared in v4.12-rc1.

Yes, KO (as in boxing knockout) means "broken", "double-plus-ungood".
It might be unfortunate to use OK and KO, as you point out.

Regards.
