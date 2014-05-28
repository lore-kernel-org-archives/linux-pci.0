Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:53569 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbaE1Ovv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 10:51:51 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/5] PCI: tegra: Overhaul regulator usage
Date: Wed, 28 May 2014 16:49:10 +0200
Message-Id: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The current device tree binding for the regulator setup on Tegra PCIe is
not accurate. While it does work for current use-cases, that's likely by
accident rather than design. This series replaces the existing set of
power-supply properties with a new set that accurately describes the
inputs of the IP block (depending on SoC generation).

As a heads-up, this breaks backwards compatibility with prior versions
of the device tree bindings, but I don't see a reason why that should
keep us from fixing this properly. Not many people are currently using
these bindings and those who are are most likely tracking upstream
development closely enough not to be impacted by this.

I've aimed to keep the series bisectible, which has the downside of
interleaving patches to unrelated trees (ARM and PCI). I'm hoping that
perhaps we can find a way to merge this as a whole to keep it possible
to bisect across the series. Although again, I guess it wouldn't be all
that bad if that wasn't the case, given how little PCIe is actually
being used.

This second version of the series has Bjorn's Acked-by for patch 3 from
the RFC. Stephen, it would be great if you can take this through the
Tegra tree so that the bisectability can be preserved. I have a bunch of
other smaller changes for the PCIe driver (mostly cleanups). I don't
think any of them will conflict, but for extra safety Bjorn may want to
pull this as a stable branch into his tree.

Thanks,
Thierry

Thierry Reding (5):
  PCI: tegra: Overhaul regulator usage
  ARM: tegra: Add new PCIe regulator properties
  PCI: tegra: Implement accurate power supply scheme
  PCI: tegra: Remove deprecated power supply properties
  ARM: tegra: Remove legacy PCIe power supply properties

 .../bindings/pci/nvidia,tegra20-pcie.txt           |  30 ++++-
 arch/arm/boot/dts/tegra20-harmony.dts              |   8 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   7 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |   8 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |  12 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |  11 +-
 drivers/pci/host/pci-tegra.c                       | 148 ++++++++++++---------
 7 files changed, 148 insertions(+), 76 deletions(-)

-- 
1.9.2

