Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33563 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751994AbcGAEto (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2016 00:49:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u614mh8H077089
	for <linux-pci@vger.kernel.org>; Fri, 1 Jul 2016 00:49:43 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23w62xdncm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 Jul 2016 00:49:43 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Fri, 1 Jul 2016 14:49:40 +1000
Subject: Re: [PATCH v3 1/7] PCI: Ignore enforced alignment when kernel uses
 existing firmware setup
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160701002852.GA15147@gwshan>
Cc: nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	linux-doc@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, warrier@linux.vnet.ibm.com,
	alex.williamson@redhat.com, paulus@samba.org, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Fri, 1 Jul 2016 12:49:39 +0800
MIME-Version: 1.0
In-Reply-To: <20160701002852.GA15147@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ecaa7d85-b705-31d7-60d7-b60f8f3b3fc2@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gavin,

On 2016/7/1 8:28, Gavin Shan wrote:

> On Thu, Jun 30, 2016 at 06:53:07PM +0800, Yongji Xie wrote:
>> PCI resources allocator will use firmware setup and not try to
>> reassign resource when PCI_PROBE_ONLY or IORESOURCE_PCI_FIXED
>> is set.
>>
>> The enforced alignment in pci_reassigndev_resource_alignment()
>> should be ignored in this case. Otherwise, some PCI devices'
>> resources would be released here and not re-allocated.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>> drivers/pci/pci.c |   12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index c8b4dbd..be8f72c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4760,6 +4760,13 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>>
>> 	spin_lock(&resource_alignment_lock);
>> 	p = resource_alignment_param;
>> +	if (pci_has_flag(PCI_PROBE_ONLY)) {
>> +		if (*p)
>> +			printk_once(KERN_INFO "PCI: Ignore resource_alignment parameter: %s with PCI_PROBE_ONLY set\n",
>> +						p);
> We don't have to print @resource_alignment as it's ignored completely.
> The content included in it doesn't mean anything:
>
> 			pr_info_once("PCI: resource_alignment ignored with PCI_PROBE_ONLY\n");

OK. It looks simpler now.

>> +		spin_unlock(&resource_alignment_lock);
>> +		return 0;
>> +	}
> A empty line is needed here.
>
>> 	while (*p) {
>> 		count = 0;
>> 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
>> @@ -4837,6 +4844,11 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>> 		r = &dev->resource[i];
>> 		if (!(r->flags & IORESOURCE_MEM))
>> 			continue;
>> +		if (r->flags & IORESOURCE_PCI_FIXED) {
>> +			dev_info(&dev->dev, "No alignment for fixed BAR%d: %pR\n",
>> +				i, r);
> The message would be like below to match PCI code style. I'm thinking it probably
> uses dev_dbg() instead dev_info(), but not sure for 100%.
>
> 			dev_info(&dev->dev, "BAR %d: fixed %pR, no alignment\n", i, r);

Maybe dev_info() is OK.:-)

>> +			continue;
>> +		}
> A empty line is needed here.
>
>> 		size = resource_size(r);
>> 		if (size < align) {
>> 			size = align;
> Thanks,
> Gavin
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

