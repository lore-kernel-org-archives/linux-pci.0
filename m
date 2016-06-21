Return-Path: <xyjxie@linux.vnet.ibm.com>
Return-Path: <xyjxie@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v2 1/4] PCI: Ignore resource_alignment if
 PCI_PROBE_ONLY was set\\
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464846411-16895-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1464846411-16895-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160621014346.GA30307@localhost>
 <6b457696-5cb6-66ba-911a-fec42bb3e0d3@linux.vnet.ibm.com>
Cc: nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com, corbet@lwn.net,
        aik@ozlabs.ru, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gwshan@linux.vnet.ibm.com,
        bhelgaas@google.com, alex.williamson@redhat.com, paulus@samba.org,
        warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 21 Jun 2016 16:38:26 +0800
MIME-Version: 1.0
In-Reply-To: <6b457696-5cb6-66ba-911a-fec42bb3e0d3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5162fcfc-5ba2-eb63-b706-dfb495cad7d1@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 2016/6/21 10:16, Yongji Xie wrote:

> On 2016/6/21 9:43, Bjorn Helgaas wrote:
>
>> On Thu, Jun 02, 2016 at 01:46:48PM +0800, Yongji Xie wrote:
>>> The resource_alignment will releases memory resources allocated
>>> by firmware so that kernel can reassign new resources later on.
>>> But this will cause the problem that no resources can be
>>> allocated by kernel if PCI_PROBE_ONLY was set, e.g. on pSeries
>>> platform because PCI_PROBE_ONLY force kernel to use firmware
>>> setup and not to reassign any resources.
>>>
>>> To solve this problem, this patch ignores resource_alignment
>>> if PCI_PROBE_ONLY was set.
>>>
>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>> ---
>>>   drivers/pci/pci.c |    6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index c8b4dbd..a259394 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -4761,6 +4761,12 @@ static resource_size_t 
>>> pci_specified_resource_alignment(struct pci_dev *dev)
>>>       spin_lock(&resource_alignment_lock);
>>>       p = resource_alignment_param;
>>>       while (*p) {
>>> +        if (pci_has_flag(PCI_PROBE_ONLY)) {
>>> +            printk(KERN_ERR "PCI: Ignore resource_alignment 
>>> parameter: %s with PCI_PROBE_ONLY set\n",
>>> +                    p);
>>> +            *p = 0;
>>> +            break;
>> Wouldn't it be simpler to make pci_set_resource_alignment_param() fail
>> if PCI_PROBE_ONLY is set?
>
> I add the check here because I want to print some logs so that users
> could know the reason why resource_alignment doesn't work when
> they add this parameter.
>
> Thanks,
> Yongji
>

Sorry, please ignore the previous reply. I didn't add this check in
pci_set_resource_alignment_param() because PCI_PROBE_ONLY
may be set after we parse "resource_alignment".

And it seems that printk_once() may be better here so that
we don't need to set *p = 0.

Thanks,
Yongji

>>> +        }
>>>           count = 0;
>>>           if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
>>>                               p[count] == '@') {
>>> -- 
>>> 1.7.9.5
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
