Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45BBC43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCD2218F0
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 21:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeLTV05 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:26:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbeLTV05 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 16:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E61AF88E58;
        Thu, 20 Dec 2018 21:26:56 +0000 (UTC)
Received: from redhat.com (ovpn-122-37.rdu2.redhat.com [10.10.122.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F594101F94C;
        Thu, 20 Dec 2018 21:26:54 +0000 (UTC)
Date:   Thu, 20 Dec 2018 16:26:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        stable@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: avoid bridge feature re-probing on hotplug
Message-ID: <20181220161052-mutt-send-email-mst@kernel.org>
References: <20181218004455.20186-1-mst@redhat.com>
 <20181220194950.GD183878@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220194950.GD183878@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Dec 2018 21:26:57 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 20, 2018 at 01:49:50PM -0600, Bjorn Helgaas wrote:
> Hi Michael,
> 
> On Mon, Dec 17, 2018 at 07:45:41PM -0500, Michael S. Tsirkin wrote:
> > commit 1f82de10d6b1 ("PCI/x86: don't assume prefetchable ranges are 64bit")
> > added probing of bridge support for 64 bit memory each time bridge is
> > re-enumerated.
> > 
> > Unfortunately this probing is destructive if any device behind
> > the bridge is in use at this time.
> > 
> > This was observed in the field, see
> > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01711.html
> > and specifically
> > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html
> > 
> > There's no real need to re-probe the bridge features as the
> > registers in question never change - detect that using
> > the memory flag being set (it's always set on the 1st pass since
> > all PCI2PCI bridges support memory forwarding) and skip the probing.
> > Thus, only the first call will perform the disruptive probing and sets
> > the resource flags as required - which we can be reasonably sure happens
> > before any devices have been configured.
> > Avoiding repeated calls to pci_bridge_check_ranges might be even nicer.
> > Unfortunately I couldn't come up with a clean way to do it without a
> > major probing code refactoring.
> 
> I'm OK with major probe code refactoring as long as it's done
> carefully.  Doing a special-case fix like this solves the immediate
> problem but adds to the long-term maintenance problem.
> 
> As far as I can tell, everything in pci_bridge_check_ranges() should
> be done once at enumeration-time, e.g., in the pci_read_bridge_bases()
> path, and pci_bridge_check_ranges() itself should be removed.
> 
> If that turns out to be impossible for some reason, we need a comment
> explaining why.

Maybe possible but I am not sure how.

Here's why:

Upon hotplug we want to poke at new bridges if any, but not the old
ones.  The issue is that e.g. with ACPI hotplug the event that Linux
knows how to handle is by design a heavy weight bus rescan.

Specifically 

pci_read_bridge_bases does not
seem to be called on ACPI hotplug path.

Rather,

pci_assign_unassigned_root_bus_resources
pci_assign_unassigned_bridge_resources

would be the two functions in question.


Would above explanation be sufficient? If not, since I understand your
reluctance to pile up hacks, would you be open to doing the suggested
rewrite yourself? Me and xuyandong can help test it.


> > Reported-by: xuyandong <xuyandong2@huawei.com>
> > Tested-by: xuyandong <xuyandong2@huawei.com>
> > Cc: stable@vger.kernel.org
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Please review and consider for stable.
> > 
> > changes from v1:
> > 	comment and commit log updates to address comments by Bjorn.
> > 
> >  drivers/pci/setup-bus.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index ed960436df5e..d5c25d465d97 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -741,6 +741,16 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
> >  	struct resource *b_res;
> >  
> >  	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> > +
> > +	/*
> > +	 * Don't re-check after this was called once already:
> > +	 * important since bridge might be in use.
> > +	 * Note: this is only reliable because as per spec all PCI to PCI
> > +	 * bridges support memory unconditionally so IORESOURCE_MEM is set.
> > +	 */
> > +	if (b_res[1].flags & IORESOURCE_MEM)
> > +		return;
> > +
> >  	b_res[1].flags |= IORESOURCE_MEM;
> >  
> >  	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > -- 
> > MST
