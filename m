Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:41100 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbbEFH0x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 03:26:53 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 6 May 2015 17:26:51 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 75D662BB0047
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2015 17:26:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t467Qeqd19857458
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2015 17:26:48 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t467QFNs001071
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2015 17:26:15 +1000
Date: Wed, 6 May 2015 15:25:57 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/iov: return a reference to PF on destroying VF
Message-ID: <20150506072557.GA22377@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150505212905.GB24643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150505212905.GB24643@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 05, 2015 at 04:29:05PM -0500, Bjorn Helgaas wrote:
>On Fri, Apr 10, 2015 at 04:53:04PM +0800, Wei Yang wrote:
>> Each VF will get a reference to its PF, while it is not returned back in
>> all cases and leave a removed PF's pci_dev un-released.
>> 
>> As commit ac205b7b ("PCI: make sriov work with hotplug remove") indicates,
>> when removing devices on a bus, we do it in the reverse order. This means
>> we would remove VFs first, then PFs. After doing so, VF's removal is done
>> with pci_stop_and_remove_bus_device() instead of virtfn_remove().
>> virtfn_remove() returns the reference of its PF, while
>> pci_stop_and_remove_bus_device() doesn't.
>
>Please use conventional citation style (12-char SHA1).
>
>ac205b7bb72f appeared in v3.4.  Did that commit cause a regression?
>Should this patch be marked for stable?
>
>"After doing so, VF removal is done with pci_stop_and_remove_device() ..."
>After doing what?  After removing the VFs and PFs?  After commit
>ac205b7bb72f?
>
>Prior to your patch, the VF reference was released in virtfn_remove(),
>which is only called via pci_disable_sriov().  This typically happens in
>a driver .remove() method.  The reference is *not* released if we call
>pci_stop_and_remove_bus_device(VF) directly, as we would via the
>remove_store() (sysfs "remove" file) or hot unplug paths, e.g.,
>pciehp_unconfigure_device().
>
>After your patch, the VF reference is released in pci_destroy_dev().  This
>is called from pci_disable_sriov(), so it happens in that path as before.
>But pci_destroy_dev() is called from pci_stop_and_remove_bus_device(), so
>the reference is now released for all the paths that use
>pci_stop_and_remove_bus_device().
>
>What about the other things done in virtfn_remove(), e.g., the sysfs link
>removal?  Your patch fixes a reference count leak, but don't we still have
>a sysfs link leak?
>
>It would be useful to mention a way to cause the leak.  I suspect writing
>to a VF's sysfs "remove" file is the easiest.
>

Looks a VF don't support the remove now.

static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
					    struct attribute *a, int n)
{
	struct device *dev = container_of(kobj, struct device, kobj);
	struct pci_dev *pdev = to_pci_dev(dev);

	if (pdev->is_virtfn)
		return 0;

	return a->mode;
}

static struct attribute_group pci_dev_hp_attr_group = {
	.attrs = pci_dev_hp_attrs,
	.is_visible = pci_dev_hp_attrs_are_visible,
};


>> This patches moves the return of PF's reference to pci_destroy_dev() to
>> make sure the PF's pci_dev is released in any case.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/iov.c    |    1 -
>>  drivers/pci/remove.c |    5 +++++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 4b3a4ea..9b04bde 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -167,7 +167,6 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>>  
>>  	/* balance pci_get_domain_bus_and_slot() */
>>  	pci_dev_put(virtfn);
>> -	pci_dev_put(dev);
>>  }
>>  
>>  static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 8bd76c9..836ddf6 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -41,6 +41,11 @@ static void pci_destroy_dev(struct pci_dev *dev)
>>  	list_del(&dev->bus_list);
>>  	up_write(&pci_bus_sem);
>>  
>> +#ifdef CONFIG_PCI_IOV
>> +	if (dev->is_virtfn)
>> +		pci_dev_put(dev->physfn);
>> +#endif
>> +
>>  	pci_free_resources(dev);
>>  	put_device(&dev->dev);
>>  }
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me

