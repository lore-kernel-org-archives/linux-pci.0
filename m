Return-Path: <SRS0=X3es=PR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5EC43387
	for <linux-pci@archiver.kernel.org>; Wed,  9 Jan 2019 06:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8E9214C6
	for <linux-pci@archiver.kernel.org>; Wed,  9 Jan 2019 06:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfAIGJ4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:09:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:44895 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfAIGJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jan 2019 01:09:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x09592Cr029143;
        Tue, 8 Jan 2019 23:09:04 -0600
Message-ID: <012d24d58a542ed44c8af9f517f1bd61ab912037.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        saeedm@mellanox.com, ogerlitz@mellanox.com, tariqt@mellanox.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, sbest@redhat.com, paulus@samba.org,
        Alexey Kardashevskiy <aik@au1.ibm.com>
Date:   Wed, 09 Jan 2019 16:09:02 +1100
In-Reply-To: <20190108040129.GE5336@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
         <20181206064509.GM15544@mtr-leonro.mtl.com>
         <20190104034401.GA2801@umbus.fritz.box> <20190105175116.GB14238@ziepe.ca>
         <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
         <20190108040129.GE5336@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-01-07 at 21:01 -0700, Jason Gunthorpe wrote:
> 
> > In a very cryptic way that requires manual parsing using non-public
> > docs sadly but yes. From the look of it, it's a completion timeout.
> > 
> > Looks to me like we don't get a response to a config space access
> > during the change of D state. I don't know if it's the write of the D3
> > state itself or the read back though (it's probably detected on the
> > read back or a subsequent read, but that doesn't tell me which specific
> > one failed).
> 
> If it is just one card doing it (again, check you have latest
> firmware) I wonder if it is a sketchy PCI-E electrical link that is
> causing a long re-training cycle? Can you tell if the PCI-E link is
> permanently gone or does it eventually return?

No, it's 100% reproducable on systems with that specific card model,
not card instance, and maybe different systems/cards as well, I'll let
David & Alexey comment further on that.

> Does the card work in Gen 3 when it starts? Is there any indication of
> PCI-E link errors?

Nope.

> Everytime or sometimes?
> 
> POWER 8 firmware is good? If the link does eventually come back, is
> the POWER8's D3 resumption timeout long enough?
> 
> If this doesn't lead to an obvious conclusion you'll probably need to
> connect to IBM's Mellanox support team to get more information from
> the card side.

We are IBM :-) So far, it seems to be that the card is doing something
not quite right, but we don't know what. We might need to engage
Mellanox themselves.

Cheers,
Ben.


