Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41748 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbJBXGO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 19:06:14 -0400
Subject: Re: [PATCH v6 01/53] sparc/PCI: Add mem64 resource parsing for root
 bus
To: Yinghai Lu <yinghai@kernel.org>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
 <1443678807-786-2-git-send-email-yinghai@kernel.org>
 <1443816007.7936.24.camel@oracle.com>
 <CAE9FiQX=qEO53rSw9bQv-2-3sSmYUO3YCJyj8m6mSNSTed3zEA@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <560F0DD1.60304@oracle.com>
Date: Fri, 2 Oct 2015 17:05:53 -0600
MIME-Version: 1.0
In-Reply-To: <CAE9FiQX=qEO53rSw9bQv-2-3sSmYUO3YCJyj8m6mSNSTed3zEA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/02/2015 04:05 PM, Yinghai Lu wrote:
> On Fri, Oct 2, 2015 at 1:00 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>> On Wed, 2015-09-30 at 22:52 -0700, Yinghai Lu wrote:
>>> Found "no compatible bridge window" warning in boot log from T5-8.
>>>
>>> pci 0000:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
>>>
>>> That resource is above 4G, but does not get offset correctly as
>>> root bus only report io and mem32.
>>>
>>> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
>>> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
>>> pci_bus 0000:00: root bus resource [bus 00-77]
>>>
>>> Add mem64 handling in pci_common for sparc, so we can have 64bit resource
>>> registered for root bus at first.
>>>
>>> After patch, will have:
>>> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
>>> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
>>> pci_bus 0000:00: root bus resource [mem 0x800100000000-0x8007ffffffff] (bus address [0x100000000-0x7ffffffff])
>>> pci_bus 0000:00: root bus resource [bus 00-77]
>>>
>>> -v2: mem64_space should use mem_space.start as offset.
>>> -v3: add IORESOURCE_MEM_64 flag
> ...
>> PCI: Scanning PBM /pci@301
>> pci_sun4v f0339c2c: PCI host bridge to bus 0009:00
>> pci_bus 0009:00: root bus resource [io  0x2027e40000000-0x2027e4fffffff] (bus address [0x0000-0xfffffff])
>> pci_bus 0009:00: root bus resource [mem 0x2024000100000-0x202407effffff] (bus address [0x00000000-0x7eefffff])
>> pci_bus 0009:00: root bus resource [mem 0x2024100000000-0x2024dffffffff] (bus address [0xfff00000-0xdffefffff])
>
> Looks like offset for mmio64 is not right.
>
> Please check attached patch on the this platform  and T5-8.

Good catch! That code change looks like the right thing to do and it 
fixed my issues with ixgbe not attaching. I still see lots of "no 
compatible bridge window" messages but overlapping address ranges are no 
longer reserved and as a result drivers are able to ioremap BARs 
successfully.

I have tested it on a T7 and one other platform where I was seeing 
problems without mem64 and both platforms work with this patch. I have 
not been able to get my hands on a T5-8 yet but I will try again on Monday.

Thanks,
Khalid

