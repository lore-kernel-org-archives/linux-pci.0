Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Rafael Wysocki <rjw@rjwysocki.net>,
	"Busch, Keith" <keith.busch@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 0/2] Fixups for mixed pcie_ports=auto and native
Date: Fri, 8 Apr 2016 17:32:45 +0000
Message-ID: <8D943B239464E04C9184454D8B3F5CFF0ACF55D7@ORSMSX101.amr.corp.intel.com>
References: <1460131280-184287-1-git-send-email-jonathan.derrick@intel.com>
 <20160408162517.GA15034@localhost>
In-Reply-To: <20160408162517.GA15034@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I noticed that too. Thanks for letting me know it's happening. I'll give it another shot on v2

-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
Sent: Friday, April 8, 2016 10:25 AM
To: Derrick, Jonathan <jonathan.derrick@intel.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>; Busch, Keith <keith.busch@intel.com>; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Fixups for mixed pcie_ports=auto and native

On Fri, Apr 08, 2016 at 10:01:18AM -0600, Jon Derrick wrote:
> This set introduces a fixup that lets non-acpi pcie ports subscribe to 
> native port services. The theory is that on an acpi system, native 
> services will require acpi to release control of the port instance.
> 
> Rather than failing on non-acpi devices, we should continue as if they 
> were native to begin with, and try to subscribe to native services 
> just the same.
> 
> Jon Derrick (2):
>   PCI/ACPI: Do not fail ports without ACPI entries
>   PCI/PCIe: Fixups for acpi port setup not being allowed to fail

I don't know what happened, but I don't see the first patch either in patchwork (https://patchwork.ozlabs.org/project/linux-pci/list/), the linux-pci archives, or my own email.

Bjorn
