Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D5EC04EBA
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0B3208E4
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="Mp7E0uPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0B3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeK1DEw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:04:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38090 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeK1DEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Nov 2018 22:04:51 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so17236509ioj.5
        for <linux-pci@vger.kernel.org>; Tue, 27 Nov 2018 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vbSG5j1FoM0i56JGB6Z6dbizmzXkxB2ylt63ftiNcM=;
        b=Mp7E0uPcDHsNtTDV3i3uC1c2KMllKJLrm9J6Mg1JT3Dz/LEWjYaNwXmicmh2UjY8IB
         en202y8DkWbHv/8mbMl4w9RyUsXC9Z9mLICWODbo8ojb30vX/b6cQY/H7/Q0AaqqcXsp
         hdKzfEVEDjvx0c70GGnsgDsnnmZNXlf7jB/yEDrGp2VB9kPSC+D+Y2BF4O1OiJOPspS9
         fq6npGNBYqWoSDC387Ywe5oFX7gx3OfqepWaBGSLjbD9Yz3f1vfzj8WnfZhxqLQZEPMP
         nznHRq1wL5z3IaWqhH7QFLOzpGtDdIBcyl2W65fbxZMpFsBjt26PdfEkoRHto0IL029k
         Hm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vbSG5j1FoM0i56JGB6Z6dbizmzXkxB2ylt63ftiNcM=;
        b=Kx2Z9MXwpbWEt+LhtymDYONdjzQt8x/QCwKF7UC63du9TTxZzWNZGs6DDgvQ9td23A
         WhaoKNgVZ7oPCG0M272+Fx+rJuHTJHRsqQ5sM9+fWabEemeKSs1RSSrm1R+Lz6ubIzFi
         JQ4SkcCQoF/krA1PpF21SeRb7/XpkmQOaOpYl1a5QxajDQile25tKB5IY/WrsK4Mxd5X
         YnknQ7knQlxtTaRPKzqthxOjmhrw0wdzaPcd2aXdZ2l3r1Wc/INqdB08bFIHjUbY082p
         LyyL+goU40WoAHUaG07722nVQO3kRqHWwU/V3uqB+YeliEoPUMNiSz50CTFGAxM9WSzm
         zU/A==
X-Gm-Message-State: AA+aEWap4oh3hePjKpt7ojR5hPWHbt5u8BW2uY+faj4zA23Zh8xyL9Hs
        8NJsLgPRTP7U9LCjbhHS0YD99VN8/BWUikmeqie/Tw==
X-Google-Smtp-Source: AFSGD/VYe4I9WtBbKeT9YWjRDL3zdWyKLI5aWZYOu0Uv2GD9sRw3P/rfP9h+NYQP55NZDGfCIF0STIAg/g9PYr+s8Oo=
X-Received: by 2002:a5e:d514:: with SMTP id e20mr28309947iom.291.1543334788563;
 Tue, 27 Nov 2018 08:06:28 -0800 (PST)
MIME-Version: 1.0
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com> <1542877322-24548-3-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1542877322-24548-3-git-send-email-wesley.sheng@microchip.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Tue, 27 Nov 2018 11:06:16 -0500
Message-ID: <CAPoiz9xRV3ny1EQZGXc3moPHUxESTkDz5rMd8+E_Ag4sFNKQ8w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntb_hw_switchtec: Added support of >=4G memory windows
To:     wesley.sheng@microchip.com
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wesleyshenggit@sina.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 21, 2018 at 9:19 PM Wesley Sheng <wesley.sheng@microchip.com> wrote:
>
> From: Paul Selles <paul.selles@microchip.com>
>
> Current Switchtec's BAR setup registers are limited to 32bits,
> corresponding to the maximum MW (memory window) size is <4G.
>
> Increase the MW sizes with the addition of the BAR Setup Extension
> Register for the upper 32bits of a 64bits MW size. This increases the MW
> range to between 4K and 2^63.
>
> Reported-by: Boris Glimcher <boris.glimcher@emc.com>
> Signed-off-by: Paul Selles <paul.selles@microchip.com>
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++++--
>  include/linux/switchtec.h              | 6 +++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 9916bc5..32850fb 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -264,6 +264,7 @@ static void switchtec_ntb_mw_clr_direct(struct switchtec_ntb *sndev, int idx)
>         ctl_val &= ~NTB_CTRL_BAR_DIR_WIN_EN;
>         iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
>         iowrite32(0, &ctl->bar_entry[bar].win_size);
> +       iowrite32(0, &ctl->bar_ext_entry[bar].win_size);
>         iowrite64(sndev->self_partition, &ctl->bar_entry[bar].xlate_addr);
>  }
>
> @@ -286,7 +287,9 @@ static void switchtec_ntb_mw_set_direct(struct switchtec_ntb *sndev, int idx,
>         ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
>
>         iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
> -       iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
> +       iowrite32(xlate_pos | (size & 0xFFFFF000),
> +                 &ctl->bar_entry[bar].win_size);
> +       iowrite32(size >> 32, &ctl->bar_ext_entry[bar].win_size);

Thanks for the patches.  Overall the look good.  Per the kbuild email,
size_t is 32bits on 32bit arch.  So, this is going to have compile
warnings on those.  Please address this and resubmit.

Also, patches 1 and 3 are bug fixes.  Please do the following, reorder
the patches to make the bug fixes first and add a "Fixes" line to the
commit messages (see
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes).
This will allow me to split up the series and get the bug fixes into
v4.20 (and the stable trees).

Thanks,
Jon

>         iowrite64(sndev->self_partition | addr,
>                   &ctl->bar_entry[bar].xlate_addr);
>  }
> @@ -1053,7 +1056,9 @@ static int crosslink_setup_mws(struct switchtec_ntb *sndev, int ntb_lut_idx,
>                 ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
>
>                 iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
> -               iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
> +               iowrite32(xlate_pos | (size & 0xFFFFF000),
> +                         &ctl->bar_entry[bar].win_size);
> +               iowrite32(size >> 32, &ctl->bar_ext_entry[bar].win_size);
>                 iowrite64(sndev->peer_partition | addr,
>                           &ctl->bar_entry[bar].xlate_addr);
>         }
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index eee0412..1e6e333 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -248,7 +248,11 @@ struct ntb_ctrl_regs {
>                 u32 win_size;
>                 u64 xlate_addr;
>         } bar_entry[6];
> -       u32 reserved2[216];
> +       struct {
> +               u32 win_size;
> +               u32 reserved[3];
> +       } bar_ext_entry[6];
> +       u32 reserved2[192];
>         u32 req_id_table[256];
>         u32 reserved3[512];
>         u64 lut_entry[512];
> --
> 2.7.4
>
