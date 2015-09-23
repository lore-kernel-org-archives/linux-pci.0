Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 Sep 2015 18:59:40 +0100
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 2/5] PCI: generic: Only fixup irqs for bus we are
 creating.
Message-ID: <20150923175940.GU7356@arm.com>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
 <1442527332-1174-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442527332-1174-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 17, 2015 at 11:02:09PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> If we create multiple buses with pci-host-generic, or there are buses
> created by other drivers, we don't want to call pci_fixup_irqs() which
> operates on all devices, not just the devices on the bus being added.
> The consequence is that either the fixups are done more than once, or
> in some cases incorrect fixups could be applied.
> 
> Call pci_bus_fixup_irqs() instead of pci_fixup_irqs().
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> Changes from v1: Moved most of the code to pci_bus_fixup_irqs(),
> making this patch very simple.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
