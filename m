Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD4C10F0B
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 06:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70C3205C9
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 06:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehauzwdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfDRGsV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:48:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33258 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRGsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2019 02:48:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id s11so611310vsn.0;
        Wed, 17 Apr 2019 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXkvHjpaF40zD5jX92LN0fw5RxTmOIUOQpaluOwwbJQ=;
        b=ehauzwdqnWV069uu6ov28GFqJZQ0zj0V7scGYY2c6300/M2WdxIXEjwtd1IJ/lPTH8
         SW9S9oE9JzrE0Jo/N7XtUgrwURTSoCTj948nvWIh4AR5BLZzzCQtNMCLL5i+ZOXoxlUx
         tsI4bZcdcIupLGgV6Gw1zppvHbkdoBLhIfawITq5GT6RhjwfoV3p1E4L+/LDPsC5qld0
         B+XfXvE8GWWt34WhhoOeGtisw36+TY+vUxwiTWXR4l3eNQjY6QcMpcTpzIenZbbM/0pj
         PiVsASp74QHX4t+FEZuJeHfM1GKbiajGzTfZY33DQeT/T4cUU6BOrK22+9Z5LgHWx86+
         pRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXkvHjpaF40zD5jX92LN0fw5RxTmOIUOQpaluOwwbJQ=;
        b=Djf28Kp+BmBs1qZxo9kBUlJ3uKw/Mkmhpc1kBh9yxPC7PA3b/hLl69A3iuiGp5gHZm
         eA6wPQMXNZUcWax7zXw6m+o9FaHw5cYiNLV4/4Py+ijjRiTDHavMsGES0+0WtqXFMEia
         Uf0rfuyPq/8F1tcPPjvMdtnsYYQiH6vyGFS7St77herKhI7e+ytNtiGZLX/uaemvzj3+
         X7fxXQmAO8rHwyB2xXacewS4JzRmuDuOVPjQ3supE5ACdWp2RWPzZAlQPVO9Cu0j4qhj
         WZFwIEehRFesm9b+STIgt0tTpfkb5tFT6hjBZp3c7mMcbjoBrARWG4pCHznhB5qSqvqS
         2ytQ==
X-Gm-Message-State: APjAAAXwZfNb1DhDiIaA2gYMboQYSwFn/ONgngzcGQuSkIYg07tvg027
        HD2oyjfdOT4xpjPuNuOiGcbHgfYUzVM3QkFC3F4=
X-Google-Smtp-Source: APXvYqxmphR7Us175NibG5bk7BFHmDuY4TzfH/nqjWagWwBFDMvq4MB32ot6zhwSyukfmdNzmjcEIkVgyHvpB+QSGSE=
X-Received: by 2002:a67:e258:: with SMTP id w24mr28105527vse.20.1555570100206;
 Wed, 17 Apr 2019 23:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <1542633272-16161-1-git-send-email-sundeep.lkml@gmail.com> <20190417201645.GR126710@google.com>
