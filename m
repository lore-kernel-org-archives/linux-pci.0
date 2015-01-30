Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:2340 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbbA3BFj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 20:05:39 -0500
Message-ID: <54CAD8CE.40203@huawei.com>
Date: Fri, 30 Jan 2015 09:05:18 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jan Beulich <JBeulich@suse.com>
CC: David Vrabel <david.vrabel@citrix.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v3] PCI: Add guard to avoid mapping a invalid
 msix base address
References: <1422503683-19709-1-git-send-email-wangyijing@huawei.com> <54CA4092020000780005ADF6@mail.emea.novell.com> <CAErSpo7s+E9+EPg+rxGDc_zf4E5jhRzT8fT=ZyThNqsW7+VU5g@mail.gmail.com>
In-Reply-To: <CAErSpo7s+E9+EPg+rxGDc_zf4E5jhRzT8fT=ZyThNqsW7+VU5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/1/29 22:12, Bjorn Helgaas wrote:
> On Thu, Jan 29, 2015 at 7:15 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>>> On 29.01.15 at 04:54, <wangyijing@huawei.com> wrote:
>>> --- a/drivers/pci/msi.c
>>> +++ b/drivers/pci/msi.c
>>> @@ -694,11 +694,16 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>>>  {
>>>       resource_size_t phys_addr;
>>>       u32 table_offset;
>>> +     unsigned long flags;
>>>       u8 bir;
>>>
>>>       pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
>>>                             &table_offset);
>>>       bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
>>> +     flags = pci_resource_flags(dev, bir);
>>> +     if (!flags || (flags & IORESOURCE_UNSET))
>>> +             return NULL;
>>
>> Mind explaining what relevance the checking of flags against zero has
>> (also in the Xen counterpart)? The patch description says nothing in
>> this regard...
> 
> It's buried in there:
> 
>>                                        reset_resource()        -->res->start/end/flags = 0
> 
> If we fail to assign resources to a BAR, in some cases we set
> res->flags = 0.  There are other cases where we set IORESOURCE_UNSET,
> and that's the direction I want to go for all situations where we
> don't assign resources.  But right now, we have a mix where flags is
> zero in some cases (including the one Zhang found), and has
> IORESOURCE_UNSET in others.
> 
> I'll try to wordsmith this in the changelog when I apply this.

Thanks to Bjorn help explain, sorry for my poor description.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

