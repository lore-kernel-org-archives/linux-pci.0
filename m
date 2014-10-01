Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16670 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaJAHJS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Oct 2014 03:09:18 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NCR0002J7VG2D30@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 01 Oct 2014 16:09:17 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
 <20141001042815.GA24581@pratyush-vbox>
In-reply-to: <20141001042815.GA24581@pratyush-vbox>
Subject: Re: [PATCH 0/2] Designware MSI fixes
Date: Wed, 01 Oct 2014 16:09:10 +0900
Message-id: <006801cfdd46$9cbcecb0$d636c610$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 01, 2014 1:28 PM, Pratyush Anand wrote:
> On Wed, Oct 01, 2014 at 12:36:25AM +0800, Lucas Stach wrote:
> > Those two patches were part of my designware multi-msi series. I decided
> > to postpone that one a little bit until the treewide MSI chip patches from
> > Yijing Wang have landed, but those two patches are just too obvious
> > fixes/style corrections to let them wait any longer.
> >
> > Both patches were tested by Jingoo Han as part of the earlier series, but
> > I had to modify them a bit for the rebase, so any review/testing much
> > appreciated. Patches are on top of the pci/host-designware branch.
> >
> > Lucas Stach (2):
> >   PCI: designware: remove bogus multiple MSI setup
> >   PCI: designware: remove open-coded bitmap operations
> >
> 
> Looks cleaner to me.
> Reviewed-by: Pratyush Anand <pratyush.anand@st.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> >  drivers/pci/host/pcie-designware.c | 98 ++++++--------------------------------
> >  1 file changed, 14 insertions(+), 84 deletions(-)
> >
> > --
> > 2.1.0

