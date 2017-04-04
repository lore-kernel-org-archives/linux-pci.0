Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V10 06/12] of: device: Fix overflow of coherent_dma_mask
To: Sricharan R <sricharan@codeaurora.org>, will.deacon@arm.com,
 joro@8bytes.org, lorenzo.pieralisi@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org,
 robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de,
 linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-7-git-send-email-sricharan@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <906032bd-8f3d-f34c-7c0f-0222c39fb552@arm.com>
Date: Tue, 4 Apr 2017 12:10:51 +0100
MIME-Version: 1.0
In-Reply-To: <1491301105-5274-7-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/04/17 11:18, Sricharan R wrote:
> Size of the dma-range is calculated as coherent_dma_mask + 1
> and passed to arch_setup_dma_ops further. It overflows when
> the coherent_dma_mask is set for full 64 bits 0xFFFFFFFFFFFFFFFF,
> resulting in size getting passed as 0 wrongly. Fix this by
> passsing in max(mask, mask + 1). Note that in this case
> when the mask is set to full 64bits, we will be passing the mask
> itself to arch_setup_dma_ops instead of the size. The real fix
> for this should be to make arch_setup_dma_ops receive the
> mask and handle it, to be done in the future.

Agreed; in the meantime, this fix is neat and robust enough.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index c17c19d..c2ae6bb 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>  	if (ret < 0) {
>  		dma_addr = offset = 0;
> -		size = dev->coherent_dma_mask + 1;
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  	} else {
>  		offset = PFN_DOWN(paddr - dma_addr);
>  		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
