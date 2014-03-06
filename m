Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38953 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885AbaCFLhx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 06:37:53 -0500
Date: Thu, 6 Mar 2014 11:37:17 +0000
From: Will Deacon <will.deacon@arm.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v5] PCI: ARM: add support for generic PCI host controller
Message-ID: <20140306113717.GE5202@mudshark.cambridge.arm.com>
References: <1393872400-7262-1-git-send-email-will.deacon@arm.com>
 <20140305181057.GC2214@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140305181057.GC2214@e106497-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 05, 2014 at 06:10:57PM +0000, Liviu Dudau wrote:
> On Mon, Mar 03, 2014 at 06:46:40PM +0000, Will Deacon wrote:
> > +static int gen_pci_calc_io_offset(struct device *dev,
> > +                                 struct of_pci_range *range,
> > +                                 struct resource *res,
> > +                                 resource_size_t *offset)
> > +{
> > +       static atomic_t wins = ATOMIC_INIT(0);
> > +       int err, idx, max_win;
> > +       unsigned int window;
> > +
> > +       if (!PAGE_ALIGNED(range->cpu_addr))
> > +               return -EINVAL;
> > +
> > +       max_win = (IO_SPACE_LIMIT + 1) / SZ_64K;
> > +       idx = atomic_inc_return(&wins);
> > +       if (idx >= max_win)
> > +               return -ENOSPC;
> > +
> > +       window = (idx - 1) * SZ_64K;
> > +       err = pci_ioremap_io(window, range->cpu_addr);
> > +       if (err)
> > +               return err;
> > +
> > +       of_pci_range_to_resource(range, dev->of_node, res);
> > +       res->start = window;
> > +       res->end = res->start + range->size - 1;
> > +       *offset = window - range->pci_addr;
> 
> If my fix for of_pci_range_to_resource will get accepted, this
> function will have to morph into the pci_register_io_range() call.
> Would that cause problems for other users of of_pci_range_to_resource()
> (namely mach-integrator ?)

I imagine anybody using an I/O region would break, no? Maybe you could check
range->flags in of_pci_range_to_resource and do the right thing if somebody
passes you an I/O range?

I'm happy to update this driver, but it's best to avoid breaking other users
if we can.

> Otherwise, looks good to me. You can add my (worthless?)
> 
> Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks, Liviu!

Will
