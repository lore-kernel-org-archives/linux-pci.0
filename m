Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F20C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1EF20862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 08:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1EF20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeKFRhb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:37:31 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37605 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeKFRhb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 12:37:31 -0500
Received: by mail-ua1-f65.google.com with SMTP id u19so3150243uae.4;
        Tue, 06 Nov 2018 00:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1kxUvtvg/KtFBpG9CICf6ia6jNicnO3FugcBEBYrxk=;
        b=SAUOtmqFcPRZinz/ai0X7q7J8cpykqpmiFWbcIKZbum4PfZBKVOYAza4Hr1L52+LJD
         9JK+3+21MUhmDoefCDkoy3qKJc2K9ZcFHkZvwvgWAnq4JpCqtJBS70nxbIzgwi26rZD6
         BSyjKEFJoKbu/bM7S3e8dLheJaedvFBLd5tzIJZfG7vuwckDekcNw6FipAyN8Gm9HXNW
         R3CpmN9jxp2uF0wfYX3ovkdJTEBLJ4kR1ZObe9VzbqeVVNOkuYFovRzmOFqQffS7rq7p
         HGqFcsZqaOretbzaiLBLD5i/j5aYuf9qLPmRk0+wgq+RJQSYWHeXvh0KebJNQ7hWagBN
         gL6w==
X-Gm-Message-State: AGRZ1gI8QnP0EIkEyF9z47T76GY9MCKArE3NTHe8bSoD2JquXUMgbhda
        FuD3b1eChqAUu2caHnZ1sxjXPUZ6IPS78vy/0RM=
X-Google-Smtp-Source: AJdET5eTdD4Ty/q/cKhyHEQw5pM14/SSxm7e5SuRp7BJfF25SW/i2xn8df4s66xNR9DOOkvDmT5HoqZWc7i26L2NtLk=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr1765875uad.78.1541492009178;
 Tue, 06 Nov 2018 00:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20181105232500.19146-1-marek.vasut+renesas@gmail.com>
In-Reply-To: <20181105232500.19146-1-marek.vasut+renesas@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 09:13:17 +0100
Message-ID: <CAMuHMdX2WKtVnzhfWTTXamXgWvtYhvJjAE1bBz9vd8UHK2rO6g@mail.gmail.com>
Subject: Re: [RFC][PATCH] PCI: Avoid PCI device removing/rescanning through
 sysfs triggers a deadlock
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        tho.vu.wh@rvc.renesas.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Thanks for your patch!

On Tue, Nov 6, 2018 at 12:25 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Tho Vu <tho.vu.wh@rvc.renesas.com>
>
> This patch fixes deadlock warning in removing/rescanning through sysfs
> when CONFIG_PROVE_LOCKING is enabled.
>
> The issue can be reproduced by these steps:
> 1. Enable CONFIG_PROVE_LOCKING via defconfig or menuconfig
> 2. Insert Ethernet card into PCIe CH0 and start up.
>    After kernel starting up, execute the following command.
>    echo 1 > /sys/class/pci_bus/0000\:00/device/0000\:00\:00.0/remove
> 3. Rescan PCI device by this command
>    echo 1 > /sys/class/pci_bus/0000\:00/rescan
>
> The deadlock warnings will occur.
> ============================================
> WARNING: possible recursive locking detected
> 4.14.70-ltsi-yocto-standard #27 Not tainted
> --------------------------------------------
> sh/3402 is trying to acquire lock:
>  (kn->count#78){++++}, at: kernfs_remove_by_name_ns+0x50/0xa8
>
> but task is already holding lock:
>  (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(kn->count#78);
>   lock(kn->count#78);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 4 locks held by sh/3402:
>  #0:  (sb_writers#4){.+.+}, at: vfs_write+0x198/0x1b0
>  #1:  (&of->mutex){+.+.}, at: kernfs_fop_write+0x108/0x210
>  #2:  (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130
>  #3:  (pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x1c/0x28
>
> stack backtrace:
> CPU: 3 PID: 3402 Comm: sh Not tainted 4.14.70-ltsi-yocto-standard #27
> Hardware name: Renesas Salvator-X 2nd version board based on r8a7795
> ES3.0+ with 8GiB (4 x 2 GiB) (DT)
> Call trace:
> dump_backtrace+0x0/0x3d8
> show_stack+0x14/0x20
> dump_stack+0xbc/0xf4
> __lock_acquire+0x930/0x18a8
> lock_acquire+0x48/0x68
> __kernfs_remove+0x280/0x2f8
> kernfs_remove_by_name_ns+0x50/0xa8
> remove_files.isra.0+0x38/0x78
> sysfs_remove_group+0x4c/0xa0
> sysfs_remove_groups+0x38/0x60
> device_remove_attrs+0x54/0x78
> device_del+0x1ac/0x308
> pci_remove_bus_device+0x78/0xf8
> pci_remove_bus_device+0x34/0xf8
> pci_stop_and_remove_bus_device_locked+0x24/0x38
> remove_store+0x6c/0x78
> dev_attr_store+0x18/0x28
> sysfs_kf_write+0x4c/0x78
> kernfs_fop_write+0x138/0x210
> __vfs_write+0x18/0x118
> vfs_write+0xa4/0x1b0
> SyS_write+0x48/0xb0
>
> This warning occurs due to a self-deletion attribute using in the sysfs

used

> PCI device directory. This kind of attribute is really tricky,
> it does not allow pci framework drop this attribute until all active

to drop

> .show() and .store() callbacks have finished unless

finished, unless

> sysfs_break_active_protection() is called.
> Hence this patch avoids writing into this attribute triggers a deadlock.

and trigger a deadlock.

>
> Referrence commit 5b55b24cec4c ("scsi: core: Avoid that SCSI device
> removal through sysfs triggers a deadlock")
> of scsi driver
>
> Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>

You forgot to append your own SoB?

> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -470,12 +470,22 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>                             const char *buf, size_t count)
>  {
>         unsigned long val;
> +       struct kernfs_node *kn;
> +
> +       kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
> +       WARN_ON_ONCE(!kn);

What's the purpose of the WARN_ON_ONCE? Just copied from the SCSI solution?
Can this ever happen?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
