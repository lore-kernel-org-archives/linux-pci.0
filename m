Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37639 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674AbaFSDty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Jun 2014 23:49:54 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Jingoo Han <jg1.han@samsung.com>,
	"'Fabio Estevam'" <festevam@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"'Fabio Estevam'" <fabio.estevam@freescale.com>
Date: Thu, 19 Jun 2014 11:49:38 +0800
Subject: RE: [PATCH] PCI: designware: Use IS_ENABLED()
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB6619C5F816AED@EAPEX1MAIL1.st.com>
References: <1403104613-9867-1-git-send-email-festevam@gmail.com>
 <005201cf8b52$f1006db0$d3014910$%han@samsung.com>
In-Reply-To: <005201cf8b52$f1006db0$d3014910$%han@samsung.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Fabio,

> -----Original Message-----
> From: Jingoo Han [mailto:jg1.han@samsung.com]
> Sent: Thursday, June 19, 2014 5:41 AM
> To: 'Fabio Estevam'; bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org; 'Fabio Estevam'; 'Jingoo Han'; Mohit KUMAR
> DCG
> Subject: Re: [PATCH] PCI: designware: Use IS_ENABLED()
> 
> On Thursday, June 19, 2014 12:17 AM, Fabio Estevam wrote:
> >
> > We can get rid of the 'ifdef' by using the IS_ENABLED() macro.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> (+cc Mohit Kumar)
> 

- yes, looks good...

Acked-by: Mohit Kumar <mohit.kumar@st.com>

Thanks
Mohit

> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> Best regards,
> Jingoo Han
> 
> > ---
> >  drivers/pci/host/pcie-designware.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> > index 1eaf4df3..dc842fd 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -497,9 +497,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >
> >  	pci_common_init_dev(pp->dev, &dw_pci);
> >  	pci_assign_unassigned_resources();
> > -#ifdef CONFIG_PCI_DOMAINS
> > -	dw_pci.domain++;
> > -#endif
> > +	if (IS_ENABLED(CONFIG_PCI_DOMAINS))
> > +		dw_pci.domain++;
> >
> >  	return 0;
> >  }
> > --
> > 1.8.3.2

