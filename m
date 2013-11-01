Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56700 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab3KACpA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2013 22:45:00 -0400
Received: by mail-ie0-f174.google.com with SMTP id qd12so6500854ieb.33
        for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2013 19:44:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131031233245.GA9853@obsidianresearch.com>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131031101357.5a56e2d0@skate> <20131031164810.GA26426@obsidianresearch.com>
 <CAErSpo7bUP63J5RkXr-DkQE8qmvKT7ri-vjkfq+TtGEaYWxSwA@mail.gmail.com> <20131031233245.GA9853@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 31 Oct 2013 20:44:36 -0600
Message-ID: <CAErSpo4NDuNJ4mj1n4V8UgsdAJxMrSRy43Qz=3JNvtsrv2rMjA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 31, 2013 at 5:32 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Oct 31, 2013 at 11:10:42AM -0600, Bjorn Helgaas wrote:
>> On Thu, Oct 31, 2013 at 10:48 AM, Jason Gunthorpe
>> <jgunthorpe@obsidianresearch.com> wrote:
>>
>> > Indeed.. I was having problems here because linux was writing 0,0
>> > during discovery to the base,limit registers to 'disable' the IO
>> > window, which triggered a window allocation. So I re-read the PCI
>> > bridge spec (apparently too quickly) and decided 0,0 was OK, and it
>> > should be <=.
>> >
>> > However, looking again at the spec - it is very clear, < is the
>> > correct test, and when the values is equal a 4k window should be
>> > created.
>> >
>> > So, I wonder if there is a little bug in the Linux discovery code
>> > path, should it write FFFF,0 instead?
>>
>> Sounds like a bug to me.  Do you want to fix it, or point me at it the
>> place where we write 0,0 so I can fix it?
>
> Okay, I remember this now, it was annoying to debug because the PCI
> driver inits before the serial port starts working, fortunately
> Sebastian fixed that up, now it is much easier to see what is going
> on..
>
> The 0,0 write comes from this trace:
>
>  [<c0111b58>] (mvebu_pcie_handle_iobase_change+0x0/0x140) from [<c0111e70>] (mvebu_pcie_wr_conf+0x1d8/0x318) r5:00000000 r4:c78d0850
>  [<c0111c98>] (mvebu_pcie_wr_conf+0x0/0x318) from [<c0100e90>] (pci_bus_write_config_word+0x40/0x4c)
>  [<c0100e50>] (pci_bus_write_config_word+0x0/0x4c) from [<c02273d0>] (__pci_bus_size_bridges+0x2e4/0x744) r4:00000000
>  [<c02270ec>] (__pci_bus_size_bridges+0x0/0x744) from [<c0227344>] (__pci_bus_size_bridges+0x258/0x744)
>  [<c02270ec>] (__pci_bus_size_bridges+0x0/0x744) from [<c0227844>] (pci_bus_size_bridges+0x14/0x18)
>  [<c0227830>] (pci_bus_size_bridges+0x0/0x18) from [<c000cdc0>] (pci_common_init_dev+0x26c/0x2c0)
>  [<c000cb54>] (pci_common_init_dev+0x0/0x2c0) from [<c0111608>] (mvebu_pcie_probe+0x41c/0x480)
>  [<c01111ec>] (mvebu_pcie_probe+0x0/0x480) from [<c01335f0>] (platform_drv_probe+0x1c/0x20)
>
> And specifically this code sequence in pci_bridge_check_ranges:
>
>         pci_read_config_word(bridge, PCI_IO_BASE, &io);
>         if (!io) {
>                 pci_write_config_word(bridge, PCI_IO_BASE, 0xf0f0);
>                 pci_read_config_word(bridge, PCI_IO_BASE, &io);
>                 pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
>         }
>         if (io)
>                 b_res[0].flags |= IORESOURCE_IO;
>
> If I read this properly, the first sets the IO window to a 4k region
> at 0xF000, and the second sets the IO window to a 4k region at 0x0.

The purpose of this code is not to disable the I/O window; it is
merely to determine whether the bridge implements an I/O window.  The
configuration of the window (if implemented) is changed only
temporarily before being restored to the original config.

If the bridge does not implement an I/O window, the I/O Base and Limit
registers must be read-only and zero.  So if we read zero the first
time, either the bridge doesn't implement an I/O window, or it does
implement it and it is configured to the 4K region at 0x0.  The body
of the "if" does a write to see whether the registers are writable.

You obviously understand all this, so sorry for the repetition; I
guess I'm just trying to get it clear in my own mind :)

> How about this instead:
>
>         if (!io) {
>                 /* Disable the IO window by setting limit < base */
>                 pci_write_config_word(bridge, PCI_IO_BASE, 0x00f0);
>                 pci_read_config_word(bridge, PCI_IO_BASE, &io);
>         }
>         /* Bridges without IO support must wire the IO register to 0 */
>         if (io)
>                 b_res[0].flags |= IORESOURCE_IO;

If an I/O window happened to be configured to the 4K region at 0x0,
this disables it.  An I/O window configured anywhere else is left
enabled.  Previously the only effect of the function was to set bits
in b_res[].flags; with this change it would also sometimes disable an
I/O window.  That seems worse to me.  Am I just misunderstanding the
problem you're solving?

Bjorn
