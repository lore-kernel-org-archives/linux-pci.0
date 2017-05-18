Return-Path: <SRS0=1vUR=4Y=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=1vUR=4Y=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "helgaas@kernel.org"
	<helgaas@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lukas@wunner.de"
	<lukas@wunner.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com"
	<mika.westerberg@linux.intel.com>,
        "liudongdong (C)"
	<liudongdong3@huawei.com>
Subject: RE: [PATCH v2 1/2] PCI/portdrv: add support for different MSI
 interrupts for PCIe port services
Date: Thu, 18 May 2017 10:08:15 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A36665@FRAEML521-MBX.china.huawei.com>
References: <1495098098-1984-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495098098-1984-2-git-send-email-gabriele.paoloni@huawei.com>
 <20170518092630.GA28006@infradead.org>
In-Reply-To: <20170518092630.GA28006@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Christoph Hellwig
> Sent: 18 May 2017 10:27
> To: Gabriele Paoloni
> Cc: bhelgaas@google.com; helgaas@kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; lukas@wunner.de; linux-kernel@vger.kernel.org;
> mika.westerberg@linux.intel.com; hch@infradead.org; liudongdong (C)
> Subject: Re: [PATCH v2 1/2] PCI/portdrv: add support for different MSI
> interrupts for PCIe port services
>=20
> > - * pcie_port_enable_msix - try to set up MSI-X as interrupt mode for
> given port
> > + * pcie_port_enable_msix_or_msi - try to set up MSI-X or MSI as
> interrupt mode
> > + * for given port
>=20
> just rename it to pcie_port_enable_vecs to avoid the overly long line..

The function is actually renamed but I missed to update the comment, my bad=
.

>=20
> > +		 * pci_irq_vector() below is able to handle entry
> differently
> > +		 * depending on MSI vs MSI-x case
>=20
> As mentioned in the review for the other patch:  no need to repeat
> this for every user of pci_irq_vector.

I also missed to remove this comment

>=20
> Otherwise this looks fine to me:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Many thanks
I'll fix comments and send out v3 straight

Cheers
Gab
