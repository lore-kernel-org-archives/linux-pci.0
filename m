Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 1/2] PCI: pci-host-generic: add support for Synopsys DesignWare RC in ECAM mode
Date: Fri,  6 Oct 2017 17:39:18 +0100
Message-Id: <20171006163919.14898-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
References: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some implementations of the Synopsys DesignWare PCIe controller implement
a so-called ECAM shift mode, which allows a static memory window to be
configured that covers the configuration space of the entire bus range.

Usually, when the firmware performs all the low level configuration that
is required to expose this controller in a fully ECAM compatible manner,
we can simply describe it as "pci-host-ecam-generic" and be done with it.
However, in some cases (e.g., the Marvell Armada 80x0 as well as the
Socionext SynQuacer Soc), the IP was synthesized with an ATU window
granularity that does not allow the first bus to be mapped in a way that
prevents the device on the downstream port from appearing more than once,
and so we still need special handling in software to drive this static
almost-ECAM configuration.

So extend the pci-host-generic driver so it can support these controllers
as well, by adding special config space accessors that take the above
quirk into account.

Note that, unlike most drivers for this IP, this driver does not expose
a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
given that this is not a true bridge, and does not require any windows
to be configured in order for the downstream device to operate correctly.
Omitting it also prevents the PCI resource allocation routines from
handing out BAR space to it unnecessarily.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/host/pci-host-generic.c | 46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 7d709a7e0aa8..01e81a30e303 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -35,6 +35,43 @@ static struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
 	}
 };
 
+static int pci_dw_ecam_config_read(struct pci_bus *bus, u32 devfn, int where,
+				   int size, u32 *val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+
+	/*
+	 * The Synopsys DesignWare PCIe controller in ECAM mode will not filter
+	 * type 0 config TLPs sent to devices 1 and up on its downstream port,
+	 * resulting in devices appearing multiple times on bus 0 unless we
+	 * filter out those accesses here.
+	 */
+	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
+
+static int pci_dw_ecam_config_write(struct pci_bus *bus, u32 devfn, int where,
+				    int size, u32 val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+
+	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return pci_generic_config_write(bus, devfn, where, size, val);
+}
+
+static struct pci_ecam_ops pci_dw_ecam_bus_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_dw_ecam_config_read,
+		.write		= pci_dw_ecam_config_write,
+	}
+};
+
 static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-cam-generic",
 	  .data = &gen_pci_cfg_cam_bus_ops },
@@ -42,6 +79,15 @@ static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-ecam-generic",
 	  .data = &pci_generic_ecam_ops },
 
+	{ .compatible = "marvell,armada8k-pcie-ecam",
+	  .data = &pci_dw_ecam_bus_ops },
+
+	{ .compatible = "socionext,synquacer-pcie-ecam",
+	  .data = &pci_dw_ecam_bus_ops },
+
+	{ .compatible = "snps,dw-pcie-ecam",
+	  .data = &pci_dw_ecam_bus_ops },
+
 	{ },
 };
 
-- 
2.11.0
