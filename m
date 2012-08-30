Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:38992 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab2H3GeU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2012 02:34:20 -0400
Message-ID: <503F0937.6020804@huawei.com>
Date: Thu, 30 Aug 2012 14:33:27 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<kaneshige.kenji@jp.fujitsu.com>, <yinghai@kernel.org>
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com>
In-Reply-To: <CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-8-30 14:23, Bjorn Helgaas wrote:
> On Thu, Aug 9, 2012 at 11:09 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>>  Hi all,
>>
>>
>>  I'd like to merge hostbridge hotplug feature.
>>  I looked at Yinghai's branch and found that this branch contains
>>  many work and can be split into some parts.
>>  I believe it is good to merge step by step.
>>
>>  My idea is splitting into the following 4 parts:
>>    1. basic hostbirdge hotplug work
>>    2. acpiphp work
>>    3. /sysfs interface work (logical hotplug?)
>>    4. cleanup
>>
>>  This patchset is 1st step based on the following Yinghai's branch:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>> for-pci-root-bus-hotplug
>>
>>   * [PATCH 1/7][RESEND] x86, PCI: Fix non acpi path pci_sysdata leaking with release_fn
>>   * [PATCH 2/7][RESEND] PCI: Correctly clean up pci root buses in function pci_remove_bus()
>>   * [PATCH 3/7][RESEND] ACPI, PCI: Use normal list for struct acpi_pci_driver
>>   * [PATCH 4/7][RESEND] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
>>   * [PATCH 5/7][RESEND] ACPI, PCI: Protect global lists in drivers/acpi/pci_root.c
>>   * [PATCH 6/7][RESEND] ACPI, PCI: add hostbridge removal function
>>   * [PATCH 7/7][RESEND] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge
> 
> I looked at merging these tonight.  But I noticed there are still a
> few unanswered questions I asked earlier.
> 
> 1) For patch [1/7], I pointed out that there is currently no way to
> remove a non-ACPI host bridge, which means the fact that we don't free
> the pci_sysdata is not really a leak.  If you want to add the
> release_fn so that you can add support for removing and adding these
> non-ACPI host bridges in the future, I do not understand that.  It
> just doesn't make sense to me to try to support hotplug for those
> bridges.
> 
> 2) For patch [2/7], I'm still curious about the scenario where this
> patch makes a difference (see my previous response for details).
> 
> 3) Patch [5/7], adds mutual exclusion to two different lists, using
> two different mechanisms (mutex and RCU).  It would be easier for
> people to review if this were done in two separate patches.
Hi Bjorn,
	Sorry, I guessed you won't merge this into 3.6, so delayed reply. Will handle it tonight.
	--Gerry

> 
> Bjorn
> 
> 


