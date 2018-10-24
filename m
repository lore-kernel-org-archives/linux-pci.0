Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404EECDE46
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A002082F
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 19:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8ojvXPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A002082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJYDnr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYDnr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Oct 2018 23:43:47 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57032082F;
        Wed, 24 Oct 2018 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540408469;
        bh=yS7Km/ANb59iHDWPdWdhLJobDtKKa+jVvp/9HswiWww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8ojvXPZ4sG3Fr40OvAUy3kIUa8sB07QVdrweRksd0RXMf0Kluh/kj3Dg4ilJto0r
         OumRi7Pxv/Z9gIh5x9Lnq/9h9kPKym8cnfVEBSrTwgHMHVwlEeiuN+cpdvsZ3fZEof
         Uem3gkiYSp0XtnCE3hUnHtGHmaOaVqUWXOjMzG5k=
Date:   Wed, 24 Oct 2018 14:14:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        linux-i2c <linux-i2c@vger.kernel.org>, linux-pci@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Singh, Sandeep" <sandeep.singh@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] i2c:amd I2C Driver based on PCI Interface for
 upcoming, platform
Message-ID: <20181024191427.GC214775@bhelgaas-glaptop.roam.corp.google.com>
References: <c2e8e3f0-ba97-ff9d-2496-3a4c09d257f0@amd.com>
 <C8C1ADA9-9247-4AB2-99EF-9C42CE467C17@canonical.com>
 <9BF2F852-DBAD-4947-81DE-919D061D5FB8@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BF2F852-DBAD-4947-81DE-919D061D5FB8@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 25, 2018 at 01:26:51AM +0800, Kai Heng Feng wrote:
> > On Sep 17, 2018, at 16:19, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > at 18:54, Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com> wrote:
> > 
> >> From: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
> >> 
> >> This contains two drivers.
> >> 1)i2c-amd-platdrv: This is based on I2C framework of
> >> linux kernel. So any i2c read write call or commands
> >> to this driver is routed to PCI Interface driver.
> >> 2) i2c-amd-platdrv: This driver is responsible to
> >> talk with Mp2 and does all C2P/P2C communication
> >> or reading/writing from DRAM in case of more
> >> data.
> >> 
> >> Reviewed-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> >> Reviewed-by: Sandeep Singh <sandeep.singh@amd.com>
> >> Signed-off-by: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
> > 
> > The I2C touchpad on Latitude 5495 works with this patch.
> 
> From PCI’s point of view, do you think this driver is good?

Speaking for myself, I usually only review things that *change* the
PCI core, not things like drivers that simply *use* the PCI core
services.

But since you made the mistake of asking, I do have a few comments
below :)

> >> --- /dev/null
> >> +++ b/drivers/i2c/busses/i2c-amd-pci-mp2.c
> >> @@ -0,0 +1,580 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2018 Advanced Micro Devices, Inc. All Rights Reserved.
> >> + *
> >> + *

Extra blank line above.

> >> + * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> + * AMD PCIe MP2 Communication Driver
> >> + */
> >> +
> >> +#include <linux/debugfs.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include "i2c-amd-pci-mp2.h"
> >> +
> >> +#define DRIVER_NAME	"pcie_mp2_amd"
> >> +#define DRIVER_DESC	"AMD(R) PCI-E MP2 Communication Driver"

"PCIe" is the usual spelling.

> >> +#define DRIVER_VER	"1.0"
> >> +
> >> +MODULE_DESCRIPTION(DRIVER_DESC);
> >> +MODULE_VERSION(DRIVER_VER);
> >> +MODULE_LICENSE("Dual BSD/GPL");

This doesn't match the SPDX tag above.
See https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

