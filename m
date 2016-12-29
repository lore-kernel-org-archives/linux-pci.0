Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
Date: Thu, 29 Dec 2016 22:18:41 +0100
Message-ID: <2103911.qf9H68dkRp@wuerfel>
In-Reply-To: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 artemi.ivanov@cogentembedded.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 29, 2016 11:45:03 PM CET Nikita Yushchenko wrote:
> 
>  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  {
> +#ifdef CONFIG_PCI
> +       if (dev_is_pci(hwdev)) {
> +               struct pci_dev *pdev = to_pci_dev(hwdev);
> +               struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
> +
> +               if (br->dev.dma_mask && (*br->dev.dma_mask) &&
> +                               (mask & (*br->dev.dma_mask)) != mask)
> +                       return 0;
> +       }
> +#endif
>         if (swiotlb)
>                 return swiotlb_dma_supported(hwdev, mask);
>         return 1;
> 

I think it's wrong to make this a special case for PCI.

Instead, we should follow the dma-ranges properties during dma_set_mask()
to ensure we don't set a mask that any of the parents up to the root
cannot support.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
