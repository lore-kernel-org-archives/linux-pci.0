Return-Path: <SRS0=Pck9=2K=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Pck9=2K=deltatee.com=logang@kernel.org>
To: Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <20170301222651.GA14852@localhost.localdomain>
Cc: Myron Stowe <myron.stowe@gmail.com>,
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
Message-ID: <84556478-c01c-0925-be75-13a61d4c8f4f@deltatee.com>
Date: Wed, 1 Mar 2017 15:37:03 -0700
MIME-Version: 1.0
In-Reply-To: <20170301222651.GA14852@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
List-ID: <linux-pci.vger.kernel.org>



On 01/03/17 03:26 PM, Keith Busch wrote:
> I think this is from using the managed device resource API to request the
> irq actions. The scope of the resource used to be tied to the pci_dev's
> dev, but now it's the new switchec class dev, which has a different
> lifetime while open references exist, so it's not releasing the irq's.

The scope of the IRQ was originally tied to the pci_dev. Then in v4 I
tied it to the switchtec device in order to try and keep using the pci
device after unbind. This didn't work, so I switched it back to using
the pci_dev. (This seems to be the way most drivers work anyway.)


> One thing about the BUG_ON that is confusing me is how it's getting
> to free_msi_irq's BUG in v4 or v5. I don't see any part releasing the
> allocated ones. Maybe the devres API is harder to use than having the
> driver manage all the resources...

free_msi_irqs seems to be called via pci_disable_device in pcim_release
which devres will call during release of the PCI device and before all
the references to the pci_dev are freed (I tried adding an extra
get_device which gets put in the child devices release -- this didn't work):

 [ 1079.845616] Call Trace:
 [ 1079.845652]  ? pcim_release+0x35/0x96
 [ 1079.845691]  ? release_nodes+0x15b/0x17c
 [ 1079.845730]  ? device_release_driver_internal+0x12d/0x1cb
 [ 1079.845771]  ? unbind_store+0x59/0x89
 [ 1079.845809]  ? kernfs_fop_write+0xe7/0x129
 [ 1079.845847]  ? __vfs_write+0x1c/0xa2
 [ 1079.845885]  ? kmem_cache_alloc+0xc5/0x131
 [ 1079.845923]  ? fput+0xd/0x7d
 [ 1079.845958]  ? filp_close+0x5a/0x61
 [ 1079.845993]  ? vfs_write+0xa2/0xe4
 [ 1079.846028]  ? SyS_write+0x48/0x73
 [ 1079.846066]  ? entry_SYSCALL_64_fastpath+0x13/0x94

v5 is correct because it registers the irqs against the pci_dev (with
devm_request_irq) and thus they get freed in time as part of the devres
unwind.

Logan
