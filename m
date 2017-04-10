Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 01/30] iommu/arm-smmu-v3: Link groups and devices
To: Robin Murphy <robin.murphy@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-2-jean-philippe.brucker@arm.com>
 <9ce9e3c5-3f94-8b06-2bd7-a665f0f33304@arm.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <91a0ac80-139b-0631-a743-e2a3861a51bf@arm.com>
Date: Mon, 10 Apr 2017 12:02:31 +0100
MIME-Version: 1.0
In-Reply-To: <9ce9e3c5-3f94-8b06-2bd7-a665f0f33304@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 27/03/17 13:18, Robin Murphy wrote:
> Hi Jean-Philippe,
> 
> On 27/02/17 19:54, Jean-Philippe Brucker wrote:
>> Reintroduce smmu_group. This structure was removed during the generic DT
>> bindings rework, but will be needed when implementing PCIe ATS, to lookup
>> devices attached to a given domain.
>>
>> When unmapping from a domain, we need to send an invalidation to all
>> devices that could have stored the mapping in their ATC. It would be nice
>> to use IOMMU API's iommu_group_for_each_dev, but that list is protected by
>> group->mutex, which we can't use because atc_invalidate won't be allowed
>> to sleep. So add a list of devices, protected by a spinlock.
> 
> Much as I dislike that particular duplication, with patch #4 in mind I
> think there's a more fundamental problem - since the primary reason for
> multi-device groups is lack of ACS, is there any guarantee that ATS
> support/enablement will be actually be homogeneous across any old set of
> devices in that situation, and thus valid to evaluate at the iommu_group
> level?

I doubt that support of ATS in group would be homogeneous, so I also test
ats bit in pci_device structure before sending a command, making the group
check an optimization.

> That said, looking at how things end up at the top commit, I think this
> is fairly easily sidestepped. We have this pattern a few times:
> 
> 	spin_lock_irqsave(&smmu_domain->groups_lock)
> 	list_for_each_entry(&smmu_domain->groups)
> 		spin_lock(&smmu_group->devices_lock)
> 		list_for_each_entry(&smmu_group->devices)
> 			do a thing for each device in the domain...
> 
> which strongly suggests that we'd be better off just linking the devices
> to the domain directly - which would also let us scope ats_enabled to
> the per-device level which seems safer than per-group as above. And if
> only devices with ATS enabled are added to a domain's list in the first
> place, then ATC invalidate gets even simpler too.
> 
> The only other uses I can see are of smmu_group->domain, which always
> looks to be directly equivalent to to_smmu_domain(iommu_group->domain).
> Overall it really looks like the smmu_group abstraction winds up making
> the end result more complex than it needs to be.

Yes in retrospect, smmu_group hardly seems necessary. I'll work on getting
rid of it.

Thanks,
Jean-Philippe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
