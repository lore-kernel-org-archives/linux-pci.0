Return-Path: <SRS0=oPQn=Q6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E61C43381
	for <linux-pci@archiver.kernel.org>; Sat, 23 Feb 2019 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246B220850
	for <linux-pci@archiver.kernel.org>; Sat, 23 Feb 2019 11:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfBWLo7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 23 Feb 2019 06:44:59 -0500
Received: from elvis.franken.de ([193.175.24.41]:48184 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfBWLo7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Feb 2019 06:44:59 -0500
X-Greylist: delayed 2413 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Feb 2019 06:44:58 EST
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1gxV6v-00021Q-00; Sat, 23 Feb 2019 12:04:49 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CCA96C004D; Sat, 23 Feb 2019 12:04:32 +0100 (CET)
Date:   Sat, 23 Feb 2019 12:04:32 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] PCI: call add_bus method also for root bus
Message-ID: <20190223110432.GA8782@alpha.franken.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
 <20190219155728.19163-8-tbogendoerfer@suse.de>
 <20190221233708.GC219879@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221233708.GC219879@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 21, 2019 at 05:37:08PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 19, 2019 at 04:57:21PM +0100, Thomas Bogendoerfer wrote:
> > pci-xtalk controller code uses the add_bus method to set node of
> > the bus device, which then is used for pcibus_to_node() implementation.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > ---
> >  drivers/pci/probe.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 257b9f6f2ebb..456448d5f46d 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -837,6 +837,12 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  
> >  	pcibios_add_bus(bus);
> >  
> > +	if (bus->ops->add_bus) {
> > +		err = bus->ops->add_bus(bus);
> > +		if (WARN_ON(err < 0))
> > +			dev_err(&bus->dev, "failed to add bus: %d\n", err);
> > +	}
> 
> Is there something special about pci-xtalk that prevents it from
> setting the node the way other platforms do, without using the
> add_bus() method?

x86: uses node in common struct pci_sysdata
ia64: uses node in common struct pci_controller
powerpc: uses node in common struct pci_controller
sparc: uses numa_node in common struct pci_pbm_info
arm64: uses dev_to_node(&bus->dev) and node is set via pcibios_add_bus()

MIPS right now has no common struct, which is reachable via bus->sysdata,
if CONFIG_PCI_DRIVERS_LEGACY is not selected (and I want to get away
with that option). So I liked the arm64 way, but I didn't want to implement
pcibios_add_bus just for SGI-IP27 and noticed, that pcibios_add_bus
is called for child and root bus, while add_bus method only for
child buses. So my patch gives add_bus the same power as pcibios_add_bus
already have. Is this good enough as argument ?

> I haven't researched the details of how other platforms do it, but if
> it would be possible for pci-xtalk to do it the same way, that would
> be ideal.

there is always a different way of course. If you don't like my patch
I'll find one ;-)

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
