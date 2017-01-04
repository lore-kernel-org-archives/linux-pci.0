Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170103184444.GP6986@arm.com> <5224989.KFLmAz9Gqk@wuerfel>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <4bbc3494-bf95-9765-ccaf-cc3b3e1cd297@cogentembedded.com>
Date: Wed, 4 Jan 2017 09:24:09 +0300
MIME-Version: 1.0
In-Reply-To: <5224989.KFLmAz9Gqk@wuerfel>
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
 artemi.ivanov@cogentembedded.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> commit 9a57d58d116800a535510053136c6dd7a9c26e25
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Nov 17 14:06:55 2015 +0100
> 
>     [EXPERIMENTAL] ARM64: check implement dma_set_mask
>     
>     Needs work for coherent mask
>     
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Unfortunately this is far incomplete

> @@ -957,6 +983,18 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	if (!dev->archdata.dma_ops)
>  		dev->archdata.dma_ops = &swiotlb_dma_ops;
>  
> +	/*
> +	 * we don't yet support buses that have a non-zero mapping.
> +	 *  Let's hope we won't need it
> +	 */
> +	WARN_ON(dma_base != 0);
> +
> +	/*
> +	 * Whatever the parent bus can set. A device must not set
> +	 * a DMA mask larger than this.
> +	 */
> +	dev->archdata.parent_dma_mask = size;
> +

... because size/mask passed here for PCI devices are meaningless.

For OF platforms, this is called via of_dma_configure(), that checks
dma-ranges of node that is *parent* for host bridge. Host bridge
currently does not control this at all.

In current device trees no dma-ranges is defined for nodes that are
parents to pci host bridges. This will make of_dma_configure() to fall
back to 32-bit size for all devices on all current platforms.  Thus
applying this patch will immediately break 64-bit dma masks on all
hardware that supports it.


Also related: dma-ranges property used by several pci host bridges is
*not* compatible with "legacy" dma-ranges parsed by of_get_dma_range() -
former uses additional flags word at beginning.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
