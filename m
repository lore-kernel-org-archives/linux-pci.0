Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755005AbdJIXi4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Oct 2017 19:38:56 -0400
Date: Mon, 9 Oct 2017 18:38:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Cc: Niklas <niklas@vividvisions.se>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 197159] New: Xhci
 host controller not responding starting kernel 4.13]
Message-ID: <20171009233852.GO25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171009170108.GK25517@bhelgaas-glaptop.roam.corp.google.com>
 <50d880c5-f76b-cb15-0faa-af9fa617ea9a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50d880c5-f76b-cb15-0faa-af9fa617ea9a@free.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 10:45:39PM +0200, Mason wrote:
> On 09/10/2017 19:01, Bjorn Helgaas wrote:
> ...

> > In that thread, Mason reported a regression that looks similar, but as
> > far as I can tell, we never identified a root cause.
> > 
> >   1) The problem Mason reported was on a Tango platform, which has a
> >      known hardware issue that corrupts data when simultaneous config
> >      and MMIO accesses occur.  You're seeing the problem on a
> >      different platform, which is very helpful.
> 
> As mentioned here:
> https://www.mail-archive.com/linux-usb@vger.kernel.org/msg94020.html
> 
> When I disable the AER driver, not a single config space access
> occurs when a USB drive is unplugged. So I'm 99.99% sure that
> the issue is NOT caused by tango's bad design. (I got the vibe
> that nobody cared about tango's issue because it was assumed
> that the design flaw was responsible for it.)

I agree; I don't think this is Tango's fault.

Can you test fe190ed0d602 and d9f11ba9f107 to determine whether
d9f11ba9f107 is the culprit?  If it is the culprit, can you try reverting
it on a current kernel to see if that fixes it?

If d9f11ba9f107 is not the culprit, can you bisect to discover exactly
where it broke?

> >   2) Mathias suggested d9f11ba9f107 ("xhci: Rework how we handle
> >      unresponsive or hoptlug removed hosts"), which appeared in
> >      v4.12-rc1, as a possible culprit, but I don't see a bisection
> >      that definitively identifies this commit.
> > 
> >      Is it possible for you to test both fe190ed0d602 ("xhci: Do not
> >      halt the host until both HCD have disconnected their devices.")
> >      and d9f11ba9f107 ("xhci: Rework how we handle unresponsive or
> >      hoptlug removed hosts") so we can tell for sure whether
> >      d9f11ba9f107 broke it?
