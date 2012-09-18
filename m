Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46430 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2IRS6B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 14:58:01 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVRGK-Of1RuvFZRtuT-yZ7LGDD_oNWr2ier2aaUqrugmA@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<CAE9FiQVRGK-Of1RuvFZRtuT-yZ7LGDD_oNWr2ier2aaUqrugmA@mail.gmail.com>
Date: Tue, 18 Sep 2012 11:57:59 -0700
Message-ID: <CAE9FiQW3pyFFt714yuG-BzuK55eUjN4ojhNZ6LvwGqGWuAtMYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] acpi,pci: hostbridge hotplug support
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 11:41 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Sep 17, 2012 at 11:12 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>> Hi all,
>>
>>   This patchset is 3rd version of the following:
>>     http://marc.info/?l=linux-pci&m=134457928913775&w=2
>>     http://marc.info/?l=linux-pci&m=134665909321684&w=2
>>
>>  v2 -> v3:
>>    - change acpi_pci_drivers' add/remove interface according to Bjorn's suggestion
>>    - abandon RCU for protecting acpi_pci_roots list according to Bjorn's suggestion
>>    - change acpi_pci_find_root implementation to avoid potential deadlock
>>
>>   * [PATCH v3 1/8] ACPI, PCI: Use normal list for struct acpi_pci_driver
>>   * [PATCH v3 2/8] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
>>   * [PATCH v3 3/8] ACPI, PCI: add acpi_pci_drivers protection
>>   * [PATCH v3 4/8] ACPI, PCI: change acpi_pci_drivers' add/remove interface
>>   * [PATCH v3 5/8] ACPI, PCI: change acpi_pci_find_root implementation
>>   * [PATCH v3 6/8] ACPI, PCI: add acpi_pci_roots protection
>>   * [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
>>   * [PATCH v3 8/8] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge
>
> now it is more similar to my for-pci-root-bus-hotplug-part4 and part5
>
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-root-bus-hotplug-part5
>
> big difference:
> I separated code from acpiphp_glue.c to pci_root_hp.c for root bridge
> hotplug support
>
> I thought we all agreed on that acpi root bridge hotplug plug need to
> be separated from acpiphp at first.
>
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=ab9fd4ccbfb6120a4a4adf9833487d656b0501d3
>
> and CONFIG_HOTPLUG will always be enabled, so root bridge hotplug will
> be always enabled.
> acpiphp will still be used as one module, and to keep it simple pciehp
> will be used for pcie etc.
> That make the system BIOS much simple to avoid acpiphp.

also current acpiphp only have root bridge add notification.
and your code do not add any code for remove notification.

So how to you test your code with removal path?

Thanks

Yinghai
