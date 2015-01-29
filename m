Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:37074 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbbA2ONH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 09:13:07 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so28464560qgd.11
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2015 06:13:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54CA4092020000780005ADF6@mail.emea.novell.com>
References: <1422503683-19709-1-git-send-email-wangyijing@huawei.com> <54CA4092020000780005ADF6@mail.emea.novell.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 29 Jan 2015 08:12:46 -0600
Message-ID: <CAErSpo7s+E9+EPg+rxGDc_zf4E5jhRzT8fT=ZyThNqsW7+VU5g@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v3] PCI: Add guard to avoid mapping a invalid
 msix base address
To: Jan Beulich <JBeulich@suse.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 29, 2015 at 7:15 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>> On 29.01.15 at 04:54, <wangyijing@huawei.com> wrote:
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -694,11 +694,16 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>>  {
>>       resource_size_t phys_addr;
>>       u32 table_offset;
>> +     unsigned long flags;
>>       u8 bir;
>>
>>       pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
>>                             &table_offset);
>>       bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
>> +     flags = pci_resource_flags(dev, bir);
>> +     if (!flags || (flags & IORESOURCE_UNSET))
>> +             return NULL;
>
> Mind explaining what relevance the checking of flags against zero has
> (also in the Xen counterpart)? The patch description says nothing in
> this regard...

It's buried in there:

>                                        reset_resource()        -->res->start/end/flags = 0

If we fail to assign resources to a BAR, in some cases we set
res->flags = 0.  There are other cases where we set IORESOURCE_UNSET,
and that's the direction I want to go for all situations where we
don't assign resources.  But right now, we have a mix where flags is
zero in some cases (including the one Zhang found), and has
IORESOURCE_UNSET in others.

I'll try to wordsmith this in the changelog when I apply this.

Bjorn
