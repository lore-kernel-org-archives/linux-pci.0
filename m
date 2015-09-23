Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:65510 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbbIWT22 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 15:28:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: David Daney <ddaney@caviumnetworks.com>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 4/5] PCI: generic: Correct, and avoid overflow, in bus_max calculation.
Date: Wed, 23 Sep 2015 21:27:41 +0200
Message-ID: <3751968.n8LRgots8n@wuerfel>
In-Reply-To: <5602EDC4.3040603@caviumnetworks.com>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com> <20150923180157.GV7356@arm.com> <5602EDC4.3040603@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 23 September 2015 11:21:56 David Daney wrote:
> >>
> >>      /* Limit the bus-range to fit within reg */
> >> -    bus_max = pci->cfg.bus_range->start +
> >> -              (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> >> +    bus_max = (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> >> +    if (bus_max > 255)
> >> +            bus_max = 255;
> >
> > I still don't understand the need for this part. If the cfg space is bigger
> > than bus_max, isn't that simply an invalid resource? Given that the resource
> > could be broken in other ways too, this check feels more like a specific
> > workaround rather than generally useful code.
> 
> Imagine...
> 
>    bus-range [0x80 .. 0xff], this requires a cfg.res that will cover the 
> entire range of 0..0xff.
> 
>    according to the calculations above, (resource_size(&pci->cfg.res) >> 
> pci->cfg.ops.bus_shift) - 1 will have a value of 0xff, so...

Extending the computation to 32 bit seems fine, but I'd rather warn loudly
if the bus range does not fit within the registers.

Also note that the computation is already correct with my interpretation
of the reg property.

	Arnd
