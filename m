Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/msi: remove unused function
 pci_msi_create_default_irq_domain
To: Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
References: <20170203162705.5182-1-hch@lst.de>
 <20170203162705.5182-2-hch@lst.de> <alpine.DEB.2.20.1702081441100.3536@nanos>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <d43182fa-fedb-c648-f607-a7aa11e6f753@arm.com>
Date: Thu, 9 Feb 2017 08:53:14 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702081441100.3536@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/02/17 13:43, Thomas Gleixner wrote:
> On Fri, 3 Feb 2017, Christoph Hellwig wrote:
> 
> No objections, but then we also can remove:
> 
> struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)
> 
> as there are no arch specific implementations
> 
> along with:
> 
> static struct irq_domain *pci_msi_default_domain;
> 
> because pci_msi_create_default_irq_domain() is the only place where the
> default domain is ever set.

Indeed. I'm all for dropping the "default" stuff, as it only gives
people the idea that they can get away with it (most of the time, they
cannot).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
