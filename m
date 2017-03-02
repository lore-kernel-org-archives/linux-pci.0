Return-Path: <SRS0=utPP=2L=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=utPP=2L=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <4a867c32-ed29-bc98-c7cb-6315243e664a@deltatee.com>
 <b34d6872-35de-da6d-2d7f-8842642d3f21@deltatee.com>
 <20170301235854.GF2820@obsidianresearch.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>,
 Myron Stowe <myron.stowe@gmail.com>,
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
 linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7d6b3b59-5cec-d73f-b65c-4d685ccc70f8@deltatee.com>
Date: Wed, 1 Mar 2017 17:23:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170301235854.GF2820@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
List-ID: <linux-pci.vger.kernel.org>



On 01/03/17 04:58 PM, Jason Gunthorpe wrote:
> On Wed, Mar 01, 2017 at 03:49:04PM -0700, Logan Gunthorpe wrote:
> 
>> Seems to me like an elegant solution would be to implement a 'cdev_kill'
>> function which could kill all the processes using a cdev. Thus, during
>> an unbind, a driver could call it and be sure that there are no users
>> left and it can safely allow the devres unwind to continue. Then no
>> difficult and racy 'alive' flags would be necessary and it would be much
>> easier on drivers.
> 
> That could help, but this would mean cdev would have to insert a shim
> to grab locks around the various file ops.

Hmm, I was hoping something more along the lines of actually killing the
processes instead of just shimming away fops.

> AFAIK TPM is correct and has been robustly tested now. We have a 'vtpm'
> driver that agressively uses hot-unplug.

Ah, thanks for the explanation of how that works. I didn't notice the
semaphore usage.

Switchtec is a bit more tricky because a) there's no upper level driver
to handle things and b) userspace may be inside a wait_for_completion
(via read or poll) that needs to be completed. If a so called
'cdev_kill' could actually just kill these processes it would be a bit
easier.

Currently, in the Switchtec code, there's a timeout if the interrupt
doesn't fire (which occurs if the pci device has been torn down) and the
code will check an alive bit (under mutex protection) and error out if
it's not alive.

Because of how poll works, I don't see how I can just hold a semaphore
inside every fops call like the tpm code does.

Logan
