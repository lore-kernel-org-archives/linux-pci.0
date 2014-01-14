Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:58535 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaANKZh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 05:25:37 -0500
Received: by mail-ee0-f43.google.com with SMTP id c41so112228eek.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 02:25:35 -0800 (PST)
Date: Tue, 14 Jan 2014 12:25:32 +0200
From: Jack Morgenstein <jackm@dev.mellanox.co.il>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, bhelgaas@google.com,
	amirv@mellanox.com, ogerlitz@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114122532.0e2b6a64@jpm-OptiPlex-GX620>
In-Reply-To: <20140114091525.GB27684@richard>
References: <20140114062215.GA19345@richard>
	<20140114105031.71882944@jpm-OptiPlex-GX620>
	<20140114091525.GB27684@richard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Jan 2014 17:15:25 +0800
Wei Yang <weiyang@linux.vnet.ibm.com> wrote:

> >> Error log:
> >>   mlx4_core 0003:05:00.0: Multiple PFs not yet supported.  Skipping
> >> PF. mlx4_core: probe of 0003:05:00.0 failed with error -22  
> >
> >1. Please include the full error log starting from host bootup and
> >driver start  
> 
> Will provide one later. 

>From procedure __mlx4_init_one() in file
drivers/net/ethernet/mellanox/mlx4_main.c:

	        /* We reset the device and enable SRIOV only for physical
                 * devices.  Try to claim ownership on the device;
                 * if already taken, skip -- do not allow multiple PFs
                 */
==>		err = mlx4_get_ownership(dev);
                if (err) {
                        if (err < 0)
                                goto err_free_dev;
                        else {
                                mlx4_warn(dev, "Multiple PFs not yet
                supported." " Skipping PF.\n");
                                err = -EINVAL;
                                goto err_free_dev;
                        }
                }
===================
#define MLX4_OWNER_BASE 0x8069c
#define MLX4_OWNER_SIZE 4

static int mlx4_get_ownership(struct mlx4_dev *dev)
{
        void __iomem *owner;
        u32 ret;

        if (pci_channel_offline(dev->pdev))
                return -EIO;

==>     owner = ioremap(pci_resource_start(dev->pdev, 0) + MLX4_OWNER_BASE,
                        MLX4_OWNER_SIZE);
        if (!owner) {
                mlx4_err(dev, "Failed to obtain ownership bit\n");
                return -ENOMEM;
        }

        ret = readl(owner);
        iounmap(owner);
==>     return (int) !!ret;
}


I suspect one of the following scenarios:

1. BAR 0 contains a "PPF Selection" (i.e., ownership) semaphore:  The first PF probe which
reads the semaphore "acquires" it (i.e., the first read grabs the semaphore (the read returns zero).
Subsequent reads return non-zero.  When the PF driver is unloaded, it calls "mlx4_free_ownership()",
which writes a zero into the semaphore dword, so that the next read will return zero.

In this scenario, initialization of the "PPF selection" semaphore to zero has been compromised somehow, so that
even the first read attempt returns a non-zero value.  In this scenario, note that the ioremap DID succeed, or
we would see the "Failed to obtain ownership bit" message in the error log.  Maybe pre-fetching has something
to do with this? (i.e., maybe if the BAR is not prefetched, the initial value of the semaphore is compromised).

2. For some reason the same PF is being probed twice by the
kernel.  In this case the second probe attempt fails because the PF has
already been probed once.

This is the reason that I want to see the entire log -- to see if
indeed the device is being "double-probed"

-Jack
