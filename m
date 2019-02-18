Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF59C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 03:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DF2218D3
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 03:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrurLslq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBRD7T (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:59:19 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44295 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfBRD7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Feb 2019 22:59:19 -0500
Received: by mail-vk1-f195.google.com with SMTP id h128so3537271vkg.11;
        Sun, 17 Feb 2019 19:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdwfr0blzWw/F/2tFf9XoiZa7cjdK1BI5z4MKe/MDNg=;
        b=QrurLslq/hzJ48+T7LnRxkDxO8bwjLHSb3YJ11Y3YHiZ/E8ENhaNPHWPkWMtrkqWX/
         OY8Pf0f8qzaGZEYTlV/dYrldcc1iLvdUVKRPvySdKFY1oCVuD3VSy9wGyTDoC2NoU7uS
         yGbI1Ee8Z9WuGmfyf6xiiC3uJcAiaB2oQIXnEUQwGzM+a6sTKF3Dlr+fnUnuck2VOC5E
         dNtM4cnwLgTlNf1EnHa2cLZdb/thopBgVaALmiY5EZnG+w+u3m3deHi8yzo0rl0ZaliP
         e3mvtSR/58S30meXWlwI4RveOTJXSXYSkq/9tM7/uZRPGTwlPHWm7Xle5MtYleIR3CnB
         IJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdwfr0blzWw/F/2tFf9XoiZa7cjdK1BI5z4MKe/MDNg=;
        b=g69RQKnWq9kFR1nOCn8XY3d32EFWS4rlHixNpAXQsEueJBge6B/q1PCGUIzLZg3VfV
         6TedWp34YGHQuWIbI10trn1QDHblsWdWp42E2yUs3EzGaARJxOY+p48qowK882h9HSBF
         BNcepWyDKM1jaIwgoKV5nwc4a0JQ+kkdrNZgk2a/fOjaACtuGitlFE762hKVOgxu9/DQ
         Giugilji9wtn3WiBbMrdq9fj9Gid580vkaDOXl0+zOXKIQBjqVFP1HIVTE5SsMnvae6G
         vjZdeOIJw592UhnhL6lys3Tc/rY148Bv0a1WpiR+aggpfU/x3BHEo7YN6WVLbVt8ItaV
         5UuQ==
X-Gm-Message-State: AHQUAuabE1D+Dr7arsk8z/463nW9ZdYIck6X+2g8qByJ7NSip3j9JvTL
        /Hd3+Qy/4LmL9lOpZnarI0jPtu8VDxDW8llY52qTdw==
X-Google-Smtp-Source: AHgI3IbFnqczzebHBLRnPmmZ2cE3YfDC9X6k9FU4G3Bg7UnCbsZFkvUdqvRkOvOJtgu1W0baEriS1YCm4P5rQoDfSW0=
X-Received: by 2002:a1f:aed6:: with SMTP id x205mr10972102vke.11.1550462357446;
 Sun, 17 Feb 2019 19:59:17 -0800 (PST)
MIME-Version: 1.0
References: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com> <CALHRZuqoA+JknbJsqcYOzyBOy-NJSGG7h9H-ZV6Qpe7puEQAiw@mail.gmail.com>
In-Reply-To: <CALHRZuqoA+JknbJsqcYOzyBOy-NJSGG7h9H-ZV6Qpe7puEQAiw@mail.gmail.com>
From:   sundeep subbaraya <sundeep.lkml@gmail.com>
Date:   Mon, 18 Feb 2019 09:29:06 +0530
Message-ID: <CALHRZuprLQcnGAuiBuYph8AmP+PDViL=VpzkFQc5U30HkwHbpg@mail.gmail.com>
Subject: Re: [v3 PATCH 1/2] PCI: read fixed bus numbers in EA for type 1 functions
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Stalley, Sean" <sean.stalley@intel.com>, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping.

Thanks,
Sundeep

On Tue, Feb 5, 2019 at 9:30 AM sundeep subbaraya <sundeep.lkml@gmail.com> wrote:
>
> Hi Bjorn,
>
> Any comments?
>
> Thanks,
> Sundeep
>
> On Wed, Jan 23, 2019 at 6:48 PM <sundeep.lkml@gmail.com> wrote:
> >
> > From: Subbaraya Sundeep <sbhatta@marvell.com>
> >
> > As per the spec - ECN_Enhanced_Allocation_23_Oct_2014_Final
> > and section 6.9.1.2, EA capability contains fixed secondary
> > and subordinate bus numbers for type 1 functions.
> > This patch adds support to read the fixed bus numbers
> > from EA capability for bridge.
> >
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
> > v3:
> >   As per Bjorn's suggestion placed EA stuff in pci_ea_init and
> >   captured bus numbers in pci_dev
> > v2:
> >   None just added Sean
> >
> >  drivers/pci/pci.c             | 10 ++++++++--
> >  include/linux/pci.h           |  4 ++++
> >  include/uapi/linux/pci_regs.h |  4 ++++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index c25acac..484b63e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2909,6 +2909,7 @@ void pci_ea_init(struct pci_dev *dev)
> >         u8 num_ent;
> >         int offset;
> >         int i;
> > +       u32 dw;
> >
> >         /* find PCI EA capability in list */
> >         ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> > @@ -2922,9 +2923,14 @@ void pci_ea_init(struct pci_dev *dev)
> >
> >         offset = ea + PCI_EA_FIRST_ENT;
> >
> > -       /* Skip DWORD 2 for type 1 functions */
> > -       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> > +       /* Note fixed bus numbers for type 1 functions */
> > +       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > +               pci_read_config_dword(dev, offset, &dw);
> > +               dev->fixed_sec_busnr = dw & PCI_EA_FIXED_SEC_BUS;
> > +               dev->fixed_sub_busnr = (dw & PCI_EA_FIXED_SUB_BUS) >>
> > +                                       PCI_EA_FIXED_SUB_SHIFT;
> >                 offset += 4;
> > +       }
> >
> >         /* parse each EA entry */
> >         for (i = 0; i < num_ent; ++i)
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 65f1d8c..3e9a3ae 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -459,6 +459,10 @@ struct pci_dev {
> >         char            *driver_override; /* Driver name to force a match */
> >
> >         unsigned long   priv_flags;     /* Private flags for the PCI driver */
> > +
> > +       /* bus numbers from EA capability if this device is a bridge */
> > +       u8 fixed_sec_busnr; /* Fixed Secondary Bus number */
> > +       u8 fixed_sub_busnr; /* Fixed Subordinate Bus number */
> >  };
> >
> >  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index e1e9888..51e9ac0 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -372,6 +372,10 @@
> >  #define PCI_EA_FIRST_ENT_BRIDGE        8       /* First EA Entry for Bridges */
> >  #define  PCI_EA_ES             0x00000007 /* Entry Size */
> >  #define  PCI_EA_BEI            0x000000f0 /* BAR Equivalent Indicator */
> > +/* Fixed Secondary and Subordinate bus numbers in EA for Bridge */
> > +#define   PCI_EA_FIXED_SEC_BUS         0xff
> > +#define   PCI_EA_FIXED_SUB_BUS         0xff00
> > +#define   PCI_EA_FIXED_SUB_SHIFT       8
> >  /* 0-5 map to BARs 0-5 respectively */
> >  #define   PCI_EA_BEI_BAR0              0
> >  #define   PCI_EA_BEI_BAR5              5
> > --
> > 1.8.3.1
> >
