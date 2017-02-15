Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 2/2] iommu: add warning when sharing groups
To: Alex Williamson <alex.williamson@redhat.com>
References: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
 <1487107522-8695-2-git-send-email-okaya@codeaurora.org>
 <20170214165155.7c49485e@t450s.home>
 <e7535138133c514c77004d64e40b4180@codeaurora.org>
 <20170215123613.1df4b33a@t450s.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9a327a29-ec4c-e936-13c1-675ec6d17df2@codeaurora.org>
Date: Wed, 15 Feb 2017 16:43:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170215123613.1df4b33a@t450s.home>
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
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2/15/2017 2:36 PM, Alex Williamson wrote:
> On Tue, 14 Feb 2017 22:53:35 -0500
> okaya@codeaurora.org wrote:
> 
>> On 2017-02-14 18:51, Alex Williamson wrote:
>>> On Tue, 14 Feb 2017 16:25:22 -0500
>>> Sinan Kaya <okaya@codeaurora.org> wrote:
>>>   
>>>> The ACS requirement has been obscured in the current code and is only
>>>> known by certain individuals who happen to read the code. Print out a
>>>> warning with ACS path failure when ACS requirement is not met.
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> ---
>>>>  drivers/iommu/iommu.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index dbe7f65..049ee0a 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -811,6 +811,9 @@ struct iommu_group *pci_device_group(struct device 
>>>> *dev)
>>>>  	if (IS_ERR(group))
>>>>  		return NULL;
>>>>
>>>> +	if (pci_is_root_bus(bus))
>>>> +		dev_warn_once(&pdev->dev, "using shared group due to ACS path 
>>>> failure\n");
>>>> +
>>>>  	return group;
>>>>  }
>>>>   
>>>
>>> The premise here is flawed.  An IOMMU group based at the root bus
>>> doesn't necessarily imply a lack of ACS.  There are devices on root
>>> buses, integrated endpoints and root ports.  Naturally an IOMMU group
>>> for these devices needs to be based at the root bus.  Additionally,
>>> there can be IOMMU groups developed around a lack of ACS that don't
>>> intersect with the root bus.  Since this is a warn_once, the false
>>> positives for root bus devices are going to be enumerated first.  On an
>>> Intel system there's typically a device as 00.0 that will always be
>>> pointlessly listed first.  Also, it's not clear that grouping devices
>>> together is always wrong, as Robin pointed out in the EHCI/OHCI
>>> example.  Lack of ACS on downtream ports is likely to cause problems,
>>> especially if that downstream port exposes a slot.  Maybe that would be
>>> a good place to start.  Also, what is someone supposed to do when they
>>> see this error?  If we can hope they'll look for the error in the code
>>> (unlikely) a big comment with useful external links might be
>>> necessary.  Based on how easily vendors ignore kernel warnings, I'm
>>> dubious there's any value to this path though.  Thanks,  
>>
>> Maybe, a better solution would be to add some sentences into vfio.txt 
>> documentation.
>>
>> I'm ready to drop this patch. I just don't want ACS requirement to be 
>> hidden between the source code.
>>
>> Would you be willing to do that?
>>
>> I know I read all pci and vfio documents in the past. I could have 
>> captured this requirement if it was there.
> 
> We already have this:
> 
> Documentation/vfio.txt:
> ...
> This isolation is not always at the granularity of a single device
> though.  Even when an IOMMU is capable of this, properties of devices,
> interconnects, and IOMMU topologies can each reduce this isolation.
> For instance, an individual device may be part of a larger multi-
> function enclosure.  While the IOMMU may be able to distinguish
> between devices within the enclosure, the enclosure may not require
> transactions between devices to reach the IOMMU.  Examples of this
> could be anything from a multi-function PCI device with backdoors
> between functions to a non-PCI-ACS (Access Control Services) capable
> bridge allowing redirection without reaching the IOMMU.  Topology
> can also play a factor in terms of hiding devices.  A PCIe-to-PCI
> bridge masks the devices behind it, making transaction appear as if
> from the bridge itself.  Obviously IOMMU design plays a major factor
> as well.
> ...
> 
> Additionally if you google for "iommu group", this is the first hit:
> 
> http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html
> 
> This talks extensively about ACS.  A few hits below that you can find a
> presentation I've given with ACS examples.  What additional
> documentation do you think would have helped you discover or understand
> this problem earlier?
> 
> I agree that device isolation is not a spec requirement.  The specs
> give us the tools that we need, but valid uses cases exist where a lack
> of isolation may be preferred.  If we logically deduce how we can give
> a device or set of devices to a user for an untrusted environment,
> isolated from other devices, I think it's pretty logical to come to the
> conclusion that ACS is the only way that PCIe hardware can allow that
> sort of control in a standard way.  Clearly we also recognize that this
> is a commonly overlooked area where hardware vendors may fail to
> incorporate this subtly into their platform design guidelines and thus
> we have numerous quirks for exposing virtual ACS-like isolation.  The
> hope is that adding a quirk for this devices means that feedback was
> provided to the hardware teams and system architects within the
> companies developing these devices to consider this use case and
> implement native ACS in the next generation.  Thanks,


I see, Maybe I was not familiar with ACS to understand these words
by the time I read it.


> 
> Alex
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
