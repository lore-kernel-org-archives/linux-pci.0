Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37926 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759095Ab2I2Bw2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 21:52:28 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXDw+D8FeMiojmcX0k_g939zkRM3XmJP08yJJG6o7_Cyg@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-4-git-send-email-yinghai@kernel.org>
	<CAErSpo63QeF-Wd8nW-K_Qfp5rjMd0mhWADGW-fZiw4Up5-0ezA@mail.gmail.com>
	<CAE9FiQXDw+D8FeMiojmcX0k_g939zkRM3XmJP08yJJG6o7_Cyg@mail.gmail.com>
Date: Fri, 28 Sep 2012 18:52:27 -0700
Message-ID: <CAE9FiQXWxgBQDPisGdVKb_r3hy6pA7LpamV-jW5OX0SqDyrCCw@mail.gmail.com>
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 6:48 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Sep 28, 2012 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> So could use assign_unassigned_bus_res pci root bus add
>>
>> After your series, acpi_pci_root_start() looks like this:
>>
>>     pci_assign_unassigned_bus_resources
>>     list_for_each_entry(driver, &acpi_pci_drivers, node)
>>         driver->add(root);
>>     pci_enable_bridges(root->bus);
>>
>> so apparently it's important that the driver->add() methods be run
>> *before* the bridges are enabled.  Why?
>

During rebase, the changelog get lost.

 pci_enable_bridges
    ==> pci_enable_device
        ==> ...
           ===> pcibios_enable_device
               ===> pcibios_enable_irq

and one of driver in acpi_pci_drivers, is ioapic drivers and it will
enable ioapic there.

So we need to enable bridges that later.

-Yinghai
