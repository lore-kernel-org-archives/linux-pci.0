Return-Path: <stern+57e13f40@rowland.harvard.edu>
Return-Path: <stern+57e13f40@rowland.harvard.edu>
Date: Thu, 13 Oct 2016 17:11:46 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Pierre de Villemereuil <flyos@mailoo.org>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
    Mathias Nyman <mathias.nyman@linux.intel.com>,
    Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>,
     <linux-pci@vger.kernel.org>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
In-Reply-To: <1492262.TFAeDeKh1k@flyosflip>
Message-ID: <Pine.LNX.4.44L0.1610131709160.1822-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 14 Oct 2016, Pierre de Villemereuil wrote:

> Hi!
> 
> I've branched the kernel package on the OpenSUSE Build Server, I'll 
> try to apply the patch there (this ought to be cleanest method).
> 
> Starting from the root of the kernel tarball, the patch should be 
> applied to drivers/pci/pci.c, am I right?

You just cd to the top directory of the kernel source, and do

	patch -p1 <filename

where "filename" is the contents of the email message containing the 
patch.  Or if you want, since the patch is so small, you can simply 
edit the file by hand to add in the new lines.

Alan Stern
