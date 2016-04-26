Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([125.16.236.6]:45430 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbcDZGol (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 02:44:41 -0400
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Tue, 26 Apr 2016 12:14:37 +0530
Subject: Re: [RFC v6 04/10] PCI: Add support for enforcing all MMIO BARs to be
 page aligned
To: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
	linux-doc@vger.kernel.org
References: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1460976961-29328-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <571EFF78.2050603@ozlabs.ru>
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <1d72614f-25a1-b6f3-ed07-e2cac818b33a@linux.vnet.ibm.com>
Date: Tue, 26 Apr 2016 14:44:12 +0800
MIME-Version: 1.0
In-Reply-To: <571EFF78.2050603@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/4/26 13:41, Alexey Kardashevskiy wrote:

> On 04/18/2016 08:56 PM, Yongji Xie wrote:
>> When vfio passthrough a PCI device of which MMIO BARs are
>> smaller than PAGE_SIZE, guest will not handle the mmio
>> accesses to the BARs which leads to mmio emulations in host.
>>
>> This is because vfio will not allow to passthrough one BAR's
>> mmio page which may be shared with other BARs. Otherwise,
>> there will be a backdoor that guest can use to access BARs
>> of other guest.
>>
>> To solve this issue, this patch modifies resource_alignment
>> to support syntax where multiple devices get the same
>> alignment. So we can use something like
>> "pci=resource_alignment=*:*:*.*:noresize" to enforce the
>> alignment of all MMIO BARs to be at least PAGE_SIZE so that
>> one BAR's mmio page would not be shared with other BARs.
>>
>> And we also define a macro PCIBIOS_MIN_ALIGNMENT to enable this
>> automatically on PPC64 platform which can easily hit this issue
>> because its PAGE_SIZE is 64KB.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   Documentation/kernel-parameters.txt |    2 ++
>>   arch/powerpc/include/asm/pci.h      |    2 ++
>>   drivers/pci/pci.c                   |   64 
>> +++++++++++++++++++++++++++++------
>>   3 files changed, 57 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt 
>> b/Documentation/kernel-parameters.txt
>> index d8b29ab..542be4a 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -2918,6 +2918,8 @@ bytes respectively. Such letter suffixes can 
>> also be entirely omitted.
>>                   aligned memory resources.
>>                   If <order of align> is not specified,
>>                   PAGE_SIZE is used as alignment.
>> +                <domain>, <bus>, <slot> and <func> can be set to
>> +                "*" which means match all values.
>>                   PCI-PCI bridge can be specified, if resource
>>                   windows need to be expanded.
>>                   noresize: Don't change the resources' sizes when
>> diff --git a/arch/powerpc/include/asm/pci.h 
>> b/arch/powerpc/include/asm/pci.h
>> index 6f8065a..78f230f 100644
>> --- a/arch/powerpc/include/asm/pci.h
>> +++ b/arch/powerpc/include/asm/pci.h
>> @@ -30,6 +30,8 @@
>>   #define PCIBIOS_MIN_IO        0x1000
>>   #define PCIBIOS_MIN_MEM        0x10000000
>>
>> +#define PCIBIOS_MIN_ALIGNMENT  PAGE_SIZE
>> +
>>   struct pci_dev;
>>
>>   /* Values for the `which' argument to sys_pciconfig_iobase 
>> syscall.  */
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 7564ccc..0381c28 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4605,7 +4605,12 @@ static resource_size_t 
>> pci_specified_resource_alignment(struct pci_dev *dev,
>>       int seg, bus, slot, func, align_order, count;
>>       resource_size_t align = 0;
>>       char *p;
>> +    bool invalid = false;
>>
>> +#ifdef PCIBIOS_MIN_ALIGNMENT
>> +    align = PCIBIOS_MIN_ALIGNMENT;
>> +    *resize = false;
>> +#endif
>>       spin_lock(&resource_alignment_lock);
>>       p = resource_alignment_param;
>>       while (*p) {
>> @@ -4622,16 +4627,49 @@ static resource_size_t 
>> pci_specified_resource_alignment(struct pci_dev *dev,
>>           } else {
>>               align_order = -1;
>>           }
>> -        if (sscanf(p, "%x:%x:%x.%x%n",
>> -            &seg, &bus, &slot, &func, &count) != 4) {
>
>
> I'd replace the above lines with:
>
>     char segstr[5] = "*", busstr[3] = "*";
>     char slotstr[3] = "*", funstr[2] = "*";
>
>     if (sscanf(p, "%4[^:]:%2[^:]:%2[^.].%1s%n",
>         &segstr, &busstr, &slotstr, &funcstr, &count) != 4) {
>
>

It seems the current implement of sscanf() in kernel
is not able to support the syntax: "%4[^:]:%2[^:]:%2[^.]".

Thanks,
Yongji

> and add some wrapper like:
>
> static bool glob_match_hex(char const *pat, int val)
> {
>     char valstr[5]; /* 5 should be enough for PCI */
>     snprintf(valstr, sizeof(valstr) - 1, "%4x", val);
>     return glob_match(pat, valstr);
> }
>
> and then use glob_match_hex() (or make a wrapper like above on top of 
> fnmatch()), this would enable better mask handling.
>
> If anyone finds this useful (which I am not sure about).
>
>
>
>
>> +        if (p[0] == '*' && p[1] == ':') {
>> +            seg = -1;
>> +            count = 1;
>> +        } else if (sscanf(p, "%x%n", &seg, &count) != 1 ||
>> +                p[count] != ':') {
>> +            invalid = true;
>> +            break;
>> +        }
>> +        p += count + 1;
>> +        if (*p == '*') {
>> +            bus = -1;
>> +            count = 1;
>> +        } else if (sscanf(p, "%x%n", &bus, &count) != 1) {
>> +            invalid = true;
>> +            break;
>> +        }
>> +        p += count;
>> +        if (*p == '.') {
>> +            slot = bus;
>> +            bus = seg;
>>               seg = 0;
>> -            if (sscanf(p, "%x:%x.%x%n",
>> -                    &bus, &slot, &func, &count) != 3) {
>> -                /* Invalid format */
>> -                printk(KERN_ERR "PCI: Can't parse resource_alignment 
>> parameter: %s\n",
>> -                    p);
>> +            p++;
>> +        } else if (*p == ':') {
>> +            p++;
>> +            if (p[0] == '*' && p[1] == '.') {
>> +                slot = -1;
>> +                count = 1;
>> +            } else if (sscanf(p, "%x%n", &slot, &count) != 1 ||
>> +                    p[count] != '.') {
>> +                invalid = true;
>>                   break;
>>               }
>> +            p += count + 1;
>> +        } else {
>> +            invalid = true;
>> +            break;
>> +        }
>> +        if (*p == '*') {
>> +            func = -1;
>> +            count = 1;
>> +        } else if (sscanf(p, "%x%n", &func, &count) != 1) {
>> +            invalid = true;
>> +            break;
>>           }
>>           p += count;
>>           if (!strncmp(p, ":noresize", 9)) {
>> @@ -4639,10 +4677,10 @@ static resource_size_t 
>> pci_specified_resource_alignment(struct pci_dev *dev,
>>               p += 9;
>>           } else
>>               *resize = true;
>> -        if (seg == pci_domain_nr(dev->bus) &&
>> -            bus == dev->bus->number &&
>> -            slot == PCI_SLOT(dev->devfn) &&
>> -            func == PCI_FUNC(dev->devfn)) {
>> +        if ((seg == pci_domain_nr(dev->bus) || seg == -1) &&
>> +            (bus == dev->bus->number || bus == -1) &&
>> +            (slot == PCI_SLOT(dev->devfn) || slot == -1) &&
>> +            (func == PCI_FUNC(dev->devfn) || func == -1)) {
>>               if (align_order == -1)
>>                   align = PAGE_SIZE;
>>               else
>> @@ -4652,10 +4690,14 @@ static resource_size_t 
>> pci_specified_resource_alignment(struct pci_dev *dev,
>>           }
>>           if (*p != ';' && *p != ',') {
>>               /* End of param or invalid format */
>> +            invalid = true;
>>               break;
>>           }
>>           p++;
>>       }
>> +    if (invalid)
>> +        printk(KERN_ERR "PCI: Can't parse resource_alignment 
>> parameter:%s\n",
>> +                p);
>>       spin_unlock(&resource_alignment_lock);
>>       return align;
>>   }
>>
>
>

