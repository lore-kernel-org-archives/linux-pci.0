Return-Path: <SRS0=RU++=2E=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=RU++=2E=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-4-git-send-email-logang@deltatee.com>
 <20170223224317.GA21548@bhelgaas-glaptop.roam.corp.google.com>
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
Message-ID: <7c981c0d-e7ff-bf28-ec55-cf5c39290437@deltatee.com>
Date: Thu, 23 Feb 2017 15:56:21 -0700
MIME-Version: 1.0
In-Reply-To: <20170223224317.GA21548@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v2 3/4] switchtec: Add sysfs attributes to the Switchtec
 driver
List-ID: <linux-pci.vger.kernel.org>



On 23/02/17 03:43 PM, Bjorn Helgaas wrote:
> This path seems a little generic.  I don't see other cases where a
> product brand name ("Switchtec") appears at the top level of
> /sys/class/...

Ok, well we are certainly open to suggestions, but there isn't really a
generic version of this device available so I'm not sure how we would
change that. Per device-type classes aren't that uncommon though, a
quick grep shows things like:

platform/chrome/cros_ec_dev.c:40:static struct class cros_class
s390/char/raw3270.h:94:extern struct class *class3270;
net/ethernet/hisilicon/hns/hnae.c:19:static struct class *hnae_class;
mfd/ucb1x00-core.c:490:static struct class ucb1x00_class

> My question is based on "ls Documentation/ABI/testing/sysfs-class*",
> not on any great knowledge of sysfs, and I see Greg has already given
> a Reviewed-by for this, so maybe this is the right approach.
> 
> It does seem like the path could include a clue that this is related
> to PCI.

I mean, we could change it to pci-switchtec or something if you think
that would be better..?? But I'm not sure how else to accommodate this.

> Is there a link to the switch PCI device itself, e.g., to
> /sys/devices/pci*?  Should these attributes simply be put in a
> subdirectory there, e.g., in
> 
>   /sys/devices/pci0000:00/0000:00:00.0/stats/...

Well our device shows up here in the tree:

/sys/devices/pci0000:00/0000:00:03.0/0000:03:00.1/switchtec/switchtec0

(Which userspace can get to by following the link at
/sys/class/switchtec/switchtec0) The switch is then always:

/sys/devices/pci0000:00/0000:00:03.0

Thanks,

Logan
