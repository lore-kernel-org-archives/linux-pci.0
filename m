Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:33337 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab3KAF25 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Nov 2013 01:28:57 -0400
Date: Thu, 31 Oct 2013 23:28:48 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
Message-ID: <20131101052848.GA20163@obsidianresearch.com>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131031101357.5a56e2d0@skate>
 <20131031164810.GA26426@obsidianresearch.com>
 <CAErSpo7bUP63J5RkXr-DkQE8qmvKT7ri-vjkfq+TtGEaYWxSwA@mail.gmail.com>
 <20131031233245.GA9853@obsidianresearch.com>
 <CAErSpo4NDuNJ4mj1n4V8UgsdAJxMrSRy43Qz=3JNvtsrv2rMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4NDuNJ4mj1n4V8UgsdAJxMrSRy43Qz=3JNvtsrv2rMjA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 31, 2013 at 08:44:36PM -0600, Bjorn Helgaas wrote:
 
> You obviously understand all this, so sorry for the repetition; I
> guess I'm just trying to get it clear in my own mind :)

Ditto, it is tricky. When I first looked at that code I thought it was
trying to do something else..

> > How about this instead:
> >
> >         if (!io) {
> >                 /* Disable the IO window by setting limit < base */
> >                 pci_write_config_word(bridge, PCI_IO_BASE, 0x00f0);
> >                 pci_read_config_word(bridge, PCI_IO_BASE, &io);
> >         }
> >         /* Bridges without IO support must wire the IO register to 0 */
> >         if (io)
> >                 b_res[0].flags |= IORESOURCE_IO;
> 
> If an I/O window happened to be configured to the 4K region at 0x0,
> this disables it.  An I/O window configured anywhere else is left
> enabled.  Previously the only effect of the function was to set bits
> in b_res[].flags; with this change it would also sometimes disable an
> I/O window.  That seems worse to me.  Am I just misunderstanding the
> problem you're solving?

No, you've got it right. The problem I had is completely solved by
PATCH 1/2 PCI: mvebu - The bridge should obey the MEM and IO command
bits

But the code looks odd to me. 

It is certainly correct as written if the check is only ever called
with PCI_COMMAND_IO cleared. 

However, I am having trouble convincing myself of this. Notably
pci_setup_bridge does not seem to make that assumption.

If PCI_COMMAND_IO is set, it can just assume IORESOURCE_IO and skip
the testing of the PCI_IO_BASE register.

Why 0xf0f0 anyhow? :)

Jason