In-Reply-To: <20190417201645.GR126710@google.com>
From:   sundeep subbaraya <sundeep.lkml@gmail.com>
Date:   Thu, 18 Apr 2019 12:18:09 +0530
Message-ID: <CALHRZuoOs7ya1EOxrj0gx7QD7_TNjmpSL_qi0OiYEA9mHpZBWQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: assign bus numbers present in EA capability for bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Stalley, Sean" <sean.stalley@intel.com>, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Apr 18, 2019 at 1:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Nov 19, 2018 at 06:44:32PM +0530, sundeep.lkml@gmail.com wrote:
> > From: Subbaraya Sundeep <sbhatta@marvell.com>
> >
> > As per the spec, bridges with EA capability work
> > with fixed secondary and subordinate bus numbers.
> > Hence assign bus numbers to bridges from EA if the
> > capability exists.
> >
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>
> I applied this with minor revisions to pci/enumeration for v5.2,
> thanks!
>
> > ---
> > Changes for v2:
> >       No changes just added Sean Stalley who did EA support for BARs.
> >
> >  drivers/pci/probe.c           | 58 ++++++++++++++++++++++++++++++++++++++++---
> >  include/uapi/linux/pci_regs.h |  6 +++++
> >  2 files changed, 60 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b1c05b5..f41d2e6 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1030,6 +1030,40 @@ static void pci_enable_crs(struct pci_dev *pdev)
> >
> >  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> >                                             unsigned int available_buses);
> > +/*
> > + * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
> > + * numbers from EA capability.
> > + * @dev: Bridge with EA
> > + * @secondary: updated with secondary bus number in EA
> > + * @subordinate: updated with subordinate bus number in EA
> > + *
> > + * If it is a bridge with EA capability then fixed bus numbers are
> > + * read from EA capability list and secondary, subordinate reference
> > + * variables will be updated. Otherwise secondary and subordinate reference
> > + * variables will be zeroed.
> > + */
> > +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *secondary,
> > +                             u8 *subordinate)
> > +{
> > +     int ea;
> > +     int offset;
> > +     u32 dw;
> > +
> > +     *secondary = *subordinate = 0;
> > +
> > +     if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> > +             return;
> > +
> > +     /* find PCI EA capability in list */
> > +     ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> > +     if (!ea)
> > +             return;
> > +
> > +     offset = ea + PCI_EA_FIRST_ENT;
> > +     pci_read_config_dword(dev, offset, &dw);
> > +     *secondary =  dw & PCI_EA_SEC_BUS_MASK;
> > +     *subordinate = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
> > +}
> >
> >  /*
> >   * pci_scan_bridge_extend() - Scan buses behind a bridge
> > @@ -1064,6 +1098,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >       u16 bctl;
> >       u8 primary, secondary, subordinate;
> >       int broken = 0;
> > +     u8 fixed_sec, fixed_sub;
> > +     int next_busnr;
> >
> >       /*
> >        * Make sure the bridge is powered on to be able to access config
> > @@ -1163,17 +1199,25 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >               /* Clear errors */
> >               pci_write_config_word(dev, PCI_STATUS, 0xffff);
> >
> > +             /* read bus numbers from EA */
> > +             pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> > +
> > +             next_busnr = max + 1;
> > +             /* Use secondary bus number in EA */
> > +             if (fixed_sec)
> > +                     next_busnr = fixed_sec;
>
> I initially thought this was not quite safe because EA could supply a
> secondary bus number of 0, in which case we would erroneously ignore
> it.  But it's actually not possible for a PCI-to-PCI bridge to have a
> secondary bus number of 0, so it *is* safe.
>
> But it's still a little subtle and since I've already done the work to
> add a bool return value from pci_ea_fixed_busnrs(), maybe it will be
> OK to keep that.  The patch as applied is below, let me know if you
> have any comments.
>
Your changes looks good. Thanks for applying the patch.

