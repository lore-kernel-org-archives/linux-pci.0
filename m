Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:33337 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbEGCld (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 22:41:33 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 7 May 2015 12:41:30 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5DB093578048
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2015 12:41:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t472fJDR23920752
	for <linux-pci@vger.kernel.org>; Thu, 7 May 2015 12:41:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t472etwj032476
	for <linux-pci@vger.kernel.org>; Thu, 7 May 2015 12:40:55 +1000
Date: Thu, 7 May 2015 10:40:38 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci/iov: return a reference to PF on destroying VF
Message-ID: <20150507024038.GB6645@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150505212905.GB24643@google.com>
 <20150506072557.GA22377@richard>
 <CAErSpo7oTxbThDGj6UkbpsAKBakkzJsq104swqsZWkr=0+dNkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7oTxbThDGj6UkbpsAKBakkzJsq104swqsZWkr=0+dNkA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 06, 2015 at 10:23:26AM -0500, Bjorn Helgaas wrote:
>On Wed, May 6, 2015 at 2:25 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Tue, May 05, 2015 at 04:29:05PM -0500, Bjorn Helgaas wrote:
>
>>>It would be useful to mention a way to cause the leak.  I suspect writing
>>>to a VF's sysfs "remove" file is the easiest.
>>>
>>
>> Looks a VF don't support the remove now.
>>
>> static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
>>                                             struct attribute *a, int n)
>> {
>>         struct device *dev = container_of(kobj, struct device, kobj);
>>         struct pci_dev *pdev = to_pci_dev(dev);
>>
>>         if (pdev->is_virtfn)
>>                 return 0;
>>
>>         return a->mode;
>> }
>>
>> static struct attribute_group pci_dev_hp_attr_group = {
>>         .attrs = pci_dev_hp_attrs,
>>         .is_visible = pci_dev_hp_attrs_are_visible,
>> };
>
>Right, I forgot about this.  A VF has no "remove" file, so it can't be
>used to cause the leak.

Hmm, I see this is introduced in commit dfab88beda88, to prevent some memory
leak.

Could we say, if we do the release properly like in this patch, we could
re-enable this "remove"?

-- 
Richard Yang
Help you, Help me

