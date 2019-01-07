Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0438CC43612
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 15:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D252F217D4
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfAGPBl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:01:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfAGPBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 10:01:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 589DA2D7F3;
        Mon,  7 Jan 2019 15:01:40 +0000 (UTC)
Received: from redhat.com (ovpn-122-143.rdu2.redhat.com [10.10.122.143])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9490760192;
        Mon,  7 Jan 2019 15:01:38 +0000 (UTC)
Date:   Mon, 7 Jan 2019 10:01:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        stable@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: avoid bridge feature re-probing on hotplug
Message-ID: <20190107095840-mutt-send-email-mst@kernel.org>
References: <20181218004455.20186-1-mst@redhat.com>
 <20181220194950.GD183878@google.com>
 <20181220161052-mutt-send-email-mst@kernel.org>
 <20181220223158.GG183878@google.com>
 <20181220173535-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220173535-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Jan 2019 15:01:40 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 20, 2018 at 05:36:03PM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 20, 2018 at 04:31:58PM -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 20, 2018 at 04:26:54PM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Dec 20, 2018 at 01:49:50PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Dec 17, 2018 at 07:45:41PM -0500, Michael S. Tsirkin wrote:
> > > > > commit 1f82de10d6b1 ("PCI/x86: don't assume prefetchable ranges are 64bit")
> > > > > added probing of bridge support for 64 bit memory each time bridge is
> > > > > re-enumerated.
> > > > > 
> > > > > Unfortunately this probing is destructive if any device behind
> > > > > the bridge is in use at this time.
> > > > > 
> > > > > This was observed in the field, see
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01711.html
> > > > > and specifically
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html
> > > > > 
> > > > > There's no real need to re-probe the bridge features as the
> > > > > registers in question never change - detect that using
> > > > > the memory flag being set (it's always set on the 1st pass since
> > > > > all PCI2PCI bridges support memory forwarding) and skip the probing.
> > > > > Thus, only the first call will perform the disruptive probing and sets
> > > > > the resource flags as required - which we can be reasonably sure happens
> > > > > before any devices have been configured.
> > > > > Avoiding repeated calls to pci_bridge_check_ranges might be even nicer.
> > > > > Unfortunately I couldn't come up with a clean way to do it without a
> > > > > major probing code refactoring.
> > > > 
> > > > I'm OK with major probe code refactoring as long as it's done
> > > > carefully.  Doing a special-case fix like this solves the immediate
> > > > problem but adds to the long-term maintenance problem.
> > > > 
> > > > As far as I can tell, everything in pci_bridge_check_ranges() should
> > > > be done once at enumeration-time, e.g., in the pci_read_bridge_bases()
> > > > path, and pci_bridge_check_ranges() itself should be removed.
> > > > 
> > > > If that turns out to be impossible for some reason, we need a comment
> > > > explaining why.
> > > 
> > > Maybe possible but I am not sure how.
> > > 
> > > Here's why:
> > > 
> > > Upon hotplug we want to poke at new bridges if any, but not the old
> > > ones.  The issue is that e.g. with ACPI hotplug the event that Linux
> > > knows how to handle is by design a heavy weight bus rescan.
> > 
> > Yeah, it's tricky.  But I don't think it's PCI or ACPI that makes this
> > tricky; I think it's just the historical baggage of the PCI core
> > design that makes it hard.
> > 
> > Even in the ACPI hotplug path, I think we use this pci_scan_device()
> > path:
> > 
> >   pci_scan_device
> >     pci_setup_device
> >       case PCI_HEADER_TYPE_NORMAL:
> >         pci_read_bases(6)             # normal PCI BARs
> >       case PCI_HEADER_TYPE_BRIDGE:
> >         pci_read_bases(2)             # bridge BARs (not windows)
> > 
> > Unfortunately that path doesn't call pci_read_bridge_bases() to read
> > the bridge windows; that currently happens in pcibios_fixup_bus(),
> > which is only called from pci_scan_child_bus_extend().
> > 
> > This is a broken design because reading the bridge apertures is not at
> > all platform-specific, so it shouldn't be done in a pcibios hook.
> > And, more to the issue at hand, it shouldn't be done in
> > pci_scan_child_bus() either.  We might have to *update* the windows
> > when scanning child buses, but we should be able to do the work of
> > finding out what windows are implemented and their properties
> > somewhere in the pci_setup_device() path.
> > 
> > > Specifically 
> > > 
> > > pci_read_bridge_bases does not
> > > seem to be called on ACPI hotplug path.
> > > 
> > > Rather,
> > > 
> > > pci_assign_unassigned_root_bus_resources
> > > pci_assign_unassigned_bridge_resources
> > > 
> > > would be the two functions in question.
> > > 
> > > 
> > > Would above explanation be sufficient? If not, since I understand your
> > > reluctance to pile up hacks, would you be open to doing the suggested
> > > rewrite yourself? Me and xuyandong can help test it.
> > 
> > I'll be on vacation or holiday most of the time until the new year,
> > but I put a reminder on my calendar to look at this again then.  I'm
> > pretty sure we've tried to unravel this in the past, but I can't
> > remember what issues we tripped over.  Maybe we can make some progress
> > by restricting the problem we're trying to solve.
> > 
> > Thanks for bringing this up!  This is a wart in the PCI core that has
> > bothered me for a long time, and maybe this is the incentive we need
> > to make some progress on it.
> > 
> > Bjorn
> 
> 
> Sounds good, let me know when I can help with testing.

Ping.

I guess I'll just have put this patch in the RHEL kernel for now.
No point in keeping kernels crashing until we can
make it perfect ...

> > > > > Reported-by: xuyandong <xuyandong2@huawei.com>
> > > > > Tested-by: xuyandong <xuyandong2@huawei.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: Yinghai Lu <yinghai@kernel.org>
> > > > > Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > > 
> > > > > Please review and consider for stable.
> > > > > 
> > > > > changes from v1:
> > > > >   comment and commit log updates to address comments by Bjorn.
> > > > > 
> > > > >  drivers/pci/setup-bus.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > > > index ed960436df5e..d5c25d465d97 100644
> > > > > --- a/drivers/pci/setup-bus.c
> > > > > +++ b/drivers/pci/setup-bus.c
> > > > > @@ -741,6 +741,16 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
> > > > >   struct resource *b_res;
> > > > >  
> > > > >   b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> > > > > +
> > > > > + /*
> > > > > +  * Don't re-check after this was called once already:
> > > > > +  * important since bridge might be in use.
> > > > > +  * Note: this is only reliable because as per spec all PCI to PCI
> > > > > +  * bridges support memory unconditionally so IORESOURCE_MEM is set.
> > > > > +  */
> > > > > + if (b_res[1].flags & IORESOURCE_MEM)
> > > > > +         return;
> > > > > +
> > > > >   b_res[1].flags |= IORESOURCE_MEM;
> > > > >  
> > > > >   pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > > > -- 
> > > > > MST
