Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Sep 2017 13:03:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: linux-next: Tree for Sep 6 (*msi.c but ! PCI_MSI)
Message-ID: <20170906180353.GA29570@bhelgaas-glaptop.roam.corp.google.com>
References: <20170906155720.581b9204@canb.auug.org.au>
 <ab28c8c3-94b9-5448-ca91-307c686a1903@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab28c8c3-94b9-5448-ca91-307c686a1903@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Marc, Thomas]

On Wed, Sep 06, 2017 at 08:53:04AM -0700, Randy Dunlap wrote:
> On 09/05/17 22:57, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Please do not add any v4.15 related material to your linux-next
> > included branches until after v4.14-rc1 has been released.
> > 
> > Changes since 20170905:
> > 
> 
> on i386:
> 
> CONFIG_PCI is not enabled, so CONFIG_PCI_MSI is not enabled.
> 
> 
> ../kernel/irq/msi.c: In function 'msi_domain_alloc_irqs':
> ../kernel/irq/msi.c:352:19: error: storage size of 'arg' isn't known
>   msi_alloc_info_t arg;
>                    ^
> 
> ../drivers/base/platform-msi.c:37:19: error: field 'arg' has incomplete type
>   msi_alloc_info_t arg;
>                    ^

Thanks.  I assume this is a new regression in next-20170906, since
you're responding to its announcement?

I don't quite see where the problem is yet (looking at next-20170906).
kernel/irq/msi.c includes linux/msi.h, which includes
arch/x86/include/asm/msi.h, which includes
arch/x86/include/asm/hw_irq.h and has a typedef for msi_alloc_info_t,
but I don't see any CONFIG_PCI guards there that would be relevant.

Bjorn
