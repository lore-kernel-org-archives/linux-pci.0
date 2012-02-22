Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47274 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab2BVQFz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2012 11:05:55 -0500
Received: by werb13 with SMTP id b13so126020wer.19
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2012 08:05:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com> <20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 Feb 2012 08:01:55 -0800
Message-ID: <CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com>
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

On Wed, Feb 22, 2012 at 12:24 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> [Adding Jesse Barnes and the linux-pci mailing list to CC.]
>
> * Stephen Warren wrote:
>> Thierry Reding wrote at Monday, February 20, 2012 12:18 PM:
>> > I would like to add device tree support for the Tegra2 PCIe controller. From
>> > what I understand this will require the PCIe code to be rewritten as a proper
>> > platform driver in order to be able to instantiate it via the device tree. Is
>> > that correct?
>>
>> That's probably the cleanest way, yes.
>>
>> Is there a drivers/ directory for PCI/PCIe host controllers? Moving the
>> code there might be nice if so, although IIRC when I asked Olof about
>> that a number of months back, he said quite a few host controllers were
>> in arch/...
>
> Most PCI/PCIe host controller drivers seem to currently be in arch/. Is there
> a specific reason for this? Would it be acceptable to put any new drivers
> below drivers/pci/?

PCI host bridges aren't architected, so discovering them and their
properties has historically been mostly architecture-specific.  ACPI
is one exception (with a driver in drivers/acpi/pci_root.c) and it
sounds like device tree might be a similar exception.  If you can make
a non-arch-specific driver and put it somewhere other than arch/, I'm
all in favor of that, especially if you can make it usable by other
arches that use device tree.  Where to put it?  I dunno.  drivers/pci/
sounds like a reasonable possibility.

Bjorn
