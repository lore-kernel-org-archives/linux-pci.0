Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49370 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933009AbcBAPXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Feb 2016 10:23:15 -0500
Date: Mon, 1 Feb 2016 15:25:07 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160201152507.GA30869@red-moon>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org>
 <20160129230645.GG12965@localhost>
 <56AC0065.5030909@codeaurora.org>
 <20160130133027.GA16394@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160130133027.GA16394@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 30, 2016 at 07:30:27AM -0600, Bjorn Helgaas wrote:

[...]

> > Most non-UEFI firmwares I have seen on ARM rely on device specific
> > driver like synopsys etc. to do the device initialization and ask
> > kernel to do the enumeration.
> > 
> > ACPI systems on the other hand handle the resource assignment before
> > the OS starts.
> 
> My guess is that this is more of a tradition than anything actually
> required by the spec.

I share your opinion, and that tradition on ARM64 should be built
on top of existing DT based systems where the bootloader assigns
*NOTHING* in 90% of designs.

That's why I want to see resource claiming carried out by default
on ACPI on ARM64, this would foster the tradition :), hopefully.

> The bottom line is that Linux can't rely on much consistency across
> the universe of architectures and firmwares.  I think the only thing
> that really makes sense for us to do is:
> 
>   - Read whatever assignments the firmware may have made
>   - Keep them unchanged if they seem sensible

Here I take "sensible" as "it can be successfully claimed" - ie the resource
is allocated in a valid way, though it may not be optimal (eg bridge window
apertures).

>   - Reassign them if they aren't sensible

And we reassign whatever can't be successfully claimed.

Yes, it seems like the best approach and likely the only viable one.

Thanks,
Lorenzo
