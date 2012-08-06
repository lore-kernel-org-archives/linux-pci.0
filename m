Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44463 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932519Ab2HFTm0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 15:42:26 -0400
Message-ID: <50201E1D.5060200@wwwdotorg.org>
Date: Mon, 06 Aug 2012 13:42:21 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>,
	Russell King <linux@arm.linux.org.uk>
CC: linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/26/2012 01:55 PM, Thierry Reding wrote:
> This patch series adds support for device tree based probing of the PCIe
> controller found on Tegra SoCs.

Thierry, I just tested all Tegra boards in v3.6-rc1, and noticed that
PCIe doesn't work on TrimSlice when booting use device tree. I think I
found the cause, and I can't see why the same problem doesn't affect
this series. Perhaps you can enlighten me?

When booting TrimSlice (or Harmony) using board files, Tegra's PCIe is
initialized using a subsys_initcall to tegra_pcie_init() directly (or
for Harmony to harmony_pcie_init() which then calls tegra_pcie_init()).

The final thing tegra_pcie_init() does is call pci_common_init(). This
calls pcibios_init_hw() which calls hw->scan() which calls
pci_scan_root_bus() which adds a device object for each device on the
PCIe bus. However, since this happens very early in the boot sequence, I
believe the enumerated PCIe devices don't immediately get probed.
Instead, control gets returned to pci_common_init() which I believe then
calls pci_bus_assign_resources() which actually sets up the resources
for those devices. Later, the PCIe devices actually get probed, and
everything works.

However, when booting using device tree, with the code currently in
v3.6-rc1, tegra_pcie_init() is called late in the boot sequence, and so
in the sequence described above, as soon as pci_scan_root_bus() adds a
device, it gets probed, before the device object's resources have been
set up, which results in the following failure:

PCI: Device 0000:01:00.0 not available because of resource collisions

... because of the following code in pcibios_enable_device():

> 	for (idx = 0; idx < 6; idx++) {
> 		/* Only set up the requested stuff */
> 		if (!(mask & (1 << idx)))
> 			continue;
> 
> 		r = dev->resource + idx;
> 		if (!r->start && r->end) {
> 			printk(KERN_ERR "PCI: Device %s not available because"
> 			       " of resource collisions\n", pci_name(dev));

Doesn't this same problem exist when instantiating the PCIe device
itself from device tree as in your patch series? If not, can you explain
why?

Now, the obvious solution in v3.6 would be to simply have
tegra_pcie_init() be called at the same early stage in the boot process
when booting using device tree as it is when booting using board files.
This works for TrimSlice.

However, on Harmony, it doesn't work, because PCIe on Harmony depends on
regulators, and the regulators are accessed using an I2C bus that is
instantiated from DT, and the instantiation of the I2C bus happens
fairly late in the boot process so can't be found early during the boot
sequence. See harmony_regulator_init() for the failing code.

Does anyone have any good ideas (small, self-contained patches) for
solving this in v3.6 in such a way that PCIe works on both TrimSlice and
Harmony?

Thanks.
