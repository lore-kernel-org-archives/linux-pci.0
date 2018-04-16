Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeDPVmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Apr 2018 17:42:06 -0400
Date: Mon, 16 Apr 2018 16:42:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] PCI: Add two more values for PCIe
 Max_Read_Request_Size
Message-ID: <20180416214204.GD28657@bhelgaas-glaptop.roam.corp.google.com>
References: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
 <ab8696d7-59e0-1f24-0ead-757057eb50cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab8696d7-59e0-1f24-0ead-757057eb50cf@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2018 at 09:37:13PM +0200, Heiner Kallweit wrote:
> This patch adds missing values for the max read request size.
> E.g. network driver r8169 uses a value of 4K.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

I'd prefer a subject line with more details, e.g.,

  PCI: Add #defines for 2K and 4K Max Read Request Size

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I suspect conflicts are more likely in r8169.c so it might make more
sense to route these through the netdev tree.  I'd also be happy to
take them, so let me know if you want me to take them, David.

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
> 
