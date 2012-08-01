Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 1 Aug 2012 16:21:47 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: matt.fleming@intel.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH V2 1/4] EFI: Stash ROMs if they're not in the PCI BAR
Message-ID: <20120801232147.GA6228@kroah.com>
References: <1343407934-459-1-git-send-email-mjg@redhat.com>
 <20120731223240.GD19134@kroah.com>
 <20120801165400.GA3042@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120801165400.GA3042@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2012 at 05:54:00PM +0100, Matthew Garrett wrote:
> On Tue, Jul 31, 2012 at 03:32:40PM -0700, Greg KH wrote:
> 
> > With this series, does the latest MacBook work properly for the Intel
> > graphics driver?  Or is this to resolve some other hardware issue?
> 
> Apple only seem to provide the ROM for the radeon. Intel normally 
> stands a much better chance of working without a ROM - the only thing it 
> really uses it for is the VBT, and I'm thinking about a couple of ways 
> of handlng that.

Ok, thanks for letting me know.  For some reason, the gmux isn't working
on the latest MacBook Pro so I can't get the vga switched to the Intel
PCI device.  Rumor has it the osx tool at
http://codykrieger.com/gfxCardStatus will switch into the Intel chip
until the laptop is hard powered off, so it is possible, just need to
figure out how to make the hardware do the switch...

greg k-h
