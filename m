Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57491 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932171AbbIYOft (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Sep 2015 10:35:49 -0400
Date: Fri, 25 Sep 2015 09:35:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Myron Stowe <myron.stowe@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
Message-ID: <20150925143546.GA1017@localhost>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
 <CAE9FiQWY1gdpzdqToBM0sNgfCRnRfEEgJfn-J9igorLH1K80JA@mail.gmail.com>
 <CAL-B5D0f10Q6C5jmjzysowDjJ=Z8iA1tSSAQwUp9qcxW-WeMPw@mail.gmail.com>
 <CAE9FiQVXox9UbaQKZvatLwdqbEp6k9QpRcSCeFNROdK6=5qq2Q@mail.gmail.com>
 <CAE9FiQWd69=6-UvCWsPOHvnZ96grJyzEt_+WR0-Q3M9wHz69hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWd69=6-UvCWsPOHvnZ96grJyzEt_+WR0-Q3M9wHz69hw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 24, 2015 at 09:35:20PM -0700, Yinghai Lu wrote:
> On Thu, Sep 24, 2015 at 12:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> 
> > Or do we want to keep a white list to say which device should have
> > ROM bar as mush have, and other is optional to have ?
> 
> Subject: [RFC PATCH] PCI: Add pci_dev_need_rom_bar()
> 
> Only set that for
> 1. if BIOS/firmware already set ROM bar.
> 2. via quirks for some devices.
> 
> We assign those needed ROM bar as required
> and other ROM bars as optional resources.

I'd rather not have a whitelist if we can avoid it.  We'd be
continually adding new devices to it, and it makes the system harder
to understand because there's no consistent rule about how ROMs are
handled.

Alex mentioned the idea of ripping the ROM, and I'd like to explore
that idea a little more.  What if we could temporarily assign space
for the ROM during enumeration, read the contents, cache the contents
somewhere, then deallocate the actual BAR space?  We could hang onto
the cache and give it to anybody who later needs the ROM.

I know there are probably issues here, but I don't know what they are,
so I'd like to at least have a conversation about it.

Bjorn
