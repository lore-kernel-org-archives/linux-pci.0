Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5312 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679Ab2KLTYw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Nov 2012 14:24:52 -0500
Message-ID: <50A14CF4.6060701@redhat.com>
Date: Mon, 12 Nov 2012 14:24:36 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Subject: Re: [PATCH 3/4] PCI,sys: SRIOV control and status via sysfs
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com> <1352146841-64458-4-git-send-email-ddutile@redhat.com> <CAE9FiQWx64YeLp=3fUCuOvZFQbyKxYd400azFvvi=oLYtQDbcA@mail.gmail.com> <CAE9FiQX2tNX25O1pcEzn6nvc7BxFCx0t2UKD11y-=17FhOmC+Q@mail.gmail.com>
In-Reply-To: <CAE9FiQX2tNX25O1pcEzn6nvc7BxFCx0t2UKD11y-=17FhOmC+Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/10/2012 02:31 AM, Yinghai Lu wrote:
> On Fri, Nov 9, 2012 at 10:47 PM, Yinghai Lu<yinghai@kernel.org>  wrote:
>> On Mon, Nov 5, 2012 at 12:20 PM, Donald Dutile<ddutile@redhat.com>  wrote:
>>>
>>>   static const struct attribute_group *pci_dev_attr_groups[] = {
>>>          &pci_dev_attr_group,
>>> +#ifdef CONFIG_PCI_IOV
>>> +&sriov_dev_attr_group,
>>> +#endif
>>
>> should move sriov_dev_attr_group related code to
>> drivers/pci/iov.c
>> or driver/pci/iov_sysfs.c
>>
>> and kill those CONFIG_IOV.
>
> Bjorn,
>
> please check attached patch that separate sriov_dev_attr_group out.
> it is against to your pci/don-sriov branch.
>
> Thanks
>
> Yinghai

Since the sriov-related files are created at the same time as
the other <DOMAIN:B:D.F> files, I would prefer to keep their
generation in the pci-sysfs.c file.
If it it moved, then put it into iov.c; the 'virtfn[X]' sysfs
files are created/destroyed in that file already, so if the
majority want it out of pci-sysfs, then I would favor a move to iov.c.
iov-sysfs.c creates yet-another file to search for SRIOV-related code,
and it's fairly centric to iov.c now.

If we're going to toss stuff out of pci-sysfs, then toss out the vga-attributes
crap, as well as other non-pci-specific files like bus-affinity(numa -- which
should go into PCI-root-bus related core code, e.g., acpi for x86; idk in ppc, arm, s390, etc.).
I'm not saying that following bad decisions of the past
is a justification for keeping the sriov related sysfs in pci-sysfs;
I am saying sriov *is* PCI-specific/architected, so it seems like
it should reside in pci-sysfs.c .

Other opinions/votes/preferences ???

- Don

