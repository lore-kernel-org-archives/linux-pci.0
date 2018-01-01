Return-Path: <SRS0=JOmu=D4=rowland.harvard.edu=stern+5a55f586@kernel.org>
Return-Path: <SRS0=JOmu=D4=rowland.harvard.edu=stern+5a55f586@kernel.org>
Date: Mon, 1 Jan 2018 10:47:19 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
cc: Bjorn Helgaas <helgaas@kernel.org>,  <linux-pci@vger.kernel.org>,
     <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
    Andy Shevchenko <andy.shevchenko@gmail.com>,  <linux-usb@vger.kernel.org>
Subject: Re: `pci_apply_final_quirks()` taking half a second
In-Reply-To: <92dff466-d0a5-b30c-4d47-48584fac579e@molgen.mpg.de>
Message-ID: <Pine.LNX.4.44L0.1801011041420.5613-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, 1 Jan 2018, Paul Menzel wrote:

> > So they are OHCI controllers.  You could add some debugging statements
> > to quirk_usb_handoff_ohci() to try and locate the part that's taking so
> > long.
> 
> As you suggested debugging statements, I guess the Linux kernel doesn’t 
> offer other ways to instrument functions without modifying the source code.

It does.  Look into ftrace, for example.  However, ftrace only provides
tracing at the level of function calls (hence the name -- "ftrace" for
"function trace"), not for individual statements within a function.  
There are other facilities as well, but none of them are likely to help 
here.

> Is it possible to only rebuild the module somehow or is the early 
> handoff stuff not a module?

It is not a module.

> > It's also worth mentioning that the same source file contains lots of
> > special-case code for AMD and ASmedia hardware.  I don't know whether
> > any of it is involved in the long time delays you are seeing, however.
> 
> Thank you for already looking into this. I haven’t had to time to read 
> the commit messages, which might shed some light into the reasoning.

Good luck!

Alan Stern
