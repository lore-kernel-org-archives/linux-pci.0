Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Tue, 23 Aug 2016 15:23:31 -0400
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160823192330.GA10866@localhost.localdomain>
References: <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
 <20160823133913.GN18628@localhost>
 <20160823171018.GB10224@localhost.localdomain>
 <eed69a47-633b-0c0c-e5c1-663bf37a9ec3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eed69a47-633b-0c0c-e5c1-663bf37a9ec3@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 01:14:03PM -0400, Sinan Kaya wrote:
> On 8/23/2016 1:10 PM, Keith Busch wrote:
> > It's superficially related to pciehp only because that's the only module
> > that touches Slot Control, and this particular hardware interprets
> > pciehp's control commands differently than the specification.
> > 
> > Since the hardware can't be changed, is there any guidance you can
> > recommend we follow to appropriately fence off pciehp from attention and
> > power indicator control? I initially attempted the least invasive method,
> > but I'm happy to explore other possibilities.
> 
> Most other non-standard HW require an LED driver for hotplug in the kernel. 
> IBM has one. It sound like you need another one.

We'd still need to fence off pciehp from LED control since it manipulates
these in response to hot plug events handled by that driver.
