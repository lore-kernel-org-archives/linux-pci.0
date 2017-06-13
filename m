Return-Path: <SRS0=XPBu=5S=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=XPBu=5S=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 13 Jun 2017 06:18:42 +0200
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
Message-ID: <20170613041842.GA13308@kroah.com>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 12, 2017 at 05:34:59PM -0600, Logan Gunthorpe wrote:
> 1) The test we are looking at is overrunning the dynamic char dev major
> numbers by a lot. On a successful run, it gets down to 216 where the
> limit is 234. Thus, there are 18 too many major numbers assigned and the
> fact that this test used to work is really just luck. (I've cc'd
> developers from 49db08c3 for this issue.)

What test causes so many major numbers to be allocated?  Is this
in-kernel test code?  Do you really have a system that requires so many
different drivers that all want a dynamic char major?

thanks,

gre gk-h
