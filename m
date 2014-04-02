Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62883 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbaDBFWr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Apr 2014 01:22:47 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3E002VH1LYCJ90@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 02 Apr 2014 14:22:46 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Pratyush ANAND' <pratyush.anand@st.com>,
	'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>
References: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FEB13752@EAPEX1MAIL1.st.com>
In-reply-to: <2CC2A0A4A178534D93D5159BF3BCB66189FEB13752@EAPEX1MAIL1.st.com>
Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
Date: Wed, 02 Apr 2014 14:22:45 +0900
Message-id: <000001cf4e33$946db4b0$bd491e10$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 02, 2014 1:57 PM, Mohit KUMAR DCG wrote:
> On Tuesday, April 01, 2014 4:00 PM, Jingoo Han wrote:
> >
> > According to the spec, the synopsys core does not implement the optional
> > BARs such as BAR0/1. This is based on the assumption that the RC host
> > probably has registers on some other internal bus and has knowledge and
> > setup access to these registers already.
> > So, remove unnecessary RC BAR setting.
> >
> - Normally BARs in RC are not used but somehow available in the design. One possible
> BAR use can be if RC has some memory connected to the BAR that needs to be accessed through link.
> 
> Otherwise we can ignore BARs setup here.

Hi Mohit KUMAR DCG,

Thank you for your feedback.

I want to know whether or not other SoCs such as ST, Freescale, TI
support BAR0/BAR1. If no SoC supports BAR0/BAR1, the unnecessary
RC BAR setting code should  be removed.

Best regards,
Jingoo Han

> 
> Thanks
> Mohit
> 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> > Tested on Exynos5440.
> >
> >  drivers/pci/host/pcie-designware.c |    4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> > designware.c
> > index 6d23d8c..7bee01f 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -798,10 +798,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >  	}
> >  	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
> >
> > -	/* setup RC BARs */
> > -	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
> > -	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
> > -
> >  	/* setup interrupt pins */
> >  	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
> >  	val &= 0xffff00ff;
> > --
> > 1.7.10.4

