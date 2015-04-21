Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33389 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbbDUQHq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2015 12:07:46 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1504200432000.1232@skynet.skynet.ie>
References: <alpine.DEB.2.00.1504200432000.1232@skynet.skynet.ie>
Date: Tue, 21 Apr 2015 09:07:45 -0700
Message-ID: <CA+55aFyVMfTBB0oz_yx8+eQOEJnzGtCsYSj9QuhEpdZ9BHdq5A@mail.gmail.com>
Subject: Re: git pull] drm for v4.1-rc1
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Dave Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hmm. The odd Intel PCI resource mess is back.

Or maybe it never went away.

I get these when suspending. Things *work*, but it's really spamming
my logs a fair bit:

  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  pci_bus 0000:01: Allocating resources
  pci_bus 0000:02: Allocating resources
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment

That resource is complete garbage. "flags 0x2" is not even a valid
flag value. I'm *guessing* it might be IORESOURCE_ROM_SHADOW, but if
that is valid, then it should also have have had the IORESOURCE_MEM
bit, and it doesn't.

(The low 8 bits of the resource flags depend on the high bits, which
is why I say that I'm "guessing" at that ROM_SHADOW bit. It could be
something else, like a IORESOURCE_MEM_CACHEABLE PnP bit - but that
should not show up for PCI, and "BAR 6" is normally the ROM resource,
so the ROM_SHADOW bit makes some sense.

The only place that sets IORESOURCE_ROM_SHADOW that I find is the x86
pci_fixup_video() function. That one checks for PCI_COMMAND_IO |
PCI_COMMAND_MEMORY in the PCI command word, though. Why are the other
bits not set?

Both i915/dri people and PCI people on the Cc. This warning does *not*
happen at bootup, but only at suspend time. So my suspicion is that
somebody messes with the PCI ROM resource, and disables it or
something, but the IORESOURCE_ROM_SHADOW never gets cleared. And then
because res->flags is non-zero, the PCI scanning code doesn't ignore
the resource.

Just before the whole bogus alignment check, the PCI code does

                if (!(r->flags) || r->parent)
                        continue;

(don't ask me about the odd parenthesis) which *should* have
triggered, but that IORESOURCE_ROM_SHADOW bit screws things up.

Anybody?

            Linus
