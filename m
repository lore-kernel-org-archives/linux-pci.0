Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35946 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbIOU0V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 16:26:21 -0400
Received: by vkfp126 with SMTP id p126so87712100vkf.3
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 13:26:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150915192559.GE25767@google.com>
References: <20150907091230.GB29293@red-moon>
	<20150914100929.GB18886@red-moon>
	<CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
	<20150914162834.GA11199@red-moon>
	<CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
	<CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
	<20150915094610.GD11199@red-moon>
	<CAErSpo5KaV7ERYcyZBzfvCEh40zSPJmymwXUCbAZkK=hb4DPSw@mail.gmail.com>
	<20150915163000.GA16240@red-moon>
	<55F84CAA.8060901@roeck-us.net>
	<20150915192559.GE25767@google.com>
Date: Tue, 15 Sep 2015 13:26:20 -0700
Message-ID: <CAE9FiQXULBy3FCO9wK9dNMTanGc1sRXip1DNoM4kjZfoEg=YFA@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ray Jui <rjui@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 12:25 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Ray]
>
> On Tue, Sep 15, 2015 at 09:51:54AM -0700, Guenter Roeck wrote:
>> On 09/15/2015 09:30 AM, Lorenzo Pieralisi wrote:
>> >On Tue, Sep 15, 2015 at 04:57:07PM +0100, Bjorn Helgaas wrote:
>
>> >>I'm inclined to revert dff22d2054b5 ("PCI: Call
>> >>pci_read_bridge_bases() from core instead of arch code") until we can
>> >>figure this out.  I think the idea of moving that work from
>> >>arch-specific code to the core is good, but it seems like it leads to
>> >>more hacky workarounds than real cleanup right now.  What would break
>> >>if we simply reverted it?  Would that reintroduce any problems?

Agreed, that is good if we can move pci_read_bridge_bases() to pci core.

Also hope that we can move pcibios_resource_survey() etc into
core too.


> I put the following on my for-linus branch for v4.3.  I'd appreciate any
> corrections to my understanding of the problem.
>
>
> commit d5da9d99d4d79d877815af96fdbfac829c4ce7b2
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Sep 15 13:18:04 2015 -0500
>
>     PCI: Revert "PCI: Call pci_read_bridge_bases() from core instead of arch code"
>
>     Revert dff22d2054b5 ("PCI: Call pci_read_bridge_bases() from core instead
>     of arch code").
>
>     Reading PCI bridge windows is not arch-specific in itself, but there is PCI
>     core code that doesn't work correctly if we read them too early.  For
>     example, Hannes found this case on an ARM Freescale i.mx6 board:
>
>       pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
>       pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>       pci 0000:00:00.0: BAR 8: no space for [mem size 0x01000000] (mem window)
>       pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
>       pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
>       pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
>
>     The 00:00.0 mem window needs to be at least 3MB: the 01:00.0 device needs
>     0x204100 of space, and mem windows are megabyte-aligned.
>
>     Bus sizing can increase a bridge window size, but never *decrease* it (see
>     d65245c3297a ("PCI: don't shrink bridge resources")).  Prior to
>     dff22d2054b5, ARM didn't read bridge windows at all, so the "original size"
>     was zero, and we assigned a 3MB window.
>
>     After dff22d2054b5, we read the bridge windows before sizing the bus.  The
>     firmware programmed a 16MB window (size 0x01000000) in 00:00.0, and since
>     we never decrease the size, we kept 16MB even though we only needed 3MB.
>     But 16MB doesn't fit in the host bridge aperture, so we failed to assign
>     space for the window and the downstream devices.
>
>     I think this is a defect in the PCI core: we shouldn't rely on the firmware
>     to assign sensible windows.
>
>     Ray reported a similar problem, also on ARM, with Broadcom iProc.
>
>     Issues like this are too hard to fix right now, so revert dff22d2054b5.
>
>     Reported-by: Hannes <oe5hpm@gmail.com>
>     Reported-by: Ray Jui <rjui@broadcom.com>
>     Link: http://lkml.kernel.org/r/CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com
>     Link: http://lkml.kernel.org/r/55F75BB8.4070405@broadcom.com
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Yinghai Lu <yinghai@kernel.org>
