Return-Path: <SRS0=uLZ3=43=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=uLZ3=43=huawei.com=gabriele.paoloni@kernel.org>
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
Subject: RE: [PATCH v3 1/2] PCI/portdrv: add support for different MSI
 interrupts for PCIe port services
Date: Sun, 21 May 2017 15:00:46 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A45545@FRAEML521-MBX.china.huawei.com>
References: <1495103748-7876-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495103748-7876-2-git-send-email-gabriele.paoloni@huawei.com>
 <20170521083234.GA20658@infradead.org>
In-Reply-To: <20170521083234.GA20658@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Christoph Hellwig
> Sent: 21 May 2017 09:33
> To: Gabriele Paoloni
> Cc: bhelgaas@google.com; helgaas@kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; lukas@wunner.de; linux-kernel@vger.kernel.org;
> mika.westerberg@linux.intel.com; hch@infradead.org; liudongdong (C)
> Subject: Re: [PATCH v3 1/2] PCI/portdrv: add support for different MSI
> interrupts for PCIe port services
>=20
> > +		 *
> > +		 * pci_irq_vector() below is able to handle entry
> diff erently
> > +		 * depending on MSI vs MSI-x case
> > +		 *
> >  		 */
>=20
> One more instance of this comment left :)

I thought that in your previous review you meant to say that we should
avoid 2 instances of the same comment (in this patchset I only have this=20
instance as I have removed the same comment from patch 2/2...)

>=20
> >  		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
> >  		entry =3D (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
> > @@ -100,7 +107,10 @@ static int pcie_port_enable_msix(struct pci_dev
> *dev, int *irqs, int mask)
> >  		 * MSI/MSI-X vectors assigned to the port is going to be
> used
> >  		 * for AER, where "For MSI-X, the value in this register
> >  		 * indicates which MSI-X Table entry is used to generate
> the
> > -		 * interrupt message."
> > +		 * interrupt message."  and "For MSI, the value
> > +		 * in this field indicates the offset between the base
> Message
> > +		 * Data and the interrupt message that is generated."
> > +		 *
> >  		 */
>=20
> And while this is getting a little too deep into nitpicking:  we
> usually
> don't add empty lines to the end of comments.

Ok I can remove the extra line and send out patch v4...

Many thanks
Gab
