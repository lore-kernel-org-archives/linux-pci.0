Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57827 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaEWTXC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 May 2014 15:23:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 4/4] PCI: Generic Configuration Access Mechanism support
Date: Fri, 23 May 2014 21:22:18 +0200
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, jgunthorpe@obsidianresearch.com,
	sthokal@xilinx.com
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com> <1400863915-24135-5-git-send-email-will.deacon@arm.com>
In-Reply-To: <1400863915-24135-5-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201405232122.18995.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 23 May 2014, Will Deacon wrote:
> +static void __iomem *pci_cfg_map_bus_ecam(struct pci_bus *bus,
> +                                         unsigned int devfn,
> +                                         int where)
> +{
> +       struct pci_sys_data *sys = bus->sysdata;
> +       struct pci_cfg_windows *cfg = sys->private_data;
> +       resource_size_t idx = bus->number - cfg->bus_range.start;
> +
> +       return cfg->win[idx] + ((devfn << PCI_CFG_ECAM_DEV_NUM) | where);
> +}

I just noticed that this function makes the code rather non-generic, because
struct pci_sys_data is the ARM specific structure that doesn't exist elsewhere,
and sys->private_data wouldn't typically point to struct pci_cfg_windows on
anything other than your generic PCI host.

I'd say let's drop this for now. I know it was my idea to do it like this,
but it seems it's more complex than I had hoped to get this right, and
I'd really prefer to merge the other three patches for 3.16 if possible.
We can factor it out later if we get more users.

	Arnd
