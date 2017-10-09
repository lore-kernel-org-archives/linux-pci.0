Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754163AbdJIRBM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Oct 2017 13:01:12 -0400
Date: Mon, 9 Oct 2017 12:01:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas <niklas@vividvisions.se>
Cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Mason <slash.tmp@free.fr>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 197159] New: Xhci host
 controller not responding starting kernel 4.13]
Message-ID: <20171009170108.GK25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-usb, Mason, Mathias, Lukas, Greg, Felipe, Alan]

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> 
> Date: Sun, 08 Oct 2017 13:28:13 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bugzilla.pci@gmail.com
> Subject: [Bug 197159] New: Xhci host controller not responding starting kernel
> 	4.13
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=197159
> 
>             Bug ID: 197159
>            Summary: Xhci host controller not responding starting kernel
>                     4.13
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 4.13
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: niklas@vividvisions.se
>         Regression: No
> 
> When booting with a Expresscard USB 3.0 adapter (NEC UPD720202 Chip), the
> following error is generated:
> 
> "xhci_hcd 0000:05:00.0: xHCI host controller not responding, assumed dead"
> 
> This card still works fine with kernel 4.9.

Thanks very much for the bug report, and sorry for the regression.

Can you please collect the complete dmesg log and "lspci -vv" output
and attach them to the bugzilla?

> Additionally, for some reason this also interferes with LUKS on an LVM
> partition; password does not work and computer becomes stuck at this point.
> This works as normal if card is removed and computer is rebooted.
> 
> Can we please have Expresscard USB 3.0 functionality back in the kernel?
> 
> This problem has been described elsewhere, but couldn't find any kernel bug
> report for it. See this link for further information:
> 
> http://patchwork.ozlabs.org/patch/804867/

In that thread, Mason reported a regression that looks similar, but as
far as I can tell, we never identified a root cause.

  1) The problem Mason reported was on a Tango platform, which has a
     known hardware issue that corrupts data when simultaneous config
     and MMIO accesses occur.  You're seeing the problem on a
     different platform, which is very helpful.

  2) Mathias suggested d9f11ba9f107 ("xhci: Rework how we handle
     unresponsive or hoptlug removed hosts"), which appeared in
     v4.12-rc1, as a possible culprit, but I don't see a bisection
     that definitively identifies this commit.

     Is it possible for you to test both fe190ed0d602 ("xhci: Do not
     halt the host until both HCD have disconnected their devices.")
     and d9f11ba9f107 ("xhci: Rework how we handle unresponsive or
     hoptlug removed hosts") so we can tell for sure whether
     d9f11ba9f107 broke it?

  3) Mason did report:
       v4.11.12 OK
       v4.12-rc1 KO
     I assume "KO" means broken (unless that's a typo for "OK"?).  If
     it means "broken", he did at least confirm that the problem first
     appeared in v4.12-rc1.

Bjorn

> Tested with Antergos (Arch) on a Thinkpad T420. The card works with the LTS
> kernel which is at 4.9.52-1 but not the latest which is 4.13.3-1.
