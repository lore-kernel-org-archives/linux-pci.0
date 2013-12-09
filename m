Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:57567 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab3LIUA5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 15:00:57 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so6744750iec.23
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 12:00:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131209193112.GA20199@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001947.27659.14981.stgit@bhelgaas-glaptop.roam.corp.google.com> <20131209193112.GA20199@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 13:00:36 -0700
Message-ID: <CAErSpo5ab6buYa9GvpYECeeCwhYATt6dVePD6Cov-75kQndf4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Prevent bus conflicts while checking for bridge apertures
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 12:31 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Dec 05, 2013 at 05:19:47PM -0700, Bjorn Helgaas wrote:
>> pci_bridge_check_ranges() determines whether the bridge supports an I/O
>> aperture and a prefetchable memory aperture.
>>
>> Previously, if the I/O aperture was unsupported, disabled, or configured at
>> [io 0x0000-0x0fff], we wrote 0xf0 to PCI_IO_BASE and PCI_IO_LIMIT, which,
>> if the bridge supports it, enables the I/O aperture at [io 0xf000-0xffff].
>> The enabled aperture may conflict with other devices in the system.
>>
>> Similarly, we wrote 0xfff0 to PCI_PREF_MEMORY_BASE and
>> PCI_PREF_MEMORY_LIMIT, which enables the prefetchable memory aperture at
>> [mem 0xfff00000-0xffffffff], and that may also conflict with other devices.
>>
>> All we need to know is whether the base and limit registers are writable,
>> so we can use values that leave the apertures disabled, e.g., PCI_IO_BASE =
>> 0xf0, PCI_IO_LIMIT = 0xe0, PCI_PREF_MEMORY_BASE = 0xfff0,
>> PCI_PREF_MEMORY_LIMIT = 0xffe0.
>>
>> Writing non-zero values to both the base and limit registers means we
>> detect whether either or both are writable, as we did before.
>
> Looks sane to me. The only refinement would be to detect if IO is
> enabled and use that as a first check.

I assume you mean checking PCI_COMMAND_IO, as in this fragment you
posted earlier:

+               pci_read_config_word(bridge, PCI_COMMAND, &command);
+               if (command & PCI_COMMAND_IO)
+                       b_res[0].flags |= IORESOURCE_IO;
+               else {
+                       pci_write_config_word(bridge, PCI_IO_BASE, 0x00f0);

That would avoid the writes to PCI_IO_BASE in the case where an I/O
aperture is already enabled and configured at [io 0x0000-0x0fff],
which has the advantage of not temporarily disabling the aperture.

I don't think it's 100% spec compliant because the spec allows
PCI_COMMAND_IO to be set if the bridge has an enabled I/O BAR but does
not support an I/O aperture.  I admit I have never seen such a device,
and I doubt one exists :)

To my mind, it's not worth adding the check, because we shouldn't be
sending I/O accesses to devices behind the bridge at this point
anyway, so the temporary disable shouldn't be a problem.  If we *are*
sending accesses to such a device, the current code moves the
aperture, so the bridge won't claim them, and we already have a
problem.  So I don't think my patch will add any problems there, and
it can conceivably prevent a conflict with another device at [io
0xf000-0xffff].

Bjorn
