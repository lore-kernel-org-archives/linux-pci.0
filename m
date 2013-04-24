Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:45661 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab3DXEJH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Apr 2013 00:09:07 -0400
Message-ID: <51775A32.5030803@cn.fujitsu.com>
Date: Wed, 24 Apr 2013 12:06:10 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>,
	Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
 instead
References: <516FB647.5030203@cn.fujitsu.com> <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com> <51763847.8090808@cn.fujitsu.com> <CAE9FiQV3e7tiUwg5qtw0=1ncRykJ5Pkog2C9cYG3VkfkKAgZnA@mail.gmail.com>
In-Reply-To: <CAE9FiQV3e7tiUwg5qtw0=1ncRykJ5Pkog2C9cYG3VkfkKAgZnA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/24/2013 01:34 AM, Yinghai Lu wrote:

> On Tue, Apr 23, 2013 at 12:29 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>> From b01e61759f894b651ed3bb39c9fc18e0b66d7cb3 Mon Sep 17 00:00:00 2001
>> From: GuZheng <guz.fnst@cn.fujitsu.com>
>> Date: Tue, 23 Apr 2013 14:01:39 +0800
>> Subject: [PATCH v2 2/2] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
>>  instead
>>
>> Use the new pci_alloc_dev(bus) to replace the existing using of alloc_pci_dev(void).
>> And new functions pci_bus_get/put() are introdued to hide pci_bus' reference management.
>>
>> v2:
>>   Follow Yinghai's suggestions to reduce pci_bus' ref when destroying pci device.
>>   Add new functions pci_bus_get/put() to hide pci_bus' reference management.
> 
> You did not tell us if the remove test scripts works after put the line back.

Hi Yinghai,
    As you know, I split this patch from the original bug-fix one, and this one is
not used to fix the bug we discussed. My test box is on the duty of other tests, I'll do the
test and send out the result as soon as it is ready for me.

BTW, Could please split a while to answer the two questions I asked you yesterday?
> 

> If it does not work, what is the point of this patch?

I think the patch title and the change log can explain all. It introduce a new pci_alloc_dev(bus)
to replace the alloc_pci_dev(), and add the pci_bus' reference management when we deal with its downstream
pci devices.

Thanks,
Gu

> 
> Yinghai
> 


