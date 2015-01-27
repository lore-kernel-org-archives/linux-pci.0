Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58668 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbA0AU3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 19:20:29 -0500
Received: by mail-ob0-f182.google.com with SMTP id gq1so10760211obb.13
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2015 16:20:29 -0800 (PST)
Date: Mon, 26 Jan 2015 18:20:25 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Chris Metcalf <cmetcalf@ezchip.com>,
	Bradley Grove <linuxdrivers@attotech.com>,
	linux-scsi@vger.kernel.org,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: Add defines for max read request sizes
Message-ID: <20150127002025.GB11624@google.com>
References: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 26, 2015 at 06:05:22PM +0100, Rafał Miłecki wrote:
> There are few drivers using magic numbers when operating with PCIe
> capabilities and PCI_EXP_DEVCTL_READRQ. Define known values to allow
> cleaning their code a bit.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

I applied this whole series, with acks from Alexandre and Chris, to
pci/misc for v3.20, thanks!

> ---
>  include/uapi/linux/pci_regs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 4a1d0cc..efe3443 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -451,6 +451,10 @@
>  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
>  #define  PCI_EXP_DEVCTL_NOSNOOP_EN 0x0800  /* Enable No Snoop */
>  #define  PCI_EXP_DEVCTL_READRQ	0x7000	/* Max_Read_Request_Size */
> +#define  PCI_EXP_DEVCTL_READRQ_128B  0x0000 /* 128 Bytes */
> +#define  PCI_EXP_DEVCTL_READRQ_256B  0x1000 /* 256 Bytes */
> +#define  PCI_EXP_DEVCTL_READRQ_512B  0x2000 /* 512 Bytes */
> +#define  PCI_EXP_DEVCTL_READRQ_1024B 0x3000 /* 1024 Bytes */
>  #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
>  #define PCI_EXP_DEVSTA		10	/* Device Status */
>  #define  PCI_EXP_DEVSTA_CED	0x0001	/* Correctable Error Detected */
> -- 
> 1.8.4.5
> 
