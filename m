Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0125.outbound.protection.outlook.com ([207.46.100.125]:33888
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753608AbbDOLiX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 07:38:23 -0400
From: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"Stuart Yoder" <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Date: Wed, 15 Apr 2015 11:38:21 +0000
Message-ID: <DM2PR0301MB06402A7F6BF42B9A84669D94E2E50@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
 <BN3PR0301MB1219110247416097623B4A7CEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR0301MB1219110247416097623B4A7CEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Varun,

Freescale LS2085A SMMU uses in hit/miss mechanism for the concatenation {tbu number,stream_id}. This concatenation is then assigned to a context bank that determines the translation type and form. The Isolation Context Identifier ICID is the main field of stream_id which will be used to hit ITS device. We may look ICID as ITS device ID and PCI device ID. But there are only 64 ICIDs  0 - 63.  If using default PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn)), PCI device(bus >=1) ) ID will larger than 63.  SMMU will miss this translation.
In addition, because the ICID number  is only 64, all the PCIe device will use the same ICID and share the same ITS device.

Thanks,
Minghuan

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Wednesday, April 15, 2015 7:08 PM
> To: Lian Minghuan-B31939; linux-pci@vger.kernel.org
> Cc: Arnd Bergmann; Lian Minghuan-B31939; Hu Mingkai-B21284; Zang Roy-
> R61911; Yoder Stuart-B08248; Bjorn Helgaas; Wood Scott-B07421; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> 
> Hi Minghuan,
> Not clear what this patch intends to do. Can you please explain the point
> about SMMU isolating limited device ID.
> 
> Regards
> Varun
> 
> > -----Original Message-----
> > From: linux-arm-kernel [mailto:linux-arm-kernel-
> > bounces@lists.infradead.org] On Behalf Of Minghuan Lian
> > Sent: Wednesday, April 15, 2015 3:19 PM
> > To: linux-pci@vger.kernel.org
> > Cc: Arnd Bergmann; Lian Minghuan-B31939; Hu Mingkai-B21284; Zang Roy-
> > R61911; Yoder Stuart-B08248; Bjorn Helgaas; Wood Scott-B07421;
> > linux-arm- kernel@lists.infradead.org
> > Subject: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> >
> > SMMU of some platforms can only isolate limited device ID.
> > This may require that all PCI devices share the same ITS device with
> > the fixed device ID. The patch adds function
> > arch_msi_share_devid_update used for these platforms to update the
> > fixed device ID and maximum MSI interrupts number.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c
> > b/drivers/irqchip/irq-gic-v3-its.c
> > index d0374a6..be78d0a 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -1169,6 +1169,15 @@ static int its_get_pci_alias(struct pci_dev
> > *pdev,
> > u16 alias, void *data)
> >  	return 0;
> >  }
> >
> > +void __weak
> > +arch_msi_share_devid_update(struct pci_dev *pdev, u32 *dev_id, u32
> > +*nvesc) {
> > +	/*
> > +	 * use PCI_DEVID NOT share device ID as default
> > +	 * so nothing need to do
> > +	 */
> > +}
> > +
> >  static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
> >  			   int nvec, msi_alloc_info_t *info)  { @@ -1185,6
> > +1194,8 @@ static int its_msi_prepare(struct irq_domain *domain,
> > +struct
> > device *dev,
> >  	dev_alias.count = nvec;
> >
> >  	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
> > +	arch_msi_share_devid_update(pdev, &dev_alias.dev_id,
> > +&dev_alias.count);
> > +
> >  	its = domain->parent->host_data;
> >
> >  	its_dev = its_find_device(its, dev_alias.dev_id);
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
