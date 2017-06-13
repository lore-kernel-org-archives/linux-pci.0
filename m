Return-Path: <SRS0=XPBu=5S=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=XPBu=5S=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 13 Jun 2017 06:35:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20170613043518.GA14621@kroah.com>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <20170613041842.GA13308@kroah.com>
 <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com>
 <20170613043416.GB14217@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170613043416.GB14217@kroah.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 06:34:16AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 12, 2017 at 10:29:20PM -0600, Logan Gunthorpe wrote:
> > 
> > 
> > On 12/06/17 10:18 PM, Greg Kroah-Hartman wrote:
> > > What test causes so many major numbers to be allocated?  Is this
> > > in-kernel test code?  Do you really have a system that requires so many
> > > different drivers that all want a dynamic char major?
> > 
> > This is a 0day kernel robot test. I'm not sure the motivations of its
> > design but it seems to be similar to an allyesconfig. So all/most
> > modules are compiled in and allocating their char device regions on boot
> > of a qemu instance.
> 
> Ah, that makes sense.  Well, someone can always work on expanding the
> range of dynamic char major numbers if they are running out of them on a
> real system, I'll gladly take patches for that :)

Or better yet, just turn all char major allocations into dynamic, which
would be really good for test systems.  I thought someone proposed
patches for that a long time ago, but I can't find them anymore.  That
would be the simplest solution here.

thnaks,

greg k-h
