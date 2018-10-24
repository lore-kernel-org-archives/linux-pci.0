Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D62BECDE46
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 23:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4F620831
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 23:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlsNmG1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4F620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeJYHt1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:49:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45990 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeJYHt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2018 03:49:27 -0400
Received: by mail-io1-f66.google.com with SMTP id p83-v6so4242012iod.12;
        Wed, 24 Oct 2018 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42eppa7ZiUt7ubGCh79zPi9jZZ3q+A4WVOavQTAEgwY=;
        b=IlsNmG1/ZNqVEZ5SIK41+KXdgo6ifOsINJdlAuxlXUXnUvQ1CS/9lfBYA/1DMT9276
         gxkwhVSyV7w6QL0LxEIPaQAmvdDBqRnmvXY7Mvg0IiZYrJlBZw4T76hkBauTi6B841wS
         5a2JJlqkq3PIhNOO6GzckjyVuiOiamNnbDOEpeAePHrstqjLHW7xgfVwMMgsrwCixZTh
         htFqYnn21qquU5RVHLLsZMoMNJzCoK5gSwPtfe5cVVsmnDVwpC0ucD83mpswFI37vcLG
         NaI/ZGPUBFNeqDI6lfqZVGxx77laHwdzwhWD+9QUg+wL6MK+uYTa5FzFYkCk4Gnly6aq
         2Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42eppa7ZiUt7ubGCh79zPi9jZZ3q+A4WVOavQTAEgwY=;
        b=M5C2iXoHSlzbhdZS5qQDXCILU3VzJVaQDvJKHfrMX5iZ7wZYO5ss1KpzunvFLqqIg/
         VgTdCDjYmWBlt3kT8eZ/VwfvzuEX6000nAGVEszLrJpYqedYVuLfWuIrizi6YWfo6Wc/
         cVNMjVNsqsU91Yut+gfNvguXZW308kdr881CUv25ilfMjIvPd6a029KovqjoK0QOVKfy
         wr2o/+beBEtVDst1Snwb+eSrPXOylhQGEVor8w85Cs47RrPwzJdiTk336PpaeABm2xwq
         0341T8sOaxVjsOyYCEkP53PRo4JU3jtNJ2LXQJiOjkcRsNM8e9yJXub8vJH/eKy8VVGJ
         4NDg==
X-Gm-Message-State: AGRZ1gKVZXJtrfiQjruLW4nJCY5de2QN9S7LTdS0Qayoo7R5UucIUOHQ
        exms6oj7nOZ7ler9fmC5TD9t2/Qn3mOiq2Wkd8Y=
X-Google-Smtp-Source: AJdET5eBtB9smJaQz+tXAHIVzUUPGm1GlsuV851ZBjYfsINK7B4qlnzKXknklBDp9A4Yfb2bvjbhCMgbuhT3xej6Bjs=
X-Received: by 2002:a6b:dc0c:: with SMTP id s12-v6mr14802585ioc.139.1540423162105;
 Wed, 24 Oct 2018 16:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <c2e8e3f0-ba97-ff9d-2496-3a4c09d257f0@amd.com> <C8C1ADA9-9247-4AB2-99EF-9C42CE467C17@canonical.com>
 <9BF2F852-DBAD-4947-81DE-919D061D5FB8@canonical.com> <20181024191427.GC214775@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181024191427.GC214775@bhelgaas-glaptop.roam.corp.google.com>
From:   Elie Morisse <syniurge@gmail.com>
Date:   Wed, 24 Oct 2018 20:19:10 -0300
Message-ID: <CAC_JBqppJXegEYUpF-x74dWT687jm6HsQ5ioq8eO1e98BY9Zhg@mail.gmail.com>
Subject: Re: [PATCH v3] i2c:amd I2C Driver based on PCI Interface for
 upcoming, platform
To:     helgaas@kernel.org
Cc:     kai.heng.feng@canonical.com, Nehal-bakulchandra.Shah@amd.com,
        linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I did some work to improve Shah's driver and make it work on laptops
where the two buses of the MP2 are enabled (e.g Lenovo Yoga
530-14ARR):

https://marc.info/?l=3Dlinux-i2c&m=3D154039677815809

v3 had some issues preventing both buses to work:

- enabling the second adapter (bus 1) was overriding amd_mp2_dev.ops
so events intended for the first adapter (bus 0) would be handled by
the second adapter
- in the interrupt handler checking whether the content of
AMD_P2C_MSG1 or AMD_P2C_MSG2 was !=3D zero to determine which bus the
IRQ was for was incorrect since they were not getting zero'd

Tomorrow I'll submit an updated patch that takes Bjorn's remarks that
still apply to my version into account.

