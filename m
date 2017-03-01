Return-Path: <SRS0=Pck9=2K=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Pck9=2K=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <4a867c32-ed29-bc98-c7cb-6315243e664a@deltatee.com>
Cc: Keith Busch <keith.busch@intel.com>, Myron Stowe <myron.stowe@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Wei Zhang <wzhang@fb.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Stephen Bates <stephen.bates@microsemi.com>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b34d6872-35de-da6d-2d7f-8842642d3f21@deltatee.com>
Date: Wed, 1 Mar 2017 15:49:04 -0700
MIME-Version: 1.0
In-Reply-To: <4a867c32-ed29-bc98-c7cb-6315243e664a@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
List-ID: <linux-pci.vger.kernel.org>

Hey,

Seems to me like an elegant solution would be to implement a 'cdev_kill'
function which could kill all the processes using a cdev. Thus, during
an unbind, a driver could call it and be sure that there are no users
left and it can safely allow the devres unwind to continue. Then no
difficult and racy 'alive' flags would be necessary and it would be much
easier on drivers.

However, I don't think any such thing exists at the moment and it's not
likely to be done in the near term. I'm reasonably confident in the
correctness of v5 of my driver (especially when compared to other
drivers) and unless someone can describe how it's wrong or a better
solution I'd rather see it merged as is. If and when a better approach
arrives I'd happily patch it to improve the situation.

Logan

On 01/03/17 03:24 PM, Logan Gunthorpe wrote:
> 
> 
> On 01/03/17 02:41 PM, Bjorn Helgaas wrote:
>> I don't think this is indicating a bug in the PCI core (although I do
>> think a BUG_ON() here is an excessive response).  I think it's an
>> indication that the driver didn't disconnect its ISR.  Without more
>> details of the failure it's hard to tell if the BUG_ON is a symptom of
>> a problem in the driver or what.
> 
> Yes, my assumption was that when you force an unbind on the PCI core,
> it's designed to stop using the PCI device right away even if there are
> users using it. Thus it becomes the drivers responsibility to handle
> this situation.
> 
>> An "alive" flag feels racy, and I can't tell if it's really the best
>> way to deal with this, or if it's just avoiding the issue.  There must
>> be other drivers with the same cleanup issue -- do they handle it the
>> same way?
> 
> I haven't done a comprehensive search, but it's very common for people
> to use (and this is what I've adopted again in v5):
> 
> devm_request_irq(&pdev->dev, ...)
> 
> In this way, the IRQs are released with the pci_dev (or often platform)
> and thus the BUG_ON never hits. However, it means any user space program
> waiting on an IRQ (like via a cdev call) will hang unless handled with
> other means. Exactly what those means are seems driver specific and not
> always obvious. I wouldn't be surprised if a lot of drivers get this
> aspect wrong.
> 
> A couple examples I've looked at:
> 
> 1) drivers/dax/dax.c uses an alive flag without any mutexes, atomics or
> anything. So I don't know if it's racy or perhaps correct for other reasons.
> 
> 2) drivers/char/hw_random has a drop_current_rng that looks like it
> could easily be racy with the get_current_rng in the userspace flow.
> 
> 3) A couple of drivers drivers/char/tpm doesn't seem to have any
> protection at all and appears like they would continue to use io
> operations even after the they may get unmapped because the char device
> persists.
> 
> So I'm not sure where you'd find a driver that does it correctly and in
> a simpler way..
> 
> Another thing: based on comments in [1], a lot of people don't seem to
> realize that cdev instances can persist long after cdev_del so it's
> probably very common for drivers to get this wrong.
> 
> Logan
> 
> [1] https://lists.01.org/pipermail/linux-nvdimm/2017-February/009001.html
