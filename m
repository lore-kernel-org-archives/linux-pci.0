Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752836AbeDLW4A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Apr 2018 18:56:00 -0400
Date: Thu, 12 Apr 2018 17:55:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add two more values for PCIe Max_Read_Request_Size
Message-ID: <20180412225557.GB46420@bhelgaas-glaptop.roam.corp.google.com>
References: <90260d62-e136-44a3-a35b-19fac1bcfb20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <90260d62-e136-44a3-a35b-19fac1bcfb20@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Heiner,

On Thu, Apr 12, 2018 at 11:08:04PM +0200, Heiner Kallweit wrote:
> This patch adds missing values for the max read request size.
> E.g. network driver r8169 uses a value of 4K.

Is there a r8169 patch that adds uses of PCI_EXP_DEVCTL_READRQ_4096B?
If so, we should probably keep it together with this one since this
one would have to be merged first.

There's also a larger issue in that when Linux configures MPS and MRRS
at enumeration-time, it makes some assumptions about how MRRS is set.
If a driver like r8169 changes MRRS later, it may break those
assumptions, which might lead to PCIe errors.

If a user boots with "pci=pcie_bus_perf", we use PCIE_BUS_PERFORMANCE
mode, and in that case we may set MPS to something larger than some
devices can support, and we rely on MRRS to avoid problems.

I don't really *like* that scheme because it makes assumptions like
"drivers never change MRRS", but that's what we have right now.

So just be aware that if r8169 changes MRRS and users boot with
"pci=pcie_bus_perf", there is the potential for PCIe bus errors.

There was some recent discussion about this; [1] is a good place to
start.

[1] http://lkml.kernel.org/r/20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/uapi/linux/pci_regs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 0c79eac5..699257fb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -506,6 +506,8 @@
>  #define  PCI_EXP_DEVCTL_READRQ_256B  0x1000 /* 256 Bytes */
>  #define  PCI_EXP_DEVCTL_READRQ_512B  0x2000 /* 512 Bytes */
>  #define  PCI_EXP_DEVCTL_READRQ_1024B 0x3000 /* 1024 Bytes */
> +#define  PCI_EXP_DEVCTL_READRQ_2048B 0x4000 /* 2048 Bytes */
> +#define  PCI_EXP_DEVCTL_READRQ_4096B 0x5000 /* 4096 Bytes */
>  #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
>  #define PCI_EXP_DEVSTA		10	/* Device Status */
>  #define  PCI_EXP_DEVSTA_CED	0x0001	/* Correctable Error Detected */
> -- 
> 2.17.0
> 
