Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Feb 2017 18:30:17 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/msi: remove unused default PCI IRQ domain code
In-Reply-To: <20170208171744.17100-2-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1702081828460.3536@nanos>
References: <20170208171744.17100-1-hch@lst.de> <20170208171744.17100-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 8 Feb 2017, Christoph Hellwig wrote:

> pci_msi_create_default_irq_domain is never called in the whole tree, so
> remove it as well as all the supporting code for a default PCI MSI domain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
