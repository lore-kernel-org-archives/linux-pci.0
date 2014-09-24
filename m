Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42795 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbaIXEXH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 00:23:07 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>
Date: Wed, 24 Sep 2014 12:22:21 +0800
Subject: RE: [PATCH v3 2/3] PCI: designware: Add get_msi_data() to
 pcie_host_ops
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661ABCDBA8EF6@EAPEX1MAIL1.st.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-4-git-send-email-Minghuan.Lian@freescale.com>
 <20140923231419.GA27357@google.com>
In-Reply-To: <20140923231419.GA27357@google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, September 24, 2014 4:44 AM
> To: Minghuan Lian
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zang
> Roy-R61911; Hu Mingkai-B21284; Scott Wood; Yoder Stuart-B08248; Arnd
> Bergmann; Mohit KUMAR DCG; Jingoo Han
> Subject: Re: [PATCH v3 2/3] PCI: designware: Add get_msi_data() to
> pcie_host_ops
> 
> [+cc Mohit, Jingoo]
> 
> On Tue, Sep 23, 2014 at 10:28:59PM +0800, Minghuan Lian wrote:
> > The patch adds get_msi_data() for some platforms to return their
> > special MSI message data.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> > Change log:
> > v3: no change
> > v2: no change just derived from v1
> >
> >  drivers/pci/host/pcie-designware.c | 7 ++++++-
> > drivers/pci/host/pcie-designware.h | 1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c
> > index 1c09f814..c28ca05 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -366,7 +366,12 @@ static int dw_msi_setup_irq(struct msi_chip *chip,
> struct pci_dev *pdev,
> >  	else
> >  		msg.address_lo = virt_to_phys((void *)pp->msi_data);
> >  	msg.address_hi = 0x0;
> > -	msg.data = pos;
> > +
> > +	if (pp->ops->get_msi_data)
> > +		msg.data = pp->ops->get_msi_data(pp, pos);
> > +	else
> > +		msg.data = pos;
> > +
> >  	write_msi_msg(irq, &msg);
> >
> >  	return 0;
> > diff --git a/drivers/pci/host/pcie-designware.h
> > b/drivers/pci/host/pcie-designware.h
> > index 904e40a..c625675 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -71,6 +71,7 @@ struct pcie_host_ops {
> >  	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> >  	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> >  	u32 (*get_msi_addr)(struct pcie_port *pp);
> > +	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
> >  	void (*scan_bus)(struct pcie_port *pp);
> >  	int (*msi_host_init)(struct pcie_port *pp, struct msi_chip *chip);
> > };
> > --
> > 1.9.1
> >
- Acked-by: Mohit KUMAR <mohit.kumar@st.com>

Thanks
Mohit
