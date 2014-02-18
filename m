Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51224 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaBRSZ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 13:25:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Liviu Dudau <liviu@dudau.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 18 Feb 2014 19:25:35 +0100
Message-ID: <1663692.UxtD9eTEBL@wuerfel>
In-Reply-To: <20140218174125.GC29304@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <2312919.pM61KLBcYY@wuerfel> <20140218174125.GC29304@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 10:41:25 Jason Gunthorpe wrote:
> On Sat, Feb 15, 2014 at 02:03:26PM +0100, Arnd Bergmann wrote:
> 
> > Can anyone with more experience on the subject than me (Bjorn,
> > Russell, Jason, ...) think of a reason why we would not want to
> > just use a new domain for every host bridge we find?
> 
> I personaly think we can safely move away from stuffing multiple host
> bridges into a single domain for DT cases. The reasons for doing this
> have long since been superseded.

Ok, that would definitely be the simplest answer. :)

> As far as I know the host bridge stuffing is something that was
> created before domains to solve the problem on embedded of multiple
> PCI host bridges on a SOC/System Controller. I know I have used it
> that way in the distant past (for MIPS).

Apple have also used the same trick on their G5 Macs, presumably
to simplify things for OS9 and OS-X, but even at the time making
it harder for Linux.
 
> However today PCI-SIG has a standard way to describe multi-port
> root-complexes in config space, so we should not need to use the
> multi-bus hack. SOCs with non-compliant HW that *really* need single
> domain can get there: mvebu shows how to write a driver that provides
> a software version of the missing hardware elements. Pushing mess like
> this out of the core code seems like a good strategy.

Ok.

> The only reason I can think of to avoid using a domain is if Linux has
> to interface with external firmware that uses bus:device.function
> notation for coding information. (eg Intel-MP tables on x86 encode
> interrupt routing use B:D.F) In this case Linux would need a way to
> map between Linux B:D.F and the Firwmare B:D.F, or it would need to
> use the Firmware B:D.F layout. But this argument does not apply to DT
> systems as DT encodes the domain too. Presumably ACPI will be the
> same.

ACPI definitely has a concept of domains, as I noticed when looking
at the x86 ACPI PCI probing code.

> So the Liviu, I would say the API should be similar to what we see in
> other OF enabled driver bases subsystems, call the core code with a
> platform_device pointer and function_ops pointer and have the core
> code create a domain, figure out the domain # from the DT (via
> aliases?), and so on.

Do we even need stable domain numbers? If we do, aliases sound fine.
A more complex method would be to sort them by MMIO window address
or perhaps by phandle.

	Arnd
