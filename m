Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog123.obsmtp.com ([207.126.144.155]:55528 "EHLO
	eu1sys200aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752068Ab3LEElS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Dec 2013 23:41:18 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Jingoo Han <jg1.han@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Marek Vasut' <marex@denx.de>,
	=?iso-8859-1?Q?=27Bj=F8rn_Erik_Nilsen=27?= <ben@datarespons.no>,
	'Pratyush Anand' <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Eric Nelson' <Eric.Nelson@boundarydevices.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>
Date: Thu, 5 Dec 2013 12:07:59 +0800
Subject: RE: [PATCH v5 0/2] Kernel oops from pci_disable_msi
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F953637D@EAPEX1MAIL1.st.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
 <1385732125-28630-1-git-send-email-ben@datarespons.no>
 <000301cef15c$acf95630$06ec0290$%han@samsung.com>
 <201312050318.39418.marex@denx.de>
 <000401cef161$27e2a690$77a7f3b0$%han@samsung.com>
In-Reply-To: <000401cef161$27e2a690$77a7f3b0$%han@samsung.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjørn Erik Nilsen,

> -----Original Message-----
> From: Jingoo Han [mailto:jg1.han@samsung.com]
> Sent: Thursday, December 05, 2013 7:55 AM
> To: 'Bjorn Helgaas'
> Cc: 'Marek Vasut'; 'Bjørn Erik Nilsen'; 'Pratyush Anand'; linux-
> pci@vger.kernel.org; 'Kishon Vijay Abraham I'; Mohit KUMAR DCG; Ajay
> KHANDELWAL; 'Tim Harvey'; 'Eric Nelson'; 'Troy Kisky'; 'Jingoo Han'
> Subject: Re: [PATCH v5 0/2] Kernel oops from pci_disable_msi
> 
> On Thursday, December 05, 2013 11:19 AM, Marek Vasut wrote:
> > On Thursday, December 05, 2013 at 02:52:38 AM, Jingoo Han wrote:
> > > On Friday, November 29, 2013 10:35 PM, Bjørn Erik Nilsen wrote:
> > > > This patchset address Marek Vasut's comments on the previous
> > > > patches. I decided to split into two separate commits as they are
> > > > unrelated.
> > > >
> > > > Bjørn Erik Nilsen (2):
> > > >   PCI: designware: Fix crash in dw_msi_teardown_irq
> > > >   PCI: designware: Remove redundant call to pci_write_config
> > > >
> > > >  drivers/pci/host/pcie-designware.c | 57
> > > >  +++++++++++++++++++++++++++----------- 1 file changed, 41
> > > > insertions(+), 16 deletions(-)
> > >
> > > I tested these patches on Exynos platform, and checked that the
> > > kernel panic was resolved.
> > >
> > > Marek Vasut, Bjørn Erik Nilsen,
> > > Is there any issue for accepting these patches?
> >
> > No issue on my end.
> >
> > Acked-by: Marek Vasut <marex@denx.de>
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
I tested it on SPEAr1310 platform and no kernel panic is found.

Tested-by: Mohit Kumar <mohit.kumar@st.com>

As 'write_msi_msg()' redundant  call is removed so the following comment messages are not required here:
	/*
	 * write_msi_msg() will update PCI_MSI_FLAGS so there is
	 * no need to explicitly call pci_write_config.
	 */
Instead move it to the commit log. Same for the other patch for dw_msi_teardown_irq().

Thanks
Mohit
