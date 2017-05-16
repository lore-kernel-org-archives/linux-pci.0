Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 16 May 2017 07:56:08 +0530
From: sricharan@codeaurora.org
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
In-Reply-To: <20170515142238.GD3605@arm.com>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
 <1486136933-20328-8-git-send-email-sricharan@codeaurora.org>
 <CAMuHMdV05uCcVss+V1E+_OQYosJO6P95rU1WynV-G08-iHJnyg@mail.gmail.com>
 <2bfd11dc-9f94-2b69-7b03-c640e53155e1@arm.com>
 <26defadf-6380-4af4-6323-b51198376bc1@codeaurora.org>
 <20170515142238.GD3605@arm.com>
Message-ID: <c9c3cdcc43eba9b9aa68fa750b61a099@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: okaya@codeaurora.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hanjun Guo <hanjun.guo@linaro.org>, linux-pci <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, tn@semihalf.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Will,

On 2017-05-15 19:52, Will Deacon wrote:
> Hi Sricharan,
> 
> On Wed, May 03, 2017 at 03:54:59PM +0530, Sricharan R wrote:
>> On 5/3/2017 3:24 PM, Robin Murphy wrote:
>> > On 02/05/17 19:35, Geert Uytterhoeven wrote:
>> >> On Fri, Feb 3, 2017 at 4:48 PM, Sricharan R <sricharan@codeaurora.org> wrote:
>> >>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> >>>
>> >>> Failures to look up an IOMMU when parsing the DT iommus property need to
>> >>> be handled separately from the .of_xlate() failures to support deferred
>> >>> probing.
>> >>>
>> >>> The lack of a registered IOMMU can be caused by the lack of a driver for
>> >>> the IOMMU, the IOMMU device probe not having been performed yet, having
>> >>> been deferred, or having failed.
>> >>>
>> >>> The first case occurs when the device tree describes the bus master and
>> >>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>> >>> or the device driver has not been compiled in. Return NULL, the caller
>> >>> will configure the device without an IOMMU.
>> >>>
>> >>> The second and third cases are handled by deferring the probe of the bus
>> >>> master device which will eventually get reprobed after the IOMMU.
>> >>>
>> >>> The last case is currently handled by deferring the probe of the bus
>> >>> master device as well. A mechanism to either configure the bus master
>> >>> device without an IOMMU or to fail the bus master device probe depending
>> >>> on whether the IOMMU is optional or mandatory would be a good
>> >>> enhancement.
>> >>>
>> >>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> >>> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
>> >>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> >>
>> >> This patch broke Renesas R-Car Gen3 platforms in renesas-drivers.
>> >> As the IOMMU nodes in DT are not yet enabled, all devices having iommus
>> >> properties in DT now fail to probe.
>> >
>> > How exactly do they fail to probe? Per d7b0558230e4, if there are no ops
>> > registered then they should merely defer until we reach the point of
>> > giving up and ignoring the IOMMU. Is it just that you have no other
>> > late-probing drivers or post-init module loads to kick the deferred
>> > queue after that point? I did try to find a way to explicitly kick it
>> > from a suitably late initcall, but there didn't seem to be any obvious
>> > public interface - anyone have any suggestions?
>> >
>> > I think that's more of a general problem with the probe deferral
>> > mechanism itself (I've seen the same thing happen with some of the
>> > CoreSight stuff on Juno due to the number of inter-component
>> > dependencies) rather than any specific fault of this series.
>> >
>> 
>> I was thinking of an additional check like below to avoid the
>> situation ?
>> 
>> From 499b6e662f60f23740b8880882b0a16f16434501 Mon Sep 17 00:00:00 2001
>> From: Sricharan R <sricharan@codeaurora.org>
>> Date: Wed, 3 May 2017 13:16:59 +0530
>> Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
>> 
>> While returning EPROBE_DEFER for iommu masters
>> take in to account of iommu nodes that could be
>> marked in DT as 'status=disabled', in which case
>> simply return NULL and let the master's probe
>> continue rather than deferring.
>> 
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/iommu/of_iommu.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 9f44ee8..e6e9bec 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct 
>> device_node *np)
>> 
>>         ops = iommu_ops_from_fwnode(fwnode);
>>         if ((ops && !ops->of_xlate) ||
>> +           !of_device_is_available(iommu_spec->np) ||
>>             (!ops && !of_iommu_driver_present(iommu_spec->np)))
>>                 return NULL;
> 
> Without this patch, v4.12-rc1 hangs on my Juno waiting to mount the 
> root
> filesystem. The problem is that the USB controller is behind an SMMU 
> which
> is marked as 'status = "disabled"' in the devicetree. Whilst there was 
> a
> separate thread with Ard about exactly what this means in terms of the 
> DMA
> ops used by upstream devices, your patch above fixes the regression and
> I think should go in regardless. The DMA ops issue will likely require
> an additional DT binding anyway, to advertise the behaviour of the
> IOMMU when it is disabled.
> 
> Tested-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Could you resend it as a proper patch, please?

Sure, will send this as a separate patch.

Regards,
  Sricharan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
