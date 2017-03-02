Return-Path: <SRS0=utPP=2L=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=utPP=2L=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170228150920.GB12481@bhelgaas-glaptop.roam.corp.google.com>
 <d3d5567a-2147-43c5-d094-fb5345f02143@deltatee.com>
 <20170302003216.GC13171@bhelgaas-glaptop.roam.corp.google.com>
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
Message-ID: <1c1c683c-df1a-bda5-fbea-0f7aaa30b632@deltatee.com>
Date: Wed, 1 Mar 2017 17:39:45 -0700
MIME-Version: 1.0
In-Reply-To: <20170302003216.GC13171@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
List-ID: <linux-pci.vger.kernel.org>



On 01/03/17 05:32 PM, Bjorn Helgaas wrote:
> It's not a perfect fit in drivers/pci because it's not bus
> infrastructure and I don't want to be the default maintainer of it,
> but I agree there's not really an alternative that's clearly better,
> so let's leave it where it is for now.

Sounds good, thanks.

It would be nice if it could stay where it is for organization but go
through other maintainers trees (though I'm not sure who). I understand
why you wouldn't want to take on the maintenance of it. Hopefully,
myself and the other Microsemi developers will be able to do the bulk of
the maintenance work for the driver.

Thanks,

Logan
