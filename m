Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
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
	<mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 2/2] PCI/portdrv: allocate MSI/MSIx vector for DPC RP
 service
Date: Tue, 16 May 2017 15:27:40 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A2E479@FRAEML521-MBX.china.huawei.com>
References: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
 <1494930342-7132-3-git-send-email-gabriele.paoloni@huawei.com>
 <20170516121112.GA16209@infradead.org>
In-Reply-To: <20170516121112.GA16209@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: 16 May 2017 13:11
> To: Gabriele Paoloni
> Cc: bhelgaas@google.com; helgaas@kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; lukas@wunner.de; linux-kernel@vger.kernel.org;
> mika.westerberg@linux.intel.com
> Subject: Re: [PATCH 2/2] PCI/portdrv: allocate MSI/MSIx vector for DPC
> RP service
>=20
> > +		 * pci_irq_vector() below is able to handle entry
> differently
> > +		 * depending on MSI vs MSI-x case
> > +		 *

Ok I'll remove this in V2

>=20
> No need to mention that for every users.
>=20
> Except for that this looks fine:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Many thanks
Gab
