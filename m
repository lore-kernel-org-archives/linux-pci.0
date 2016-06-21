Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:34768 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbcFUMek (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jun 2016 08:34:40 -0400
In-Reply-To: <1463726502-14679-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org,
	Gavin Shan <gwshan@linux.vnet.ibm.com>, alistair@popple.id.au
Subject: Re: [v10,01/18] PCI: Add pcibios_setup_bridge()
Message-Id: <3rYn6W4S0bz9sf9@ozlabs.org>
Date: Tue, 21 Jun 2016 22:27:15 +1000 (AEST)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-20-05 at 06:41:25 UTC, Gavin Shan wrote:
> Currently, PowerPC PowerNV platform utilizes ppc_md.pcibios_fixup(),
> which is called for once after PCI probing and resource assignment
> are completed, to allocate platform required resources for PCI devices:
> PE#, IO and MMIO mapping, DMA address translation (TCE) table etc.
> Obviously, it's not hotplug friendly.
> 
> This adds weak function pcibios_setup_bridge(), which is called by
> pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
> to assign above platform required resources to newly plugged PCI devices
> during PCI hotplug in subsequent patches.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Entire series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d366d28cd1325f11d582ec6d4a

cheers
