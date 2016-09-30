Return-Path: <xyjxie@linux.vnet.ibm.com>
Return-Path: <xyjxie@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 4/4] PCI: Add a macro to set default alignment for all
 PCI devices
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1473757234-5284-5-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160929140014.GB31048@localhost>
Cc: zhong@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
        gwshan@linux.vnet.ibm.com, alex.williamson@redhat.com,
        paulus@samba.org, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Fri, 30 Sep 2016 12:13:30 +0800
MIME-Version: 1.0
In-Reply-To: <20160929140014.GB31048@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <313ed70e-d857-6429-e5ca-6d22b0a39c98@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 2016/9/29 22:00, Bjorn Helgaas wrote:

> On Tue, Sep 13, 2016 at 05:00:34PM +0800, Yongji Xie wrote:
>> When vfio passthroughs a PCI device of which MMIO BARs are
>> smaller than PAGE_SIZE, guest will not handle the mmio
>> accesses to the BARs which leads to mmio emulations in host.
>>
>> This is because vfio will not allow to passthrough one BAR's
>> mmio page which may be shared with other BARs. Otherwise,
>> there will be a backdoor that guest can use to access BARs
>> of other guest.
>>
>> This patch adds a macro to set default alignment for all
>> PCI devices. Then we could solve this issue on some platforms
>> which would easily hit this issue because of their 64K page
>> such as PowerNV platform by defining this macro as PAGE_SIZE.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/pci.h |    4 ++++
>>   drivers/pci/pci.c              |    4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
>> index e9bd6cf..5e31bc2 100644
>> --- a/arch/powerpc/include/asm/pci.h
>> +++ b/arch/powerpc/include/asm/pci.h
>> @@ -28,6 +28,10 @@
>>   #define PCIBIOS_MIN_IO		0x1000
>>   #define PCIBIOS_MIN_MEM		0x10000000
>>   
>> +#ifdef CONFIG_PPC_POWERNV
>> +#define PCIBIOS_DEFAULT_ALIGNMENT	PAGE_SIZE
>> +#endif
>> +
>>   struct pci_dev;
>>   
>>   /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 37f8062..9c61cbe 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4959,6 +4959,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>   	resource_size_t align = 0;
>>   	char *p;
>>   
>> +#ifdef PCIBIOS_DEFAULT_ALIGNMENT
>> +	align = PCIBIOS_DEFAULT_ALIGNMENT;
>> +	*resize = false;
>> +#endif
> I'm a little confused about how this works.
>
> I think this change only does something if the user specifies
> "pci=resource_alignment=..." or writes to the /sys/.../resource_alignment
> file, because those are the only ways to set resource_alignment_param.
>
> If that's true, isn't the *default* to align to PAGE_SIZE?  So I don't
> understand what PCIBIOS_DEFAULT_ALIGNMENT changes.

In pci_reassigndev_resource_alignment(), we can see:

align = pci_specified_resource_alignment(dev);
     if (!align)
         return;

So we would still align the device's BAR to PAGE_SIZE without
set resource_alignment_param if we set @align to a default value
in pci_specified_resource_alignment().

> And I'm hoping we can get rid of the resize flag based on the
> discussion of the previous patch.

Will do.

Thanks,
Yongji
