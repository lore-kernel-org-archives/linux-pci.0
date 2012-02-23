Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39819 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab2BWRuA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 12:50:00 -0500
Received: by wics10 with SMTP id s10so929796wic.19
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 09:49:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
 <20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com> <20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 09:49:39 -0800
Message-ID: <CAErSpo7wSB-uCjV4YeA-fUOHPtugn4ASXScN3MndVybfkk8mOw@mail.gmail.com>
Subject: Re: PCIe device tree support
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Stephen Warren <swarren@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Olof Johansson (olof@lixom.net)" <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2012 at 10:03 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> * Bjorn Helgaas wrote:
>> On Wed, Feb 22, 2012 at 12:24 AM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > [Adding Jesse Barnes and the linux-pci mailing list to CC.]
>> >
>> > * Stephen Warren wrote:
>> >> Thierry Reding wrote at Monday, February 20, 2012 12:18 PM:
>> >> > I would like to add device tree support for the Tegra2 PCIe controller. From
>> >> > what I understand this will require the PCIe code to be rewritten as a proper
>> >> > platform driver in order to be able to instantiate it via the device tree. Is
>> >> > that correct?
>> >>
>> >> That's probably the cleanest way, yes.
>> >>
>> >> Is there a drivers/ directory for PCI/PCIe host controllers? Moving the
>> >> code there might be nice if so, although IIRC when I asked Olof about
>> >> that a number of months back, he said quite a few host controllers were
>> >> in arch/...
>> >
>> > Most PCI/PCIe host controller drivers seem to currently be in arch/. Is there
>> > a specific reason for this? Would it be acceptable to put any new drivers
>> > below drivers/pci/?
>>
>> PCI host bridges aren't architected, so discovering them and their
>> properties has historically been mostly architecture-specific.  ACPI
>> is one exception (with a driver in drivers/acpi/pci_root.c) and it
>> sounds like device tree might be a similar exception.  If you can make
>> a non-arch-specific driver and put it somewhere other than arch/, I'm
>> all in favor of that, especially if you can make it usable by other
>> arches that use device tree.  Where to put it?  I dunno.  drivers/pci/
>> sounds like a reasonable possibility.
>
> I don't think it would be possible to write a driver that works for all
> device tree based boards or architectures. As you said the implementation is
> very hardware specific and probably couldn't even be generalized among two
> chipsets of the same architecture.

Host bridges may be hardware-specific, but the PCI core really only
needs an abstract description.  It needs the bus number aperture, the
I/O port apertures, the MMIO apertures, and associated offsets between
CPU and PCI bus addresses.  I don't know anything about device tree,
but I'd be surprised and disappointed if it encodes this basic
information in platform-specific ways.

I agree that if the code isn't shared at all, there's no point in
putting it in a generic place like drivers/pci/.

Bjorn
