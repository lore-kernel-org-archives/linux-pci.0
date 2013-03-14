Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 14 Mar 2013 17:09:59 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Hurley <peter@hurleysoftware.com>,
	Thomas Meyer <thomas@m3y3r.de>,
	Shawn Starr <shawn.starr@rogers.com>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [3.9-rc1] irq 16: nobody cared  (was [3.9-rc1] very poor interrupt
 responses)
In-Reply-To: <alpine.LNX.2.00.1303141555090.30118@pobox.suse.cz>
Message-ID: <alpine.LNX.2.00.1303141709000.30118@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1303141050310.1983-100000@iolanthe.rowland.org> <alpine.LNX.2.00.1303141555090.30118@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Mar 2013, Jiri Kosina wrote:

> > > I don't think I have seen this message on rc1+ (8343bce, to be precise), 
> > > but I have definitely seen sluggish system response on that kernel as 
> > > well.
> > > 
> > > Attaching lspci, /proc/interrupts and dmesg. 
> > 
> > Can you try to do a git bisect for this?  Is the sluggish system 
> > response clear enough that you can tell reliably when it is present and 
> > when it isn't?
> 
> That was my first thought, but unfortunately I am afraid there will be 
> point at which I will easily make a bisection mistake, as the 
> responsiveness of the system varies over time, so it's not really a 
> 100% objective measure.

So I will try a bisect, but it'll take some time so that I could claim it 
to be trustworthy.

Therefore in case anyone has any idea in parallel, I am all ears.

-- 
Jiri Kosina
SUSE Labs
