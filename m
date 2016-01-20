Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46250 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934158AbcATQCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Jan 2016 11:02:41 -0500
Date: Wed, 20 Jan 2016 16:04:27 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160120160427.GD13437@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I noticed that:

79953dd22c1d ("PCI: rcar: Remove dependency on ARM-specific struct hw_pci")
cbce7900598c ("PCI: designware: Make driver arch-agnostic")

added code in the respective host controller drivers to size bridges
and assign resources only if the PCI_PROBE_ONLY flag is clear, which makes
me wonder if there exists PCI_PROBE_ONLY set-ups for the respective
host controllers:

- On ARM PCI_PROBE_ONLY can be set-up only via the command line or
  by DT (but the host controllers drivers have to check the DT and
  set it - see of_pci_check_probe_only()

  in drivers/pci/host/pci-host-generic.c

  neither designware nor rcar calls that function and I do not see
  any dts file with that property). Given that I can't see a way
  to set up PCI_PROBE_ONLY other than the command line on designware
  or rcar I assume the PCI_PROBE_ONLY set-ups have been tested by
  forcing it through command line parameter

- On ARM64 PCI_PROBE_ONLY can *only* be set via DT, so see above

We want to get rid of PCI_PROBE_ONLY on ARM/ARM64:

https://patchwork.ozlabs.org/patch/545671/

so unless you really have *existing* set-ups that require it, please
remove the respective checks from the host controller drivers, this is
becoming a serious issue, because either:

- we claim resources if and only if PCI_PROBE_ONLY is set

Either like this (to be done for every host controllers and ARM
bios32):

https://patchwork.ozlabs.org/patch/545670/

or in core ARM/ARM64 code - eg pcibios_fixup_bus() - (to avoid adding a
resource claiming call in ALL PCI host controllers)

- or we *always* carry out resource claiming regardless of PCI_PROBE_ONLY
  (but on ARM we can't really do that since PCI FW set-up on most of the
  platforms is not present)

On PCI_PROBE_ONLY systems resources claiming is mandatory if we want
to get rid of arches workarounds:

https://patchwork.ozlabs.org/patch/545671/

Comments very appreciated.

Thanks,
Lorenzo
