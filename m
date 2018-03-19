Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966729AbeCSSnY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Mar 2018 14:43:24 -0400
Date: Mon, 19 Mar 2018 13:43:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 00/13] PCI: Simplify PCIe port driver
Message-ID: <20180319184322.GB77194@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 09, 2018 at 12:59:49PM -0600, Bjorn Helgaas wrote:
> This is an attempt to move a few things out of the port driver.
> 
> I added these new patches since v1:
> 
>   Merge pcieport_if.h into portdrv.h
>     Merge pcieport_if.h and portdrv.h to reduce clutter
> 
>   Remove unnecessary "pcie_ports=auto" parameter
>     This is the default setting anyway, so specifying the parameter doesn't
>     do anything.
> 
>   Encapsulate pcie_ports_auto inside the port driver
>     "pcie_ports_auto" was declared in linux/pci.h even though nobody
>     outside the port driver used it.
> 
>   Rename and reverse sense of pcie_ports_auto
>     "pcie_ports_auto" is connected with the "pcie_ports=native" parameter,
>     so rename it to match.
> 
> Other changes since v1:
>   - Rebase onto my pci/portdrv branch.
>   - Rename pcie_resume_early() to pcie_pme_root_status_cleanup() as
>     suggested by Rafael.
>   - Add Rafael's Reviewed-by tags.
> 
> v1: https://lkml.kernel.org/r/152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com
> 
> ---
> 
> Bjorn Helgaas (13):
>       PCI/portdrv: Merge pcieport_if.h into portdrv.h
>       PCI/PM: Move pcie_clear_root_pme_status() to core
>       PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver
>       PCI/PM: Clear PCIe PME Status bit for Root Complex Event Collectors
>       PCI/portdrv: Disable port driver in compat mode
>       PCI/portdrv: Remove pcie_port_bus_type link order dependency
>       PCI/portdrv: Remove unused PCIE_PORT_SERVICE_VC
>       PCI/portdrv: Simplify PCIe feature permission checking
>       PCI/portdrv: Remove unnecessary include of <linux/pci-aspm.h>
>       PCI/portdrv: Remove "pcie_hp=nomsi" kernel parameter
>       PCI/portdrv: Remove unnecessary "pcie_ports=auto" parameter
>       PCI/portdrv: Encapsulate pcie_ports_auto inside the port driver
>       PCI/portdrv: Rename and reverse sense of pcie_ports_auto

I applied these with Christoph's acks and Lukas' renaming suggestion to
pci/portdrv for v4.17.
