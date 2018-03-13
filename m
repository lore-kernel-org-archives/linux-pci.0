Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:32256
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934427AbeCMQAC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 12:00:02 -0400
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Christoph Hellwig <hch@lst.de>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Date: Tue, 13 Mar 2018 15:59:58 +0000
Message-ID: <HE1PR0401MB242509FE2B60674CAF306A4AE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <20180313073448.GA32269@lst.de>
In-Reply-To: <20180313073448.GA32269@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Tuesday, March 13, 2018 13:05
> > +int amba_dma_configure(struct device *dev)
> > +{
> > +	enum dev_dma_attr attr;
> > +	int ret =3D 0;
> > +
> > +	if (dev->of_node) {
> > +		ret =3D of_dma_configure(dev, dev->of_node);
> > +	} else if (has_acpi_companion(dev)) {
> > +		attr =3D acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> > +		if (attr !=3D DEV_DMA_NOT_SUPPORTED)
> > +			ret =3D acpi_dma_configure(dev, attr);
> > +	}
> > +
> > +	return ret;
>=20
> This code sniplet is duplicated so many times that I think we should
> just have some sort of dma_common_configure() for it that the various
> busses can use.

Agree. There is no good point in duplicating the code.
So this new API will be part of 'drivers/base/dma-mapping.c' file?

>=20
> > +void amba_dma_deconfigure(struct device *dev)
> > +{
> > +	of_dma_deconfigure(dev);
> > +	acpi_dma_deconfigure(dev);
> > +}
>=20
> As mention in my previous reply I think we don't even need a deconfigure
> callback at this point - just remove the ACPI and OF wrappers and
> clear the dma ops.
>=20
> Also in this series we should replace the force_dma flag by use of the
> proper method, e.g. give a force parameter to of_dma_configure and the
> new dma_common_configure helper that the busses that want it can set.

I am more inclined to what Robin states in other mail to keep symmetry.
i.e. to keep dma_configure() and dma_deconfigure() and call
dev->bus->dma_configure from dma_configure(). Is this okay?

Thanks,
Nipun
