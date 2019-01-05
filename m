Return-Path: <SRS0=A2IS=PN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F5C43387
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 17:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1A8218E2
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 17:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ITdm6f4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfAERvU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:51:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42570 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfAERvT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jan 2019 12:51:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so18836181pga.9
        for <linux-pci@vger.kernel.org>; Sat, 05 Jan 2019 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bmFtkiMzY0SjcGgWZDnXoB7lrhs+dKojhnWxuZ4Ulkg=;
        b=ITdm6f4fW8QautoLRLSG1phMTMj2iuQLmLxDF+T0kN82TxeVV1j00miE0Oo3PslMCO
         bQ6TrG8UQ73pjOcXA73iW8aR45Cz3HAKFz1BtvLEMpdNyFCiN+B0jqgWcVENVyqR4KFO
         L5ovF35IgXPwJPIKg7TAaWZqEjbmpgkemK+oaQeTp+BUBv639FtVLUCnYThlsw7U4klp
         jBo9vtXrHIXYU7FZLG3b2aIODlSkG9va85ecBLN7eFKCWvCc3DOsKnE+og9x/fEarDIu
         XQEFOyMEksq4jWcLbKWF9i2JUj8D+iy3tHD47fDvNw0diAQaD4T/Ej+zYg/cHJeDKJ4J
         fFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmFtkiMzY0SjcGgWZDnXoB7lrhs+dKojhnWxuZ4Ulkg=;
        b=p9D8X8Drd0Oyr35QK4m380VQaY+IHaiDWFKBiwvzQF3gnllp48uurSV/aIAD+woOfT
         zyZuk0Pzwpr4Js7c9EQsKlfkGzhZZgFEAFEitLGnsengoWNNkoqD/B73OO3cQ7caUjQH
         el6m0D0sVpJmSgwnqAv0ZTFzVjHJta4FDX7s5PhSHC9E2PPEnMx44xxEZMJk1U60zr7x
         v1X2UqbTSB6E9go330hr1MvqsTfbk6PO1dZCtm0QOtq/+bx+tTm3wS+8m5wYpbFSErZ4
         1as3yBcNQhFIVariMTcufBSLWFbQu7CJd5x+gb9q0nMz6KLB8fARNK6A+o4pPXI336/o
         3nFg==
X-Gm-Message-State: AJcUukcmgi+LshnNOn2H2pNRV7ieE/E+W1XitqFBAU6YLEYTAamTFTG+
        y2nXs8vPRBmzaKAXU8++IzN3sA==
X-Google-Smtp-Source: ALg8bN5CWdV0l04sM6sKg6mHb4H5KfjJ+9BVYkv5JG/kj/c+dIa75hYcEg6kHnIsIdFDi+ZgYRVb9g==
X-Received: by 2002:a63:1d59:: with SMTP id d25mr24839142pgm.180.1546710678704;
        Sat, 05 Jan 2019 09:51:18 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id y71sm119832456pfi.123.2019.01.05.09.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 09:51:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gfq6P-00045X-0F; Sat, 05 Jan 2019 10:51:17 -0700
Date:   Sat, 5 Jan 2019 10:51:16 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        saeedm@mellanox.com, ogerlitz@mellanox.com, tariqt@mellanox.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, sbest@redhat.com, paulus@samba.org,
        benh@kernel.crashing.org
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20190105175116.GB14238@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104034401.GA2801@umbus.fritz.box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 02:44:01PM +1100, David Gibson wrote:
> On Thu, Dec 06, 2018 at 08:45:09AM +0200, Leon Romanovsky wrote:
> > On Thu, Dec 06, 2018 at 03:19:51PM +1100, David Gibson wrote:
> > > Mellanox ConnectX-5 IB cards (MT27800) seem to cause a call trace when
> > > unbound from their regular driver and attached to vfio-pci in order to pass
> > > them through to a guest.
> > >
> > > This goes away if the disable_idle_d3 option is used, so it looks like a
> > > problem with the hardware handling D3 state.  To fix that more permanently,
> > > use a device quirk to disable D3 state for these devices.
> > >
> > > We do this by renaming the existing quirk_no_ata_d3() more generally and
> > > attaching it to the ConnectX-[45] devices (0x15b3:0x1013).
> > >
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > >  drivers/pci/quirks.c | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > >
> > 
> > Hi David,
> > 
> > Thank for your patch,
> > 
> > I would like to reproduce the calltrace before moving forward,
> > but have trouble to reproduce the original issue.
> > 
> > I'm working with vfio-pci and CX-4/5 cards on daily basis,
> > tried manually enter into D3 state now, and it worked for me.
> 
> Interesting.  I've investigated this further, though I don't have as
> many new clues as I'd like.  The problem occurs reliably, at least on
> one particular type of machine (a POWER8 "Garrison" with ConnectX-4).
> I don't yet know if it occurs with other machines, I'm having trouble
> getting access to other machines with a suitable card.  I didn't
> manage to reproduce it on a different POWER8 machine with a
> ConnectX-5, but I don't know if it's the difference in machine or
> difference in card revision that's important.

Make sure the card has the latest firmware is always good advice..

> So possibilities that occur to me:
>   * It's something specific about how the vfio-pci driver uses D3
>     state - have you tried rebinding your device to vfio-pci?
>   * It's something specific about POWER, either the kernel or the PCI
>     bridge hardware
>   * It's something specific about this particular type of machine

Does the EEH indicate what happend to actually trigger it?

Jason
