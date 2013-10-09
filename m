Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65001 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab3JIB3x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 21:29:53 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUD006VRO5DHAC0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 09 Oct 2013 10:29:37 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jason Cooper' <jason@lakedaemon.net>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <20131007233846.11805.50302.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131008092137.0ed32a32@skate>
 <CAErSpo4bn_TVbquQrs_WzLnL8Q=2urk1VyrWPiqDBnh6OrQbtQ@mail.gmail.com>
 <20131008180337.GV5402@titan.lakedaemon.net>
In-reply-to: <20131008180337.GV5402@titan.lakedaemon.net>
Subject: Re: [PATCH] PCI: mvebu: Make mvebu_pcie_align_resource() static
Date: Wed, 09 Oct 2013 10:29:37 +0900
Message-id: <001c01cec48f$0488ba80$0d9a2f80$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 09, 2013 3:04 AM, Jason Cooper wrote:
> On Tue, Oct 08, 2013 at 10:07:52AM -0600, Bjorn Helgaas wrote:
> > On Tue, Oct 8, 2013 at 1:21 AM, Thomas Petazzoni
> > <thomas.petazzoni@free-electrons.com> wrote:
> > > Dear Bjorn Helgaas,
> > >
> > > On Mon, 07 Oct 2013 17:38:46 -0600, Bjorn Helgaas wrote:
> > >> mvebu_pcie_align_resource() is only used inside pci-mvebu.c, so
> > >> make it static.
> > >>
> > >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > I'm obviously fine with that, but there is already a patch "[PATCH V2
> > > 2/3] PCI: mvebu: make local functions static" hanging around to do the
> > > same.
> >
> > OK, sorry for the duplication.  I dropped Jingoo's patch from
> > patchwork because Jason C. is merging mvebu stuff, and then it's "out
> > of sight, out of mind."
> 
> Ok, I dug Jingoo's patch out of the Internet (it has everything!), and
> applied it.  Unfortunately, I don't have the original email to reply
> to, so this email will have to suffice.
> 
> Applied to mvebu/drivers
> 
Jason Cooper,
Thank you for accepting my patch. :-)

Bjorn Helgaas,
Thank you for sending patches for PCIe host drivers. :-)
It is very helpful.

Best regards,
Jingoo Han

