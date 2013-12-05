Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17454 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab3LECYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 21:24:44 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXB005DOAP69SB0@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 05 Dec 2013 11:24:42 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Marek Vasut' <marex@denx.de>,
	=?iso-8859-1?Q?'Bj=F8rn_Erik_Nilsen'?= <ben@datarespons.no>,
	'Pratyush Anand' <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Ajay KHANDELWAL' <ajay.khandelwal@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Eric Nelson' <Eric.Nelson@boundarydevices.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
 <1385732125-28630-1-git-send-email-ben@datarespons.no>
 <000301cef15c$acf95630$06ec0290$%han@samsung.com>
 <201312050318.39418.marex@denx.de>
In-reply-to: <201312050318.39418.marex@denx.de>
Subject: Re: [PATCH v5 0/2] Kernel oops from pci_disable_msi
Date: Thu, 05 Dec 2013 11:24:42 +0900
Message-id: <000401cef161$27e2a690$77a7f3b0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 05, 2013 11:19 AM, Marek Vasut wrote:
> On Thursday, December 05, 2013 at 02:52:38 AM, Jingoo Han wrote:
> > On Friday, November 29, 2013 10:35 PM, Bjørn Erik Nilsen wrote:
> > > This patchset address Marek Vasut's comments on the previous
> > > patches. I decided to split into two separate commits as they are
> > > unrelated.
> > >
> > > Bjørn Erik Nilsen (2):
> > >   PCI: designware: Fix crash in dw_msi_teardown_irq
> > >   PCI: designware: Remove redundant call to pci_write_config
> > >
> > >  drivers/pci/host/pcie-designware.c | 57
> > >  +++++++++++++++++++++++++++----------- 1 file changed, 41
> > >  insertions(+), 16 deletions(-)
> >
> > I tested these patches on Exynos platform, and checked that
> > the kernel panic was resolved.
> >
> > Marek Vasut, Bjørn Erik Nilsen,
> > Is there any issue for accepting these patches?
> 
> No issue on my end.
> 
> Acked-by: Marek Vasut <marex@denx.de>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

