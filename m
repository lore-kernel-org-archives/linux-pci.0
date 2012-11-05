Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34659 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab2KEW1c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2012 17:27:32 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2866266wey.19
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2012 14:27:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3954574.77sdfIpds8@vostro.rjw.lan>
References: <20121030040237.GA10472@google.com> <1351618965-16761-1-git-send-email-yinghai@kernel.org>
 <3954574.77sdfIpds8@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Nov 2012 15:27:10 -0700
Message-ID: <CAErSpo4M8ku9uCeXVYcSr3chKvhhG-7vWJ8UjZtOKNezF9y1Yg@mail.gmail.com>
Subject: Re:
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 1, 2012 at 6:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Tuesday, October 30, 2012 10:42:37 AM Yinghai Lu wrote:
>> Subject: [PATCH resend 0/8] PCI, ACPI, x86: pci root bus hotplug support resources assign and remove path
>>
>> 1. add support for assign resource for hot add path.
>> 2. stop and remove root bus during acpi root remove.
>>
>>
>> could get from
>>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>>
>> Yinghai Lu (8):
>>   PCI: Separate out pci_assign_unassigned_bus_resources()
>>   PCI: Move pci_rescan_bus() back to probe.c
>>   PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
>>   PCI, ACPI: assign unassigned resource for hot add root bus
>>   PCI: Add pci_stop/remove_root_bus()
>>   PCI, ACPI: Make acpi_pci_root_remove stop/remove pci root bus
>>   PCI, ACPI: delete root bus prt during hot remove path
>>   PCI, ACPI: remove acpi_root_driver in reserse order
>>
>>  drivers/acpi/pci_root.c |   21 ++++++++++++++++++++-
>>  drivers/pci/probe.c     |   22 ++++++++++++++++++++++
>>  drivers/pci/remove.c    |   36 ++++++++++++++++++++++++++++++++++++
>>  drivers/pci/setup-bus.c |   22 +---------------------
>>  include/linux/pci.h     |    3 +++
>>  5 files changed, 82 insertions(+), 22 deletions(-)
>
> Please feel free to add
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> to the ACPI-related patches in this series.

I applied these to my pci/yinghai-for-pci-root-bus-hotplug branch as
v3.8 material.  They should appear in "next" tomorrow.  Thanks!
