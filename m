Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54444 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751872AbaIXEM6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 00:12:58 -0400
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
Date: Wed, 24 Sep 2014 12:12:10 +0800
Subject: RE: [PATCH v3 1/3] PCI: designware: Rename get_msi_data to
 get_msi_addr
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661ABCDBA8EEA@EAPEX1MAIL1.st.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-3-git-send-email-Minghuan.Lian@freescale.com>
 <20140923224555.GE27117@google.com>
In-Reply-To: <20140923224555.GE27117@google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Minghuan,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, September 24, 2014 4:16 AM
> To: Minghuan Lian
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zang
> Roy-R61911; Hu Mingkai-B21284; Scott Wood; Yoder Stuart-B08248; Arnd
> Bergmann; Mohit KUMAR DCG; Jingoo Han
> Subject: Re: [PATCH v3 1/3] PCI: designware: Rename get_msi_data to
> get_msi_addr
> 
> [+cc Mohit, Jingoo]
> 
> On Tue, Sep 23, 2014 at 10:28:58PM +0800, Minghuan Lian wrote:
> > The function get_msi_data is used to return MSI message address.
> > In order to accurately express function purpose the patch rename it to
> > get_msi_addr.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> I think this looks like a good idea, but it needs an ack from Mohit and/or
> Jingoo (cc'd).
> 

- Acked-by: Mohit KUMAR <mohit.kumar@st.com>

Thanks
Mohit

> You previously asked whether .get_msi_addr() should also be changed to
> return u64 instead of u32.  I think it should, and you can do that in a separate
> patch that also changes the use in dw_msi_setup_irq() to split the 64-bit
> result into msg.address_lo and msg.address_hi.
> 
> I don't see any implementations of .get_msi_data() or .get_msi_addr(), so
> this seems pretty straightforward.
> 
> Bjorn
> 
> > ---
> > Change log:
> > v3: no change
> > v2: no change just derived from v1
> >
> >  drivers/pci/host/pcie-designware.c | 4 ++--
> > drivers/pci/host/pcie-designware.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c
> > index 5d720c2..1c09f814 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -361,8 +361,8 @@ static int dw_msi_setup_irq(struct msi_chip *chip,
> struct pci_dev *pdev,
> >  	 */
> >  	desc->msi_attrib.multiple = msgvec;
> >
> > -	if (pp->ops->get_msi_data)
> > -		msg.address_lo = pp->ops->get_msi_data(pp);
> > +	if (pp->ops->get_msi_addr)
> > +		msg.address_lo = pp->ops->get_msi_addr(pp);
> >  	else
> >  		msg.address_lo = virt_to_phys((void *)pp->msi_data);
> >  	msg.address_hi = 0x0;
> > diff --git a/drivers/pci/host/pcie-designware.h
> > b/drivers/pci/host/pcie-designware.h
> > index 48f8670..904e40a 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -70,7 +70,7 @@ struct pcie_host_ops {
> >  	void (*host_init)(struct pcie_port *pp);
> >  	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> >  	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> > -	u32 (*get_msi_data)(struct pcie_port *pp);
> > +	u32 (*get_msi_addr)(struct pcie_port *pp);
> >  	void (*scan_bus)(struct pcie_port *pp);
> >  	int (*msi_host_init)(struct pcie_port *pp, struct msi_chip *chip);
> > };
> > --
> > 1.9.1
> >
