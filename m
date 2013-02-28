Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56302 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab3B1FK0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2013 00:10:26 -0500
Date: Wed, 27 Feb 2013 21:10:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: ACPI based PCI/PCIe bridge hotplug
Message-ID: <20130228050857.GA31066@roeck-us.net>
References: <20130228044205.GA30949@roeck-us.net>
 <CAE9FiQX3Q+2ycXpR=Bn=tqW94F6e8cDZjiiE8vxO7wmJn_kUCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQX3Q+2ycXpR=Bn=tqW94F6e8cDZjiiE8vxO7wmJn_kUCg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 27, 2013 at 08:53:37PM -0800, Yinghai Lu wrote:
> On Wed, Feb 27, 2013 at 8:42 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > Hi all,
> >
> > we had a discussion about ACPI hotplug today at work. Someone claimed that ACPI
> > would not support PCI/PCIe bridge hotplug.
> >
> > I don't know much about ACPI, but that seemed like a surprising limitation
> > to me. After a little research, I found that the ACPI hotplug code seems to
> > support it, and Microsoft was talking about adding it to Vista back in 2003.
> >
> > So ... just for my education, I have a couple of questions: Does ACPI support
> > PCI/PCIe bridge hotplug or not ? And if it does, are there any limitations ?
> 
> Yes, Linux kernel support that via acpiphp.
> 
> but that will more rely on bios do the right job in ACPI DSDT.
> 
> Also need to make sure BIOS have leave enough bus number range and
> io/mmio range.
> 
> Kernel also have pciehp for pcie hotplug.
> 
Exactly what I thought.

Thanks a lot for the clarification.

Guenter

[ Bjorn, sorry I dropped you from the Cc:, but my e-mail provider and Google
  still don't like each other ]
