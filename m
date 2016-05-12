Return-Path: <xyjxie@linux.vnet.ibm.com>
Return-Path: <xyjxie@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio
 page is exclusive
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1462966459-12459-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160511151034.GB21753@localhost>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
        zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
        gwshan@linux.vnet.ibm.com, kevin.tian@intel.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <6be14833-2a0f-8dd8-5bb1-b932850521f2@linux.vnet.ibm.com>
Date: Thu, 12 May 2016 13:56:45 +0800
MIME-Version: 1.0
In-Reply-To: <20160511151034.GB21753@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 2016/5/11 23:10, Bjorn Helgaas wrote:

> On Wed, May 11, 2016 at 07:34:19PM +0800, Yongji Xie wrote:
>> Current vfio-pci implementation disallows to mmap
>> sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
>> page may be shared with other BARs. This will cause some
>> performance issues when we passthrough a PCI device with
>> this kind of BARs. Guest will be not able to handle the mmio
>> accesses to the BARs which leads to mmio emulations in host.
>>
>> However, not all sub-page BARs will share page with other BARs.
>> We should allow to mmap the sub-page MMIO BARs which we can
>> make sure will not share page with other BARs.
>>
>> This patch adds support for this case. And we try to add some
>> dummy resources to reserve the remaind of the page which
>> hot-add device's BAR might be assigned into.
> This is starting to look more reasonable from a safety perspective.
> At least I don't have an allergic reaction to mapping a page that may
> contain BARs from other random devices :)
>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci.c         |   85 ++++++++++++++++++++++++++++++++---
>>   drivers/vfio/pci/vfio_pci_private.h |    8 ++++
>>   2 files changed, 86 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 98059df..33282b8 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -110,16 +110,77 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>>   	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>>   }
>>   
>> +static bool vfio_pci_bar_mmap_supported(struct vfio_pci_device *vdev, int index)
>> +{
>> +	struct resource *res = vdev->pdev->resource + index;
>> +	struct vfio_pci_dummy_resource *dummy_res1 = NULL;
>> +	struct vfio_pci_dummy_resource *dummy_res2 = NULL;
>> +
>> +	if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) && res->flags & IORESOURCE_MEM &&
>> +		resource_size(res) > 0) {
>> +		if (resource_size(res) >= PAGE_SIZE)
>> +			return true;
>> +
>> +		if ((res->start & ~PAGE_MASK)) {
>> +			/*
>> +			 * Add a dummy resource to reserve the portion
>> +			 * before res->start in exclusive page in case
>> +			 * that hot-add device's bar is assigned into it.
>> +			 */
>> +			dummy_res1 = kzalloc(sizeof(*dummy_res1), GFP_KERNEL);
> Should check for kzalloc() failure here.
>
>> +			dummy_res1->resource.start = res->start & PAGE_MASK;
>> +			dummy_res1->resource.end = res->start - 1;
>> +			dummy_res1->resource.flags = res->flags;
>> +			if (request_resource(res->parent,
>> +						&dummy_res1->resource)) {
>> +				kfree(dummy_res1);
>> +				return false;
>> +			}
>> +			dummy_res1->index = index;
>> +			list_add(&dummy_res1->res_next,
>> +					&vdev->dummy_resources_list);
> The main body of this function is unnecessarily indented.  If you did
> this it would be less indented:
>
>    if (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP))
>      return false;
>
>    if (!res->flags & IORESOURCE_MEM)
>      return false;
>
>    /*
>     * Not sure this is necessary; the PCI core *shouldn't* set up a
>     * resource with a type but zero size.  But there may be bugs that
>     * cause us to do that.
>     */
>    if (!resource_size(res))
>      return false;
>
>    if (resource_size(res) >= PAGE_SIZE)
>      return true;
>
>    if ((res->start & ~PAGE_MASK)) {
>      ...
>

Thanks for your comments. I'll send a v3 soon.

Regards,
Yongji
