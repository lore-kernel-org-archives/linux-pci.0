Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38203 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2JASBi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2012 14:01:38 -0400
Received: by lbon3 with SMTP id n3so4316507lbo.19
        for <linux-pci@vger.kernel.org>; Mon, 01 Oct 2012 11:01:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWv9V7gV1SPcTGGhnCGMow2xT42MXvFh1s6T6S23xTgkQ@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
 <1348733519-24684-4-git-send-email-yinghai@kernel.org> <CAErSpo63QeF-Wd8nW-K_Qfp5rjMd0mhWADGW-fZiw4Up5-0ezA@mail.gmail.com>
 <CAE9FiQXDw+D8FeMiojmcX0k_g939zkRM3XmJP08yJJG6o7_Cyg@mail.gmail.com>
 <CAE9FiQXWxgBQDPisGdVKb_r3hy6pA7LpamV-jW5OX0SqDyrCCw@mail.gmail.com>
 <CAErSpo4soM=HigBX3CxbGOGRtjr=4VgXneDXakaCHSufsOoH4Q@mail.gmail.com> <CAE9FiQWv9V7gV1SPcTGGhnCGMow2xT42MXvFh1s6T6S23xTgkQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 1 Oct 2012 12:01:16 -0600
Message-ID: <CAErSpo55BBr8YGdD1e4Oe0zeCOPG7i-os1tc3WTZAzMkVJfAqw@mail.gmail.com>
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 10:04 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Sep 28, 2012 at 8:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> Is it important that pci_assign_unassigned_bus_resources() be run
>> before the driver->add() methods?  Why?
>
> for ioapic controller that may need kernel to assign base bar.

It seems like there are two cases of IOAPICs we need to worry about:

1) An IOAPIC device in the ACPI namespace (ACPI0009, ACPI000A, or
ACPI000B).  This device has a _CRS that contains the device base
address.  Since it's an ACPI device and has _CRS, I expect it should
*not* appear in PCI config space and would have no BARs.

2) An IOAPIC device that appears in PCI config space.  This has a BAR
that we'll need to assign when hot-adding the device.

The spec (ACPI v5.0, sec 9.17) implies that the second type (a
bus-enumerated device) will not have an device in the ACPI namespace.
However, sec 6.2.6 says we need a _GSB for both types of IOAPICs, and
I don't know where the _GSB for bus-enumerated IOAPICs would live if
there's no ACPI device for them.

Since you're talking about assigning a BAR, I assume you're talking
about the second type -- a bus-enumerated IOAPIC.  I would also assume
that a PCI IOAPIC would appear in the hierarchy *above* any devices
that are connected to it, so we'd enumerate it *before* those devices.
 Maybe that will help ensure that we bind the driver to the IOAPIC
before binding drivers to devices that use it.

Can you help me understand this?  What's the topology of the machine
you're working on?  E.g., what does this part of the ACPI namespace
and PCI config space look like?

>> Do you have a pointer to this ioapic driver?  I don't think it's in
>> the tree yet.  I know about drivers/pci/ioapic.c, but it doesn't use
>> acpi_pci_register_driver().
>
> it is in my for-x86-irq branch.
>
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-x86-irq
>
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=c186df98f84336422088740ef8cedc1313ca2485
