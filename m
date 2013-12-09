Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42775 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761436Ab3LIUQN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 15:16:13 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so7014563iec.41
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 12:16:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131209193332.GB20199@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com> <20131209193332.GB20199@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 13:15:52 -0700
Message-ID: <CAErSpo4Q-sjiCUs3UbQWdPhOTdxfJP1ay1MugxTPT1E2=TkpJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when
 setting up I/O aperture
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 12:33 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Dec 05, 2013 at 05:19:55PM -0700, Bjorn Helgaas wrote:
>> pci_setup_bridge_io() accessed PCI_IO_BASE and PCI_IO_LIMIT using dword
>> (32-bit) reads and writes, which also access the Secondary Status register.
>> Since the Secondary Status register is in the upper 16 bits of the dword,
>> and we preserved those upper 16 bits, this had the effect of clearing any
>> of the write-1-to-clear bits that happened to be set in the Secondary
>> Status register.
>
> This is a good catch!
>
>> -     pci_write_config_dword(bridge, PCI_IO_BASE, l);
>> +     pci_write_config_word(bridge, PCI_IO_BASE, l);
>
> But this is a problem :(
>
> tegra and mvebu at least do not have HW to do non-32 bit writes, so
> their implementation of pci_write_config_word does the RMW internally
> and will still have this same bug.
>
> I think you have to keep the 32 bit write here, but zero the
> write-one-to-clear bits :(

Is there actually some spec requirement about the access sizes that
must be supported by the hardware?  If there is something, I'll gladly
keep the 32-bit access, but if it's only a tegra/mvebu-specific
restriction, then I think it needs to be handled in the PCI config
accessors for that hardware.

This spec statement (PCI (not PCIe) r3.0, sec 3.2.2.3.4) makes it
sound like tegra/mvebu is non-conforming and should deal with this
specially:

"A function must not restrict the size of the access it supports in
Configuration Space. The configuration commands, like other commands,
allow data to be accessed using any combination of bytes (including a
byte, word, DWORD, or non-contiguous bytes) and multiple data phases
in a burst. The target is required to handle any combination of byte
enables."

I think the tegra/mvebu accessors should be able to use the address
and access size to figure out what we're trying to do.  If we're doing
a WORD write to PCI_IO_BASE, it can turn that into: 32-bit read, clear
the upper 16 bits (secondary status), insert the PCI_IO_BASE part,
32-bit write.  If we're doing a 16-bit write to PCI_SEC_STATUS, it can
turn that into: 32-bit read, insert upper 16 bits (secondary status),
leave lower 16 bits alone, 32-bit write.

Bjorn
