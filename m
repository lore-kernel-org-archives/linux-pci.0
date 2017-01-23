Return-Path: <SRS0=KVF9=ZF=gmail.com=myron.stowe@kernel.org>
Return-Path: <SRS0=KVF9=ZF=gmail.com=myron.stowe@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151015172305.GC17702@localhost>
References: <1443051076-27716-1-git-send-email-rbezut@gmail.com> <20151015172305.GC17702@localhost>
From: Myron Stowe <myron.stowe@gmail.com>
Date: Mon, 23 Jan 2017 13:57:28 -0700
Message-ID: <CAL-B5D2zfKg2pzc0M2udS3=tNQ-=RzG8qLdBWAQC3KVh4PRQ0g@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Export all remapped MSIs to sysfs attributes
To: Bjorn Helgaas <helgaas@kernel.org>, rbezut@gmail.com
Cc: linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Neil Horman <nhorman@tuxdriver.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 11:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Sep 24, 2015 at 01:31:16AM +0200, Romain Bezut wrote:
>> irqbalance uses these attributes to populate its internal database, which is
>> then used to bind the irq on the appropriate NUMA node.
>>
>> On a device accepting multiple MSIs and with interrupt remapping enabled,
>> only the first irq entry is exported to msi_irqs directory.
>> This results in irqbalance having no clue of the NUMA affinity for the extra
>> irqs and starting to bind them on random nodes.
>>
>> This patch exports all MSI interrupts as sysfs attributes when relevant.
>>
>> Signed-off-by: Romain Bezut <rbezut@gmail.com>
>
> Applied with Thomas' ack to pci/msi for v4.4, thanks, Romain!

Internal testing with netperf - network performance between two
machines with 10Gb Intel NICs running 24 instances of the netperf tool
in parallel (to utilize all CPU cores) - shows a roughly 20%
performance degradation.  Bi-section showed the offending commit to be
this patch: commit a86760664f4 ("PCI/MSI: Export all remapped MSIs to
sysfs attributes").

  Prior: 9.62 +-0.00 gbits/sec
  After: 7.77 +-0.17 gbits/sec

>> ---
>>  drivers/pci/msi.c | 31 +++++++++++++++++--------------
>>  1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d449714..324a164 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -475,10 +475,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>>       int ret = -ENOMEM;
>>       int num_msi = 0;
>>       int count = 0;
>> +     int i;
>>
>>       /* Determine how many msi entries we have */
>>       for_each_pci_msi_entry(entry, pdev)
>> -             ++num_msi;
>> +             num_msi += entry->nvec_used;
>>       if (!num_msi)
>>               return 0;
>>
>> @@ -487,19 +488,21 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>>       if (!msi_attrs)
>>               return -ENOMEM;
>>       for_each_pci_msi_entry(entry, pdev) {
>> -             msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
>> -             if (!msi_dev_attr)
>> -                     goto error_attrs;
>> -             msi_attrs[count] = &msi_dev_attr->attr;
>> -
>> -             sysfs_attr_init(&msi_dev_attr->attr);
>> -             msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
>> -                                                 entry->irq);
>> -             if (!msi_dev_attr->attr.name)
>> -                     goto error_attrs;
>> -             msi_dev_attr->attr.mode = S_IRUGO;
>> -             msi_dev_attr->show = msi_mode_show;
>> -             ++count;
>> +             for (i = 0; i < entry->nvec_used; i++) {
>> +                     msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
>> +                     if (!msi_dev_attr)
>> +                             goto error_attrs;
>> +                     msi_attrs[count] = &msi_dev_attr->attr;
>> +
>> +                     sysfs_attr_init(&msi_dev_attr->attr);
>> +                     msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
>> +                                                         entry->irq + i);
>> +                     if (!msi_dev_attr->attr.name)
>> +                             goto error_attrs;
>> +                     msi_dev_attr->attr.mode = S_IRUGO;
>> +                     msi_dev_attr->show = msi_mode_show;
>> +                     ++count;
>> +             }
>>       }
>>
>>       msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
>> --
>> 2.4.9
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
