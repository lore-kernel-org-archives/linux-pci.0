Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 0/1] Fix kernel panic caused by device ID duplication
 presented to the IOMMU
To: Robin Murphy <robin.murphy@arm.com>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        joro@8bytes.org, will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc: Jayachandran.Nair@cavium.com, Ganapatrao.Kulkarni@cavium.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, mw@semihalf.com, stable@vger.kernel.org
References: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <7f7fca76-88f8-6ee7-c402-fe4300c62253@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <15883568-4cf6-b88c-8ee9-cf643c5e96f2@semihalf.com>
Date: Fri, 22 Dec 2017 12:29:08 +0100
MIME-Version: 1.0
In-Reply-To: <7f7fca76-88f8-6ee7-c402-fe4300c62253@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robin,

On 19.12.2017 17:34, Robin Murphy wrote:
> Hi Tomasz,
> 
> On 19/12/17 15:13, Tomasz Nowicki wrote:
>> Here is my lspci output of ThunderX2 for which I am observing kernel 
>> panic coming from
>> SMMUv3 driver -> arm_smmu_write_strtab_ent() -> BUG_ON(ste_live):
>>
>> # lspci -vt
>> -[0000:00]-+-00.0-[01-1f]--+ [...]
>>                             + [...]
>>                             \-00.0-[1e-1f]----00.0-[1f]----00.0  
>> ASPEED Technology, Inc. ASPEED Graphics Family
>>
>> ASP device -> 1f:00.0 VGA compatible controller: ASPEED Technology, 
>> Inc. ASPEED Graphics Family
>> PCI-Express to PCI/PCI-X Bridge -> 1e:00.0 PCI bridge: ASPEED 
>> Technology, Inc. AST1150 PCI-to-PCI Bridge
>> While setting up ASP device SID in IORT dirver:
>> iort_iommu_configure() -> pci_for_each_dma_alias()
>> we need to walk up and iterate over each device which alias 
>> transaction from
>> downstream devices.
>>
>> AST device (1f:00.0) gets BDF=0x1f00 and corresponding SID=0x1f00 from 
>> IORT.
>> Bridge (1e:00.0) is the first alias. Following PCI Express to 
>> PCI/PCI-X Bridge
>> spec: PCIe-to-PCI/X bridges alias transactions from downstream devices 
>> using
>> the subordinate bus number. For bridge (1e:00.0), the subordinate is 
>> equal
>> to 0x1f. This gives BDF=0x1f00 and SID=1f00 which is the same as 
>> downstream
>> device. So it is possible to have two identical SIDs. The question is 
>> what we
>> should do about such case. Presented patch prevents from registering 
>> the same
>> ID so that SMMUv3 is not complaining later on.
> 
> Ooh, subtle :( There is logic in arm_smmu_attach_device() to tolerate
> grouped devices aliasing to the same ID, but I guess I overlooked the
> distinction of a device sharing an alias ID with itself. I'm not sure
> I really like trying to work around this in generic code, since
> fwspec->ids is essentially opaque data in a driver-specific format - in
> theory a driver is free to encode a single logical ID into multiple
> fwspec elements (I think I did that in an early draft of SMMUv2 SMR
> support), at which point this approach might corrupt things massively.
> 
> Does the (untested) diff below suffice?
> 
> Robin.
> 
> ----->8-----diff --git a/drivers/iommu/arm-smmu-v3.c 
> b/drivers/iommu/arm-smmu-v3.c
> index f122071688fd..d8a730d83401 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1731,7 +1731,7 @@ static __le64 *arm_smmu_get_step_for_sid(struct 
> arm_smmu_device *smmu, u32 sid)
> 
>   static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
>   {
> -    int i;
> +    int i, j;
>       struct arm_smmu_master_data *master = fwspec->iommu_priv;
>       struct arm_smmu_device *smmu = master->smmu;
> 
> @@ -1739,6 +1739,13 @@ static void arm_smmu_install_ste_for_dev(struct 
> iommu_fwspec *fwspec)
>           u32 sid = fwspec->ids[i];
>           __le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
> 
> +        /* Bridged PCI devices may end up with duplicated IDs */
> +        for (j = 0; j < i; j++)
> +            if (fwspec->ids[j] == sid)
> +                break;
> +        if (j < i)
> +            continue;
> +
>           arm_smmu_write_strtab_ent(smmu, sid, step, &master->ste);
>       }
>   }

The patch works for me:

Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>

The bug causes a regression on our platform and would be nice to fix it 
for 4.15. Since no more comments so far, IMO we can put the fix to 
SMMUv3 driver. Do you prefer to send patch yourself or would you like me 
to do it?

Thanks,
Tomasz
