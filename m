Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:42164 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760488AbcDFC6J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2016 22:58:09 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Wed, 6 Apr 2016 12:58:06 +1000
Subject: Re: [RFC v5 1/7] PCI: Ignore resource_alignment if PCI_PROBE_ONLY was
 set
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459863813-2830-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160406004840.GA6187@gwshan>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	aik@ozlabs.ru, alex.williamson@redhat.com,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <57047AF3.7070401@linux.vnet.ibm.com>
Date: Wed, 6 Apr 2016 10:56:51 +0800
MIME-Version: 1.0
In-Reply-To: <20160406004840.GA6187@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/4/6 8:48, Gavin Shan wrote:
> On Tue, Apr 05, 2016 at 09:43:29PM +0800, Yongji Xie wrote:
>> The resource_alignment will releases memory
>> resources allocated by firmware so that kernel
>> can reassign new resources later on. But this
>> will cause the problem that no resources can be
>> allocated by kernel if PCI_PROBE_ONLY was set,
>> e.g. on pSeries platform because PCI_PROBE_ONLY
>> force kernel to use firmware setup and not to
>> reassign any resources.
>>
>> To solve this problem, this patch ignores
>> resource_alignment if PCI_PROBE_ONLY was set.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>> drivers/pci/pci.c |    6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 602eb42..1db9267 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4607,6 +4607,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>> 	spin_lock(&resource_alignment_lock);
>> 	p = resource_alignment_param;
>> 	while (*p) {
>> +		if (pci_has_flag(PCI_PROBE_ONLY)) {
>> +			printk(KERN_ERR "PCI: Ignore resource_alignment parameter: %s with"
>> +					" PCI_PROBE_ONLY set\n", p);
>> +			*p = 0;
>> +			break;
> It seems no "*p = 0" isn't required if I don't miss anything. If the check
> on flag PCI_PROBE_ONLY is moved before the spin_lock(), it would save a bit
> CPU cycles at least. Also, the logic looks more clear.

I used "*p = 0" in case that the warning is called
in every pci_device_add().

And the warning should be called only when users
use resource_alignment parameter. So we test
while(*p) before we call the warning.

Thanks,
Yongji

>> +		}
>> 		count = 0;
>> 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
>> 							p[count] == '@') {
> Thanks,
> Gavin
>
>> -- 
>> 1.7.9.5
>>

