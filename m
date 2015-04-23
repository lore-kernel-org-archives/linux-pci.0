Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36736 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbbDWWrM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2015 18:47:12 -0400
MIME-Version: 1.0
In-Reply-To: <CAPeXnHsrQrkeJ3QQ6ds6yhY0C31DKqnR2uHSm9rcXdGEHBDDAg@mail.gmail.com>
References: <alpine.DEB.2.00.1504200432000.1232@skynet.skynet.ie>
	<CA+55aFyVMfTBB0oz_yx8+eQOEJnzGtCsYSj9QuhEpdZ9BHdq5A@mail.gmail.com>
	<20150423213015.GA7888@google.com>
	<CAPeXnHsrQrkeJ3QQ6ds6yhY0C31DKqnR2uHSm9rcXdGEHBDDAg@mail.gmail.com>
Date: Thu, 23 Apr 2015 15:47:10 -0700
Message-ID: <CA+55aFwC+sH+62b4rDuy5PWAPEc9Xr3tWcCAQXOED+2Jk9C65A@mail.gmail.com>
Subject: Re: git pull] drm for v4.1-rc1
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Matthew Garrett <matthew.garrett@coreos.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@coreos.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 23, 2015 at 2:56 PM, Matthew Garrett
<matthew.garrett@coreos.com> wrote:
> On Thu, Apr 23, 2015 at 2:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>>   int pcibios_add_device(struct pci_dev *dev)
>>   {
>>     if (dev-is-default-vga-device) {
>>       dev->rom = 0xC0000;
>>       dev->romlen = 0x20000;
>>     }
>
> I don't know what we want to do here. This is, at some level,
> fundamentally wrong - however, it also wouldn't surprise me if this is
> also the only copy of the video ROM we have on some UEFI systems,
> especially since I believe that Windows 7 still required that there be
> a legacy ROM it could use for bootloader modesetting on UEFI
> platforms. So simply making this conditional on BIOS may break
> existing machines. But if there *is* a ROM there then we should be
> able to id it from the usual video ROM signature?

I'm not sure why we want that IORESOURCE_ROM_SHADOW thing at all, but
yes, if what this is all about is the magic video ROM at 0xc0000, then

 (a) it should have nothing what-so-ever to do with the actual PCI
BAR, since it's been *ages* since people actually had an expansion rom
like that, and it's much more common that the video ROM comes as part
of the system BIOS on laptops etc.

 (b) yes, the sane thing to do would be to just look for the ROM
signature, 0x55 0xaa at 2kB incrementing headers (and checking the
proper checksum too).

There is no way to see that from the PCI device state, because as
mentioned, quite often the "ROM" is entirely fake, and is not just
some shadowed copy of a real underlying hardware ROM, but is
fundamentally just a RAM image decompressed from some other source and
then marked read-only.

                   Linus
