Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 19 Sep 2018 16:41:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jim Quinlan <jim2101024@gmail.com>
Subject: Re: [PATCH v5 11/12] ARM64: add dma remap for BrcmSTB PCIe
Message-ID: <20180919144119.GB29096@lst.de>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Brian Norris <computersforpeace@gmail.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 10:32:06AM -0400, Jim Quinlan wrote:
> +#if defined(CONFIG_ARM64)

Please use plain #ifdef where possible.

> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	return brcm_phys_to_dma(dev, paddr);
> +}
> +
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> +{
> +	return brcm_dma_to_phys(dev, dev_addr);
> +}
> +#endif

How is this going to work for a kernel with BrcmSTB built in, but running
on a more standard arm64 SOC?

I suspect we really just want a set of ranges hanging off struct device
(conditional on a config option).  Each SoC can then fill it at boot
time, and if it is non-NULL the DMA code will use it instead of
calling __phys_to_dma and __dma_to_phys.  In fact the single range
version could probably just replace the existing dma_pfn_offset
field.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
