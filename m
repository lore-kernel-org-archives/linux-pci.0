Return-Path: <SRS0=EDSp=2K=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=EDSp=2K=intel.com=keith.busch@kernel.org>
Date: Wed, 1 Mar 2017 17:59:58 -0500
From: Keith Busch <keith.busch@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-nvme@lists.infradead.org,
	Wei Zhang <wzhang@fb.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	linux-doc@vger.kernel.org,
	Stephen Bates <stephen.bates@microsemi.com>,
	Myron Stowe <myron.stowe@gmail.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
Message-ID: <20170301225958.GB14852@localhost.localdomain>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <20170301222651.GA14852@localhost.localdomain>
 <84556478-c01c-0925-be75-13a61d4c8f4f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84556478-c01c-0925-be75-13a61d4c8f4f@deltatee.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 01, 2017 at 03:37:03PM -0700, Logan Gunthorpe wrote:
> On 01/03/17 03:26 PM, Keith Busch wrote:
> > I think this is from using the managed device resource API to request the
> > irq actions. The scope of the resource used to be tied to the pci_dev's
> > dev, but now it's the new switchec class dev, which has a different
> > lifetime while open references exist, so it's not releasing the irq's.
> 
> The scope of the IRQ was originally tied to the pci_dev. Then in v4 I
> tied it to the switchtec device in order to try and keep using the pci
> device after unbind. This didn't work, so I switched it back to using
> the pci_dev. (This seems to be the way most drivers work anyway.)

Okay, I see. Was mistakenliy looking at v4. The v5 looks right.
