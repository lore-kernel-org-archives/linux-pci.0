Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE39C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 19:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3313E20831
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 19:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpZEVHe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3313E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKTFjk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:39:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38130 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTFjj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 00:39:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id e3-v6so33287904wrs.5
        for <linux-pci@vger.kernel.org>; Mon, 19 Nov 2018 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CGqaeDSi7dsh5PwftqxFw8duwN7ODkpr7jlBIeagn8=;
        b=fpZEVHe4jQkbKpGcqtrtl+3bh+Wdw9UYfIW+V8JY5tiMFUnsHX/An3Pmld4HVAABXo
         iRzJQ7g47fAdhf0NfFwQh4C7CIdFI8iL0SNRkPS6BZX2mLxERUpel3N7iN1pNwNB8x/5
         fDsd2U8+Th70VHzOgt+UHziWDYZC6oTbnXoFVA86GY/93krrVNjLZTFq0KclcxmWJC2Y
         8/G6rntKgDijU6+ebRDapfXtqvlNXW+vcH0Tzm/H/G/j3vRRT6+f6NNTyjD0tFZt/iTr
         MRZdBxQ4ym6Cp0aQaoMVjVReMFJRk1mRoWS8wkNDJjVXYPEuNXGrZWbmgesivg0or9SN
         cEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CGqaeDSi7dsh5PwftqxFw8duwN7ODkpr7jlBIeagn8=;
        b=WIEj7ZFqAE+cP6/W4t1cejC4tmsDWod72Je1CUf8RlSJ7qPsEwGD0YfkkP40SxZGJX
         4ZiG0c2awDqeRmes7Cri7QYR8o/GsOzM1kg2gqvk7S4On4zIZQNJpDUV5xgiTmtYx33+
         BgOqXrDnziMXvEJbCLZe3k2IxImN06UiSPuwho9t3BSEZit1fvQpFLxR3zb7m+eJLO7O
         4ovDR18qOuhk7P6XR83+PCbFTdj1K4UA42jumWTHHD1S38Wa+rHttC5/SvxFgiWZ9tN+
         GEJ61L1+YOA/sQEp0bVS8eHMn7BIL0AqebD81h/m6biAJ3XI+Oo4inJmInIcHsTUE+8l
         awqw==
X-Gm-Message-State: AGRZ1gIfLOs302RmRTLTWT3rWtbLtweJQg9gHHdDX9iZicjfzoAzXz+d
        eDBh5xsk9v90bMWi2zMhfPckdj8OKoKTXnOS8yc=
X-Google-Smtp-Source: AJdET5dOuVNIwvcXrQrniK7fK4HzKctISlP+4g+jhHYc9Ty33P9R179aRTK4nm+x2uoEiLa6rQm7g087U9hXfzE4Z1s=
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr19961958wrm.128.1542654879297;
 Mon, 19 Nov 2018 11:14:39 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
 <CADnq5_O5j89M=1p5-NYtRv+Sj2dpDTeAU69Mo_Qk92BQy2oJ=Q@mail.gmail.com> <CADnq5_OwyRVcwDVqD73q-Lr_WXCsgaVqCzS_9YZ=7-itZiAoag@mail.gmail.com>
In-Reply-To: <CADnq5_OwyRVcwDVqD73q-Lr_WXCsgaVqCzS_9YZ=7-itZiAoag@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 19 Nov 2018 14:14:26 -0500
Message-ID: <CADnq5_PAN8aVUyxBjsrFVWYujjrD7C_i78YQGAPNigdSV_+=WA@mail.gmail.com>
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

On Wed, Nov 14, 2018 at 10:44 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Oct 30, 2018 at 2:00 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Oct 30, 2018 at 12:36 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > > The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
> > > the register and compare it against them.
> > >
> > > This patch fixes errors "amdgpu: [powerplay] failed to send message 261
> > > ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
> > > the slot is being incorrectly reported as PCIe-v3 capable.
> > >
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> > > Cc: stable@vger.kernel.org      # v4.17+
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
>
> Has this patch been picked up yet?  It fixes a ton of bugs.  Please apply!

Any word on this?  Fixes:
https://bugs.freedesktop.org/show_bug.cgi?id=108704
https://bugs.freedesktop.org/show_bug.cgi?id=108778
and several others.

Alex

>
> Alex
>
> >
> > >
> > > ---
> > >  drivers/pci/pci.c |    8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > Index: linux-4.19/drivers/pci/pci.c
> > > ===================================================================
> > > --- linux-4.19.orig/drivers/pci/pci.c   2018-10-30 16:58:58.000000000 +0100
> > > +++ linux-4.19/drivers/pci/pci.c        2018-10-30 16:58:58.000000000 +0100
> > > @@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
> > >
> > >         pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > >         if (lnkcap) {
> > > -               if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> > > +               if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
> > >                         return PCIE_SPEED_16_0GT;
> > > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> > > +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
> > >                         return PCIE_SPEED_8_0GT;
> > > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> > > +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
> > >                         return PCIE_SPEED_5_0GT;
> > > -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> > > +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
> > >                         return PCIE_SPEED_2_5GT;
> > >         }
> > >
