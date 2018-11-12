Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F4C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 06:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886C92175B
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 06:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsW6hcGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886C92175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbeKLP7L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:59:11 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35967 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbeKLP7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 10:59:11 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so4441946vsc.3;
        Sun, 11 Nov 2018 22:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlWr/2WpPQt9d/A71YS5YJu5IlECyiTdpDZRmk1kR6k=;
        b=DsW6hcGwt/M5yWYV70wTP7T6B/5nNQjZ1xd7/Lc5iDALwtS/HXFdykZT6M8V3M4T8z
         iJhQ3QLmaTWwgSbZcGY7OGOk/EcnP3zzxeBnEpmLCec4kVZUW9wJqE9LuLu5+MzRe1na
         1EKUY3rbejpOJwJnlH5NZMGLh30tRBPQDUUrOccAB36wreEQsR4jmP3fkgV6U0+r+km/
         vEX90W3N1uzbR9uGPelBNXw1U/+dyNCjFswRuuIv46wa4pg3hvZ+YXmMbNECu9QhbX9A
         3Qit7f8vkA5Jv+90jrKhaj9hYCRNAjDEclAtRctKgqSd+HzYHobRbHLVT3kVit7NO5BJ
         8UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlWr/2WpPQt9d/A71YS5YJu5IlECyiTdpDZRmk1kR6k=;
        b=FbZKUOcYCX7szUnpwOMDto1ZFd2V4LwB9FsLwWwXrqyqNC5kugcI60ocHELhzw1NQk
         ll57JBzdCMR/eqTgt3GJJu8vcKh8M6DRkSx0LRPq1DPOb/RSalCMe1SOJk3umac4Lojr
         dgq6xkq6OoaI87+KR+LaNM/rFmPAAw7B0eaulTWVc0rXLN/ZQp0QNSfRwQ57fwrS8jZ4
         FhMGJwrLvZGGJtvd+6/7ad46SFdDDhzwZ9bBul6ERBu7hjZrvR3ct0tj6h8gX7m1+Sx4
         DTog8MnD0PgjSZL4nL9JEE7U9aU4XW7JEd/+7uA3wjLYgifvgsZQlzql5C6IgjlfE0YB
         0Grw==
X-Gm-Message-State: AGRZ1gJH0zeTUVwVeVaHeW/y6La0WmDx8ulN821s08MD0rjnDRGCC0re
        KD/xsl7GfnABZWRvTdKgnDlCsfwqe0Oa0BKUyuLHBw==
X-Google-Smtp-Source: AJdET5dlgGwz91ywKOXnYtxI6NR/QvSwEgcBXuc6mEkxVWvxyl5HHCrhVKs4jaIRyuWWuS6jvLLmudjJ6HvwRy5NSqE=
X-Received: by 2002:a67:1505:: with SMTP id 5mr5990692vsv.20.1542002845041;
 Sun, 11 Nov 2018 22:07:25 -0800 (PST)
MIME-Version: 1.0
References: <1541064675-20324-1-git-send-email-sundeep.lkml@gmail.com>
In-Reply-To: <1541064675-20324-1-git-send-email-sundeep.lkml@gmail.com>
From:   sundeep subbaraya <sundeep.lkml@gmail.com>
Date:   Mon, 12 Nov 2018 11:37:11 +0530
Message-ID: <CALHRZurB1J45G-+83MwGexMJouw+9Q1LAzs15=uqdvq0VsSPaw@mail.gmail.com>
Subject: Re: [PATCH] PCI: assign bus numbers present in EA capability for bridges
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sgoutham@marvell.com, Subbaraya Sundeep <sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Any comments?

Thanks,
Sundeep
On Thu, Nov 1, 2018 at 3:01 PM <sundeep.lkml@gmail.com> wrote:
>
> From: Subbaraya Sundeep <sbhatta@marvell.com>
>
> As per the spec, bridges with EA capability work
> with fixed secondary and subordinate bus numbers.
> Hence assign bus numbers to bridges from EA if the
> capability exists.
>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/pci/probe.c           | 58 ++++++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h |  6 +++++
>  2 files changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b5..f41d2e6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1030,6 +1030,40 @@ static void pci_enable_crs(struct pci_dev *pdev)
>
>  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>                                               unsigned int available_buses);
> +/*
> + * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
> + * numbers from EA capability.
> + * @dev: Bridge with EA
> + * @secondary: updated with secondary bus number in EA
> + * @subordinate: updated with subordinate bus number in EA
> + *
> + * If it is a bridge with EA capability then fixed bus numbers are
> + * read from EA capability list and secondary, subordinate reference
> + * variables will be updated. Otherwise secondary and subordinate reference
> + * variables will be zeroed.
> + */
> +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *secondary,
> +                               u8 *subordinate)
> +{
> +       int ea;
> +       int offset;
> +       u32 dw;
> +
> +       *secondary = *subordinate = 0;
> +
> +       if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +               return;
> +
> +       /* find PCI EA capability in list */
> +       ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> +       if (!ea)
> +               return;
> +
> +       offset = ea + PCI_EA_FIRST_ENT;
> +       pci_read_config_dword(dev, offset, &dw);
> +       *secondary =  dw & PCI_EA_SEC_BUS_MASK;
> +       *subordinate = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
> +}
>
>  /*
>   * pci_scan_bridge_extend() - Scan buses behind a bridge
> @@ -1064,6 +1098,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>         u16 bctl;
>         u8 primary, secondary, subordinate;
>         int broken = 0;
> +       u8 fixed_sec, fixed_sub;
> +       int next_busnr;
>
>         /*
>          * Make sure the bridge is powered on to be able to access config
> @@ -1163,17 +1199,25 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>                 /* Clear errors */
>                 pci_write_config_word(dev, PCI_STATUS, 0xffff);
>
> +               /* read bus numbers from EA */
> +               pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> +
> +               next_busnr = max + 1;
> +               /* Use secondary bus number in EA */
> +               if (fixed_sec)
> +                       next_busnr = fixed_sec;
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
> @@ -1234,7 +1278,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>                         max += i;
>                 }
>
> -               /* Set subordinate bus number to its real value */
> +               /*
> +                * Set subordinate bus number to its real value.
> +                * If fixed subordinate bus number exists from EA
> +                * capability then use it.
> +                */
> +               if (fixed_sub)
> +                       max = fixed_sub;
>                 pci_bus_update_busn_res_end(child, max);
>                 pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
>         }
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e1e9888..c3d0904 100644
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
> --
> 1.8.3.1
>
