Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Dec 2016 07:35:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] MicroSemi Switchtec management interface driver
Message-ID: <20161219063515.GA5814@kroah.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <1481994562-9283-2-git-send-email-logang@deltatee.com>
 <20161218075141.GE29850@kroah.com>
 <d7c26e15-34f3-26d4-e13a-f24b4a9034c3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d7c26e15-34f3-26d4-e13a-f24b4a9034c3@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 18, 2016 at 10:20:47AM -0700, Logan Gunthorpe wrote:
> Hi Greg,
> 
> Thanks for the quick review!
> 
> On 18/12/16 12:51 AM, Greg Kroah-Hartman wrote:
> > On Sat, Dec 17, 2016 at 10:09:22AM -0700, Logan Gunthorpe wrote:
> > > +struct switchtec_dev {
> > > +	struct pci_dev *pdev;
> > > +	struct msix_entry *msix;
> > > +	struct device *dev;
> > > +	struct kref kref;
> > 
> > Why do you have a pointer to a device, yet a kref as well?  Just have
> > this structure embed a 'struct device' in itself, like you did for a
> > kref, and you will be fine.  Otherwise you are dealing with two
> > different sets of reference counting here, for no good reason.
> 
> Ok, understood. I had referenced the device dax driver which did it this way
> in 4.8 but looks like it was changed to the way you suggest in 4.9.
> 
> > > +#define stdev_pdev(stdev) ((stdev)->pdev)
> > > +#define stdev_pdev_dev(stdev) (&stdev_pdev(stdev)->dev)
> > > +#define stdev_name(stdev) pci_name(stdev_pdev(stdev))
> > > +#define stdev_dev(stdev) ((stdev)->dev)
> > 
> > Ick, just open code these please.  That's a huge hint your use of the
> > driver model is not correct :)
> 
> Ok, will do. For reference, I was copying
> 
> drivers/ntb/hw/intel/ntb_hw_intel.h
> 
> which does a similar thing.

No need to copy bad code, I suggest fixing that up as well :)

thanks,

greg k-h
