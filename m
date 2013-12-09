Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33052 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761846Ab3LIV61 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 16:58:27 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so6992652iec.23
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 13:58:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131209212744.GK5429@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131209193332.GB20199@obsidianresearch.com> <CAErSpo4Q-sjiCUs3UbQWdPhOTdxfJP1ay1MugxTPT1E2=TkpJw@mail.gmail.com>
 <20131209212744.GK5429@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 14:58:06 -0700
Message-ID: <CAErSpo6ZNM0SW+q7tSi+1hT6yAfb7Ckz85LjM4QUDgbH3wLAaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when
 setting up I/O aperture
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 2:27 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Dec 09, 2013 at 01:15:52PM -0700, Bjorn Helgaas wrote:
>
>> Is there actually some spec requirement about the access sizes that
>> must be supported by the hardware?  If there is something, I'll gladly
>> keep the 32-bit access, but if it's only a tegra/mvebu-specific
>> restriction, then I think it needs to be handled in the PCI config
>> accessors for that hardware.
>
> The host register interface is not specified by any standard.
>
> I looked a for a bit and found other drivers with the same problem:
>   arch/arm/mach-cns3xxx/pcie.c
>   arch/arm/mach-iop13xx/pci.c
>   arch/arm/mach-ks8695/pci.c
>   arch/arm/mach-sa1100/pci-nanoengine.c
>  [..]
>
> I stopped looking after that point..
>
>> This spec statement (PCI (not PCIe) r3.0, sec 3.2.2.3.4) makes it
>> sound like tegra/mvebu is non-conforming and should deal with this
>> specially:
>>
>> "A function must not restrict the size of the access it supports in
>> Configuration Space. The configuration commands, like other commands,
>> allow data to be accessed using any combination of bytes (including a
>> byte, word, DWORD, or non-contiguous bytes) and multiple data phases
>> in a burst. The target is required to handle any combination of byte
>> enables."
>
> This verbage is talking about the target/responder, not the host. Any
> target must respond to all possible sizes for all possible config
> registers, including combinations that even x86 can't issue (like a BE
> pattern of b0110)

Now I'm confused.  From the PCI core's point of view,
pci_setup_bridge_io() is talking to a target, namely a PCI-to-PCI
bridge.  PCI config space accessors are also for talking to targets.

I think you're talking about host bridges, and I agree that they are
not covered by this spec statement and can have arbitrary register
layout and access size restrictions.

Some arches set up their host bridges so they appear in PCI config
space and have register layouts that look like PCI-to-PCI bridges.  In
my opinion, those arches then have the responsibility of following all
the PCI-to-PCI bridge rules, including access size restrictions,
either directly in hardware or in their config accessors.

I don't think it makes sense to try to make the core know about this
stuff.  There are many places that touch bridges, and it would be
pretty hard to manage exceptions like this.

Bjorn
