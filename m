Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44544C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7D522419
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 15:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHx26ZHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7D522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbeKOBsq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:48:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52959 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732933AbeKOBsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2018 20:48:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so15875916wmb.2
        for <linux-pci@vger.kernel.org>; Wed, 14 Nov 2018 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izmqQyUGZtJLfTHp0nD4qtZ5HKh5NS666VqgpqhLGlk=;
        b=mHx26ZHCEiLO3ZFjh0Sm4sH4M+F77MaBAdioVAycZE1ibm/RaFch7rRPslFJYeGSSG
         Qf4PTL0OfPGmT/ISpd705tBeBkIeeHVY9O+Z5EOUMIL5KSQWKtImf+0FOjP4eOZ7+IK4
         AQ6568i2QBFii3LPRAVe7gRBZqMxeyJ1YNx6wLkRQvixS1KFG7r1pQBUYs+I5Q8gjDC3
         MqAR4Bjyic1ysYC9ninf6ryTyCQoBOgaajh1aJ1O1LKGU6/xJwHHgBB1I27Oa0eEGJ4k
         fND0AiOK1HNzoZhl6ytR0Co6Ub14JeEUOEIZBQ+QvB6i0AVWW6944ATC8N9wQQBsWrjC
         TEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izmqQyUGZtJLfTHp0nD4qtZ5HKh5NS666VqgpqhLGlk=;
        b=Ik7UJ0qJMKL3HVAxaoaGz15o0Adm4KALFNdQr/IzDB/oA5TCe7EonblbP9mOVnGxEv
         ik7VNKFhQ2fL964zjMb7rbI/cXW3V6kZxbWjFtzoL/WbPMfQCHN3FqtjV4x/ZZNEKQKW
         BsXRO84u8R9xZrfLW3xoBnqLilUvInWmI4NjZdpNiNmVMJbH/XisQ4jF0+TJ/c6wfRiO
         i93JkF9wCJhT/hrv3Vd6QCVsRywMi5rKCIJQMkPs85GM9ZUwHsuUHRDb4S/to9FzEpge
         vNJkNuympPXrfVagZ3/fiSZPlh09TK3bOatAFGwhxwpF7gAcQ4X40KSOmC40a9Db5Oq4
         Ujug==
X-Gm-Message-State: AGRZ1gKWEkKQKdKltWX/h4L028wf+m/wLtnIrrQZARb1bkf3XDd/s5/q
        T7Qk3Xycue+MylXtoz6FzlUsX+Xa3bWKmzIWnTc=
X-Google-Smtp-Source: AJdET5fIUCzj6pX5GQ3vJbT4/ERExIYoftXLgdEG3WH6EtR9SBDwitc4vVsT/MstB3nnDZP6pBjp586ggKM7YtaT/rI=
X-Received: by 2002:a1c:adc2:: with SMTP id w185-v6mr2277639wme.103.1542210299083;
 Wed, 14 Nov 2018 07:44:59 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
 <CADnq5_O5j89M=1p5-NYtRv+Sj2dpDTeAU69Mo_Qk92BQy2oJ=Q@mail.gmail.com>
In-Reply-To: <CADnq5_O5j89M=1p5-NYtRv+Sj2dpDTeAU69Mo_Qk92BQy2oJ=Q@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 14 Nov 2018 10:44:47 -0500
Message-ID: <CADnq5_OwyRVcwDVqD73q-Lr_WXCsgaVqCzS_9YZ=7-itZiAoag@mail.gmail.com>
Subject: Re: [PATCH] pci: fix incorrect value returned from pcie_get_speed_cap
To:     mpatocka@redhat.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>, talgi@mellanox.com,
        tariqt@mellanox.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 30, 2018 at 2:00 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Oct 30, 2018 at 12:36 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
> > the register and compare it against them.
> >
> > This patch fixes errors "amdgpu: [powerplay] failed to send message 261
> > ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
> > the slot is being incorrectly reported as PCIe-v3 capable.
> >
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> > Cc: stable@vger.kernel.org      # v4.17+
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>


Has this patch been picked up yet?  It fixes a ton of bugs.  Please apply!

Alex

>
> >
> > ---
> >  drivers/pci/pci.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > Index: linux-4.19/drivers/pci/pci.c
> > ===================================================================
> > --- linux-4.19.orig/drivers/pci/pci.c   2018-10-30 16:58:58.000000000 +0100
> > +++ linux-4.19/drivers/pci/pci.c        2018-10-30 16:58:58.000000000 +0100
> > @@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
> >
> >         pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> >         if (lnkcap) {
> > -               if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> > +               if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
> >                         return PCIE_SPEED_16_0GT;
> > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> > +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
> >                         return PCIE_SPEED_8_0GT;
> > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> > +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
> >                         return PCIE_SPEED_5_0GT;
> > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> > +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
> >                         return PCIE_SPEED_2_5GT;
> >         }
> >
