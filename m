Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:59302 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757664AbcASI5I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 03:57:08 -0500
Subject: Re: [PATCH V3 20/21] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: Tomasz Nowicki <tn@semihalf.com>, Mark Salter <msalter@redhat.com>,
	<bhelgaas@google.com>, <arnd@arndb.de>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <rjw@rjwysocki.net>,
	<hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
	<okaya@codeaurora.org>, <jiang.liu@linux.intel.com>,
	<Stefano.Stabellini@eu.citrix.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-21-git-send-email-tn@semihalf.com>
 <1452785776.28109.22.camel@redhat.com> <569CDD8F.807@semihalf.com>
 <569D9634.3040304@huawei.com> <569DEBE9.5090909@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
	<tglx@linutronix.de>, <wangyijing@huawei.com>,
	<Suravee.Suthikulpanit@amd.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <jchandra@broadcom.com>,
	<jcm@redhat.com>, Zhou Wang <wangzhou1@hisilicon.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: "liudongdong (C)" <liudongdong3@huawei.com>
Message-ID: <569DF949.5080208@huawei.com>
Date: Tue, 19 Jan 2016 16:52:25 +0800
MIME-Version: 1.0
In-Reply-To: <569DEBE9.5090909@semihalf.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



在 2016/1/19 15:55, Tomasz Nowicki 写道:
> On 19.01.2016 02:49, liudongdong (C) wrote:
>> Hi Tomasz, Mark
>>
>> 在 2016/1/18 20:41, Tomasz Nowicki 写道:
>>> On 14.01.2016 16:36, Mark Salter wrote:
>>>>> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
>>>>> >+extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
>>>>> >+
>>>>> >+static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_root
>>>>> *root)
>>>>> >+{
>>>>> >+    struct pci_mcfg_fixup *f;
>>>>> >+    int bus_num = root->secondary.start;
>>>>> >+    int domain = root->segment;
>>>>> >+
>>>>> >+    /*
>>>>> >+     * First match against PCI topology <domain:bus> then use DMI or
>>>>> >+     * custom match handler.
>>>>> >+     */
>>>>> >+    for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups;
>>>>> f++) {
>>>>> >+        if ((f->domain == domain || f->domain ==
>>>>> PCI_MCFG_DOMAIN_ANY) &&
>>>>> >+            (f->bus_num == bus_num || f->bus_num ==
>>>>> PCI_MCFG_BUS_ANY) &&
>>>>> >+            (f->system ? dmi_check_system(f->system) : 0 ||
>>>>> >+             f->match ? f->match(f, root) : 0))
>>>>> >+            return f->ops;
>>>> I think this would be better as:
>>>>
>>>>             (f->system ? dmi_check_system(f->system) : 1 &&
>>>>              f->match ? f->match(f, root) : 1))
>>>>             return f->ops;
>>>>
>>>> Otherwise, one has to call dmi_check_system() from f->match() if
>>>> access to root is needed.
>>>
>>
>> Non-DMI, we need not to call dmi_check_system() from f->match(),
>> we can use _HID to decide to hook the pci_ops or not.
>
> Sorry, but I dont understand your point. Can you elaborate?
>
> With Mark modification, you can use the following cases to identify platform:
> 1. DMI only
> 2. f->match() only (_HID can be used there)
> 3. DMI and f->match()
>
> DMI used to be very convenient way to recognise platform, sometimes it is not enough, hence f->match() alternative.
>

Yes, you are right,  I was wrong.
In my case, I can use the second point.
2. f->match() only (_HID can be used there)

Thanks
Dongdong

> Tomasz
>
>
>
> .
>

