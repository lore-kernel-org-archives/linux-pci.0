Return-Path: <SRS0=A2IS=PN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C3C43387
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 22:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91194222B3
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 22:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfAEWo4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:44:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:43209 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfAEWoz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jan 2019 17:44:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x05MhkSS014869;
        Sat, 5 Jan 2019 16:43:51 -0600
Message-ID: <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        saeedm@mellanox.com, ogerlitz@mellanox.com, tariqt@mellanox.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, sbest@redhat.com, paulus@samba.org
Date:   Sun, 06 Jan 2019 09:43:46 +1100
In-Reply-To: <20190105175116.GB14238@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
         <20181206064509.GM15544@mtr-leonro.mtl.com>
         <20190104034401.GA2801@umbus.fritz.box> <20190105175116.GB14238@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2019-01-05 at 10:51 -0700, Jason Gunthorpe wrote:
> 
> > Interesting.  I've investigated this further, though I don't have as
> > many new clues as I'd like.  The problem occurs reliably, at least on
> > one particular type of machine (a POWER8 "Garrison" with ConnectX-4).
> > I don't yet know if it occurs with other machines, I'm having trouble
> > getting access to other machines with a suitable card.  I didn't
> > manage to reproduce it on a different POWER8 machine with a
> > ConnectX-5, but I don't know if it's the difference in machine or
> > difference in card revision that's important.
> 
> Make sure the card has the latest firmware is always good advice..
> 
> > So possibilities that occur to me:
> >   * It's something specific about how the vfio-pci driver uses D3
> >     state - have you tried rebinding your device to vfio-pci?
> >   * It's something specific about POWER, either the kernel or the PCI
> >     bridge hardware
> >   * It's something specific about this particular type of machine
> 
> Does the EEH indicate what happend to actually trigger it?

In a very cryptic way that requires manual parsing using non-public
docs sadly but yes. From the look of it, it's a completion timeout.

Looks to me like we don't get a response to a config space access
during the change of D state. I don't know if it's the write of the D3
state itself or the read back though (it's probably detected on the
read back or a subsequent read, but that doesn't tell me which specific
one failed).

Some extra logging in OPAL might help pin that down by checking the InA
error state in the config accessor after the config write (and polling
on it for a while as from a CPU perspective I don't knw if the write is
synchronous, probably not).

Cheers,
Ben.


