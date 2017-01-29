Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
To: Sricharan R <sricharan@codeaurora.org>, robin.murphy@arm.com,
 will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <34a703f0-3b37-88f0-46fa-b56ab6717a42@codeaurora.org>
Date: Sun, 29 Jan 2017 11:36:16 -0500
MIME-Version: 1.0
In-Reply-To: <1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
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

On 1/23/2017 11:18 AM, Sricharan R wrote:
> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>  	if (ret < 0) {
>  		dma_addr = offset = 0;
> -		size = dev->coherent_dma_mask + 1;
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  	} else {

what's happening here?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
