Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:46337 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab3B1Exj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2013 23:53:39 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so1191166iak.32
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2013 20:53:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130228044205.GA30949@roeck-us.net>
References: <20130228044205.GA30949@roeck-us.net>
Date: Wed, 27 Feb 2013 20:53:37 -0800
Message-ID: <CAE9FiQX3Q+2ycXpR=Bn=tqW94F6e8cDZjiiE8vxO7wmJn_kUCg@mail.gmail.com>
Subject: Re: ACPI based PCI/PCIe bridge hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 27, 2013 at 8:42 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi all,
>
> we had a discussion about ACPI hotplug today at work. Someone claimed that ACPI
> would not support PCI/PCIe bridge hotplug.
>
> I don't know much about ACPI, but that seemed like a surprising limitation
> to me. After a little research, I found that the ACPI hotplug code seems to
> support it, and Microsoft was talking about adding it to Vista back in 2003.
>
> So ... just for my education, I have a couple of questions: Does ACPI support
> PCI/PCIe bridge hotplug or not ? And if it does, are there any limitations ?

Yes, Linux kernel support that via acpiphp.

but that will more rely on bios do the right job in ACPI DSDT.

Also need to make sure BIOS have leave enough bus number range and
io/mmio range.

Kernel also have pciehp for pcie hotplug.

Current kernel have some problem with loading sequence of acpiphp and pciehp,
but it will be solved.

Thanks

Yinghai
