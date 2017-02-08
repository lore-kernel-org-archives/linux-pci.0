Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Feb 2017 14:43:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/2] PCI/msi: remove unused function
 pci_msi_create_default_irq_domain
In-Reply-To: <20170203162705.5182-2-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1702081441100.3536@nanos>
References: <20170203162705.5182-1-hch@lst.de> <20170203162705.5182-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 3 Feb 2017, Christoph Hellwig wrote:

No objections, but then we also can remove:

struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)

as there are no arch specific implementations

along with:

static struct irq_domain *pci_msi_default_domain;

because pci_msi_create_default_irq_domain() is the only place where the
default domain is ever set.

Thanks,

	tglx
