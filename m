Return-Path: <SRS0=utPP=2L=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=utPP=2L=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <4a867c32-ed29-bc98-c7cb-6315243e664a@deltatee.com>
 <b34d6872-35de-da6d-2d7f-8842642d3f21@deltatee.com>
 <20170301235854.GF2820@obsidianresearch.com>
 <7d6b3b59-5cec-d73f-b65c-4d685ccc70f8@deltatee.com>
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
Message-ID: <8e20a911-988b-b486-4530-2525efc8b2c2@deltatee.com>
Date: Wed, 1 Mar 2017 17:29:27 -0700
MIME-Version: 1.0
In-Reply-To: <7d6b3b59-5cec-d73f-b65c-4d685ccc70f8@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
List-ID: <linux-pci.vger.kernel.org>



On 01/03/17 05:23 PM, Logan Gunthorpe wrote:
> Because of how poll works, I don't see how I can just hold a semaphore
> inside every fops call like the tpm code does.

On 01/03/17 04:58 PM, Jason Gunthorpe wrote:
> Both infiniband and TPM have the 'detach' flavour of unplug where the
> user is not forced to close their open cdevs. For simpler cases you
> can just wait for all cdevs to close with a simple rwsem, much like
> sysfs does already during device_del.

Though, after reading your email again, a hard fence on close sounds
like a good idea. Tomorrow I'll post a v6 that uses that approach.


Thanks,

Logan
