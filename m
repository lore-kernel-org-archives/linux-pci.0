Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEFC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B9D21905
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 14:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfAaOmn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:42:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfAaOmn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 09:42:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8ED49CAA8E;
        Thu, 31 Jan 2019 14:42:42 +0000 (UTC)
Received: from redhat.com (ovpn-124-197.rdu2.redhat.com [10.10.124.197])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE07460BF7;
        Thu, 31 Jan 2019 14:42:40 +0000 (UTC)
Date:   Thu, 31 Jan 2019 09:42:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: linux-next: manual merge of the vhost tree with the pci tree
Message-ID: <20190131094203-mutt-send-email-mst@kernel.org>
References: <20190131134033.1ed0021d@canb.auug.org.au>
 <CAErSpo7y-PunYStmzvWvbfz-_CV0yoL2Pro3oC-+f47S3RPYAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErSpo7y-PunYStmzvWvbfz-_CV0yoL2Pro3oC-+f47S3RPYAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 31 Jan 2019 14:42:42 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 08:15:50AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 30, 2019 at 8:40 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the vhost tree got a conflict in:
> >
> >   drivers/pci/setup-bus.c
> >
> > between commit:
> >
> >   51c48b310183 ("PCI: Probe bridge window attributes once at enumeration-time")
> >
> > from the pci tree and commit:
> >
> >   955156f34e7d ("PCI: avoid bridge feature re-probing on hotplug")
> >
> > from the vhost tree.
> >
> > I fixed it up (hopefully - see below) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> 
> 51c48b310183 and 955156f34e7d are both to solve the same problem, so I
> think the best resolution is to drop 955156f34e7d from the vhost tree
> completely.

Will do.

> The remaining wrinkle to work out is that we need a stable backport.
> 51c48b310183 is technically a little large for a stable backport, so I
> want to have a solid justification for it.  As soon as I get a
> kernel.org bugzilla with those details (who's affected by the
> breakage, what the failure looks like, how to reproduce it, etc), I'll
> add that URL and the stable tag.
> 
> Bjorn

OK.

> > diff --cc drivers/pci/setup-bus.c
> > index 1941bb0a6c13,d5c25d465d97..000000000000
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@@ -735,17 -735,50 +735,26 @@@ int pci_claim_bridge_resource(struct pc
> >      base/limit registers must be read-only and read as 0. */
> >   static void pci_bridge_check_ranges(struct pci_bus *bus)
> >   {
> >  -      u16 io;
> >  -      u32 pmem;
> >         struct pci_dev *bridge = bus->self;
> >  -      struct resource *b_res;
> >  -
> >  -      b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> >  +      struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> >
> > +       /*
> > +        * Don't re-check after this was called once already:
> > +        * important since bridge might be in use.
> > +        * Note: this is only reliable because as per spec all PCI to PCI
> > +        * bridges support memory unconditionally so IORESOURCE_MEM is set.
> > +        */
> > +       if (b_res[1].flags & IORESOURCE_MEM)
> > +               return;
> > +
> >         b_res[1].flags |= IORESOURCE_MEM;
> >
> >  -      pci_read_config_word(bridge, PCI_IO_BASE, &io);
> >  -      if (!io) {
> >  -              pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
> >  -              pci_read_config_word(bridge, PCI_IO_BASE, &io);
> >  -              pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> >  -      }
> >  -      if (io)
> >  +      if (bridge->io_window)
> >                 b_res[0].flags |= IORESOURCE_IO;
> >
> >  -      /*  DECchip 21050 pass 2 errata: the bridge may miss an address
> >  -          disconnect boundary by one PCI data phase.
> >  -          Workaround: do not use prefetching on this device. */
> >  -      if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
> >  -              return;
> >  -
> >  -      pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> >  -      if (!pmem) {
> >  -              pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
> >  -                                             0xffe0fff0);
> >  -              pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> >  -              pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
> >  -      }
> >  -      if (pmem) {
> >  +      if (bridge->pref_window) {
> >                 b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
> >  -              if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
> >  -                  PCI_PREF_RANGE_TYPE_64) {
> >  +              if (bridge->pref_64_window) {
> >                         b_res[2].flags |= IORESOURCE_MEM_64;
> >                         b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
> >                 }
