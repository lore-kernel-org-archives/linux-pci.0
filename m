Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbaBSJ6d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 04:58:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <liviu@dudau.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Wed, 19 Feb 2014 10:58:18 +0100
Message-ID: <2200534.anptP81x7X@wuerfel>
In-Reply-To: <20140219002814.GD8786@google.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <2312919.pM61KLBcYY@wuerfel> <20140219002814.GD8786@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 17:28:14 Bjorn Helgaas wrote:
> On Sat, Feb 15, 2014 at 02:03:26PM +0100, Arnd Bergmann wrote:
> > On Friday 14 February 2014 22:00:47 Liviu Dudau wrote:
> > 
> > Can anyone with more experience on the subject than me (Bjorn,
> > Russell, Jason, ...) think of a reason why we would not want to
> > just use a new domain for every host bridge we find?
> 
> With ACPI on x86 and ia64, we currently use _SEG directly as the Linux
> PCI domain.  Are you proposing that we make the Linux PCI domain
> independent of _SEG?

I don't think we should change anything for ACPI.
The point is that we don't currently have the equivalent of _SEG
for DT probing. The best two options we have are:

a) introduce a 'pci-segment' property with the same meaning as _SEG
on ACPI, and use that as the domain number

b) don't introduce the segment concept on DT but just give each
host bridge its own domain.

The second one seems a little easier to implement, and I don't
see what _SEG is used for other than to avoid having domains
when you don't need them. Is there more to it that I'm missing?

> It will look sort of funny to have things like this:
> 
>   ACPI: PCI Root Bridge [L000] (_SEG 0 domain 0000 [bus 00-1b])
>   ACPI: PCI Root Bridge [L001] (_SEG 0 domain 0001 [bus 1c-37])
>   ACPI: PCI Root Bridge [L002] (_SEG 0 domain 0002 [bus 38-53])
> 
> where the firmware had _SEG==0 for all the bridges and assigned
> non-overlapping bus number ranges, but since nothing in PCI really
> depends on the domain, I guess it should work.

I would expect that with DT, this would look like

Root bridge 0: domain 0 [bus 0-1b]
Root bridge 1: domain 1 [bus 0-1b]
Root bridge 2: domain 2 [bus 0-1b]

Since you wouldn't have a reason to use a bus range starting at
a nonzero number.

	Arnd
