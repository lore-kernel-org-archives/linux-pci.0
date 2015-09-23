Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50698 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbbIWHwP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 03:52:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2] PCI: generic: Add support for Cavium ThunderX PCIe root complexes.
Date: Wed, 23 Sep 2015 09:51:30 +0200
Message-ID: <1524364.fcqUh1gtkt@wuerfel>
In-Reply-To: <1442967415-13595-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442967415-13595-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 22 September 2015 17:16:55 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The config space for external PCIe root complexes on some Cavium
> ThunderX SoCs is very similar to CAM and ECAM, but differs in the
> shift values that have to be applied to the bus and devfn numbers to
> compose that address window offset.  These root complexes also have
> the interesting property that there is no root bridge, so the standard
> manner of limiting scanning to only the first device doesn't work.  We
> can use the standard pci-host-generic driver if we make a minor
> addition to handle these differences, so we...
> 
> Add a mapping function for ThunderX PCIe root complexes with a bus
> shift of 24 and devfn shift of 16.  Ignore accesses for devices other
> than the first device on the primary bus.
> 
> Document the whole thing in devicetree/bindings/pci/host-generic-pci.txt
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
