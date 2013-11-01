Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38643 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab3KANu0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2013 09:50:26 -0400
Received: by mail-ie0-f171.google.com with SMTP id tp5so7657033ieb.30
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2013 06:50:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131101052848.GA20163@obsidianresearch.com>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131031101357.5a56e2d0@skate> <20131031164810.GA26426@obsidianresearch.com>
 <CAErSpo7bUP63J5RkXr-DkQE8qmvKT7ri-vjkfq+TtGEaYWxSwA@mail.gmail.com>
 <20131031233245.GA9853@obsidianresearch.com> <CAErSpo4NDuNJ4mj1n4V8UgsdAJxMrSRy43Qz=3JNvtsrv2rMjA@mail.gmail.com>
 <20131101052848.GA20163@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 1 Nov 2013 07:50:05 -0600
Message-ID: <CAErSpo5Y5TH+iapqzhQAcLY6V0rvK=7QAEStcbzLv4mAuLKPDg@mail.gmail.com>
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

On Thu, Oct 31, 2013 at 11:28 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Oct 31, 2013 at 08:44:36PM -0600, Bjorn Helgaas wrote:
>
>> You obviously understand all this, so sorry for the repetition; I
>> guess I'm just trying to get it clear in my own mind :)
>
> Ditto, it is tricky. When I first looked at that code I thought it was
> trying to do something else..
>
>> > How about this instead:
>> >
>> >         if (!io) {
>> >                 /* Disable the IO window by setting limit < base */
>> >                 pci_write_config_word(bridge, PCI_IO_BASE, 0x00f0);
>> >                 pci_read_config_word(bridge, PCI_IO_BASE, &io);
>> >         }
>> >         /* Bridges without IO support must wire the IO register to 0 */
>> >         if (io)
>> >                 b_res[0].flags |= IORESOURCE_IO;
>>
>> If an I/O window happened to be configured to the 4K region at 0x0,
>> this disables it.  An I/O window configured anywhere else is left
>> enabled.  Previously the only effect of the function was to set bits
>> in b_res[].flags; with this change it would also sometimes disable an
>> I/O window.  That seems worse to me.  Am I just misunderstanding the
>> problem you're solving?
>
> No, you've got it right. The problem I had is completely solved by
> PATCH 1/2 PCI: mvebu - The bridge should obey the MEM and IO command
> bits
>
> But the code looks odd to me.
>
> It is certainly correct as written if the check is only ever called
> with PCI_COMMAND_IO cleared.
>
> However, I am having trouble convincing myself of this. Notably
> pci_setup_bridge does not seem to make that assumption.

Yeah, I didn't see any place that clears or even checks PCI_COMMAND_IO
before doing this.   Originally this would only have been run at
boot-time, and there was probably no worry about concurrent accesses
that might get claimed while the window is temporarily configured at
0xf000.  But the boot-time only assumption no longer holds, so this
makes me uneasy.

> If PCI_COMMAND_IO is set, it can just assume IORESOURCE_IO and skip
> the testing of the PCI_IO_BASE register.
>
> Why 0xf0f0 anyhow? :)

I don't know why 0xf0f0.  Anything that's non-zero in the upper four
bits of each byte should work to determine writability.  It seems like
it would be safer to write 0x00f0 so the window is disabled, because
even if we're enumerating the bridge at hot-plug time, nobody else
should be trying to access a device behind the bridge, and we wouldn't
inadvertently claim something destined for [io 0xf000-0xffff].

Bjorn
