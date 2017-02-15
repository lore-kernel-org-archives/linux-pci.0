Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 14 Feb 2017 22:53:35 -0500
From: okaya@codeaurora.org
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] iommu: add warning when sharing groups
In-Reply-To: <20170214165155.7c49485e@t450s.home>
References: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
 <1487107522-8695-2-git-send-email-okaya@codeaurora.org>
 <20170214165155.7c49485e@t450s.home>
Message-ID: <e7535138133c514c77004d64e40b4180@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-02-14 18:51, Alex Williamson wrote:
> On Tue, 14 Feb 2017 16:25:22 -0500
> Sinan Kaya <okaya@codeaurora.org> wrote:
> 
>> The ACS requirement has been obscured in the current code and is only
>> known by certain individuals who happen to read the code. Print out a
>> warning with ACS path failure when ACS requirement is not met.
>> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/iommu/iommu.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index dbe7f65..049ee0a 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -811,6 +811,9 @@ struct iommu_group *pci_device_group(struct device 
>> *dev)
>>  	if (IS_ERR(group))
>>  		return NULL;
>> 
>> +	if (pci_is_root_bus(bus))
>> +		dev_warn_once(&pdev->dev, "using shared group due to ACS path 
>> failure\n");
>> +
>>  	return group;
>>  }
>> 
> 
> The premise here is flawed.  An IOMMU group based at the root bus
> doesn't necessarily imply a lack of ACS.  There are devices on root
> buses, integrated endpoints and root ports.  Naturally an IOMMU group
> for these devices needs to be based at the root bus.  Additionally,
> there can be IOMMU groups developed around a lack of ACS that don't
> intersect with the root bus.  Since this is a warn_once, the false
> positives for root bus devices are going to be enumerated first.  On an
> Intel system there's typically a device as 00.0 that will always be
> pointlessly listed first.  Also, it's not clear that grouping devices
> together is always wrong, as Robin pointed out in the EHCI/OHCI
> example.  Lack of ACS on downtream ports is likely to cause problems,
> especially if that downstream port exposes a slot.  Maybe that would be
> a good place to start.  Also, what is someone supposed to do when they
> see this error?  If we can hope they'll look for the error in the code
> (unlikely) a big comment with useful external links might be
> necessary.  Based on how easily vendors ignore kernel warnings, I'm
> dubious there's any value to this path though.  Thanks,

Maybe, a better solution would be to add some sentences into vfio.txt 
documentation.

I'm ready to drop this patch. I just don't want ACS requirement to be 
hidden between the source code.

Would you be willing to do that?

I know I read all pci and vfio documents in the past. I could have 
captured this requirement if it was there.

> 
> Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
