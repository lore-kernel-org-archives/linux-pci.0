Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 4/9] arm64: dma-mapping: export symbol arch_setup_dma_ops
To: Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-5-git-send-email-jim2101024@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a8fa87e4-4d70-eb60-f1c5-94071d6394aa@arm.com>
Date: Thu, 12 Oct 2017 18:06:48 +0100
MIME-Version: 1.0
In-Reply-To: <1507761269-7017-5-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/10/17 23:34, Jim Quinlan wrote:
> The BrcmSTB driver needs to get ahold of a pointer to swiotlb_dma_ops.
> However, that variable is defined as static.  Instead, we use
> arch_setup_dma_ops() to get the pointer to swiotlb_dma_ops.  Since
> we also want our driver to be a separate module, we need to
> export this function.

NAK. Retrieve the platform-assigned ops from the device via
get_dma_ops() and stash them in your drvdata or wherever before you
replace them. Don't go poking around arch code internals directly from a
driver.

Robin.

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 614af88..dae572f 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -936,3 +936,4 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	}
>  #endif
>  }
> +EXPORT_SYMBOL(arch_setup_dma_ops);
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
