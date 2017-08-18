Return-Path: <SRS0=idZX=7U=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=idZX=7U=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH v2 4/4] iommu: Prevent VMD child devices from being
 remapping targets
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Keith Busch <keith.busch@intel.com>,
 Scott Bauer <scott.bauer@intel.com>, David Fugate <david.fugate@intel.com>,
 linux-kernel@vger.kernel.org
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
 <20170817181014.1257-5-jonathan.derrick@intel.com>
 <20170818160433.GN28977@bhelgaas-glaptop.roam.corp.google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <632c5063-97aa-98b8-7951-65d4aed692a7@arm.com>
Date: Fri, 18 Aug 2017 17:35:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170818160433.GN28977@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 18/08/17 17:04, Bjorn Helgaas wrote:
> [+cc Robin]
> 
> This series looks fine to me as far as PCI is concerned, and I'd be
> happy to take it via my tree given an ack from David for this IOMMU
> piece.  Alternatively, you can add my
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> to the other patches if you want to take it via another tree.
> 
> Robin raised a question about basically this same patch the first time
> around.  Not sure whether there's still an objection there.

Oh, I don't actually mind the patch as-is - implementing proper IOMMU
group support for VMD almost certainly should be the longer-term goal,
but for all I know that may be non-trivial so in the meantime a quick
and simple way to make things safe is good, however heavy-handed.

Robin.

> On Thu, Aug 17, 2017 at 12:10:14PM -0600, Jon Derrick wrote:
>> VMD child devices must use the VMD endpoint's ID as the requester.
>> Because of this, there needs to be a way to link the parent VMD
>> endpoint's iommu group and associated mappings to the VMD child devices
>> such that attaching and detaching child devices modify the endpoint's
>> mappings, while preventing early detaching on a singular device removal
>> or unbinding.
>>
>> The reassignment of individual VMD child devices devices to VMs is
>> outside the scope of VMD, but may be implemented in the future. For now
>> it is best to prevent any such attempts.
>>
>> This patch prevents VMD child devices from returning an IOMMU, which
>> prevents it from exposing an iommu_group sysfs directories and allowing
>> subsequent binding by userspace-access drivers such as VFIO.
>>
>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 687f18f..94353a6e 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -901,6 +901,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>>  		struct pci_dev *pf_pdev;
>>  
>>  		pdev = to_pci_dev(dev);
>> +
>> +		/* VMD child devices currently cannot be handled individually */
>> +		if (is_vmd(pdev->bus))
>> +			return NULL;
>> +
>>  		/* VFs aren't listed in scope tables; we need to look up
>>  		 * the PF instead to find the IOMMU. */
>>  		pf_pdev = pci_physfn(pdev);
>> -- 
>> 2.9.4
>>
