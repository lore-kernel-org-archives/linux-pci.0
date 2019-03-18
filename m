Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9771FC10F00
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7142620857
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCRIr0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:47:26 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44408 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfCRIr0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 04:47:26 -0400
Received: by mail-vk1-f195.google.com with SMTP id q189so3580607vkq.11;
        Mon, 18 Mar 2019 01:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMCOJBdT81x95nQSd+KHI/V3/nHjH2gKNc7RE2sG/yw=;
        b=j/u3s23iGbx6ieiIEXBqyg7TFwJTSdld8HGkQCSWz8J5E5rA8g0RmWc9kvFX53mbjV
         lN4e9mD2spc5gVAjFg/b4ImjRoMclRxIDnCDkm8cHm7TzvgsndeGw5rVkgHQuULnNDyf
         QgNCXL99DDOv2x2/A67tVzRmrxFtUdtLNB3itRZGbtn7KXE+THtpPBBAythG8UNRSq98
         BxayZ5jsPHrAiLckCqzoujkJqFhKHaOUrcsH9HFe6T80OdnjtcG3+rn7mFC+yad21PxQ
         5tu0v/xOXfQa/ug6W3ElMhS5+NGi9fEhuUGlqIyv0uzaJml6ez/MVXJLBq+xk6LkXhzW
         q2+g==
X-Gm-Message-State: APjAAAWAxdSNXip1KvXmxL5/L8ss+wWvkLn5mf2rm0utY8fAlcdq7964
        /LiB4fjKNYDrQHqht5He9dS4i8XV1iYzUZoASY8=
X-Google-Smtp-Source: APXvYqxeL/kwdJY1CHyIBsO+YWUZkHtDnVJ0NIVZFATKOMP91cuZggqv1RBAkVKKrYy3sGxKJtwnNSisX6iAfYZLCT4=
X-Received: by 2002:a1f:be81:: with SMTP id o123mr8563404vkf.83.1552898845483;
 Mon, 18 Mar 2019 01:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190317000608.24881-1-marek.vasut@gmail.com>
In-Reply-To: <20190317000608.24881-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Mar 2019 09:47:13 +0100
Message-ID: <CAMuHMdW5+aKVFdQYF-xiO3JyoyNYDwOTQqF8BJgku1b7ZzD1Mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: rcar: Replace unsigned long with u32 for
 register values
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Sun, Mar 17, 2019 at 1:06 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace unsigned long with u32 type for variables holding
> register values, since the registers are 32bit. Note that
> rcar_pcie_msi_irq() still uses unsigned long because both
> find_first_bit() and __fls() require unsigned long as an
> argument.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
>  drivers/pci/controller/pcie-rcar.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 1408c8aa758b..857d88fd03d5 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -169,7 +169,7 @@ enum {
>
>  static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
>  {
> -       int shift = 8 * (where & 3);
> +       u32 shift = 8 * (where & 3);

shift is not a register value, so IMHO the original type is fine (the "int"
comes from the pci_ops API, BTW).

>         u32 val = rcar_pci_read_reg(pcie, where & ~3);
>
>         val &= ~(mask << shift);
> @@ -179,7 +179,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
>
>  static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
>  {
> -       int shift = 8 * (where & 3);
> +       u32 shift = 8 * (where & 3);

Likewise

>         u32 val = rcar_pci_read_reg(pcie, where & ~3);
>
>         return val >> shift;
> @@ -190,7 +190,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
>                 unsigned char access_type, struct pci_bus *bus,
>                 unsigned int devfn, int where, u32 *data)
>  {
> -       int dev, func, reg, index;
> +       u32 dev, func, reg, index;

reg is the only register value, isn't it?

>
>         dev = PCI_SLOT(devfn);
>         func = PCI_FUNC(devfn);
> @@ -508,7 +508,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>                                  unsigned int rate, unsigned int addr,
>                                  unsigned int lane, unsigned int data)
>  {
> -       unsigned long phyaddr;
> +       u32 phyaddr;
>
>         phyaddr = WRITE_CMD |
>                 ((rate & 1) << RATE_POS) |
> @@ -1116,7 +1116,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct rcar_pcie *pcie;
> -       unsigned int data;
> +       u32 data;
>         int err;
>         int (*phy_init_fn)(struct rcar_pcie *);
>         struct pci_host_bridge *bridge;

For the last two changes:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
