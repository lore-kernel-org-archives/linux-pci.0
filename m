Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54177 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbAEJfv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jan 2015 04:35:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robherring2@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Peter Maydell <peter.maydell@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"arm@kernel.org" <arm@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/9] pci: add DT based ARM Versatile PCI host driver
Date: Mon, 05 Jan 2015 10:35:32 +0100
Message-ID: <29010664.sxfpXiecGs@wuerfel>
In-Reply-To: <CAL_JsqKj3KCwgtb8SViiAFSqhOS0gSq2gLQU1G3kFmV6o=q5iQ@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com> <5205206.j8Q9x4GQsU@wuerfel> <CAL_JsqKj3KCwgtb8SViiAFSqhOS0gSq2gLQU1G3kFmV6o=q5iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 02 January 2015 17:13:19 Rob Herring wrote:
> On Fri, Jan 2, 2015 at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 02 January 2015 12:14:43 Rob Herring wrote:
> >> On Tue, Dec 30, 2014 at 3:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Tuesday 30 December 2014 13:28:33 Rob Herring wrote:

> >> > Maybe just return PCIBIOS_BAD_REGISTER_NUMBER in this case?
> >>
> >> Perhaps. We could probably simplify the config space read/write
> >> functions and just provide the PCI core a bus/devfn/offset to config
> >> address translation function. That would not work in all cases, but
> >> propably most that have memory mapped config space.
> >
> > Actually, thinking about this some more, the implementation seems to
> > be "CAM" compliant, and we could share the confic space accessors with
> > the ones from drivers/pci/host/pci-host-generic.c.
> 
> Almost. It uses readl for all size accesses. Yet writes support
> different access sizes. I would guess that the h/w can support byte
> and word reads if writes are supported, but I can't really verify.
> Dword-only sized reads or reads and writes seem to be the main
> variations for config space accesses. There's a few hosts with more
> complex config space access setup, but quite a few only vary in
> address decode.

It was probably just done the current way because it seemed simpler
at the time, but I agree that we can just keep it like this if there
is any chance it's required as a workaround for a hardware glitch.

With your other patch you just posted, it really becomes trivial
to do.

> >> I'm a bit puzzled myself. I think that the devices are not probed
> >> until after pci_assign_unassigned_bus_resources. It certainly doesn't
> >> work without that call. Really, I think of_irq_parse_and_map_pci
> >> should be the default if no one else has set the device's irq (and the
> >> host has a device node of course).
> >>
> >> It also seems to be a bit of random set of pci functions that are
> >> called here. It would be nice to simplify this chunk of code.
> >
> > Yes, and we recently had some attempts at creating a better interface posted
> > on the mailing list, not sure what the latest status on it is. I think we
> > want to end up with a two-stage interface along the lines of:
> >
> >         /* allocate a pci_host_bridge, scan DT, set default operations, map
> >            I/O space if necessary, request all resources ... */
> >         phb = pci_host_bridge_create(parent, ..., sizeof(struct my_pci_private));
> 
> Humm, I wondered what happened to pci_host_bridge_create and thought
> we had abandoned it. It wasn't too clear reading thru the threads. The
> host drivers generally still have to walk thru the resources anyway to
> setup inbound and outbound windows, so we don't gain too much moving
> that out. 
I think the discussion has not ended yet, I'm still in favor of
doing it like that. The current of_pci_get_host_bridge_resources()
function is indeed lacking a bit because it just returns the resources
that are needed for setting up the PCI side, but it doesn't
provide a list of the host side windows that may need to get programmed
into hardware registers on machines without a firmware that has set them
up in advance (i.e. most ARM32 and MIPS32 machines).

We could add another exported function to return those, or we could
find a way to pass those back through the pci_host_bridge pointer
from the common function.

Setting up the PCI side by itself does seem useful to me though, mainly
to prevent host controller drivers from getting it wrong.

> And the error clean-up gets complicated too.

In what way? I would hope that we could come up with a way to make
pci_host_bridge_create() able to roll-back, so it does nothing in
case of an error, and allocate all resources using devm_* so it
all gets undone if probe() fails for another reason.

	Arnd
