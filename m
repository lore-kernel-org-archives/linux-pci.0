Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 May 2012 14:54:55 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Wei Yang <weiyang.kernel@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: One problem in reassign pci bus number?
Message-ID: <20120503065455.GA30042@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120410090306.GA7056@richard>
 <20120422155202.GA13540@richard>
 <CAE9FiQXoUcUw5kOcBmsbBu_hJ+GbKk--qFt+WyUHbjJPwY+8Pw@mail.gmail.com>
 <CADLM8XPryGVVWVruB=sZ9zxPp-nEhz8xKeMhY3u8KBShk2suBQ@mail.gmail.com>
 <CAE9FiQXLxEEu68tJvph3LB53nqycK+YctwDKMEF824koXVM5AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXLxEEu68tJvph3LB53nqycK+YctwDKMEF824koXVM5AA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2012 at 09:28:19AM -0700, Yinghai Lu wrote:
>On Wed, Apr 25, 2012 at 2:47 AM, Wei Yang <weiyang.kernel@gmail.com> wrote:
>>> busn_alloc patchset should address your concern.
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>>> for-pci-busn-alloc
>>>
>> Yinghai
>>
>> You mean this patch 44b2347b fix the problem?
>>
>> In the comment, "do pass0 for all good bridge".
>> Then there are totally two pass for a whole pci domain?
>
>also other commits about strict checking to see if it is good.
>
>>
>> I tried "git grep busn_alloc", but not find anything.
>
>the commit in the patchset.
>
>  PCI: Add busn_res into struct pci_bus.
>  PCI: Add busn_res operation functions
>  PCI: Release busn_res when removing bus
>  PCI: Insert busn_res in pci_create_root_bus()
>  PCI: Checking busn_res in pci_scan_root_bus()
>  PCI: Add default busn_resource
>  PCI: Add default busn_res for pci_scan_bus()
>  x86, PCI: Add busn_res into resources list for acpi path
>  x86, PCI: Put busn resource in pci_root_info for not using _CRS path
>  PCI, ia64: Register busn_res for root buses
>  PCI, sparc: Register busn_res for root buses
>  PCI, powerpc: Register busn_res for root buses
>  PCI, parisc: Register busn_res for root buses
>  resources: Add probe_resource()
>  resources: Replace registered resource in tree.
>  PCI: Add pci_bus_extend/shrink_top()
>  PCI: Probe safe range that we can use for unassigned bridge.
>  PCI: Add pci_bus_replace_busn_res()
>  PCI: Allocate bus range instead of use max blindly
>  PCI: Strict checking of valid range for bridge
>  PCI: Kill pci_fixup_parent_subordinate_busnr()
>  PCI: Seperate child bus scanning to two passes overall
>  pcmcia: Remove workaround for fixing pci parent bus subordinate
>  PCI: Double checking setting for bus register and bus struct.
>  PCI, pciehp: Remove not needed bus number range checking
>  PCI: More strict checking of valid range for bridge
>  PCI: Don't shrink too much for hotplug bridge

Yinghai,

For some functions, such as probe_resource() would you mind add some
comments?  Such as explain the parameter usage.
That would help for reading the function.
-- 
Richard Yang
Help you, Help me

