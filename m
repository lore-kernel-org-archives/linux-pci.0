Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V2 2/3] iommu: of: Ignore all errors except EPROBE_DEFER
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <1495102030-10548-1-git-send-email-sricharan@codeaurora.org>
 <1495102030-10548-2-git-send-email-sricharan@codeaurora.org>
 <6863998.WsTHer29ZI@avalon>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <2c3babb3-7bee-340c-d474-267a55f23cd5@codeaurora.org>
Date: Thu, 18 May 2017 17:26:14 +0530
MIME-Version: 1.0
In-Reply-To: <6863998.WsTHer29ZI@avalon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org,
 frowand.list@gmail.com, m.szyprowski@samsung.com, linux-arch@vger.kernel.org,
 lorenzo.pieralisi@arm.com, tn@semihalf.com, joro@8bytes.org,
 magnus.damm@gmail.com, linux-acpi@vger.kernel.org, geert@linux-m68k.org,
 catalin.marinas@arm.com, lenb@kernel.org, devicetree@vger.kernel.org,
 arnd@arndb.de, linux-arm-msm@vger.kernel.org, j.neuschaefer@gmx.net,
 robh+dt@kernel.org, bhelgaas@google.com,
 laurent.pinchart+renesas@ideasonboard.com,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Laurent,

On 5/18/2017 4:09 PM, Laurent Pinchart wrote:
> Hi Sricharan,
> 
> Thank you for the patch.
> 
> On Thursday 18 May 2017 15:37:09 Sricharan R wrote:
>> While deferring the probe of IOMMU masters,
>> xlate and add_device callback can pass back error values
>> like -ENODEV, which means IOMMU cannot be connected
>> with that master for real reasons. So rather than
>> killing the master's probe for such errors, just
>> ignore the errors and let the master work without
>> an IOMMU.
> 
> I don't think this is a good idea. Why should we allow IOMMU drivers to return 
> an error if we're always going to ignore the error value ? That will lead to 
> drivers implementing slightly different behaviours, which will be painful the 
> day we'll need to start acting based on the error value.
> 

The of_iommu_configure interface, before this series, was returning either
correct 'iommu_ops' or NULL. Also there was no return value from
of_dma_configure which calls of_iommu_configure. This means that if we block
only -ENODEV now and let the other errors, the probe of the master devices
can be killed for reasons apart from deferring. This would be a change in
behavior introduced. All of xlate, add_device, of_pci_map_rid and others
can return values apart from -ENODEV. So was thinking that restoring the
old behavior, except for returning EPROBE_DEFER was the better thing to do ? 

Regards,
 Sricharan

> At the very least, if you want to give a specific meaning to -ENODEV, you 
> should check for that value specifically and not ignore all errors other than 
> -EPROBE_DEFER. You also need to document the meaning of the error value. This 
> can be done in the documentation of the of_xlate operation in 
> include/linux/iommu.h:
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 2cb54adc4a33..6ba553e7384a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -181,7 +181,6 @@ struct iommu_resv_region {
>   * @domain_window_disable: Disable a particular window for a domain
>   * @domain_set_windows: Set the number of windows for a domain
>   * @domain_get_windows: Return the number of windows for a domain
> - * @of_xlate: add OF master IDs to iommu grouping
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>   */
>  struct iommu_ops {
> @@ -224,6 +223,11 @@ struct iommu_ops {
>  	/* Get the number of windows per domain */
>  	u32 (*domain_get_windows)(struct iommu_domain *domain);
>  
> +	/**
> +	 * @of_xlate:
> +	 *
> +	 * Add OF master IDs to iommu grouping.
> +	 */
>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>  
>  	unsigned long pgsize_bitmap;
> 
> 
> And add documentation for the error codes there.
> 
> If you want to ignore some errors returned from the add_device operation you 
> should document it similarly, and in particular document which error check(s) 
> need to be performed by of_xlate and which are the responsibility of 
> add_device.
> 
>> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred
>> probing or error")
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Tested-by: Magnus Damn <magnus.damn@gmail.com>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>> [V2] Corrected spelling/case in commit log
>>
>>  drivers/iommu/of_iommu.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index e6e9bec..f0d22c0 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -237,6 +237,12 @@ const struct iommu_ops *of_iommu_configure(struct
>> device *dev, ops = ERR_PTR(err);
>>  	}
>>
>> +	/* Ignore all other errors apart from EPROBE_DEFER */
>> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
>> +		dev_info(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
>> +		ops = NULL;
>> +	}
>> +
>>  	return ops;
>>  }
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
