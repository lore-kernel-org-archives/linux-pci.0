Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2 03/15] arm64: mm: change IOMMU notifier action to
 attach DMA ops
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	iommu@lists.linux-foundation.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-4-git-send-email-lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>
Message-ID: <5763C27A.9030306@arm.com>
Date: Fri, 17 Jun 2016 10:27:22 +0100
MIME-Version: 1.0
In-Reply-To: <1465306270-27076-4-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

I think this patch makes sense even independent of the rest of the 
series, one nit inline notwithstanding.

Marek; I'm curious as to whether this could make the workaround in 
722ec35f7 obsolete as well, or are all the drivers also bound 
super-early in the setup you had there?

On 07/06/16 14:30, Lorenzo Pieralisi wrote:
> Current bus notifier in ARM64 (__iommu_attach_notifier)
> attempts to attach dma_ops to a device on BUS_NOTIFY_ADD_DEVICE
> action notification.
>
> This causes issues on ACPI based systems, where PCI devices
> can be added before the IOMMUs the devices are attached to
> had a chance to be probed, causing failures on attempts to
> attach dma_ops in that the domain for the respective IOMMU
> may not be set-up yet by the time the bus notifier is run.
>
> Devices dma_ops do not require to be set-up till the matching
> device drivers are probed. This means that instead of running
> the notifier attaching dma_ops to devices (__iommu_attach_notifier)
> on BUS_NOTIFY_ADD_DEVICE action, it can be run just before the
> device driver is bound to the device in question (on action
> BUS_NOTIFY_BIND_DRIVER) so that it is certain that its IOMMU
> group and domain are set-up accordingly at the time the
> notifier is triggered.
>
> This patch changes the notifier action upon which dma_ops
> are attached to devices and defer it to driver binding time,
> so that IOMMU devices have a chance to be probed and to register
> their bus notifiers before the dma_ops attach sequence for a
> device is actually carried out.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>   arch/arm64/mm/dma-mapping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index c566ec8..79b0882 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -848,7 +848,7 @@ static int __iommu_attach_notifier(struct notifier_block *nb,
>   {
>   	struct iommu_dma_notifier_data *master, *tmp;
>
> -	if (action != BUS_NOTIFY_ADD_DEVICE)
> +	if (action != BUS_NOTIFY_BIND_DRIVER)

With this, you can also get rid of the priority setting and big fat 
explanatory comment in register_iommu_dma_ops_notifier().

Robin.

>   		return 0;
>
>   	mutex_lock(&iommu_dma_notifier_lock);
>

