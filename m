Return-Path: <SRS0=YtmY=2J=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=YtmY=2J=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170228150920.GB12481@bhelgaas-glaptop.roam.corp.google.com>
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
 linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d3d5567a-2147-43c5-d094-fb5345f02143@deltatee.com>
Date: Tue, 28 Feb 2017 10:11:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170228150920.GB12481@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
List-ID: <linux-pci.vger.kernel.org>


> This driver doesn't have anything to do with the PCI core, other than
> using the pci_register_driver() interface (just like all other drivers
> for PCI-connected devices), so drivers/pci doesn't really feel like
> the right place for it.  Putting it in drivers/pci leads to the sort
> of confusion you mentioned above ("To make this entirely clear ...").
> 
> Would drivers/perf or drivers/misc/switchtec/ be possible places for
> it?

I made a similar argument when we made the decision of where to put the
code. In the end, the device _is_ a PCI Switch and someone going through
menuconfig or the source tree would probably look there first.

As for drivers/perf, our device does a fair bit more than performance
counters so it doesn't seem like it really fits in there. drivers/misc
just seems like a dumping ground which we'd prefer not to contribute to.
We also considered drivers/char (seeing it exposes a char device), but
that also seems like a dumping ground with stuff that belongs and other
stuff that just ended up stuck between the cracks.

If you still feel strongly about this we can move it into misc, but I
think from an organizational perspective pci/switch makes a bit more sense.

In any case, I also wish we could have had this discussion 3 months ago
when we posted the RFC and not when I have people pushing to get this
merged.

Thanks,

Logan
