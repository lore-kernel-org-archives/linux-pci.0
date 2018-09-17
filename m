Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209D4ECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF073214DA
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 17:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXb9IrWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF073214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeIQWkz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:40:55 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43261 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQWkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 18:40:55 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so5748405ywb.10
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2018 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiUJiZX7zEQ3gTY4reQmlxAzPWAhCRypOrE+YhFPiO8=;
        b=KXb9IrWLCyYfvuEsc2qHbZNM/Mo0d25ujXprWeYNyv3+XMYABeishK9Twq8LEPaKa1
         c2tXjR+nRJuorqQx2e8vpef+dwhUztYzhxsq4bQ5Ko2kjCO47t1hlhLwsaOS/im7U5M8
         dcW/RQje7vfo0kbyP+Ce5Y1sdeKRW9/6vzu6TFq2m7TSZWYSzDvw4B+Bo1RY1cCb1es+
         9hBvCtCdESSWdL9QfJgIs7qk+Z+hMnbYmwPeqVTiXdIdQM2EOKKRMBMPEIslrHyTcyGq
         aMopI7+b1iq9cgeKCm+nFDD81Lnl54aHb0q5bXxO0L9wC8pYgabQlp3XWeaj3iYpZ4MS
         wbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiUJiZX7zEQ3gTY4reQmlxAzPWAhCRypOrE+YhFPiO8=;
        b=sm3nlTXu8/DM41sf+R+/gf3OrhSkvc7uY4Oohn+aE14hNpUJWv5V+e/BARCWgFkX13
         3ECG+7LE7vsXSPxN0LT3PbLT37UJSJo/Yei4TJveoLzF+q357hBayx2yd/NE8RbFqQHO
         T52bPuKZT8XNNXY1iulsC4Vpd+x/b0LrlnuWH8wcoB4u8dBnCzRbBzxaa1qIk2j+AhTA
         eC1KY8+eGNbTjq4s5H0672s6ANUOwpeBrfwYmhFxAoZLXTeDwaElhb78NbCRyXnnfQsq
         7jddY/Rz3AadI2AXQdg5+gX/vOXSB07Mfufv/JH4i4FSZSPtvVQsQX6iEhZl5HCKL/7W
         89kQ==
X-Gm-Message-State: APzg51Cs3h8PWTwDdWakWHl1nXIPJV24PsuETyuLCkBzLl7dOl9oCpu9
        xCWMDnW0WMOynfgNey7BpVjUJHcAaua0DnhhPDwO6VWQDVmZ
X-Google-Smtp-Source: ANB0VdaCJ7kaIbS3T9Rr0orFenbsNpsiqm8SLKSPj/Iw9GM/yi9oReHXhwjV+FZjEd8f++8MVcIi1vLl1wWPrRLLRnI=
X-Received: by 2002:a0d:e1cb:: with SMTP id k194-v6mr10157959ywe.314.1537204358640;
 Mon, 17 Sep 2018 10:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20171215202935.157396.74423.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180917144734.GF7239@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180917144734.GF7239@e107981-ln.cambridge.arm.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 17 Sep 2018 12:12:26 -0500
Message-ID:
 <CAErSpo5vuW=HQ9rS68WVRmr58x9WiT11a0xvb0sc66_LfDe4Fg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Remove redundant "valid device" check
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917171226.LRYc4uy86I63TtKGxCg3pOFgjzYOcraLmd_KZ8d4mdQ@z>

On Mon, Sep 17, 2018 at 9:47 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 15, 2017 at 02:29:35PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > In rockchip_pcie_valid_device(), we do the exact same test twice:
> >
> >   if (bus->number == rockchip->root_bus_nr && dev > 0)
> >     return 0;
> >   if (bus->number == rockchip->root_bus_nr && dev > 0)
> >     return 0;
> >
> > We only need to do it once, so remove one of them.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/host/pcie-rockchip.c |    4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> > index 9051c6c8fea4..dd9c7ea69e0b 100644
> > --- a/drivers/pci/host/pcie-rockchip.c
> > +++ b/drivers/pci/host/pcie-rockchip.c
> > @@ -293,10 +293,6 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
> >  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
> >                                     struct pci_bus *bus, int dev)
> >  {
> > -     /* access only one slot on each root port */
> > -     if (bus->number == rockchip->root_bus_nr && dev > 0)
> > -             return 0;
> > -
> >       /*
> >        * do not read more than one device on the bus directly attached
> >        * to RC's downstream side.
> >
>
> Hi Bjorn,
>
> this patch slipped through the cracks but I do not think it is right.
>
> The point here is filtering both the host bridge access side (ie check
> for dev > 0) AND the RC downstream side, it is two different busses.
>
> Perhaps the check can be written in a more concise way (squash them in
> one single conditional) but I think the current logic is correct,
> AFAICS.
>
> I would drop it from the PCI patch queue.

Definitely should be dropped from patchwork.  I can't find a posting
that had the duplicate check in it, so I don't know what I was looking
at, but the initial commit (e77f847df54c) doesn't seem to have any
duplication there.

Bjorn
