Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58782 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933554AbbJHPKm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 11:10:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 3/5] PCI: generic: Quit clobbering our pci_ops.
Date: Thu, 08 Oct 2015 17:09:56 +0200
Message-ID: <5128429.u9O5dh5qKB@wuerfel>
In-Reply-To: <20151008150215.GB3885@localhost>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com> <1443811443-18878-4-git-send-email-ddaney.cavm@gmail.com> <20151008150215.GB3885@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 October 2015 10:02:16 Bjorn Helgaas wrote:
> [+cc Arnd]
> 
> Arnd, you had comments on the previous version.  What do you think of
> this one?

Looks good to me

> On Fri, Oct 02, 2015 at 11:44:01AM -0700, David Daney wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > The pci-host-generic driver keeps a global struct pci_ops which it
> > then patches with the .map_bus method appropriate for the bus device.
> > A problem arises when the driver is used for two different types of
> > bus devices, the .map_bus method for the last device probed clobbers
> > the method for all previous devices.  The result, only the last bus
> > device probed has the proper .map_bus, and the others fail.
> > 
> > Move the struct pci_ops into the bus specific structure, and
> > initialize a pointer to it when the bus device is probed.
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: David Daney <david.daney@cavium.com>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
