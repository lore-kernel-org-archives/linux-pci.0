Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59583 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbaKCWBJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Nov 2014 17:01:09 -0500
Received: by mail-lb0-f173.google.com with SMTP id p9so4472146lbv.32
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2014 14:01:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5wxRyfpfaTM-MqwMYqzV4tYzz5uZKV5kRWwi5Y7-CiqQ@mail.gmail.com>
References: <5456C024.4060103@hauke-m.de> <CAErSpo5wxRyfpfaTM-MqwMYqzV4tYzz5uZKV5kRWwi5Y7-CiqQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 3 Nov 2014 16:00:46 -0600
Message-ID: <CAL_JsqK0737hND4C0pkNXYwyuecm8K2k=LUMNDZvqdkg=H52NA@mail.gmail.com>
Subject: Re: PCIe host controller without IO port access.
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 3, 2014 at 11:41 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Rob (author of 3c5d1699887b), Arnd]
>
> On Sun, Nov 2, 2014 at 4:37 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> Hi,
>>
>> I am currently writing a driver for a PCIe host controller which does
>> not support IO port access.
>>
>> My plan was to only provide IORESOURCE_MEM to pci_sys_data->resources,
>> but then it allocates some generic IORESOURCE_IO memory in
>> arch/arm/kernel/bios32.c:pcibios_init_resources(). This will work for
>> the fist PCIe controller, but when the second controller gets registered
>> I am getting this: "unable to allocate I/O port region (-16)".
>>
>> Is there an example for an arm driver for a PCIe controller which does
>> not support IO port access?
>>
>> Should I change arch/arm/kernel/bios32.c in a way so that it would
>> ignore the io port mem?
>
> I think this is a case of "all current platforms support an I/O space,
> so we'll set it up in the ARM PCI core."  But I/O space is not (as far
> as I know) a required feature of PCI host bridges on ARM, so I suspect
> you should change arch/arm/kernel/bios32.c in some way to accomodate
> controllers with no I/O port space at all.

I guess we could ignore the error on request_resource or define a way
to flag no i/o space. However, any new driver should be using all the
new generic infrastructure. I think this code path should not even be
called in that case.

Rob
