Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <503F96EB.2010304@gmail.com>
Date: Fri, 31 Aug 2012 00:38:03 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, jiang.liu@huawei.com
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com> <CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com>
In-Reply-To: <CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/30/2012 11:48 PM, Yinghai Lu wrote:
> On Wed, Aug 29, 2012 at 11:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Aug 9, 2012 at 11:09 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>>>  Hi all,
>>>
>>>
>>>  I'd like to merge hostbridge hotplug feature.
>>>  I looked at Yinghai's branch and found that this branch contains
>>>  many work and can be split into some parts.
>>>  I believe it is good to merge step by step.
>>>
>>>  My idea is splitting into the following 4 parts:
>>>    1. basic hostbirdge hotplug work
>>>    2. acpiphp work
>>>    3. /sysfs interface work (logical hotplug?)
>>>    4. cleanup
>>>
>>>  This patchset is 1st step based on the following Yinghai's branch:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>>> for-pci-root-bus-hotplug
>>>
>>>   * [PATCH 1/7][RESEND] x86, PCI: Fix non acpi path pci_sysdata leaking with release_fn
>>>   * [PATCH 2/7][RESEND] PCI: Correctly clean up pci root buses in function pci_remove_bus()
>>>   * [PATCH 3/7][RESEND] ACPI, PCI: Use normal list for struct acpi_pci_driver
>>>   * [PATCH 4/7][RESEND] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
>>>   * [PATCH 5/7][RESEND] ACPI, PCI: Protect global lists in drivers/acpi/pci_root.c
>>>   * [PATCH 6/7][RESEND] ACPI, PCI: add hostbridge removal function
>>>   * [PATCH 7/7][RESEND] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge
>>
>> I looked at merging these tonight.  But I noticed there are still a
>> few unanswered questions I asked earlier.
>>
>> 1) For patch [1/7], I pointed out that there is currently no way to
>> remove a non-ACPI host bridge, which means the fact that we don't free
>> the pci_sysdata is not really a leak.  If you want to add the
>> release_fn so that you can add support for removing and adding these
>> non-ACPI host bridges in the future, I do not understand that.  It
>> just doesn't make sense to me to try to support hotplug for those
>> bridges.
> 
> for Intel Nehalem and westmere -ex system, there will be root bus from
> 0xf8 to 0xff for cpus.
> and BIOS does not put the in ACPI, but __pci_mmcfg_init will set the
> pcibios_last_bus.
> so those but get probed via pcibios_fixup_peer_bridges.
Hi Yinghai,
	For system does support physical processor hotplug, I think
BIOS should expose those special PCI buses, otherwise we may run into
trouble after removing a physical processor.
	BTW, do we really want to support logical PCI host bridge hotplug
or only support physical host bridge hotplug? Here logical hotplug means
adding a PCI bus into or removing a PCI bus from the running kernel.
	--Gerry 

> 
> I hope I could use /sys to remove non-acpi root bus.
> 
> As for merging, I suggest following sequence:
> 1. fw resource allocate per bus.
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=patch;h=3b0a9d26e1838b7ddd2b2273ee38ff4ea3bcc89e
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=bb6436eb378c2b86478d3d6dfae3b032288ce68a
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=48e4eb57f72cba194486ed8b264148820a4165ec
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=f01ef104f823ec8fbe0eb0313d1677ef596eeb74
> 
> 2. separate out pci host bridge hotplug add support from acpiphp
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=f00a5bdd7f0460eef573e2ef8f2a96a408300c75
> 
> 3. add pci host bridge remove support
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=eb46eaf0369464e4fab003f8721dc80423b34ee1
> ...
> 
> will rebase
> busn_alloc and root bus branch and send whole patchset for review.
> 
> Thanks
> 
> Yinghai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

