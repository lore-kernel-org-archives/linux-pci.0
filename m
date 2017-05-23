Return-Path: <SRS0=fyJp=45=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=fyJp=45=huawei.com=gabriele.paoloni@kernel.org>
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
Date: Tue, 23 May 2017 14:25:21 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A5484A@FRAEML521-MBX.china.huawei.com>
References: <1495103748-7876-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495103748-7876-2-git-send-email-gabriele.paoloni@huawei.com>
 <20170521083234.GA20658@infradead.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A45545@FRAEML521-MBX.china.huawei.com>
 <20170522174411.GA29861@infradead.org>
In-Reply-To: <20170522174411.GA29861@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Christoph Hellwig
> Sent: 22 May 2017 18:44
> To: Gabriele Paoloni
> Cc: Christoph Hellwig; bhelgaas@google.com; helgaas@kernel.org;
> Linuxarm; linux-pci@vger.kernel.org; lukas@wunner.de; linux-
> kernel@vger.kernel.org; mika.westerberg@linux.intel.com; liudongdong
> (C)
> Subject: Re: [PATCH v3 1/2] PCI/portdrv: add support for different MSI
> interrupts for PCIe port services
>=20
> On Sun, May 21, 2017 at 03:00:46PM +0000, Gabriele Paoloni wrote:
> >
> > I thought that in your previous review you meant to say that we
> should
> > avoid 2 instances of the same comment (in this patchset I only have
> this
> > instance as I have removed the same comment from patch 2/2...)
>=20
> No, there is no pointin the comment.  The whole point of pci_irq_vector
> is to abstract away from how to get at the interrupt in detail.  There
> is no need to comment on this at the callsite.  If you think the
> existing documentation for the function is not good enough send a patch
> to improve it there instead of commenting the callsites.

Ok got it. I have just sent out v5 where this is fixed.
Thanks
Gab
