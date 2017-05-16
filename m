Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 16 May 2017 19:59:01 +0530
From: sricharan@codeaurora.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
In-Reply-To: <1825810.fLbCv8umR7@avalon>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
 <1924197.MWBQ7kvoOo@avalon> <5724f819-40db-e830-1ec1-62c887ba39ee@arm.com>
 <1825810.fLbCv8umR7@avalon>
Message-ID: <4484f88d5ce342a3a27a00ef12869acc@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: okaya@codeaurora.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Magnus Damm <magnus.damm@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hanjun Guo <hanjun.guo@linaro.org>, linux-pci <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, tn@semihalf.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm-owner@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 2017-05-16 19:40, Laurent Pinchart wrote:
> Hi Robin,
> 
> On Tuesday 16 May 2017 15:04:55 Robin Murphy wrote:
>> On 16/05/17 08:17, Laurent Pinchart wrote:
>> > On Tuesday 16 May 2017 07:53:57 sricharan@codeaurora.org wrote:
> 
> [snip]
> 
>> >> arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
>> >> ,dma_ops should be cleared in the teardown path. Otherwise
>> >> this causes problem when the probe of device is retried after
>> >> being deferred. The device's iommu structures are cleared
>> >> after EPROBEDEFER error, but on the next try dma_ops will still
>> >> be set to old value, which is not right.
>> >>
>> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> >> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> >> ---
>> >>
>> >>   arch/arm/mm/dma-mapping.c | 1 +
>> >>   1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> >> index ab4f745..a40f03e 100644
>> >> --- a/arch/arm/mm/dma-mapping.c
>> >> +++ b/arch/arm/mm/dma-mapping.c
>> >> @@ -2358,6 +2358,7 @@ static void arm_teardown_iommu_dma_ops(struct
>> >> device *dev)
>> >
>> >>   	__arm_iommu_detach_device(dev);
>> >>   	arm_iommu_release_mapping(mapping);
>> >> +	set_dma_ops(dev, NULL);
>> >>   }
>> >>   #else
>> >
>> > The subject mentions arch_teardown_dma_ops(), which I think is correct,
>> > but the patch adds the set_dma_ops() call to arm_teardown_iommu_dma_ops().
>> >
>> > However, the situation is perhaps more complex. Note the check at the
>> > beginning of arch_setup_dma_ops():
>> > 	/*
>> > 	 * Don't override the dma_ops if they have already been set. Ideally
>> > 	 * this should be the only location where dma_ops are set, remove this
>> > 	 * check when all other callers of set_dma_ops will have disappeared.
>> > 	 */
>> > 	if (dev->dma_ops)
>> > 		return;
>> >
>> > If you set the dma_ops to NULL in arm_teardown_iommu_dma_ops() or
>> > arch_teardown_dma_ops(), the next call to arch_setup_dma_ops() will
>> > override them. To be safe you should only set them to NULL if they have
>> > been set by arch_setup_dma_ops(). More than that, arch_teardown_dma_ops()
>> > should probably not call arm_teardown_iommu_dma_ops() at all if the
>> > dma_ops were set by arm_iommu_attach_device() and not
>> > arch_teardown_dma_ops().
>> 
>> Under what circumstances is that an issue? We'll only be tearing down
>> the DMA ops when unbinding the driver,
> 
> Or when deferring probe.
> 
>> and I think it would be erroneous to expect the device to retain much 
>> state
>> after that. Everything else would be set up from scratch again if it 
>> get
>> reprobed later, so why not the DMA ops?
> 
> Because the DMA ops might have been set elsewhere than 
> arch_setup_dma_ops().
> If you look at the patch that added the above warning, its commit 
> message
> states
> 
> commit 26b37b946a5c2658dbc37dd5d6df40aaa9685d70 (iommu-joerg/arm/core)
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Fri May 15 02:00:02 2015 +0300
> 
>     arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()
> 
>     The arch_setup_dma_ops() function is in charge of setting dma_ops 
> with a
>     call to set_dma_ops(). set_dma_ops() is also called from
> 
>     - highbank and mvebu bus notifiers
>     - dmabounce (to be replaced with swiotlb)
>     - arm_iommu_attach_device
> 
>     (arm_iommu_attach_device is itself called from IOMMU and bus master
>     device drivers)
> 
>     To allow the arch_setup_dma_ops() call to be moved from device add 
> time
>     to device probe time we must ensure that dma_ops already setup by 
> any of
>     the above callers will not be overriden.
> 
>     Aftering replacing dmabounce with swiotlb, converting IOMMU drivers 
> to
>     of_xlate and taking care of highbank and mvebu, the workaround 
> should be
>     removed.
> 
> I'm concerned about potentially breaking these if we unconditionally 
> remove
> the DMA ops and mapping.

arch_teardown_dma_ops does nothing if there is
no mapping (not behind iommu), dma_ops without iommu is ok.
But when the arm_iommu_create_mapping/arm_iommu_attach_device
was called previously in the iommu driver, after we teardown,
that path in the iommu driver which called those functions is not
replayed.

Regards,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
