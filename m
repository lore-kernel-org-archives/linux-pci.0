Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 8 Apr 2016 11:25:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
	Keith Busch <keith.busch@intel.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Fixups for mixed pcie_ports=auto and native
Message-ID: <20160408162517.GA15034@localhost>
References: <1460131280-184287-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460131280-184287-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 08, 2016 at 10:01:18AM -0600, Jon Derrick wrote:
> This set introduces a fixup that lets non-acpi pcie ports subscribe to
> native port services. The theory is that on an acpi system, native
> services will require acpi to release control of the port instance.
> 
> Rather than failing on non-acpi devices, we should continue as if they
> were native to begin with, and try to subscribe to native services just
> the same.
> 
> Jon Derrick (2):
>   PCI/ACPI: Do not fail ports without ACPI entries
>   PCI/PCIe: Fixups for acpi port setup not being allowed to fail

I don't know what happened, but I don't see the first patch either in
patchwork (https://patchwork.ozlabs.org/project/linux-pci/list/), the
linux-pci archives, or my own email.

Bjorn
