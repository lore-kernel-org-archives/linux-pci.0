Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10963 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab3JHSDl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 14:03:41 -0400
Date: Tue, 8 Oct 2013 14:03:37 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Make mvebu_pcie_align_resource() static
Message-ID: <20131008180337.GV5402@titan.lakedaemon.net>
References: <20131007233846.11805.50302.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131008092137.0ed32a32@skate>
 <CAErSpo4bn_TVbquQrs_WzLnL8Q=2urk1VyrWPiqDBnh6OrQbtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4bn_TVbquQrs_WzLnL8Q=2urk1VyrWPiqDBnh6OrQbtQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 08, 2013 at 10:07:52AM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 8, 2013 at 1:21 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Dear Bjorn Helgaas,
> >
> > On Mon, 07 Oct 2013 17:38:46 -0600, Bjorn Helgaas wrote:
> >> mvebu_pcie_align_resource() is only used inside pci-mvebu.c, so
> >> make it static.
> >>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > I'm obviously fine with that, but there is already a patch "[PATCH V2
> > 2/3] PCI: mvebu: make local functions static" hanging around to do the
> > same.
> 
> OK, sorry for the duplication.  I dropped Jingoo's patch from
> patchwork because Jason C. is merging mvebu stuff, and then it's "out
> of sight, out of mind."

Ok, I dug Jingoo's patch out of the Internet (it has everything!), and
applied it.  Unfortunately, I don't have the original email to reply
to, so this email will have to suffice.

Applied to mvebu/drivers

thx,

Jason.
