Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:51598 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbEFGK3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 02:10:29 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 6 May 2015 16:10:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id C062E3578053
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2015 16:10:24 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t466AGiW31260798
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2015 16:10:24 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4669pK4022192
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2015 16:09:52 +1000
Date: Wed, 6 May 2015 14:09:33 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/iov: return a reference to PF on destroying VF
Message-ID: <20150506060933.GA19030@richard>
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

Hi, Bjorn

Nice to see you again :-)

>
>Please use conventional citation style (12-char SHA1).

sure, I'd like to change it.

>
>ac205b7bb72f appeared in v3.4.  Did that commit cause a regression?
>Should this patch be marked for stable?
>

Hmm... regression.

I think commit ac205b7bb72f is not a complete fix for the problem. Before
commit ac205b7bb72f, system would crash, and after that, at least we can use
the machine.

While yes, I prefer this could be in stable tree.

>"After doing so, VF removal is done with pci_stop_and_remove_device() ..."
>After doing what?  After removing the VFs and PFs?  After commit
>ac205b7bb72f?

Sorry for my poor expression.

Here I mean, after commit ac205b7bb72f.
Before this commit ac205b7bb72f, VFs are destroyed in sriov_disable() called 
by the PF's driver. After this commit ac205b7bb72f, since we reverse the
order, VFs are destroyed by the pci_stop_and_remove_bus_device() in the loop.

>
>Prior to your patch, the VF reference was released in virtfn_remove(),
>which is only called via pci_disable_sriov().  This typically happens in
>a driver .remove() method.  The reference is *not* released if we call
>pci_stop_and_remove_bus_device(VF) directly, as we would via the
>remove_store() (sysfs "remove" file) or hot unplug paths, e.g.,
>pciehp_unconfigure_device().

You want to say the reference for VF or PF?

VF's reference is still released in virtfn_remove.
pci_stop_and_remove_bus_device() will call pci_destroy_dev() which will put
the dev's reference.

Maybe I don't get your point.

>
>After your patch, the VF reference is released in pci_destroy_dev().  This
>is called from pci_disable_sriov(), so it happens in that path as before.
>But pci_destroy_dev() is called from pci_stop_and_remove_bus_device(), so
>the reference is now released for all the paths that use
>pci_stop_and_remove_bus_device().
>

The change in this patch is the reference release of the PF.

Before my patch, PF's reference is released in virtfn_remove(). After my
patch, PF's reference is released in the pci_destroy_dev() of the VF.

>What about the other things done in virtfn_remove(), e.g., the sysfs link
>removal?  Your patch fixes a reference count leak, but don't we still have
>a sysfs link leak?
>

Agree, I am afraid the sysfs would have a leak too.

While I am not that familiar with the sysfs part, I don't dare to move that to
pci_destroy_dev(). Need more investigation.

>It would be useful to mention a way to cause the leak.  I suspect writing
>to a VF's sysfs "remove" file is the easiest.
>

I use the EEH hotplug case to see the leak, sounds your way is more general.
I will do some tests, and if it is true, I will put it in the change log.

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

