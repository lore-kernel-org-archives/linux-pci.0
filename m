Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:43416 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753229AbbILRsD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Sep 2015 13:48:03 -0400
Date: Sat, 12 Sep 2015 13:48:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Roland Weber <r-o-l@web.de>
cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
In-Reply-To: <trinity-a551d763-5359-4caa-9985-2b89ecf7161d-1442055427110@3capp-webde-bs34>
Message-ID: <Pine.LNX.4.44L0.1509121341080.13622-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 12 Sep 2015, Roland Weber wrote:

> Hi Alan,
> 
> I'm sending a "Reply to all" on this mail. Should I continue to keep
> Mathias and Bjorn on copy and cross-posting to linux-pci@ (I'm not
> yet subscribed there, so that post probably won't get through anyway)?

Most kernel lists don't require posters to subscribe.  Yes, please keep 
everybody on the CC: list.

> > [Roland, what happens if you try unbinding xhci-hcd before ehci-hcd?  
> > Note that unbinding xhci-hcd will cause your wireless keyboard & mouse
> > to stop working, so you'll have to use a shell script or a network
> > login to run the test.]
> 
> The outcome is the same, the system freezes on the readl.
> See below for the transcript from a screen photo.
> 
> > I say this may be relevant because Roland found that ehci-hcd was
> > unable to communicate over the USB bus if it tried to do so before
> > xhci-hcd was probed.  This happens in the 3.17 or earlier kernel -- and
> > that kernel doesn't suffer the freeze problem.
> 
> I can also produce the freeze on 3.17, with some extra steps:

Okay, that's worth knowing.

> (after boot there's just the ehci-pci bus with no device)
> - unbind ehci-pci
> - bind ehci-pci

During both the unbind and the bind, the debugging lines you added to
ehci-hcd.c should show up.  Do they?

> (now the ehci-pci bus has the missing device)
> - unbind ehci-pci
> 
> So the only reason why the older kernels didn't freeze is that
> the device in question couldn't be initialized with the original
> probe sequence. I'll try your blacklisting tip over the weekend.

I wouldn't call it the "only reason".  Rather, it's another symptom
arising from the same underlying problem.

Alan Stern