> >> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> >> +
> >> +static const struct file_operations amd_mp2_debugfs_info;
> >> +static struct dentry *debugfs_dir;
> >> +
> >> +int amd_mp2_connect(struct pci_dev *dev, struct i2c_config i2c_cfg)
> >> +{
> >> +	struct amd_mp2_dev *privdata = pci_get_drvdata(dev);
> >> +	union i2c_cmd_base i2c_cmd_base;
> >> +	unsigned  long  flags;

Extra spaces in the "flags" declaration.

> >> +
> >> +	raw_spin_lock_irqsave(&privdata->lock, flags);
> >> +	dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> >> +		i2c_cfg.dev_addr, i2c_cfg.bus_id);
> >> +
> >> +	i2c_cmd_base.ul = 0;
> >> +	i2c_cmd_base.s.i2c_cmd = i2c_enable;
> >> +	i2c_cmd_base.s.bus_id = i2c_cfg.bus_id;
> >> +	i2c_cmd_base.s.i2c_speed = i2c_cfg.i2c_speed;
> >> +
> >> +	if (i2c_cmd_base.s.bus_id == i2c_bus_1) {
> >> +		writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG1);
> >> +	} else if (i2c_cmd_base.s.bus_id == i2c_bus_0) {
> >> +		writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> >> +	} else {
> >> +		dev_err(ndev_dev(privdata), "%s Invalid bus id\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +	raw_spin_unlock_irqrestore(&privdata->lock, flags);
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(amd_mp2_connect);
> >> +
> >> +int amd_mp2_read(struct pci_dev *dev, struct i2c_config i2c_cfg)
> >> +{
> >> +	struct amd_mp2_dev *privdata = pci_get_drvdata(dev);
> >> +	union i2c_cmd_base i2c_cmd_base;
> >> +
> >> +	dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> >> +		i2c_cfg.dev_addr, i2c_cfg.bus_id);
> >> +
> >> +	privdata->requested = true;
> >> +	i2c_cmd_base.ul = 0;
> >> +	i2c_cmd_base.s.i2c_cmd = i2c_read;
> >> +	i2c_cmd_base.s.dev_addr = i2c_cfg.dev_addr;
> >> +	i2c_cmd_base.s.length = i2c_cfg.length;
> >> +	i2c_cmd_base.s.bus_id = i2c_cfg.bus_id;

This block is repeated and could be factored out to a helper function
(parameterized with i2c_read/i2c_write).

> >> +
> >> +	if (i2c_cfg.length <= 32) {
> >> +		i2c_cmd_base.s.mem_type = use_c2pmsg;
> >> +		privdata->eventval.buf = (u32 *)i2c_cfg.read_buf;
> >> +		if (!privdata->eventval.buf) {
> >> +			dev_err(ndev_dev(privdata), "%s no mem for buf received\n",
> >> +				__func__);
> >> +			return -ENOMEM;
> >> +		}
> >> +	} else {
> >> +		i2c_cmd_base.s.mem_type = use_dram;
> >> +		privdata->i2c_cfg.phy_addr = i2c_cfg.phy_addr;
> >> +		privdata->i2c_cfg.read_buf = i2c_cfg.read_buf;
> >> +		write64((u64)privdata->i2c_cfg.phy_addr,
> >> +			privdata->mmio + AMD_C2P_MSG2);
> >> +	}
> >> +
> >> +	switch (i2c_cfg.i2c_speed) {
> >> +	case 0:
> >> +		i2c_cmd_base.s.i2c_speed = speed100k;
> >> +		break;
> >> +	case 1:
> >> +		i2c_cmd_base.s.i2c_speed = speed400k;
> >> +		break;
> >> +	case 2:
> >> +		i2c_cmd_base.s.i2c_speed = speed1000k;
> >> +		break;
> >> +	case 3:
> >> +		i2c_cmd_base.s.i2c_speed = speed1400k;
> >> +		break;
> >> +	case 4:
> >> +		i2c_cmd_base.s.i2c_speed = speed3400k;
> >> +		break;
> >> +	default:
> >> +		dev_err(ndev_dev(privdata), "Invalid ConnectionSpeed\n");
> >> +	}

This switch statement is repeated below and could be factored out into
a helper function.

> >> +	if (i2c_cmd_base.s.bus_id == i2c_bus_1) {
> >> +		writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG1);
> >> +	} else if (i2c_cmd_base.s.bus_id == i2c_bus_0) {
> >> +		writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> >> +	} else {
> >> +		dev_err(ndev_dev(privdata), "%s Invalid bus id\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(amd_mp2_read);
> >> +
> >> +int amd_mp2_write(struct pci_dev *dev, struct i2c_config i2c_cfg)
> >> +{
> >> +	struct amd_mp2_dev *privdata = pci_get_drvdata(dev);
> >> +	union i2c_cmd_base i2c_cmd_base;
> >> +	int i = 0;

This initialization is unnecessary.

> >> +	privdata->requested = true;
> >> +	dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> >> +		i2c_cfg.dev_addr, i2c_cfg.bus_id);
> >> +
> >> +	i2c_cmd_base.ul = 0;
> >> +	i2c_cmd_base.s.i2c_cmd = i2c_write;
> >> +	i2c_cmd_base.s.dev_addr = i2c_cfg.dev_addr;
> >> +	i2c_cmd_base.s.length = i2c_cfg.length;
> >> +	i2c_cmd_base.s.bus_id = i2c_cfg.bus_id;
> >> +
> >> +	switch (i2c_cfg.i2c_speed) {
> >> +	case 0:
> >> +		i2c_cmd_base.s.i2c_speed = speed100k;
> >> +		break;
> >> +	case 1:
> >> +		i2c_cmd_base.s.i2c_speed = speed400k;
> >> +		break;
> >> +	case 2:
> >> +		i2c_cmd_base.s.i2c_speed = speed1000k;
> >> +		break;
> >> +	case 3:
> >> +		i2c_cmd_base.s.i2c_speed = speed1400k;
> >> +		break;
> >> +	case 4:
> >> +		i2c_cmd_base.s.i2c_speed = speed3400k;
> >> +		break;
> >> +	default:
> >> +		dev_err(ndev_dev(privdata), "Invalid ConnectionSpeed\n");
> >> +	}
> >> +
> >> +	if (i2c_cfg.length <= 32) {
> >> +		i2c_cmd_base.s.mem_type = use_c2pmsg;
> >> +		for (i = 0; i < ((i2c_cfg.length + 3) / 4); i++) {
> >> +			writel(i2c_cfg.write_buf[i],
> >> +			       privdata->mmio + (AMD_C2P_MSG2 + i * 4));
> >> +		}
> >> +	} else {
> >> +		i2c_cmd_base.s.mem_type = use_dram;
> >> +		privdata->i2c_cfg.phy_addr = i2c_cfg.phy_addr;
> >> +		write64((u64)privdata->i2c_cfg.phy_addr,
> >> +			privdata->mmio + AMD_C2P_MSG2);
> >> +	}
> >> +
> >> +	if (i2c_cmd_base.s.bus_id == i2c_bus_1) {
> >> +		writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG1);
> >> +	} else if (i2c_cmd_base.s.bus_id == i2c_bus_0) {
> >> +		writel(i2c_cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
> >> +	} else {
> >> +		dev_err(ndev_dev(privdata), "%s Invalid bus id\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(amd_mp2_write);
> >> +
> >> +int amd_i2c_register_cb(struct pci_dev *dev, const struct amd_i2c_pci_ops *ops,
> >> +			void *dev_ctx)
> >> +{
> >> +	struct amd_mp2_dev *privdata = pci_get_drvdata(dev);
> >> +
> >> +	privdata->ops = ops;
> >> +	privdata->i2c_dev_ctx = dev_ctx;
> >> +
> >> +	if (!privdata->ops || !privdata->i2c_dev_ctx)
> >> +		return -EINVAL;
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(amd_i2c_register_cb);
> >> +
> >> +static void amd_mp2_pci_work(struct work_struct *work)
> >> +{
> >> +	struct amd_mp2_dev *privdata = mp2_dev(work);
> >> +	u32 readdata = 0;
> >> +	int i = 0;

The above two initializations (readdata, i) are unnecessary.

> >> +	int sts = privdata->eventval.base.r.status;
> >> +	int res = privdata->eventval.base.r.response;
> >> +	int len = privdata->eventval.base.r.length;
> >> +
> >> +	if (res == command_success && sts == i2c_readcomplete_event) {
> >> +		if (privdata->ops->read_complete) {
> >> +			if (len <= 32) {
> >> +				for (i = 0; i < ((len + 3) / 4); i++) {
> >> +					readdata = readl(privdata->mmio +
> >> +							(AMD_C2P_MSG2 + i * 4));
> >> +					privdata->eventval.buf[i] = readdata;
> >> +				}
> >> +				privdata->ops->read_complete(privdata->eventval,
> >> +						privdata->i2c_dev_ctx);
> >> +			} else {
> >> +				privdata->ops->read_complete(privdata->eventval,
> >> +						privdata->i2c_dev_ctx);
> >> +			}
> >> +		}
> >> +	} else if (res == command_success && sts == i2c_writecomplete_event) {
> >> +		if (privdata->ops->write_complete)
> >> +			privdata->ops->write_complete(privdata->eventval,
> >> +					privdata->i2c_dev_ctx);
> >> +	} else if (res == command_success && sts == i2c_busenable_complete) {
> >> +		if (privdata->ops->connect_complete)
> >> +			privdata->ops->connect_complete(privdata->eventval,
> >> +					privdata->i2c_dev_ctx);
> >> +	} else {
> >> +		dev_err(ndev_dev(privdata), "ERROR!!nothing to be handled !\n");
> >> +	}
> >> +}
> >> +
> >> +static irqreturn_t amd_mp2_irq_isr(int irq, void *dev)
> >> +{
> >> +	struct amd_mp2_dev *privdata = dev;
> >> +	u32 val = 0;

This initialization is unnecessary.

> >> +	unsigned long  flags;

Extra space before "flags".

> >> +
> >> +	raw_spin_lock_irqsave(&privdata->lock, flags);
> >> +	val = readl(privdata->mmio + AMD_P2C_MSG1);
> >> +	if (val != 0) {
> >> +		writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> >> +		privdata->eventval.base.ul = val;
> >> +	} else {
> >> +		val = readl(privdata->mmio + AMD_P2C_MSG2);
> >> +		if (val != 0) {
> >> +			writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> >> +			privdata->eventval.base.ul = val;
> >> +		}
> >> +	}
> >> +
> >> +	raw_spin_unlock_irqrestore(&privdata->lock, flags);
> >> +	if (!privdata->ops)
> >> +		return IRQ_NONE;
> >> +
> >> +	if (!privdata->requested)
> >> +		return IRQ_HANDLED;
> >> +
> >> +	privdata->requested = false;
> >> +	schedule_delayed_work(&privdata->work, 0);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static ssize_t amd_mp2_debugfs_read(struct file *filp, char __user *ubuf,
> >> +				    size_t count, loff_t *offp)
> >> +{
> >> +	struct amd_mp2_dev *privdata;
> >> +	void __iomem *mmio;
> >> +	u8 *buf;
> >> +	u32 data;
> >> +	size_t buf_size;
> >> +	ssize_t ret, off;
> >> +
> >> +	privdata = filp->private_data;
> >> +	mmio = privdata->mmio;
> >> +	buf_size = min(count, 0x800ul);
> >> +	buf = kmalloc(buf_size, GFP_KERNEL);
> >> +
> >> +	if (!buf)
> >> +		return -ENOMEM;
> >> +
> >> +	off = 0;
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"Mp2 Device Information:\n");
> >> +
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"========================\n");
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"\tMP2 C2P Message Register Dump:\n\n");
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG0);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG0 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG1);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG1 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG2);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG2 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG3);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG3 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG4);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG4 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG5);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG5 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG6);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG6 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG7);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG7 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG8);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG8 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_C2P_MSG9);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_C2P_MSG9 -\t\t\t%#06x\n", data);
> >> +
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"\n\tMP2 P2C Message Register Dump:\n\n");
> >> +
> >> +	data = readl(privdata->mmio + AMD_P2C_MSG1);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_P2C_MSG1 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_P2C_MSG2);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_P2C_MSG2 -\t\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_P2C_MSG_INTEN);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_P2C_MSG_INTEN -\t\t%#06x\n", data);
> >> +
> >> +	data = readl(privdata->mmio + AMD_P2C_MSG_INTSTS);
> >> +	off += scnprintf(buf + off, buf_size - off,
> >> +			"AMD_P2C_MSG_INTSTS -\t\t%#06x\n", data);
> >> +
> >> +	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
> >> +	kfree(buf);
> >> +	return ret;
> >> +}
> >> +
> >> +static void amd_mp2_init_debugfs(struct amd_mp2_dev *privdata)
> >> +{
> >> +	if (!debugfs_dir) {
> >> +		privdata->debugfs_dir = NULL;
> >> +		privdata->debugfs_info = NULL;

Just return here and unindent the following block, like this:

  if (!debugfs_dir) {
    ...
    return;
  }

  privdata->debugfs_dir = ...

> >> +	} else {
> >> +		privdata->debugfs_dir = debugfs_create_dir(ndev_name(privdata),
> >> +							   debugfs_dir);
> >> +		if (!privdata->debugfs_dir) {
> >> +			privdata->debugfs_info = NULL;
> >> +		} else {
> >> +			privdata->debugfs_info = debugfs_create_file
> >> +				("info", 0400, privdata->debugfs_dir,
> >> +					privdata, &amd_mp2_debugfs_info);
> >> +		}
> >> +	}
> >> +}
> >> +
> >> +static void amd_mp2_deinit_debugfs(struct amd_mp2_dev *privdata)
> >> +{
> >> +	debugfs_remove_recursive(privdata->debugfs_dir);
> >> +}
> >> +
> >> +static void amd_mp2_clear_reg(struct amd_mp2_dev *privdata)
> >> +{
> >> +	int reg = 0;

Unnecessary initialization.

> >> +
> >> +	for (reg = AMD_C2P_MSG0; reg <= AMD_C2P_MSG9; reg += 4)
> >> +		writel(0, privdata->mmio + reg);
> >> +
> >> +	for (reg = AMD_P2C_MSG0; reg <= AMD_P2C_MSG2; reg += 4)
> >> +		writel(0, privdata->mmio + reg);
> >> +}
> >> +
> >> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pci_dev *pdev)
> >> +{
> >> +	int rc;
> >> +	int bar_index = 2;

Better to hardcode "2" at the point where bar_index used so the reader
doesn't have to scan back up to the top of the function to see which
it is.

> >> +	resource_size_t size, base;
> >> +
> >> +	pci_set_drvdata(pdev, privdata);
> >> +
> >> +	rc = pci_enable_device(pdev);
> >> +	if (rc)
> >> +		goto err_pci_enable;
> >> +
> >> +	rc = pci_request_regions(pdev, DRIVER_NAME);
> >> +	if (rc)
> >> +		goto err_pci_regions;
> >> +
> >> +	pci_set_master(pdev);
> >> +
> >> +	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> >> +	if (rc) {
> >> +		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> >> +		if (rc)
> >> +			goto err_dma_mask;
> >> +		dev_warn(ndev_dev(privdata), "Cannot DMA highmem\n");
> >> +	}
> >> +
> >> +	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> >> +	if (rc) {
> >> +		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> >> +		if (rc)
> >> +			goto err_dma_mask;
> >> +		dev_warn(ndev_dev(privdata), "Cannot DMA consistent highmem\n");
> >> +	}
> >> +
> >> +	base = pci_resource_start(pdev, bar_index);
> >> +	size = pci_resource_len(pdev, bar_index);
> >> +
> >> +	privdata->mmio = ioremap(base, size);
> >> +	if (!privdata->mmio) {
> >> +		rc = -EIO;
> >> +		goto err_dma_mask;
> >> +	}
> >> +
> >> +	/* Try to set up intx irq */
> >> +	pci_intx(pdev, 1);
> >> +	privdata->eventval.buf = NULL;
> >> +	privdata->requested = false;
> >> +	raw_spin_lock_init(&privdata->lock);
> >> +	rc = request_irq(pdev->irq, amd_mp2_irq_isr, IRQF_SHARED, "mp2_irq_isr",
> >> +			 privdata);
> >> +	if (rc)
> >> +		goto err_intx_request;
> >> +
> >> +	return 0;
> >> +
> >> +err_intx_request:
> >> +	return rc;
> >> +err_dma_mask:
> >> +	pci_clear_master(pdev);
> >> +	pci_release_regions(pdev);
> >> +err_pci_regions:
> >> +	pci_disable_device(pdev);
> >> +err_pci_enable:
> >> +	pci_set_drvdata(pdev, NULL);
> >> +	return rc;
> >> +}
> >> +
> >> +static void amd_mp2_pci_deinit(struct amd_mp2_dev *privdata)
> >> +{
> >> +	struct pci_dev *pdev = ndev_pdev(privdata);
> >> +
> >> +	pci_iounmap(pdev, privdata->mmio);
> >> +
> >> +	pci_clear_master(pdev);
> >> +	pci_release_regions(pdev);
> >> +	pci_disable_device(pdev);
> >> +	pci_set_drvdata(pdev, NULL);
> >> +}
> >> +
> >> +static int amd_mp2_pci_probe(struct pci_dev *pdev,
> >> +			     const struct pci_device_id *id)
> >> +{
> >> +	struct amd_mp2_dev *privdata;
> >> +	int rc;
> >> +
> >> +	dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> >> +		 (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
> >> +
> >> +	privdata = kzalloc(sizeof(*privdata), GFP_KERNEL);
> >> +	privdata->pdev = pdev;
> >> +
> >> +	if (!privdata) {
> >> +		rc = -ENOMEM;
> >> +		goto err_dev;
> >> +	}
> >> +
> >> +	rc = amd_mp2_pci_init(privdata, pdev);
> >> +	if (rc)
> >> +		goto err_pci_init;
> >> +	dev_dbg(&pdev->dev, "pci init done.\n");
> >> +
> >> +	INIT_DELAYED_WORK(&privdata->work, amd_mp2_pci_work);
> >> +
> >> +	amd_mp2_init_debugfs(privdata);
> >> +	dev_info(&pdev->dev, "MP2 device registered.\n");
> >> +	return 0;
> >> +
> >> +err_pci_init:
> >> +	kfree(privdata);
> >> +err_dev:
> >> +	dev_err(&pdev->dev, "Memory Allocation Failed\n");
> >> +	return rc;
> >> +}
> >> +
> >> +static void amd_mp2_pci_remove(struct pci_dev *pdev)
> >> +{
> >> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> >> +
> >> +	amd_mp2_deinit_debugfs(privdata);
> >> +	amd_mp2_clear_reg(privdata);
> >> +	cancel_delayed_work_sync(&privdata->work);
> >> +	free_irq(pdev->irq, privdata);
> >> +	pci_intx(pdev, 0);
> >> +	amd_mp2_pci_deinit(privdata);
> >> +	kfree(privdata);
> >> +}
> >> +
> >> +static const struct file_operations amd_mp2_debugfs_info = {
> >> +	.owner = THIS_MODULE,
> >> +	.open = simple_open,
> >> +	.read = amd_mp2_debugfs_read,
> >> +};
> >> +
> >> +static const struct pci_device_id amd_mp2_pci_tbl[] = {
> >> +	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> >> +	{0}
> >> +};
> >> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> >> +
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int amd_mp2_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
> >> +{
> >> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> >> +
> >> +	if (!privdata)
> >> +		return -EINVAL;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int amd_mp2_pci_device_resume(struct pci_dev *pdev)
> >> +{
> >> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
> >> +
> >> +	if (!privdata)
> >> +		return -EINVAL;
> >> +
> >> +	return 0;
> >> +}
> >> +#endif
> >> +
> >> +static struct pci_driver amd_mp2_pci_driver = {
> >> +	.name		= DRIVER_NAME,
> >> +	.id_table	= amd_mp2_pci_tbl,
> >> +	.probe		= amd_mp2_pci_probe,
> >> +	.remove		= amd_mp2_pci_remove,
> >> +#ifdef CONFIG_PM_SLEEP
> >> +	.suspend		= amd_mp2_pci_device_suspend,
> >> +	.resume			= amd_mp2_pci_device_resume,
> >> +#endif
> >> +};
> >> +
> >> +static int __init amd_mp2_pci_driver_init(void)
> >> +{
> >> +	pr_info("%s: %s Version: %s\n", DRIVER_NAME, DRIVER_DESC, DRIVER_VER);

This sort of thing is annoying because if this driver is built into
the kernel statically (not as a module), it *always* prints stuff,
regardless of whether the device is present.  There *are* examples
of that in the kernel, but I don't think they're good examples to
follow.

For example, I get the following useless messages on my laptop despite
the fact that they apparently only apply to IBM xSeries x366 and x460
systems.  I think this is just anti-social.

  Calgary: detecting Calgary via BIOS EBDA area
  Calgary: Unable to locate Rio Grande table in EBDA - bailing!

If you need the driver name/desc/ver, you can always print it in
amd_mp2_pci_probe() (just the first time through).

> >> +
> >> +	if (debugfs_initialized())
> >> +		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> >> +
> >> +	return pci_register_driver(&amd_mp2_pci_driver);
> >> +}
> >> +module_init(amd_mp2_pci_driver_init);
> >> +
> >> +static void __exit amd_mp2_pci_driver_exit(void)
> >> +{
> >> +	pci_unregister_driver(&amd_mp2_pci_driver);
> >> +	debugfs_remove_recursive(debugfs_dir);
> >> +}
> >> +module_exit(amd_mp2_pci_driver_exit);
> >> diff --git a/drivers/i2c/busses/i2c-amd-pci-mp2.h b/drivers/i2c/busses/i2c-amd-pci-mp2.h
> >> new file mode 100644
> >> index 0000000..787484e
> >> --- /dev/null
> >> +++ b/drivers/i2c/busses/i2c-amd-pci-mp2.h
> >> @@ -0,0 +1,196 @@
> >> +/* SPDX-License-Identifier: GPL-2.0

Doesn't match the MODULE_LICENSE in the .c files.

> >> + *
> >> + * Copyright (C) 2018 Advanced Micro Devices, Inc. All Rights Reserved
> >> + *
> >> + * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> + * AMD PCIe MP2 Communication Interface Driver
> >> + */
> >> +
> >> +#ifndef I2C_AMD_PCI_MP2_H
> >> +#define I2C_AMD_PCI_MP2_H
> >> +
> >> +#include <linux/pci.h>
> >> +
> >> +#define PCI_DEVICE_ID_AMD_MP2	0x15E6
> >> +
> >> +#define write64 _write64
> >> +static inline void _write64(u64 val, void __iomem *mmio)
> >> +{
> >> +	writel(val, mmio);
> >> +	writel(val >> 32, mmio + sizeof(u32));
> >> +}
> >> +
> >> +#define read64 _read64
> >> +static inline u64 _read64(void __iomem *mmio)
> >> +{
> >> +	u64 low, high;
> >> +
> >> +	low = readl(mmio);
> >> +	high = readl(mmio + sizeof(u32));
> >> +	return low | (high << 32);
> >> +}
> >> +
> >> +enum {
> >> +	/* MP2 C2P Message Registers */
> >> +	AMD_C2P_MSG0 = 0x10500, /*MP2 Message for I2C0*/

Generally people use a space after "/*" and another before "*/".
You should at least be consistent for all your comments (some of them
have the spaces and some don't).

> >> +	AMD_C2P_MSG1 = 0x10504, /*MP2 Message for I2C1*/
> >> +	AMD_C2P_MSG2 = 0x10508, /*DRAM Address Lo / Data 0*/
> >> +	AMD_C2P_MSG3 = 0x1050c, /*DRAM Address HI / Data 1*/
> >> +	AMD_C2P_MSG4 = 0x10510, /*Data 2*/
> >> +	AMD_C2P_MSG5 = 0x10514, /*Data 3*/
> >> +	AMD_C2P_MSG6 = 0x10518, /*Data 4*/
> >> +	AMD_C2P_MSG7 = 0x1051c, /*Data 5*/
> >> +	AMD_C2P_MSG8 = 0x10520, /*Data 6*/
> >> +	AMD_C2P_MSG9 = 0x10524, /*Data 7*/
> >> +
> >> +	/* MP2 P2C Message Registers */
> >> +	AMD_P2C_MSG0 = 0x10680, /*Do not use*/
> >> +	AMD_P2C_MSG1 = 0x10684, /*I2c0 int reg*/
> >> +	AMD_P2C_MSG2 = 0x10688, /*I2c1 int reg*/
> >> +	AMD_P2C_MSG3 = 0x1068C, /*MP2 debug info*/
> >> +	AMD_P2C_MSG_INTEN = 0x10690, /*MP2 int gen register*/
> >> +	AMD_P2C_MSG_INTSTS = 0x10694, /*Interrupt sts*/
> >> +};
> >> +
> >> +/* Command register data structures */
> >> +
> >> +enum i2c_cmd {
> >> +	i2c_read,
> >> +	i2c_write,
> >> +	i2c_enable,
> >> +	i2c_disable,
> >> +	number_of_sensor_discovered,
> >> +	is_mp2_active,
> >> +	invalid_cmd = 0xF,
> >> +};
> >> +
> >> +enum i2c_bus_index {
> >> +	i2c_bus_0 = 0,
> >> +	i2c_bus_1 = 1,
> >> +	i2c_bus_max
> >> +};
> >> +
> >> +enum speed_enum {
> >> +	speed100k = 0,
> >> +	speed400k = 1,
> >> +	speed1000k = 2,
> >> +	speed1400k = 3,
> >> +	speed3400k = 4
> >> +};
> >> +
> >> +enum mem_type {
> >> +	use_dram = 0,
> >> +	use_c2pmsg = 1,
> >> +};
> >> +
> >> +union i2c_cmd_base {
> >> +	u32 ul;
> >> +	struct {
> >> +		enum i2c_cmd i2c_cmd : 4; /*!< bit: 0..3 i2c R/W command */
> >> +		enum i2c_bus_index bus_id : 4; /*!< bit: 4..7 i2c bus index */
> >> +		u32 dev_addr : 8; /*!< bit: 8..15 device address or Bus Speed*/
> >> +		u32 length : 12; /*!< bit: 16..29 read/write length */
> >> +		enum speed_enum i2c_speed : 3; /*!< bit: 30 register address*/
> >> +		enum mem_type mem_type : 1; /*!< bit: 15 mem type*/
> >> +	} s; /*!< Structure used for bit access */
> >> +};
> >> +
> >> +/* Response register data structures */
> >> +
> >> +/*Response - Response of SFI*/
> >> +enum response_type {
> >> +	invalid_response = 0,
> >> +	command_success = 1,
> >> +	command_failed = 2,
> >> +};
> >> +
> >> +/*Status - Command ID to indicate a command*/
> >> +enum status_type {
> >> +	i2c_readcomplete_event = 0,
> >> +	i2c_readfail_event = 1,
> >> +	i2c_writecomplete_event = 2,
> >> +	i2c_writefail_event = 3,
> >> +	i2c_busenable_complete = 4,
> >> +	i2c_busenable_failed = 5,
> >> +	i2c_busdisable_complete = 6,
> >> +	i2c_busdisable_failed = 7,
> >> +	invalid_data_length = 8,
> >> +	invalid_slave_address = 9,
> >> +	invalid_i2cbus_id = 10,
> >> +	invalid_dram_addr = 11,
> >> +	invalid_command = 12,
> >> +	mp2_active = 13,
> >> +	numberof_sensors_discovered_resp = 14,
> >> +	i2C_bus_notinitialized
> >> +};
> >> +
> >> +struct i2c_event {
> >> +	union {
> >> +		u32 ul;
> >> +		struct {
> >> +			enum response_type response : 2; /*!< bit: 0..1 I2C res type */
> >> +			enum status_type status : 5; /*!< bit: 2..6 status_type */
> >> +			enum mem_type mem_type : 1; /*!< bit: 7 0-DRAM;1- C2PMsg o/p */
> >> +			enum i2c_bus_index bus_id : 4; /*!< bit: 8..11 I2C Bus ID */
> >> +			u32 length : 12; /*!< bit:16..29 length */
> >> +			u32 slave_addr : 8; /*!< bit: 15 debug msg include in p2c msg */
> >> +		} r; /*!< Structure used for bit access */
> >> +	} base;
> >> +	u32 *buf;
> >> +};
> >> +
> >> +/* data structures for communication with I2c*/
> >> +
> >> +struct i2c_config {
> >> +	enum i2c_bus_index bus_id;
> >> +	u64 i2c_speed;
> >> +	u16 dev_addr;
> >> +	u32 length;
> >> +	phys_addr_t phy_addr;
> >> +	u8 *read_buf;
> >> +	u32 *write_buf;
> >> +};
> >> +
> >> +/* struct to send/receive data b/w pci and i2c drivers*/
> >> +struct amd_i2c_pci_ops {
> >> +	int (*read_complete)(struct i2c_event event, void *dev_ctx);
> >> +	int (*write_complete)(struct i2c_event event, void *dev_ctx);
> >> +	int (*connect_complete)(struct i2c_event event, void *dev_ctx);
> >> +};
> >> +
> >> +struct amd_i2c_common {
> >> +	struct i2c_config i2c_cfg;
> >> +	const struct amd_i2c_pci_ops *ops;
> >> +	struct pci_dev *pdev;
> >> +};
> >> +
> >> +struct amd_mp2_dev {
> >> +	struct pci_dev *pdev;
> >> +	struct dentry *debugfs_dir;
> >> +	struct dentry *debugfs_info;
> >> +	void __iomem *mmio;
> >> +	struct i2c_event eventval;
> >> +	enum i2c_cmd reqcmd;
> >> +	struct i2c_config i2c_cfg;
> >> +	union i2c_cmd_base i2c_cmd_base;
> >> +	const struct amd_i2c_pci_ops *ops;
> >> +	struct delayed_work work;
> >> +	void *i2c_dev_ctx;
> >> +	bool requested;
> >> +	raw_spinlock_t lock;
> >> +};
> >> +
> >> +int amd_mp2_read(struct pci_dev *pdev, struct i2c_config i2c_cfg);
> >> +int amd_mp2_write(struct pci_dev *pdev,
> >> +		  struct i2c_config i2c_cfg);
> >> +int amd_mp2_connect(struct pci_dev *pdev,
> >> +		    struct i2c_config i2c_cfg);
> >> +int amd_i2c_register_cb(struct pci_dev *pdev, const struct amd_i2c_pci_ops *ops,
> >> +			void *dev_ctx);
> >> +
> >> +#define ndev_pdev(ndev) ((ndev)->pdev)
> >> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> >> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> >> +#define mp2_dev(__work) container_of(__work, struct amd_mp2_dev, work.work)
> >> +
> >> +#endif
> >> diff --git a/drivers/i2c/busses/i2c-amd-platdrv.c b/drivers/i2c/busses/i2c-amd-platdrv.c
> >> new file mode 100644
> >> index 0000000..95e3b37
> >> --- /dev/null
> >> +++ b/drivers/i2c/busses/i2c-amd-platdrv.c
> >> @@ -0,0 +1,277 @@
> >> +// SPDX-License-Identifier: GPL-2.0

Doesn't match MODULE_LICENSE.

> >> +/*
> >> + *
> >> + * Copyright (C) 2018 Advanced Micro Devices, Inc. All Rights Reserved.
> >> + *
> >> + *

Extra blank lines above.

> >> + * Author: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
> >> + * AMD I2C Platform Driver
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/types.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/acpi.h>
> >> +#include <linux/delay.h>
> >> +#include "i2c-amd-pci-mp2.h"
> >> +
> >> +struct amd_i2c_dev {
> >> +	struct platform_device *pdev;
> >> +	struct i2c_adapter adapter;
> >> +	struct amd_i2c_common i2c_common;
> >> +	struct completion msg_complete;
> >> +	struct i2c_msg *msg_buf;
> >> +	bool is_configured;
> >> +	u8 bus_id;
> >> +	u8 *buf;
> >> +};
> >> +
> >> +static int i2c_amd_read_completion(struct i2c_event event, void *dev_ctx)
> >> +{
> >> +	struct amd_i2c_dev *i2c_dev = (struct amd_i2c_dev *)dev_ctx;

I don't think this cast is necessary.

> >> +	struct amd_i2c_common *commond = &i2c_dev->i2c_common;
> >> +	int i = 0;

Unnecessary initialization.

> >> +
> >> +	if (event.base.r.status == i2c_readcomplete_event) {
> >> +		if (event.base.r.length <= 32) {
> >> +			pr_devel(" in %s i2c_dev->msg_buf :%p\n",
> >> +				 __func__, i2c_dev->msg_buf);
> >> +
> >> +			memcpy(i2c_dev->msg_buf->buf,
> >> +			       (unsigned char *)event.buf, event.base.r.length);
> >> +
> >> +			for (i = 0; i < ((event.base.r.length + 3) / 4); i++)
> >> +				pr_devel("%s: readdata:%x\n",
> >> +					 __func__, event.buf[i]);
> >> +
> >> +		} else {
> >> +			memcpy(i2c_dev->msg_buf->buf,
> >> +			       (unsigned char *)commond->i2c_cfg.read_buf,
> >> +				event.base.r.length);
> >> +
> >> +			for (i = 0; i < ((event.base.r.length + 3) / 4); i++)
> >> +				pr_devel("%s: readdata:%x\n", __func__,
> >> +					 ((unsigned int *)commond->i2c_cfg.read_buf)[i]);
> >> +		}
> >> +
> >> +				complete(&i2c_dev->msg_complete);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int i2c_amd_write_completion(struct i2c_event event, void *dev_ctx)
> >> +{
> >> +	struct amd_i2c_dev *i2c_dev = (struct amd_i2c_dev *)dev_ctx;

Unnecessary cast.

> >> +
> >> +	if (event.base.r.status == i2c_writecomplete_event)
> >> +			complete(&i2c_dev->msg_complete);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int i2c_amd_connect_completion(struct i2c_event event, void *dev_ctx)
> >> +{
> >> +	struct amd_i2c_dev *i2c_dev = (struct amd_i2c_dev *)dev_ctx;

Unnecessary cast.

> >> +
> >> +	if (event.base.r.status == i2c_busenable_complete)
> >> +			complete(&i2c_dev->msg_complete);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct amd_i2c_pci_ops data_handler = {
> >> +		.read_complete = i2c_amd_read_completion,
> >> +		.write_complete = i2c_amd_write_completion,
> >> +		.connect_complete = i2c_amd_connect_completion,
> >> +};
> >> +
> >> +static int i2c_amd_pci_configure(struct amd_i2c_dev *i2c_dev, int slaveaddr)
> >> +{
> >> +	struct amd_i2c_common *i2c_common = &i2c_dev->i2c_common;
> >> +	int ret;
> >> +
> >> +	amd_i2c_register_cb(i2c_common->pdev, &data_handler, (void *)i2c_dev);
> >> +	i2c_common->i2c_cfg.bus_id = i2c_dev->bus_id;
> >> +	i2c_common->i2c_cfg.dev_addr = slaveaddr;
> >> +	i2c_common->i2c_cfg.i2c_speed = speed400k;
> >> +	ret = amd_mp2_connect(i2c_common->pdev, i2c_common->i2c_cfg);
> >> +
> >> +	if (ret)
> >> +		return	-EIO;
> >> +
> >> +	mdelay(100);

This deserves a comment about why the delay is needed.

> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int i2c_amd_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> >> +{
> >> +	struct amd_i2c_dev *dev = i2c_get_adapdata(adap);
> >> +	struct amd_i2c_common *i2c_common = &dev->i2c_common;
> >> +

Remove this blank line.

> >> +	int i;
> >> +	unsigned long timeout;
> >> +	struct i2c_msg *pmsg;
> >> +	unsigned char *dma_buf = NULL;
> >> +	dma_addr_t phys;
> >> +
> >> +	reinit_completion(&dev->msg_complete);
> >> +	if (dev->is_configured == 0) {
> >> +		i2c_amd_pci_configure(dev, msgs->addr);
> >> +		timeout = wait_for_completion_timeout(&dev->msg_complete, 50);
> >> +		dev->is_configured = 1;
> >> +	}
> >> +
> >> +	for (i = 0; i < num; i++) {
> >> +		pmsg = &msgs[i];
> >> +		i2c_common->i2c_cfg.length = pmsg->len;
> >> +		if (pmsg->len > 32) {
> >> +			dma_buf = (u8 *)dma_alloc_coherent(&i2c_common->pdev->dev,
> >> +					pmsg->len, &phys, GFP_KERNEL);
> >> +			i2c_common->i2c_cfg.phy_addr = phys;
> >> +		}
> >> +
> >> +		if (pmsg->flags & I2C_M_RD) {
> >> +			if (pmsg->len <= 32)
> >> +				i2c_common->i2c_cfg.read_buf = dev->buf;
> >> +			else
> >> +				i2c_common->i2c_cfg.read_buf = dma_buf;
> >> +
> >> +			dev->msg_buf = pmsg;
> >> +			amd_mp2_read(i2c_common->pdev,
> >> +				     i2c_common->i2c_cfg);
> >> +
> >> +		} else {
> >> +			if (pmsg->len <= 32)
> >> +				i2c_common->i2c_cfg.write_buf = (unsigned int *)pmsg->buf;
> >> +			else
> >> +				i2c_common->i2c_cfg.write_buf = (unsigned int *)dma_buf;
> >> +
> >> +			amd_mp2_write(i2c_common->pdev,
> >> +				      i2c_common->i2c_cfg);
> >> +		}
> >> +
> >> +		timeout = wait_for_completion_timeout
> >> +					(&dev->msg_complete, 50);
> >> +		if (dma_buf)
> >> +			dma_free_coherent(&i2c_common->pdev->dev,
> >> +					  pmsg->len, dma_buf, phys);
> >> +
> >> +		if (timeout == 0)
> >> +			return -ETIMEDOUT;
> >> +	}
> >> +	return num;
> >> +}
> >> +
> >> +static u32 i2c_amd_func(struct i2c_adapter *a)
> >> +{
> >> +	return I2C_FUNC_I2C;
> >> +}
> >> +
> >> +static const struct i2c_algorithm i2c_amd_algorithm = {
> >> +	.master_xfer = i2c_amd_xfer,
> >> +	.functionality = i2c_amd_func,
> >> +};
> >> +
> >> +static int i2c_amd_probe(struct platform_device *pdev)
> >> +{
> >> +	int ret;
> >> +	struct amd_i2c_dev *i2c_dev;
> >> +	struct device *dev = &pdev->dev;
> >> +	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> >> +	struct acpi_device *adev;
> >> +	const char *uid = NULL;
> >> +
> >> +	i2c_dev = devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
> >> +	if (!i2c_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	i2c_dev->pdev = pdev;
> >> +
> >> +	if (!acpi_bus_get_device(handle, &adev)) {
> >> +		pr_err(" i2c0  pdev->id=%s\n", adev->pnp.unique_id);

All the printks here should be some form of dev_printk(), probably
using the platform_device.  All driver printks should use dev_printk()
so the messages can be associated with a specific device.

> >> +		uid = adev->pnp.unique_id;
> >> +	}
> >> +
> >> +	if (strcmp(uid, "0") == 0) {

This is unsafe: uid may be NULL here, and strcmp will dereference it.

> >> +		pr_err(" bus id is 0\n");
> >> +		i2c_dev->bus_id = 0;
> >> +	}
> >> +
> >> +	pr_devel(" i2c1  pdev->id=%s\n", uid);
> >> +	if (strcmp(uid, "1") == 0) {
> >> +		pr_err(" bus id is 1\n");
> >> +		i2c_dev->bus_id = 1;
> >> +	}
> >> +	/* setup i2c adapter description */
> >> +	i2c_dev->adapter.owner = THIS_MODULE;
> >> +	i2c_dev->adapter.algo = &i2c_amd_algorithm;
> >> +	i2c_dev->adapter.dev.parent = dev;
> >> +	i2c_dev->adapter.algo_data = i2c_dev;
> >> +	ACPI_COMPANION_SET(&i2c_dev->adapter.dev, ACPI_COMPANION(&pdev->dev));

I don't understand what's going on here.  You seem to be claiming
AMDI0011 devices, but I can't see that you ever *do* anything with
that.  I don't see any methods on that device being called or any
information from the ACPI namespace being used.  What am I missing?

> >> +	i2c_dev->adapter.dev.of_node = dev->of_node;
> >> +	/*buffer for 32 bytes of read  data*/

Extra space in "read  data", and not enough at beginning and end.

> >> +	i2c_dev->buf = kzalloc(32, GFP_KERNEL);
> >> +
> >> +	if (!i2c_dev->buf)
> >> +		return -ENOMEM;
> >> +
> >> +	snprintf(i2c_dev->adapter.name, sizeof(i2c_dev->adapter.name), "%s-%s",
> >> +		 "i2c_dev-i2c", dev_name(pdev->dev.parent));
> >> +
> >> +	i2c_dev->i2c_common.pdev = pci_get_device(PCI_VENDOR_ID_AMD,
> >> +						  PCI_DEVICE_ID_AMD_MP2, NULL);

I really don't like this.  pci_get_device() basically subverts the PCI
driver registration mechanism.  If a driver has claimed the MP2 device
using pci_register_driver(), then *it* completely owns the device and
no other code should touch it.  pci_get_device() is a way for
arbitrary other code to get a pointer to the device and muck with it.

In this case, I'm guessing the driver claiming the MP2 device is
probably another piece of *this* driver, and you should have some
mechanism internal to the driver to coordinate knowledge of the device
and access to it.

> >> +
> >> +	if (!i2c_dev->i2c_common.pdev) {
> >> +		pr_err("%s Could not find pdev in i2c\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +	platform_set_drvdata(pdev, i2c_dev);
> >> +	i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
> >> +
> >> +	init_completion(&i2c_dev->msg_complete);
> >> +	/* and finally attach to i2c layer */
> >> +	ret = i2c_add_adapter(&i2c_dev->adapter);
> >> +
> >> +	if (ret < 0)
> >> +		pr_err(" i2c add adpater failed =%d", ret);

s/adpater/adapter/

> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int i2c_amd_remove(struct platform_device *pdev)
> >> +{
> >> +	struct amd_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
> >> +
> >> +	kfree(i2c_dev->buf);
> >> +
> >> +	i2c_del_adapter(&i2c_dev->adapter);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct acpi_device_id i2c_amd_acpi_match[] = {
> >> +		{ "AMDI0011" },
> >> +		{ },
> >> +};
> >> +
> >> +static struct platform_driver amd_i2c_plat_driver = {
> >> +		.probe = i2c_amd_probe,
> >> +		.remove = i2c_amd_remove,
> >> +		.driver = {
> >> +				.name = "i2c_amd_platdrv",
> >> +				.acpi_match_table = ACPI_PTR
> >> +						(i2c_amd_acpi_match),
> >> +		},
> >> +};
> >> +
> >> +module_platform_driver(amd_i2c_plat_driver);
> >> +
> >> +MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
> >> +MODULE_DESCRIPTION("AMD I2C Platform Driver");
> >> +MODULE_LICENSE("Dual BSD/GPL");
> >> -- 
> >> 2.7.4
> > 
> > 
> 
