Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32770 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932216AbcCHKrV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 05:47:21 -0500
Date: Tue, 8 Mar 2016 10:49:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof Ha??asa <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr()
 on ARM
Message-ID: <20160308104937.GA18919@red-moon>
References: <m337sapw89.fsf@t19.piap.pl>
 <20160307223311.GB26149@localhost>
 <20160308030106.GA18190@red-moon>
 <20160308042427.GA20580@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308042427.GA20580@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 07, 2016 at 10:24:27PM -0600, Bjorn Helgaas wrote:

[...]

> > > Actually, I did find one problem report:
> > > http://forum.doozan.com/read.php?2,17868,22070,quote=1 from last May,
> > > but apparently it got lost in a forum and never found its way
> > > upstream.
> > > 
> > > I reworked the changelog because this problem will affect *any* arch
> > > that enables CONFIG_PCI_DOMAINS_GENERIC and supplies NULL "parent"
> > > pointers -- ia64, mips, mn10300, s390, x86, etc., would be affected if
> > > they enabled CONFIG_PCI_DOMAINS_GENERIC.
> > > 
> > > I also added a "Fixes:" tag for 7c674700098c, since that's the commit
> > > that added the generic code we're fixing.  Backports of 7c674700098c
> > > should also backport this change.
> > 
> > That's really unfortunate, when I moved code from arm64 to generic I
> > did not spot this issue in the original code and carried it over, you
> > summarized the reasons in the commit log so without any further ado (and
> > with my apologies):
> > 
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> No worries, it just goes with the territory.  What surprises me is
> that it took us so long to notice.  v4.0 was released almost a year
> ago (April 12, 2015), so I can't figure out how nobody noticed until
> now.
> 
> And I don't know what happened with the problem report in the forum.
> That's a case where somebody *did* notice, but I guess they just gave
> up on v4.0 and went back to v3.18.  What a shame :)  I don't know if
> people just have low expectations of Linux, or they feel like it's too
> hard to report bugs, or we don't make it easy enough, or we're not
> approachable enough, or what.  I notice that many times somebody finds
> a workaround, and people seem satisfied with that, and we don't get a
> chance to fix the real problem.

I agree it is a pity the problem was not reported upstream which would
have solved the issue (that I should have spotted anyway while moving
the code) a long time ago, unfortunately I think it has to do with
how often developers/distros upgrade their kernels on these boards/socs
and how they interact with upstream, which is a discussion worth having.

Thank you !
Lorenzo
