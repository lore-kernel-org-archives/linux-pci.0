Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923BAC5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657592087F
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 19:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657592087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLKTBP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:01:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbeLKTBP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 14:01:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9ECDC46202;
        Tue, 11 Dec 2018 19:01:14 +0000 (UTC)
Received: from redhat.com (ovpn-126-162.rdu2.redhat.com [10.10.126.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB46A103BAB7;
        Tue, 11 Dec 2018 19:01:13 +0000 (UTC)
Date:   Tue, 11 Dec 2018 14:01:13 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        stable@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: avoid bridge feature re-probing on hotplug
Message-ID: <20181211135755-mutt-send-email-mst@kernel.org>
References: <20181211021617.24072-1-mst@redhat.com>
 <20181211141808.GE99796@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211141808.GE99796@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 11 Dec 2018 19:01:14 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 08:18:08AM -0600, Bjorn Helgaas wrote:
> Hi Michael,
> 
> Please run "git log --oneline drivers/pci/setup-bus.c" and follow
> the usual style.
> 
> On Mon, Dec 10, 2018 at 09:18:40PM -0500, Michael S. Tsirkin wrote:
> > commit 1f82de10d6 ("PCI/x86: don't assume prefetchable ranges are
> > 64bit") added probing of bridge support for 64 bit memory
> > each time bridge is re-enumerated.
> 
> Use conventional SHA1 reference (12-char SHA1).
> 
> > Unfortunately this probing is destructive if any device behind
> > the bridge is in use at this time.
> 
> Agreed, this sounds like a problem.
> 
> > There's no real need to re-probe the bridge features as the
> > regiters in question never change - detect that using
> > the memory flag being set and skip the probing.
> 
> s/regiters/registers/


Will address above.

> > Avoiding repeated calls to pci_bridge_check_ranges might be even nicer
> > would be a bigger patch and probably not appropriate on stable.
> 
> Maybe so.  The ideal thing might be to have a trivial patch like this
> that can be marked for stable, immediately followed by the nicer
> patch.  Trivial band-aids tend to accumulate and make things harder in
> the future.

I understand, and I looked at it briefly, but it's not a simple
change, with probing taking detours through acpi etc.

I plan to look at it some more but should we release another linux
with this bug?

> I'd have to take a much harder look at the problem to understand
> 1f82de10d6b1.  The comment about "double check" seems misleading -- as
> you say, the hardware doesn't change and checking once should be
> enough.  And if we're calling pci_bridge_check_ranges() more than
> necessary, that sounds like a problem, too.

So that will kind of make it a non issue. Should we still worry?

> > Reported-by: xuyandong <xuyandong2@huawei.com>
> > Cc: stable@vger.kernel.org
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > This issue has been reported on upstream Linux and Centos.
> 
> Are there URLs to these reports that we could include in the changelog?

https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01711.html

and specifically

https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html


> >  drivers/pci/setup-bus.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index ed960436df5e..7ab42f76579e 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -741,6 +741,13 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
> >  	struct resource *b_res;
> >  
> >  	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> > +
> > +	/* Don't re-check after this was called once already:
> > +	 * important since bridge might be in use.
> > +	 */
> > +	if (b_res[1].flags & IORESOURCE_MEM)
> > +		return;
> 
> Use conventional multi-line comment style.
> 
> This test isn't 100%: devices below the bridge could be using only IO,
> or theoretically could be even using just config space.
> 
> If it's safe to bail out if the bridge is in use, why isn't it safe to
> bail out *always*?
> 
> >  	b_res[1].flags |= IORESOURCE_MEM;
> >  
> >  	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > -- 
> > MST
