Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <34989330.IyIZ6Qqfxh@vostro.rjw.lan>
References: <1673357.1IdxNNvGWX@vostro.rjw.lan>
	<1362978316-23553-1-git-send-email-yinghai@kernel.org>
	<34989330.IyIZ6Qqfxh@vostro.rjw.lan>
Date: Tue, 26 Mar 2013 08:12:30 -0700
Message-ID: <CAE9FiQVSZd216JrdHdeLSrr1k0d5xTCmLz9FH151BHDDo8KRAQ@mail.gmail.com>
Subject: Re: [PATCH] PCI, ACPI: hold acpi_scan_lock during root bus hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 26, 2013 at 6:24 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, March 10, 2013 10:05:16 PM Yinghai Lu wrote:
>> During merging pci tree with pm/acpi tree, Linus noticed that
>> we don't have same lock using patten about acpi pci root as
>> acpiphp.
>>
>> Here apply same lock patten, and we need to change
>> acpi_bus_hot_remove_device executing via acpi_os_hotplug_execute()
>> as it also hold the lock in acpi_bus_hot_remove_device.
>>
>> That will make acpi_bus_hot_remove_device calling the same as other
>> callers.
>>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
>
> Bjorn, this needs to go in before final 3.9.
>
> Are you going to handle it, or should I take care of it?

It should be better via your pm+acpi tree, as that lock is added via your tree.

Thanks

Yinghai