Elie Morisse
Le mer. 24 oct. 2018 =C3=A0 16:16, Bjorn Helgaas <helgaas@kernel.org> a =C3=
=A9crit :
>
> On Thu, Oct 25, 2018 at 01:26:51AM +0800, Kai Heng Feng wrote:
> > > On Sep 17, 2018, at 16:19, Kai-Heng Feng <kai.heng.feng@canonical.com=
> wrote:
> > > at 18:54, Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com> =
wrote:
> > >
> > >> From: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
> > >>
> > >> This contains two drivers.
> > >> 1)i2c-amd-platdrv: This is based on I2C framework of
> > >> linux kernel. So any i2c read write call or commands
> > >> to this driver is routed to PCI Interface driver.
> > >> 2) i2c-amd-platdrv: This driver is responsible to
> > >> talk with Mp2 and does all C2P/P2C communication
> > >> or reading/writing from DRAM in case of more
> > >> data.
> > >>
> > >> Reviewed-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> > >> Reviewed-by: Sandeep Singh <sandeep.singh@amd.com>
> > >> Signed-off-by: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.=
com>
> > >
> > > The I2C touchpad on Latitude 5495 works with this patch.
> >
> > From PCI=E2=80=99s point of view, do you think this driver is good?
>
> Speaking for myself, I usually only review things that *change* the
> PCI core, not things like drivers that simply *use* the PCI core
> services.
>
> But since you made the mistake of asking, I do have a few comments
> below :)
>
> > >> --- /dev/null
> > >> +++ b/drivers/i2c/busses/i2c-amd-pci-mp2.c
> > >> @@ -0,0 +1,580 @@
> > >> +// SPDX-License-Identifier: GPL-2.0
> > >> +/*
> > >> + * Copyright (C) 2018 Advanced Micro Devices, Inc. All Rights Reser=
ved.
> > >> + *
> > >> + *
>
> Extra blank line above.
>
> > >> + * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > >> + * AMD PCIe MP2 Communication Driver
> > >> + */
> > >> +
> > >> +#include <linux/debugfs.h>
> > >> +#include <linux/interrupt.h>
> > >> +#include <linux/module.h>
> > >> +#include <linux/pci.h>
> > >> +#include <linux/slab.h>
> > >> +
> > >> +#include "i2c-amd-pci-mp2.h"
> > >> +
> > >> +#define DRIVER_NAME       "pcie_mp2_amd"
> > >> +#define DRIVER_DESC       "AMD(R) PCI-E MP2 Communication Driver"
>
> "PCIe" is the usual spelling.
>
> > >> +#define DRIVER_VER        "1.0"
> > >> +
> > >> +MODULE_DESCRIPTION(DRIVER_DESC);
> > >> +MODULE_VERSION(DRIVER_VER);
> > >> +MODULE_LICENSE("Dual BSD/GPL");
>
> This doesn't match the SPDX tag above.
> See https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/license-rules.rst
>
> > >> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> > >> +
> > >> +static const struct file_operations amd_mp2_debugfs_info;
> > >> +static struct dentry *debugfs_dir;
> > >> +
> > >> +int amd_mp2_connect(struct pci_dev *dev, struct i2c_config i2c_cfg)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D pci_get_drvdata(dev);
> > >> +  union i2c_cmd_base i2c_cmd_base;
> > >> +  unsigned  long  flags;
>
> Extra spaces in the "flags" declaration.
>
> > >> +
> > >> +  raw_spin_lock_irqsave(&privdata->lock, flags);
> > >> +  dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> > >> +          i2c_cfg.dev_addr, i2c_cfg.bus_id);
> > >> +
> > >> +  i2c_cmd_base.ul =3D 0;
> > >> +  i2c_cmd_base.s.i2c_cmd =3D i2c_enable;
> > >> +  i2c_cmd_base.s.bus_id =3D i2c_cfg.bus_id;
> > >> +  i2c_cmd_base.s.i2c_speed =3D i2c_cfg.i2c_speed;
> > >> +
> > >> +  if (i2c_cmd_base.s.bus_id =3D=3D i2c_bus_1) {
> > >> +          writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG1);
> > >> +  } else if (i2c_cmd_base.s.bus_id =3D=3D i2c_bus_0) {
> > >> +          writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> > >> +  } else {
> > >> +          dev_err(ndev_dev(privdata), "%s Invalid bus id\n", __func=
__);
> > >> +          return -EINVAL;
> > >> +  }
> > >> +  raw_spin_unlock_irqrestore(&privdata->lock, flags);
> > >> +  return 0;
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(amd_mp2_connect);
> > >> +
> > >> +int amd_mp2_read(struct pci_dev *dev, struct i2c_config i2c_cfg)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D pci_get_drvdata(dev);
> > >> +  union i2c_cmd_base i2c_cmd_base;
> > >> +
> > >> +  dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> > >> +          i2c_cfg.dev_addr, i2c_cfg.bus_id);
> > >> +
> > >> +  privdata->requested =3D true;
> > >> +  i2c_cmd_base.ul =3D 0;
> > >> +  i2c_cmd_base.s.i2c_cmd =3D i2c_read;
> > >> +  i2c_cmd_base.s.dev_addr =3D i2c_cfg.dev_addr;
> > >> +  i2c_cmd_base.s.length =3D i2c_cfg.length;
> > >> +  i2c_cmd_base.s.bus_id =3D i2c_cfg.bus_id;
>
> This block is repeated and could be factored out to a helper function
> (parameterized with i2c_read/i2c_write).
>
> > >> +
> > >> +  if (i2c_cfg.length <=3D 32) {
> > >> +          i2c_cmd_base.s.mem_type =3D use_c2pmsg;
> > >> +          privdata->eventval.buf =3D (u32 *)i2c_cfg.read_buf;
> > >> +          if (!privdata->eventval.buf) {
> > >> +                  dev_err(ndev_dev(privdata), "%s no mem for buf re=
ceived\n",
> > >> +                          __func__);
> > >> +                  return -ENOMEM;
> > >> +          }
> > >> +  } else {
> > >> +          i2c_cmd_base.s.mem_type =3D use_dram;
> > >> +          privdata->i2c_cfg.phy_addr =3D i2c_cfg.phy_addr;
> > >> +          privdata->i2c_cfg.read_buf =3D i2c_cfg.read_buf;
> > >> +          write64((u64)privdata->i2c_cfg.phy_addr,
> > >> +                  privdata->mmio + AMD_C2P_MSG2);
> > >> +  }
> > >> +
> > >> +  switch (i2c_cfg.i2c_speed) {
> > >> +  case 0:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed100k;
> > >> +          break;
> > >> +  case 1:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed400k;
> > >> +          break;
> > >> +  case 2:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed1000k;
> > >> +          break;
> > >> +  case 3:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed1400k;
> > >> +          break;
> > >> +  case 4:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed3400k;
> > >> +          break;
> > >> +  default:
> > >> +          dev_err(ndev_dev(privdata), "Invalid ConnectionSpeed\n");
> > >> +  }
>
> This switch statement is repeated below and could be factored out into
> a helper function.
>
> > >> +  if (i2c_cmd_base.s.bus_id =3D=3D i2c_bus_1) {
> > >> +          writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG1);
> > >> +  } else if (i2c_cmd_base.s.bus_id =3D=3D i2c_bus_0) {
> > >> +          writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> > >> +  } else {
> > >> +          dev_err(ndev_dev(privdata), "%s Invalid bus id\n", __func=
__);
> > >> +          return -EINVAL;
> > >> +  }
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(amd_mp2_read);
> > >> +
> > >> +int amd_mp2_write(struct pci_dev *dev, struct i2c_config i2c_cfg)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D pci_get_drvdata(dev);
> > >> +  union i2c_cmd_base i2c_cmd_base;
> > >> +  int i =3D 0;
>
> This initialization is unnecessary.
>
> > >> +  privdata->requested =3D true;
> > >> +  dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> > >> +          i2c_cfg.dev_addr, i2c_cfg.bus_id);
> > >> +
> > >> +  i2c_cmd_base.ul =3D 0;
> > >> +  i2c_cmd_base.s.i2c_cmd =3D i2c_write;
> > >> +  i2c_cmd_base.s.dev_addr =3D i2c_cfg.dev_addr;
> > >> +  i2c_cmd_base.s.length =3D i2c_cfg.length;
> > >> +  i2c_cmd_base.s.bus_id =3D i2c_cfg.bus_id;
> > >> +
> > >> +  switch (i2c_cfg.i2c_speed) {
> > >> +  case 0:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed100k;
> > >> +          break;
> > >> +  case 1:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed400k;
> > >> +          break;
> > >> +  case 2:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed1000k;
> > >> +          break;
> > >> +  case 3:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed1400k;
> > >> +          break;
> > >> +  case 4:
> > >> +          i2c_cmd_base.s.i2c_speed =3D speed3400k;
> > >> +          break;
> > >> +  default:
> > >> +          dev_err(ndev_dev(privdata), "Invalid ConnectionSpeed\n");
> > >> +  }
> > >> +
> > >> +  if (i2c_cfg.length <=3D 32) {
> > >> +          i2c_cmd_base.s.mem_type =3D use_c2pmsg;
> > >> +          for (i =3D 0; i < ((i2c_cfg.length + 3) / 4); i++) {
> > >> +                  writel(i2c_cfg.write_buf[i],
> > >> +                         privdata->mmio + (AMD_C2P_MSG2 + i * 4));
> > >> +          }
> > >> +  } else {
> > >> +          i2c_cmd_base.s.mem_type =3D use_dram;
> > >> +          privdata->i2c_cfg.phy_addr =3D i2c_cfg.phy_addr;
> > >> +          write64((u64)privdata->i2c_cfg.phy_addr,
> > >> +                  privdata->mmio + AMD_C2P_MSG2);
> > >> +  }
> > >> +
> > >> +  if (i2c_cmd_base.s.bus_id =3D=3D i2c_bus_1) {
> > >> +          writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG1);
> > >> +  } else if (i2c_cmd_base.s.bus_id =3D=3D i2c_bus_0) {
> > >> +          writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> > >> +  } else {
> > >> +          dev_err(ndev_dev(privdata), "%s Invalid bus id\n", __func=
__);
> > >> +          return -EINVAL;
> > >> +  }
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(amd_mp2_write);
> > >> +
> > >> +int amd_i2c_register_cb(struct pci_dev *dev, const struct amd_i2c_p=
ci_ops *ops,
> > >> +                  void *dev_ctx)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D pci_get_drvdata(dev);
> > >> +
> > >> +  privdata->ops =3D ops;
> > >> +  privdata->i2c_dev_ctx =3D dev_ctx;
> > >> +
> > >> +  if (!privdata->ops || !privdata->i2c_dev_ctx)
> > >> +          return -EINVAL;
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(amd_i2c_register_cb);
> > >> +
> > >> +static void amd_mp2_pci_work(struct work_struct *work)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D mp2_dev(work);
> > >> +  u32 readdata =3D 0;
> > >> +  int i =3D 0;
>
> The above two initializations (readdata, i) are unnecessary.
>
> > >> +  int sts =3D privdata->eventval.base.r.status;
> > >> +  int res =3D privdata->eventval.base.r.response;
> > >> +  int len =3D privdata->eventval.base.r.length;
> > >> +
> > >> +  if (res =3D=3D command_success && sts =3D=3D i2c_readcomplete_eve=
nt) {
> > >> +          if (privdata->ops->read_complete) {
> > >> +                  if (len <=3D 32) {
> > >> +                          for (i =3D 0; i < ((len + 3) / 4); i++) {
> > >> +                                  readdata =3D readl(privdata->mmio=
 +
> > >> +                                                  (AMD_C2P_MSG2 + i=
 * 4));
> > >> +                                  privdata->eventval.buf[i] =3D rea=
ddata;
> > >> +                          }
> > >> +                          privdata->ops->read_complete(privdata->ev=
entval,
> > >> +                                          privdata->i2c_dev_ctx);
> > >> +                  } else {
> > >> +                          privdata->ops->read_complete(privdata->ev=
entval,
> > >> +                                          privdata->i2c_dev_ctx);
> > >> +                  }
> > >> +          }
> > >> +  } else if (res =3D=3D command_success && sts =3D=3D i2c_writecomp=
lete_event) {
> > >> +          if (privdata->ops->write_complete)
> > >> +                  privdata->ops->write_complete(privdata->eventval,
> > >> +                                  privdata->i2c_dev_ctx);
> > >> +  } else if (res =3D=3D command_success && sts =3D=3D i2c_busenable=
_complete) {
> > >> +          if (privdata->ops->connect_complete)
> > >> +                  privdata->ops->connect_complete(privdata->eventva=
l,
> > >> +                                  privdata->i2c_dev_ctx);
> > >> +  } else {
> > >> +          dev_err(ndev_dev(privdata), "ERROR!!nothing to be handled=
 !\n");
> > >> +  }
> > >> +}
> > >> +
> > >> +static irqreturn_t amd_mp2_irq_isr(int irq, void *dev)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D dev;
> > >> +  u32 val =3D 0;
>
> This initialization is unnecessary.
>
> > >> +  unsigned long  flags;
>
> Extra space before "flags".
>
> > >> +
> > >> +  raw_spin_lock_irqsave(&privdata->lock, flags);
> > >> +  val =3D readl(privdata->mmio + AMD_P2C_MSG1);
> > >> +  if (val !=3D 0) {
> > >> +          writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> > >> +          privdata->eventval.base.ul =3D val;
> > >> +  } else {
> > >> +          val =3D readl(privdata->mmio + AMD_P2C_MSG2);
> > >> +          if (val !=3D 0) {
> > >> +                  writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> > >> +                  privdata->eventval.base.ul =3D val;
> > >> +          }
> > >> +  }
> > >> +
> > >> +  raw_spin_unlock_irqrestore(&privdata->lock, flags);
> > >> +  if (!privdata->ops)
> > >> +          return IRQ_NONE;
> > >> +
> > >> +  if (!privdata->requested)
> > >> +          return IRQ_HANDLED;
> > >> +
> > >> +  privdata->requested =3D false;
> > >> +  schedule_delayed_work(&privdata->work, 0);
> > >> +
> > >> +  return IRQ_HANDLED;
> > >> +}
> > >> +
> > >> +static ssize_t amd_mp2_debugfs_read(struct file *filp, char __user =
*ubuf,
> > >> +                              size_t count, loff_t *offp)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata;
> > >> +  void __iomem *mmio;
> > >> +  u8 *buf;
> > >> +  u32 data;
> > >> +  size_t buf_size;
> > >> +  ssize_t ret, off;
> > >> +
> > >> +  privdata =3D filp->private_data;
> > >> +  mmio =3D privdata->mmio;
> > >> +  buf_size =3D min(count, 0x800ul);
> > >> +  buf =3D kmalloc(buf_size, GFP_KERNEL);
> > >> +
> > >> +  if (!buf)
> > >> +          return -ENOMEM;
> > >> +
> > >> +  off =3D 0;
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "Mp2 Device Information:\n");
> > >> +
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n");
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "\tMP2 C2P Message Register Dump:\n\n");
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG0);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG0 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG1);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG1 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG2);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG2 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG3);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG3 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG4);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG4 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG5);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG5 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG6);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG6 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG7);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG7 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG8);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG8 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_C2P_MSG9);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_C2P_MSG9 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "\n\tMP2 P2C Message Register Dump:\n\n");
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_P2C_MSG1);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_P2C_MSG1 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_P2C_MSG2);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_P2C_MSG2 -\t\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_P2C_MSG_INTEN);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_P2C_MSG_INTEN -\t\t%#06x\n", data);
> > >> +
> > >> +  data =3D readl(privdata->mmio + AMD_P2C_MSG_INTSTS);
> > >> +  off +=3D scnprintf(buf + off, buf_size - off,
> > >> +                  "AMD_P2C_MSG_INTSTS -\t\t%#06x\n", data);
> > >> +
> > >> +  ret =3D simple_read_from_buffer(ubuf, count, offp, buf, off);
> > >> +  kfree(buf);
> > >> +  return ret;
> > >> +}
> > >> +
> > >> +static void amd_mp2_init_debugfs(struct amd_mp2_dev *privdata)
> > >> +{
> > >> +  if (!debugfs_dir) {
> > >> +          privdata->debugfs_dir =3D NULL;
> > >> +          privdata->debugfs_info =3D NULL;
>
> Just return here and unindent the following block, like this:
>
>   if (!debugfs_dir) {
>     ...
>     return;
>   }
>
>   privdata->debugfs_dir =3D ...
>
> > >> +  } else {
> > >> +          privdata->debugfs_dir =3D debugfs_create_dir(ndev_name(pr=
ivdata),
> > >> +                                                     debugfs_dir);
> > >> +          if (!privdata->debugfs_dir) {
> > >> +                  privdata->debugfs_info =3D NULL;
> > >> +          } else {
> > >> +                  privdata->debugfs_info =3D debugfs_create_file
> > >> +                          ("info", 0400, privdata->debugfs_dir,
> > >> +                                  privdata, &amd_mp2_debugfs_info);
> > >> +          }
> > >> +  }
> > >> +}
> > >> +
> > >> +static void amd_mp2_deinit_debugfs(struct amd_mp2_dev *privdata)
> > >> +{
> > >> +  debugfs_remove_recursive(privdata->debugfs_dir);
> > >> +}
> > >> +
> > >> +static void amd_mp2_clear_reg(struct amd_mp2_dev *privdata)
> > >> +{
> > >> +  int reg =3D 0;
>
> Unnecessary initialization.
>
> > >> +
> > >> +  for (reg =3D AMD_C2P_MSG0; reg <=3D AMD_C2P_MSG9; reg +=3D 4)
> > >> +          writel(0, privdata->mmio + reg);
> > >> +
> > >> +  for (reg =3D AMD_P2C_MSG0; reg <=3D AMD_P2C_MSG2; reg +=3D 4)
> > >> +          writel(0, privdata->mmio + reg);
> > >> +}
> > >> +
> > >> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pc=
i_dev *pdev)
> > >> +{
> > >> +  int rc;
> > >> +  int bar_index =3D 2;
>
> Better to hardcode "2" at the point where bar_index used so the reader
> doesn't have to scan back up to the top of the function to see which
> it is.
>
> > >> +  resource_size_t size, base;
> > >> +
> > >> +  pci_set_drvdata(pdev, privdata);
> > >> +
> > >> +  rc =3D pci_enable_device(pdev);
> > >> +  if (rc)
> > >> +          goto err_pci_enable;
> > >> +
> > >> +  rc =3D pci_request_regions(pdev, DRIVER_NAME);
> > >> +  if (rc)
> > >> +          goto err_pci_regions;
> > >> +
> > >> +  pci_set_master(pdev);
> > >> +
> > >> +  rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> > >> +  if (rc) {
> > >> +          rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> > >> +          if (rc)
> > >> +                  goto err_dma_mask;
> > >> +          dev_warn(ndev_dev(privdata), "Cannot DMA highmem\n");
> > >> +  }
> > >> +
> > >> +  rc =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> > >> +  if (rc) {
> > >> +          rc =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)=
);
> > >> +          if (rc)
> > >> +                  goto err_dma_mask;
> > >> +          dev_warn(ndev_dev(privdata), "Cannot DMA consistent highm=
em\n");
> > >> +  }
> > >> +
> > >> +  base =3D pci_resource_start(pdev, bar_index);
> > >> +  size =3D pci_resource_len(pdev, bar_index);
> > >> +
> > >> +  privdata->mmio =3D ioremap(base, size);
> > >> +  if (!privdata->mmio) {
> > >> +          rc =3D -EIO;
> > >> +          goto err_dma_mask;
> > >> +  }
> > >> +
> > >> +  /* Try to set up intx irq */
> > >> +  pci_intx(pdev, 1);
> > >> +  privdata->eventval.buf =3D NULL;
> > >> +  privdata->requested =3D false;
> > >> +  raw_spin_lock_init(&privdata->lock);
> > >> +  rc =3D request_irq(pdev->irq, amd_mp2_irq_isr, IRQF_SHARED, "mp2_=
irq_isr",
> > >> +                   privdata);
> > >> +  if (rc)
> > >> +          goto err_intx_request;
> > >> +
> > >> +  return 0;
> > >> +
> > >> +err_intx_request:
> > >> +  return rc;
> > >> +err_dma_mask:
> > >> +  pci_clear_master(pdev);
> > >> +  pci_release_regions(pdev);
> > >> +err_pci_regions:
> > >> +  pci_disable_device(pdev);
> > >> +err_pci_enable:
> > >> +  pci_set_drvdata(pdev, NULL);
> > >> +  return rc;
> > >> +}
> > >> +
> > >> +static void amd_mp2_pci_deinit(struct amd_mp2_dev *privdata)
> > >> +{
> > >> +  struct pci_dev *pdev =3D ndev_pdev(privdata);
> > >> +
> > >> +  pci_iounmap(pdev, privdata->mmio);
> > >> +
> > >> +  pci_clear_master(pdev);
> > >> +  pci_release_regions(pdev);
> > >> +  pci_disable_device(pdev);
> > >> +  pci_set_drvdata(pdev, NULL);
> > >> +}
> > >> +
> > >> +static int amd_mp2_pci_probe(struct pci_dev *pdev,
> > >> +                       const struct pci_device_id *id)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata;
> > >> +  int rc;
> > >> +
> > >> +  dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> > >> +           (int)pdev->vendor, (int)pdev->device, (int)pdev->revisio=
n);
> > >> +
> > >> +  privdata =3D kzalloc(sizeof(*privdata), GFP_KERNEL);
> > >> +  privdata->pdev =3D pdev;
> > >> +
> > >> +  if (!privdata) {
> > >> +          rc =3D -ENOMEM;
> > >> +          goto err_dev;
> > >> +  }
> > >> +
> > >> +  rc =3D amd_mp2_pci_init(privdata, pdev);
> > >> +  if (rc)
> > >> +          goto err_pci_init;
> > >> +  dev_dbg(&pdev->dev, "pci init done.\n");
> > >> +
> > >> +  INIT_DELAYED_WORK(&privdata->work, amd_mp2_pci_work);
> > >> +
> > >> +  amd_mp2_init_debugfs(privdata);
> > >> +  dev_info(&pdev->dev, "MP2 device registered.\n");
> > >> +  return 0;
> > >> +
> > >> +err_pci_init:
> > >> +  kfree(privdata);
> > >> +err_dev:
> > >> +  dev_err(&pdev->dev, "Memory Allocation Failed\n");
> > >> +  return rc;
> > >> +}
> > >> +
> > >> +static void amd_mp2_pci_remove(struct pci_dev *pdev)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> > >> +
> > >> +  amd_mp2_deinit_debugfs(privdata);
> > >> +  amd_mp2_clear_reg(privdata);
> > >> +  cancel_delayed_work_sync(&privdata->work);
> > >> +  free_irq(pdev->irq, privdata);
> > >> +  pci_intx(pdev, 0);
> > >> +  amd_mp2_pci_deinit(privdata);
> > >> +  kfree(privdata);
> > >> +}
> > >> +
> > >> +static const struct file_operations amd_mp2_debugfs_info =3D {
> > >> +  .owner =3D THIS_MODULE,
> > >> +  .open =3D simple_open,
> > >> +  .read =3D amd_mp2_debugfs_read,
> > >> +};
> > >> +
> > >> +static const struct pci_device_id amd_mp2_pci_tbl[] =3D {
> > >> +  {PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> > >> +  {0}
> > >> +};
> > >> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> > >> +
> > >> +#ifdef CONFIG_PM_SLEEP
> > >> +static int amd_mp2_pci_device_suspend(struct pci_dev *pdev, pm_mess=
age_t mesg)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> > >> +
> > >> +  if (!privdata)
> > >> +          return -EINVAL;
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int amd_mp2_pci_device_resume(struct pci_dev *pdev)
> > >> +{
> > >> +  struct amd_mp2_dev *privdata =3D pci_get_drvdata(pdev);
> > >> +
> > >> +  if (!privdata)
> > >> +          return -EINVAL;
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +#endif
> > >> +
> > >> +static struct pci_driver amd_mp2_pci_driver =3D {
> > >> +  .name           =3D DRIVER_NAME,
> > >> +  .id_table       =3D amd_mp2_pci_tbl,
> > >> +  .probe          =3D amd_mp2_pci_probe,
> > >> +  .remove         =3D amd_mp2_pci_remove,
> > >> +#ifdef CONFIG_PM_SLEEP
> > >> +  .suspend                =3D amd_mp2_pci_device_suspend,
> > >> +  .resume                 =3D amd_mp2_pci_device_resume,
> > >> +#endif
> > >> +};
> > >> +
> > >> +static int __init amd_mp2_pci_driver_init(void)
> > >> +{
> > >> +  pr_info("%s: %s Version: %s\n", DRIVER_NAME, DRIVER_DESC, DRIVER_=
VER);
>
> This sort of thing is annoying because if this driver is built into
> the kernel statically (not as a module), it *always* prints stuff,
> regardless of whether the device is present.  There *are* examples
> of that in the kernel, but I don't think they're good examples to
> follow.
>
> For example, I get the following useless messages on my laptop despite
> the fact that they apparently only apply to IBM xSeries x366 and x460
> systems.  I think this is just anti-social.
>
>   Calgary: detecting Calgary via BIOS EBDA area
>   Calgary: Unable to locate Rio Grande table in EBDA - bailing!
>
> If you need the driver name/desc/ver, you can always print it in
> amd_mp2_pci_probe() (just the first time through).
>
> > >> +
> > >> +  if (debugfs_initialized())
> > >> +          debugfs_dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> > >> +
> > >> +  return pci_register_driver(&amd_mp2_pci_driver);
> > >> +}
> > >> +module_init(amd_mp2_pci_driver_init);
> > >> +
> > >> +static void __exit amd_mp2_pci_driver_exit(void)
> > >> +{
> > >> +  pci_unregister_driver(&amd_mp2_pci_driver);
> > >> +  debugfs_remove_recursive(debugfs_dir);
> > >> +}
> > >> +module_exit(amd_mp2_pci_driver_exit);
> > >> diff --git a/drivers/i2c/busses/i2c-amd-pci-mp2.h b/drivers/i2c/buss=
es/i2c-amd-pci-mp2.h
> > >> new file mode 100644
> > >> index 0000000..787484e
> > >> --- /dev/null
> > >> +++ b/drivers/i2c/busses/i2c-amd-pci-mp2.h
> > >> @@ -0,0 +1,196 @@
> > >> +/* SPDX-License-Identifier: GPL-2.0
>
> Doesn't match the MODULE_LICENSE in the .c files.
>
> > >> + *
> > >> + * Copyright (C) 2018 Advanced Micro Devices, Inc. All Rights Reser=
ved
> > >> + *
> > >> + * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > >> + * AMD PCIe MP2 Communication Interface Driver
> > >> + */
> > >> +
> > >> +#ifndef I2C_AMD_PCI_MP2_H
> > >> +#define I2C_AMD_PCI_MP2_H
> > >> +
> > >> +#include <linux/pci.h>
> > >> +
> > >> +#define PCI_DEVICE_ID_AMD_MP2     0x15E6
> > >> +
> > >> +#define write64 _write64
> > >> +static inline void _write64(u64 val, void __iomem *mmio)
> > >> +{
> > >> +  writel(val, mmio);
> > >> +  writel(val >> 32, mmio + sizeof(u32));
> > >> +}
> > >> +
> > >> +#define read64 _read64
> > >> +static inline u64 _read64(void __iomem *mmio)
> > >> +{
> > >> +  u64 low, high;
> > >> +
> > >> +  low =3D readl(mmio);
> > >> +  high =3D readl(mmio + sizeof(u32));
> > >> +  return low | (high << 32);
> > >> +}
> > >> +
> > >> +enum {
> > >> +  /* MP2 C2P Message Registers */
> > >> +  AMD_C2P_MSG0 =3D 0x10500, /*MP2 Message for I2C0*/
>
> Generally people use a space after "/*" and another before "*/".
> You should at least be consistent for all your comments (some of them
> have the spaces and some don't).
>
> > >> +  AMD_C2P_MSG1 =3D 0x10504, /*MP2 Message for I2C1*/
> > >> +  AMD_C2P_MSG2 =3D 0x10508, /*DRAM Address Lo / Data 0*/
> > >> +  AMD_C2P_MSG3 =3D 0x1050c, /*DRAM Address HI / Data 1*/
> > >> +  AMD_C2P_MSG4 =3D 0x10510, /*Data 2*/
> > >> +  AMD_C2P_MSG5 =3D 0x10514, /*Data 3*/
> > >> +  AMD_C2P_MSG6 =3D 0x10518, /*Data 4*/
> > >> +  AMD_C2P_MSG7 =3D 0x1051c, /*Data 5*/
> > >> +  AMD_C2P_MSG8 =3D 0x10520, /*Data 6*/
> > >> +  AMD_C2P_MSG9 =3D 0x10524, /*Data 7*/
> > >> +
> > >> +  /* MP2 P2C Message Registers */
> > >> +  AMD_P2C_MSG0 =3D 0x10680, /*Do not use*/
> > >> +  AMD_P2C_MSG1 =3D 0x10684, /*I2c0 int reg*/
> > >> +  AMD_P2C_MSG2 =3D 0x10688, /*I2c1 int reg*/
> > >> +  AMD_P2C_MSG3 =3D 0x1068C, /*MP2 debug info*/
> > >> +  AMD_P2C_MSG_INTEN =3D 0x10690, /*MP2 int gen register*/
> > >> +  AMD_P2C_MSG_INTSTS =3D 0x10694, /*Interrupt sts*/
> > >> +};
> > >> +
> > >> +/* Command register data structures */
> > >> +
> > >> +enum i2c_cmd {
> > >> +  i2c_read,
> > >> +  i2c_write,
> > >> +  i2c_enable,
> > >> +  i2c_disable,
> > >> +  number_of_sensor_discovered,
> > >> +  is_mp2_active,
> > >> +  invalid_cmd =3D 0xF,
> > >> +};
> > >> +
> > >> +enum i2c_bus_index {
> > >> +  i2c_bus_0 =3D 0,
> > >> +  i2c_bus_1 =3D 1,
> > >> +  i2c_bus_max
> > >> +};
> > >> +
> > >> +enum speed_enum {
> > >> +  speed100k =3D 0,
> > >> +  speed400k =3D 1,
> > >> +  speed1000k =3D 2,
> > >> +  speed1400k =3D 3,
> > >> +  speed3400k =3D 4
> > >> +};
> > >> +
> > >> +enum mem_type {
> > >> +  use_dram =3D 0,
> > >> +  use_c2pmsg =3D 1,
> > >> +};
> > >> +
> > >> +union i2c_cmd_base {
> > >> +  u32 ul;
> > >> +  struct {
> > >> +          enum i2c_cmd i2c_cmd : 4; /*!< bit: 0..3 i2c R/W command =
*/
> > >> +          enum i2c_bus_index bus_id : 4; /*!< bit: 4..7 i2c bus ind=
ex */
> > >> +          u32 dev_addr : 8; /*!< bit: 8..15 device address or Bus S=
peed*/
> > >> +          u32 length : 12; /*!< bit: 16..29 read/write length */
> > >> +          enum speed_enum i2c_speed : 3; /*!< bit: 30 register addr=
ess*/
> > >> +          enum mem_type mem_type : 1; /*!< bit: 15 mem type*/
> > >> +  } s; /*!< Structure used for bit access */
> > >> +};
> > >> +
> > >> +/* Response register data structures */
> > >> +
> > >> +/*Response - Response of SFI*/
> > >> +enum response_type {
> > >> +  invalid_response =3D 0,
> > >> +  command_success =3D 1,
> > >> +  command_failed =3D 2,
> > >> +};
> > >> +
> > >> +/*Status - Command ID to indicate a command*/
> > >> +enum status_type {
> > >> +  i2c_readcomplete_event =3D 0,
> > >> +  i2c_readfail_event =3D 1,
> > >> +  i2c_writecomplete_event =3D 2,
> > >> +  i2c_writefail_event =3D 3,
> > >> +  i2c_busenable_complete =3D 4,
> > >> +  i2c_busenable_failed =3D 5,
> > >> +  i2c_busdisable_complete =3D 6,
> > >> +  i2c_busdisable_failed =3D 7,
> > >> +  invalid_data_length =3D 8,
> > >> +  invalid_slave_address =3D 9,
> > >> +  invalid_i2cbus_id =3D 10,
> > >> +  invalid_dram_addr =3D 11,
> > >> +  invalid_command =3D 12,
> > >> +  mp2_active =3D 13,
> > >> +  numberof_sensors_discovered_resp =3D 14,
> > >> +  i2C_bus_notinitialized
> > >> +};
> > >> +
> > >> +struct i2c_event {
> > >> +  union {
> > >> +          u32 ul;
> > >> +          struct {
> > >> +                  enum response_type response : 2; /*!< bit: 0..1 I=
2C res type */
> > >> +                  enum status_type status : 5; /*!< bit: 2..6 statu=
s_type */
> > >> +                  enum mem_type mem_type : 1; /*!< bit: 7 0-DRAM;1-=
 C2PMsg o/p */
> > >> +                  enum i2c_bus_index bus_id : 4; /*!< bit: 8..11 I2=
C Bus ID */
> > >> +                  u32 length : 12; /*!< bit:16..29 length */
> > >> +                  u32 slave_addr : 8; /*!< bit: 15 debug msg includ=
e in p2c msg */
> > >> +          } r; /*!< Structure used for bit access */
> > >> +  } base;
> > >> +  u32 *buf;
> > >> +};
> > >> +
> > >> +/* data structures for communication with I2c*/
> > >> +
> > >> +struct i2c_config {
> > >> +  enum i2c_bus_index bus_id;
> > >> +  u64 i2c_speed;
> > >> +  u16 dev_addr;
> > >> +  u32 length;
> > >> +  phys_addr_t phy_addr;
> > >> +  u8 *read_buf;
> > >> +  u32 *write_buf;
> > >> +};
> > >> +
> > >> +/* struct to send/receive data b/w pci and i2c drivers*/
> > >> +struct amd_i2c_pci_ops {
> > >> +  int (*read_complete)(struct i2c_event event, void *dev_ctx);
> > >> +  int (*write_complete)(struct i2c_event event, void *dev_ctx);
> > >> +  int (*connect_complete)(struct i2c_event event, void *dev_ctx);
> > >> +};
> > >> +
> > >> +struct amd_i2c_common {
> > >> +  struct i2c_config i2c_cfg;
> > >> +  const struct amd_i2c_pci_ops *ops;
> > >> +  struct pci_dev *pdev;
> > >> +};
> > >> +
> > >> +struct amd_mp2_dev {
> > >> +  struct pci_dev *pdev;
> > >> +  struct dentry *debugfs_dir;
> > >> +  struct dentry *debugfs_info;
> > >> +  void __iomem *mmio;
> > >> +  struct i2c_event eventval;
> > >> +  enum i2c_cmd reqcmd;
> > >> +  struct i2c_config i2c_cfg;
> > >> +  union i2c_cmd_base i2c_cmd_base;
> > >> +  const struct amd_i2c_pci_ops *ops;
> > >> +  struct delayed_work work;
> > >> +  void *i2c_dev_ctx;
> > >> +  bool requested;
> > >> +  raw_spinlock_t lock;
> > >> +};
> > >> +
> > >> +int amd_mp2_read(struct pci_dev *pdev, struct i2c_config i2c_cfg);
> > >> +int amd_mp2_write(struct pci_dev *pdev,
> > >> +            struct i2c_config i2c_cfg);
> > >> +int amd_mp2_connect(struct pci_dev *pdev,
> > >> +              struct i2c_config i2c_cfg);
> > >> +int amd_i2c_register_cb(struct pci_dev *pdev, const struct amd_i2c_=
pci_ops *ops,
> > >> +                  void *dev_ctx);
> > >> +
> > >> +#define ndev_pdev(ndev) ((ndev)->pdev)
> > >> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> > >> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> > >> +#define mp2_dev(__work) container_of(__work, struct amd_mp2_dev, wo=
rk.work)
> > >> +
> > >> +#endif
> > >> diff --git a/drivers/i2c/busses/i2c-amd-platdrv.c b/drivers/i2c/buss=
es/i2c-amd-platdrv.c
> > >> new file mode 100644
> > >> index 0000000..95e3b37
> > >> --- /dev/null
> > >> +++ b/drivers/i2c/busses/i2c-amd-platdrv.c
> > >> @@ -0,0 +1,277 @@
> > >> +// SPDX-License-Identifier: GPL-2.0
>
> Doesn't match MODULE_LICENSE.
>
> > >> +/*
> > >> + *
> > >> + * Copyright (C) 2018 Advanced Micro Devices, Inc. All Rights Reser=
ved.
> > >> + *
> > >> + *
>
> Extra blank lines above.
>
> > >> + * Author: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com=
>
> > >> + * AMD I2C Platform Driver
> > >> + */
> > >> +
> > >> +#include <linux/kernel.h>
> > >> +#include <linux/module.h>
> > >> +#include <linux/types.h>
> > >> +#include <linux/slab.h>
> > >> +#include <linux/i2c.h>
> > >> +#include <linux/platform_device.h>
> > >> +#include <linux/dma-mapping.h>
> > >> +#include <linux/acpi.h>
> > >> +#include <linux/delay.h>
> > >> +#include "i2c-amd-pci-mp2.h"
> > >> +
> > >> +struct amd_i2c_dev {
> > >> +  struct platform_device *pdev;
> > >> +  struct i2c_adapter adapter;
> > >> +  struct amd_i2c_common i2c_common;
> > >> +  struct completion msg_complete;
> > >> +  struct i2c_msg *msg_buf;
> > >> +  bool is_configured;
> > >> +  u8 bus_id;
> > >> +  u8 *buf;
> > >> +};
> > >> +
> > >> +static int i2c_amd_read_completion(struct i2c_event event, void *de=
v_ctx)
> > >> +{
> > >> +  struct amd_i2c_dev *i2c_dev =3D (struct amd_i2c_dev *)dev_ctx;
>
> I don't think this cast is necessary.
>
> > >> +  struct amd_i2c_common *commond =3D &i2c_dev->i2c_common;
> > >> +  int i =3D 0;
>
> Unnecessary initialization.
>
> > >> +
> > >> +  if (event.base.r.status =3D=3D i2c_readcomplete_event) {
> > >> +          if (event.base.r.length <=3D 32) {
> > >> +                  pr_devel(" in %s i2c_dev->msg_buf :%p\n",
> > >> +                           __func__, i2c_dev->msg_buf);
> > >> +
> > >> +                  memcpy(i2c_dev->msg_buf->buf,
> > >> +                         (unsigned char *)event.buf, event.base.r.l=
ength);
> > >> +
> > >> +                  for (i =3D 0; i < ((event.base.r.length + 3) / 4)=
; i++)
> > >> +                          pr_devel("%s: readdata:%x\n",
> > >> +                                   __func__, event.buf[i]);
> > >> +
> > >> +          } else {
> > >> +                  memcpy(i2c_dev->msg_buf->buf,
> > >> +                         (unsigned char *)commond->i2c_cfg.read_buf=
,
> > >> +                          event.base.r.length);
> > >> +
> > >> +                  for (i =3D 0; i < ((event.base.r.length + 3) / 4)=
; i++)
> > >> +                          pr_devel("%s: readdata:%x\n", __func__,
> > >> +                                   ((unsigned int *)commond->i2c_cf=
g.read_buf)[i]);
> > >> +          }
> > >> +
> > >> +                          complete(&i2c_dev->msg_complete);
> > >> +  }
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int i2c_amd_write_completion(struct i2c_event event, void *d=
ev_ctx)
> > >> +{
> > >> +  struct amd_i2c_dev *i2c_dev =3D (struct amd_i2c_dev *)dev_ctx;
>
> Unnecessary cast.
>
> > >> +
> > >> +  if (event.base.r.status =3D=3D i2c_writecomplete_event)
> > >> +                  complete(&i2c_dev->msg_complete);
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int i2c_amd_connect_completion(struct i2c_event event, void =
*dev_ctx)
> > >> +{
> > >> +  struct amd_i2c_dev *i2c_dev =3D (struct amd_i2c_dev *)dev_ctx;
>
> Unnecessary cast.
>
> > >> +
> > >> +  if (event.base.r.status =3D=3D i2c_busenable_complete)
> > >> +                  complete(&i2c_dev->msg_complete);
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static const struct amd_i2c_pci_ops data_handler =3D {
> > >> +          .read_complete =3D i2c_amd_read_completion,
> > >> +          .write_complete =3D i2c_amd_write_completion,
> > >> +          .connect_complete =3D i2c_amd_connect_completion,
> > >> +};
> > >> +
> > >> +static int i2c_amd_pci_configure(struct amd_i2c_dev *i2c_dev, int s=
laveaddr)
> > >> +{
> > >> +  struct amd_i2c_common *i2c_common =3D &i2c_dev->i2c_common;
> > >> +  int ret;
> > >> +
> > >> +  amd_i2c_register_cb(i2c_common->pdev, &data_handler, (void *)i2c_=
dev);
> > >> +  i2c_common->i2c_cfg.bus_id =3D i2c_dev->bus_id;
> > >> +  i2c_common->i2c_cfg.dev_addr =3D slaveaddr;
> > >> +  i2c_common->i2c_cfg.i2c_speed =3D speed400k;
> > >> +  ret =3D amd_mp2_connect(i2c_common->pdev, i2c_common->i2c_cfg);
> > >> +
> > >> +  if (ret)
> > >> +          return  -EIO;
> > >> +
> > >> +  mdelay(100);
>
> This deserves a comment about why the delay is needed.
>
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int i2c_amd_xfer(struct i2c_adapter *adap, struct i2c_msg *m=
sgs, int num)
> > >> +{
> > >> +  struct amd_i2c_dev *dev =3D i2c_get_adapdata(adap);
> > >> +  struct amd_i2c_common *i2c_common =3D &dev->i2c_common;
> > >> +
>
> Remove this blank line.
>
> > >> +  int i;
> > >> +  unsigned long timeout;
> > >> +  struct i2c_msg *pmsg;
> > >> +  unsigned char *dma_buf =3D NULL;
> > >> +  dma_addr_t phys;
> > >> +
> > >> +  reinit_completion(&dev->msg_complete);
> > >> +  if (dev->is_configured =3D=3D 0) {
> > >> +          i2c_amd_pci_configure(dev, msgs->addr);
> > >> +          timeout =3D wait_for_completion_timeout(&dev->msg_complet=
e, 50);
> > >> +          dev->is_configured =3D 1;
> > >> +  }
> > >> +
> > >> +  for (i =3D 0; i < num; i++) {
> > >> +          pmsg =3D &msgs[i];
> > >> +          i2c_common->i2c_cfg.length =3D pmsg->len;
> > >> +          if (pmsg->len > 32) {
> > >> +                  dma_buf =3D (u8 *)dma_alloc_coherent(&i2c_common-=
>pdev->dev,
> > >> +                                  pmsg->len, &phys, GFP_KERNEL);
> > >> +                  i2c_common->i2c_cfg.phy_addr =3D phys;
> > >> +          }
> > >> +
> > >> +          if (pmsg->flags & I2C_M_RD) {
> > >> +                  if (pmsg->len <=3D 32)
> > >> +                          i2c_common->i2c_cfg.read_buf =3D dev->buf=
;
> > >> +                  else
> > >> +                          i2c_common->i2c_cfg.read_buf =3D dma_buf;
> > >> +
> > >> +                  dev->msg_buf =3D pmsg;
> > >> +                  amd_mp2_read(i2c_common->pdev,
> > >> +                               i2c_common->i2c_cfg);
> > >> +
> > >> +          } else {
> > >> +                  if (pmsg->len <=3D 32)
> > >> +                          i2c_common->i2c_cfg.write_buf =3D (unsign=
ed int *)pmsg->buf;
> > >> +                  else
> > >> +                          i2c_common->i2c_cfg.write_buf =3D (unsign=
ed int *)dma_buf;
> > >> +
> > >> +                  amd_mp2_write(i2c_common->pdev,
> > >> +                                i2c_common->i2c_cfg);
> > >> +          }
> > >> +
> > >> +          timeout =3D wait_for_completion_timeout
> > >> +                                  (&dev->msg_complete, 50);
> > >> +          if (dma_buf)
> > >> +                  dma_free_coherent(&i2c_common->pdev->dev,
> > >> +                                    pmsg->len, dma_buf, phys);
> > >> +
> > >> +          if (timeout =3D=3D 0)
> > >> +                  return -ETIMEDOUT;
> > >> +  }
> > >> +  return num;
> > >> +}
> > >> +
> > >> +static u32 i2c_amd_func(struct i2c_adapter *a)
> > >> +{
> > >> +  return I2C_FUNC_I2C;
> > >> +}
> > >> +
> > >> +static const struct i2c_algorithm i2c_amd_algorithm =3D {
> > >> +  .master_xfer =3D i2c_amd_xfer,
> > >> +  .functionality =3D i2c_amd_func,
> > >> +};
> > >> +
> > >> +static int i2c_amd_probe(struct platform_device *pdev)
> > >> +{
> > >> +  int ret;
> > >> +  struct amd_i2c_dev *i2c_dev;
> > >> +  struct device *dev =3D &pdev->dev;
> > >> +  acpi_handle handle =3D ACPI_HANDLE(&pdev->dev);
> > >> +  struct acpi_device *adev;
> > >> +  const char *uid =3D NULL;
> > >> +
> > >> +  i2c_dev =3D devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
> > >> +  if (!i2c_dev)
> > >> +          return -ENOMEM;
> > >> +
> > >> +  i2c_dev->pdev =3D pdev;
> > >> +
> > >> +  if (!acpi_bus_get_device(handle, &adev)) {
> > >> +          pr_err(" i2c0  pdev->id=3D%s\n", adev->pnp.unique_id);
>
> All the printks here should be some form of dev_printk(), probably
> using the platform_device.  All driver printks should use dev_printk()
> so the messages can be associated with a specific device.
>
> > >> +          uid =3D adev->pnp.unique_id;
> > >> +  }
> > >> +
> > >> +  if (strcmp(uid, "0") =3D=3D 0) {
>
> This is unsafe: uid may be NULL here, and strcmp will dereference it.
>
> > >> +          pr_err(" bus id is 0\n");
> > >> +          i2c_dev->bus_id =3D 0;
> > >> +  }
> > >> +
> > >> +  pr_devel(" i2c1  pdev->id=3D%s\n", uid);
> > >> +  if (strcmp(uid, "1") =3D=3D 0) {
> > >> +          pr_err(" bus id is 1\n");
> > >> +          i2c_dev->bus_id =3D 1;
> > >> +  }
> > >> +  /* setup i2c adapter description */
> > >> +  i2c_dev->adapter.owner =3D THIS_MODULE;
> > >> +  i2c_dev->adapter.algo =3D &i2c_amd_algorithm;
> > >> +  i2c_dev->adapter.dev.parent =3D dev;
> > >> +  i2c_dev->adapter.algo_data =3D i2c_dev;
> > >> +  ACPI_COMPANION_SET(&i2c_dev->adapter.dev, ACPI_COMPANION(&pdev->d=
ev));
>
> I don't understand what's going on here.  You seem to be claiming
> AMDI0011 devices, but I can't see that you ever *do* anything with
> that.  I don't see any methods on that device being called or any
> information from the ACPI namespace being used.  What am I missing?
>
> > >> +  i2c_dev->adapter.dev.of_node =3D dev->of_node;
> > >> +  /*buffer for 32 bytes of read  data*/
>
> Extra space in "read  data", and not enough at beginning and end.
>
> > >> +  i2c_dev->buf =3D kzalloc(32, GFP_KERNEL);
> > >> +
> > >> +  if (!i2c_dev->buf)
> > >> +          return -ENOMEM;
> > >> +
> > >> +  snprintf(i2c_dev->adapter.name, sizeof(i2c_dev->adapter.name), "%=
s-%s",
> > >> +           "i2c_dev-i2c", dev_name(pdev->dev.parent));
> > >> +
> > >> +  i2c_dev->i2c_common.pdev =3D pci_get_device(PCI_VENDOR_ID_AMD,
> > >> +                                            PCI_DEVICE_ID_AMD_MP2, =
NULL);
>
> I really don't like this.  pci_get_device() basically subverts the PCI
> driver registration mechanism.  If a driver has claimed the MP2 device
> using pci_register_driver(), then *it* completely owns the device and
> no other code should touch it.  pci_get_device() is a way for
> arbitrary other code to get a pointer to the device and muck with it.
>
> In this case, I'm guessing the driver claiming the MP2 device is
> probably another piece of *this* driver, and you should have some
> mechanism internal to the driver to coordinate knowledge of the device
> and access to it.
>
> > >> +
> > >> +  if (!i2c_dev->i2c_common.pdev) {
> > >> +          pr_err("%s Could not find pdev in i2c\n", __func__);
> > >> +          return -EINVAL;
> > >> +  }
> > >> +  platform_set_drvdata(pdev, i2c_dev);
> > >> +  i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
> > >> +
> > >> +  init_completion(&i2c_dev->msg_complete);
> > >> +  /* and finally attach to i2c layer */
> > >> +  ret =3D i2c_add_adapter(&i2c_dev->adapter);
> > >> +
> > >> +  if (ret < 0)
> > >> +          pr_err(" i2c add adpater failed =3D%d", ret);
>
> s/adpater/adapter/
>
> > >> +
> > >> +  return ret;
> > >> +}
> > >> +
> > >> +static int i2c_amd_remove(struct platform_device *pdev)
> > >> +{
> > >> +  struct amd_i2c_dev *i2c_dev =3D platform_get_drvdata(pdev);
> > >> +
> > >> +  kfree(i2c_dev->buf);
> > >> +
> > >> +  i2c_del_adapter(&i2c_dev->adapter);
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static const struct acpi_device_id i2c_amd_acpi_match[] =3D {
> > >> +          { "AMDI0011" },
> > >> +          { },
> > >> +};
> > >> +
> > >> +static struct platform_driver amd_i2c_plat_driver =3D {
> > >> +          .probe =3D i2c_amd_probe,
> > >> +          .remove =3D i2c_amd_remove,
> > >> +          .driver =3D {
> > >> +                          .name =3D "i2c_amd_platdrv",
> > >> +                          .acpi_match_table =3D ACPI_PTR
> > >> +                                          (i2c_amd_acpi_match),
> > >> +          },
> > >> +};
> > >> +
> > >> +module_platform_driver(amd_i2c_plat_driver);
> > >> +
> > >> +MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
> > >> +MODULE_DESCRIPTION("AMD I2C Platform Driver");
> > >> +MODULE_LICENSE("Dual BSD/GPL");
> > >> --
> > >> 2.7.4
> > >
> > >
> >
