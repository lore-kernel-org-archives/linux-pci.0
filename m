Return-Path: <stern+57e13f40@rowland.harvard.edu>
Return-Path: <stern+57e13f40@rowland.harvard.edu>
Date: Wed, 12 Oct 2016 14:23:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Pierre de Villemereuil <flyos@mailoo.org>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
    Mathias Nyman <mathias.nyman@linux.intel.com>,
    Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>,
     <linux-pci@vger.kernel.org>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
In-Reply-To: <1592720.zmCgj0tZJa@flyosflip>
Message-ID: <Pine.LNX.4.44L0.1610121420410.1376-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 12 Oct 2016, Pierre de Villemereuil wrote:

> Hi!
> 
> I'm sorry, I'm not savvy enough to know what to do with this (I know 
> basics on how to code and compile, but I'm no dev). Could someone 
> guide me through it?
> 
> I gather this patch needs to be applied to some kernel module code 
> which needs to be compiled and reloaded into my current kernel, 
> right?

More likely you'll have to rebuild an entire new kernel, not just a 
single module.

Search the support site for the distribution you are using.  It ought
to contain reasonably thorough instructions on how to build and install
your own version of their kernel.

Once you know how to do all that, I can tell you how the patch should
be applied -- that's the easy part.

Alan Stern
