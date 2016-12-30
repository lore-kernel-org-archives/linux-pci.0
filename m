Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34981 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbcL3Jqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2016 04:46:53 -0500
Received: by mail-lf0-f43.google.com with SMTP id b14so234353379lfg.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Dec 2016 01:46:52 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
Cc: artemi.ivanov@cogentembedded.com, linux-kernel@vger.kernel.org
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b83c353c-c054-4378-9308-e625c460bdd9@cogentembedded.com>
Date: Fri, 30 Dec 2016 12:46:49 +0300
MIME-Version: 1.0
In-Reply-To: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

On 12/29/2016 11:45 PM, Nikita Yushchenko wrote:

> It is possible that PCI device supports 64-bit DMA addressing, and thus
> it's driver sets device's dma_mask to DMA_BIT_MASK(64), however PCI host

    Its.

> bridge has limitations on inbound transactions addressing. Example of
> such setup is NVME

    Isn't it called NVMe?

> SSD device connected to RCAR PCIe controller.

    R=Car.

> Previously there was attempt to handle this via bus notifier: after
> driver is attached to PCI device, bridge driver gets notifier callback,
> and resets dma_mask from there. However, this is racy: PCI device driver
> could already allocate buffers and/or start i/o in probe routine.
> In NVME case, i/o is started in workqueue context, and this race gives
> "sometimes works, sometimes not" effect.
>
> Proper solution should make driver's dma_set_mask() call to fail if host
> bridge can't support mask being set.
>
> This patch makes __swiotlb_dma_supported() to check mask being set for

    "To" not needed here.

> PCI device against dma_mask of struct device corresponding to PCI host
> bridge (one with name "pciXXXX:YY"), if that dma_mask is set.
>
> This is the least destructive approach: currently dma_mask of that device
> object is not used anyhow, thus all existing setups will work as before,
> and modification is required only in actually affected components -
> driver of particular PCI host bridge, and dma_map_ops of particular
> platform.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 290a84f..49645277 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
[...]
> @@ -347,6 +348,16 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>
>  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  {
> +#ifdef CONFIG_PCI
> +	if (dev_is_pci(hwdev)) {
> +		struct pci_dev *pdev = to_pci_dev(hwdev);
> +		struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
> +
> +		if (br->dev.dma_mask && (*br->dev.dma_mask) &&
> +				(mask & (*br->dev.dma_mask)) != mask)

    Hum, inner parens not necessary?

[...]

MBR, Sergei

