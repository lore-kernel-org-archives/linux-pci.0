Return-Path: <SRS0=bhXG=Z5=redhat.com=prarit@kernel.org>
Return-Path: <SRS0=bhXG=Z5=redhat.com=prarit@kernel.org>
Message-ID: <58A59F53.60005@redhat.com>
Date: Thu, 16 Feb 2017 07:47:15 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Linux PCI <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Myron Stowe <mstowe@redhat.com>
Subject: Re: [RESENT PATCH] PCI/MSI: Fix msi_desc->affinity memory leak when
 freeing MSI IRQs.
References: <1487177588-31369-1-git-send-email-prarit@redhat.com> <20170215235657.GC26758@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170215235657.GC26758@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>



On 02/15/2017 06:56 PM, Bjorn Helgaas wrote:
> On Wed, Feb 15, 2017 at 11:53:08AM -0500, Prarit Bhargava wrote:
>> No response ... trying again.
>>
>> P.
>>
>> ---8<---
>>
>> During device setup, msix_setup_entries() and msi_setup_entry() allocate
>> msi_desc by calling alloc_msi_entry().  alloc_msi_entry() can also allocate a
>> affinity cpumask.  During device teardown free_msi_irqs() is called and the
>> msi_desc is freed, but the affinity cpumask is leaked.
>>
>> Fix it by calling free_msi_entry() which frees both the msi_desc and the
>> affinity cpumask.
> 
> Sorry for the delay, Prarit.  I started looking at this when you first
> posted it.  The more I looked at it, the less I liked the setup/free
> paths -- they're not very parallel and I don't remember what else.
> 

Yes, I noticed this as well.  As you say ...

> But I guess it's probably a longer term effort to clean that up.
> 

... there's a larger cleanup that's required here.

> Do you have a bug report or anything for this, or did you just find
> this by code inspection?  If there's a bugzilla or even a symptom, we
> could mention it in the changelog.
> 

This was noticed during code inspection while Myron & I were debugging
an issue in RHEL7.

P.

>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: mstowe@redhat.com
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/msi.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 50c5003295ca..3d709311052d 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -379,7 +379,7 @@ static void free_msi_irqs(struct pci_dev *dev)
>>  		}
>>  
>>  		list_del(&entry->list);
>> -		kfree(entry);
>> +		free_msi_entry(entry);
>>  	}
>>  
>>  	if (dev->msi_irq_groups) {
>> -- 
>> 1.7.9.3
>>
