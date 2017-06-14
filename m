Return-Path: <SRS0=qceG=5T=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=qceG=5T=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 14 Jun 2017 07:01:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	kernel test robot <fengguang.wu@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, LKP <lkp@01.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	wfg@linux.intel.com, Alan Cox <alan@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	David Airlie <airlied@linux.ie>,
	David Herrmann <dh.herrmann@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable
 to handle kernel NULL pointer dereference at 00000000000000a8
Message-ID: <20170614050112.GB11630@kroah.com>
References: <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <20170613041842.GA13308@kroah.com>
 <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com>
 <20170613043416.GB14217@kroah.com>
 <20170613043518.GA14621@kroah.com>
 <8462abee-0a7f-00fb-6111-1f78362ea3f7@deltatee.com>
 <20170613163508.GA31961@kroah.com>
 <alpine.DEB.2.20.1706132106410.11042@aurora.sdinet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1706132106410.11042@aurora.sdinet.de>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 09:13:32PM +0200, Sven-Haegar Koch wrote:
> On Tue, 13 Jun 2017, Greg Kroah-Hartman wrote:
> 
> > On Tue, Jun 13, 2017 at 10:25:40AM -0600, Logan Gunthorpe wrote:
> > > 
> > > On 12/06/17 10:35 PM, Greg Kroah-Hartman wrote:
> > > > Or better yet, just turn all char major allocations into dynamic, which
> > > > would be really good for test systems.  I thought someone proposed
> > > > patches for that a long time ago, but I can't find them anymore.  That
> > > > would be the simplest solution here.
> > > 
> > > Would people not complain about that? I would not be surprised if some
> > > crazy application is using hard coded major numbers in userspace. So
> > > such a change could potentially break userspace...
> > 
> > For char devices, I doubt it, but we can't take the chance, which is why
> > you make it an option.  Then, it's enabled for 'allmodconfig' builds,
> > which helps testers out.
> 
> At least for /dev/null, /dev/zero, and perhaps /dev/tty it would 
> definitely break things if the major+minor number is not static. I have 
> multiple chroot environments having only some minimal needed static 
> /dev subdir, with naturally no daemons or filesystem creating those 
> on-demand. For the main /dev I use whatever the system sets up, so 
> devtmpfs with udev.

No, it wouldn't be required, it would be an option for those people
using devtmpfs.

thanks,

greg k-h