Sundeep
> > +
> >               /*
> >                * Prevent assigning a bus number that already exists.
> >                * This can happen when a bridge is hot-plugged, so in this
> >                * case we only re-scan this bus.
> >                */
> > -             child = pci_find_bus(pci_domain_nr(bus), max+1);
> > +             child = pci_find_bus(pci_domain_nr(bus), next_busnr);
> >               if (!child) {
> > -                     child = pci_add_new_bus(bus, dev, max+1);
> > +                     child = pci_add_new_bus(bus, dev, next_busnr);
> >                       if (!child)
> >                               goto out;
> > -                     pci_bus_insert_busn_res(child, max+1,
> > +                     pci_bus_insert_busn_res(child, next_busnr,
> >                                               bus->busn_res.end);
> >               }
> >               max++;
> > @@ -1234,7 +1278,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >                       max += i;
> >               }
> >
> > -             /* Set subordinate bus number to its real value */
> > +             /*
> > +              * Set subordinate bus number to its real value.
> > +              * If fixed subordinate bus number exists from EA
> > +              * capability then use it.
> > +              */
> > +             if (fixed_sub)
> > +                     max = fixed_sub;
> >               pci_bus_update_busn_res_end(child, max);
> >               pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
> >       }
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index e1e9888..c3d0904 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -372,6 +372,12 @@
> >  #define PCI_EA_FIRST_ENT_BRIDGE      8       /* First EA Entry for Bridges */
> >  #define  PCI_EA_ES           0x00000007 /* Entry Size */
> >  #define  PCI_EA_BEI          0x000000f0 /* BAR Equivalent Indicator */
> > +
> > +/* EA fixed Secondary and Subordinate bus numbers for Bridge */
> > +#define PCI_EA_SEC_BUS_MASK  0xff
> > +#define PCI_EA_SUB_BUS_MASK  0xff00
> > +#define PCI_EA_SUB_BUS_SHIFT 8
> > +
> >  /* 0-5 map to BARs 0-5 respectively */
> >  #define   PCI_EA_BEI_BAR0            0
> >  #define   PCI_EA_BEI_BAR5            5
> > --
> > 1.8.3.1
> >
>
> commit 2dbce5901179
> Author: Subbaraya Sundeep <sbhatta@marvell.com>
> Date:   Mon Nov 19 18:44:32 2018 +0530
>
>     PCI: Assign bus numbers present in EA capability for bridges
>
>     The "Enhanced Allocation (EA) for Memory and I/O Resources" ECN, approved
>     23 October 2014, sec 6.9.1.2, specifies a second DW in the capability for
>     type 1 (bridge) functions to describe fixed secondary and subordinate bus
>     numbers.  This ECN was included in the PCIe r4.0 spec, but sec 6.9.1.2 was
>     omitted, presumably by mistake.
>
>     Read fixed bus numbers from the EA capability for bridges.
>
>     Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>     [bhelgaas: add pci_ea_fixed_busnrs() return value]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 012250a78da7..a6874c306908 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1086,6 +1086,36 @@ static void pci_enable_crs(struct pci_dev *pdev)
>
>  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>                                               unsigned int available_buses);
> +/**
> + * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
> + * numbers from EA capability.
> + * @dev: Bridge
> + * @sec: updated with secondary bus number from EA
> + * @sub: updated with subordinate bus number from EA
> + *
> + * If @dev is a bridge with EA capability, update @sec and @sub with
> + * fixed bus numbers from the capability and return true.  Otherwise,
> + * return false.
> + */
> +static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
> +{
> +       int ea, offset;
> +       u32 dw;
> +
> +       if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +               return false;
> +
> +       /* find PCI EA capability in list */
> +       ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> +       if (!ea)
> +               return false;
> +
> +       offset = ea + PCI_EA_FIRST_ENT;
> +       pci_read_config_dword(dev, offset, &dw);
> +       *sec =  dw & PCI_EA_SEC_BUS_MASK;
> +       *sub = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
> +       return true;
> +}
>
>  /*
>   * pci_scan_bridge_extend() - Scan buses behind a bridge
> @@ -1120,6 +1150,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>         u16 bctl;
>         u8 primary, secondary, subordinate;
>         int broken = 0;
> +       bool fixed_buses;
> +       u8 fixed_sec, fixed_sub;
> +       int next_busnr;
>
>         /*
>          * Make sure the bridge is powered on to be able to access config
> @@ -1219,17 +1252,24 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>                 /* Clear errors */
>                 pci_write_config_word(dev, PCI_STATUS, 0xffff);
>
> +               /* Read bus numbers from EA Capability (if present) */
> +               fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> +               if (fixed_buses)
> +                       next_busnr = fixed_sec;
> +               else
> +                       next_busnr = max + 1;
> +
>                 /*
>                  * Prevent assigning a bus number that already exists.
>                  * This can happen when a bridge is hot-plugged, so in this
>                  * case we only re-scan this bus.
>                  */
> -               child = pci_find_bus(pci_domain_nr(bus), max+1);
> +               child = pci_find_bus(pci_domain_nr(bus), next_busnr);
>                 if (!child) {
> -                       child = pci_add_new_bus(bus, dev, max+1);
> +                       child = pci_add_new_bus(bus, dev, next_busnr);
>                         if (!child)
>                                 goto out;
> -                       pci_bus_insert_busn_res(child, max+1,
> +                       pci_bus_insert_busn_res(child, next_busnr,
>                                                 bus->busn_res.end);
>                 }
>                 max++;
> @@ -1290,7 +1330,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>                         max += i;
>                 }
>
> -               /* Set subordinate bus number to its real value */
> +               /*
> +                * Set subordinate bus number to its real value.
> +                * If fixed subordinate bus number exists from EA
> +                * capability then use it.
> +                */
> +               if (fixed_buses)
> +                       max = fixed_sub;
>                 pci_bus_update_busn_res_end(child, max);
>                 pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
>         }
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 5c98133f2c94..c51e0066de8b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -372,6 +372,12 @@
>  #define PCI_EA_FIRST_ENT_BRIDGE        8       /* First EA Entry for Bridges */
>  #define  PCI_EA_ES             0x00000007 /* Entry Size */
>  #define  PCI_EA_BEI            0x000000f0 /* BAR Equivalent Indicator */
> +
> +/* EA fixed Secondary and Subordinate bus numbers for Bridge */
> +#define PCI_EA_SEC_BUS_MASK    0xff
> +#define PCI_EA_SUB_BUS_MASK    0xff00
> +#define PCI_EA_SUB_BUS_SHIFT   8
> +
>  /* 0-5 map to BARs 0-5 respectively */
>  #define   PCI_EA_BEI_BAR0              0
>  #define   PCI_EA_BEI_BAR5              5
