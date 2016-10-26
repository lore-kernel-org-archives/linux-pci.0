Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 26 Oct 2016 11:44:40 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mvebu: Take control of mbus windows setup by the
 firmware
Message-ID: <20161026174440.GA24717@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The firmware may setup the mbus to access PCI-E and indicate this
has happened with a ranges mapping for the PCI-E ID. If this happens
then the mbus setup and the pci dynamic setup conflict, creating
problems.

Have PCI-E assume control of the firmware specified default mapping by
setting the value of the bridge window to match the firmware mapping.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/bus/mvebu-mbus.c     | 36 ++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pci-mvebu.c | 22 ++++++++++++++++++++++
 include/linux/mbus.h         |  3 +++
 3 files changed, 61 insertions(+)

In the DT this could look like:

	mbus {
		ranges = <MBUS_ID(0x04, 0xe8) 0 0xe0000000 0x8000000 /* PEX 0 MEM */
		pex@e0000000 {
			compatible = "marvell,kirkwood-pcie";
			ranges = <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000 /* Controller regs */
				  0x82000000 1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
				  >;
			pcie@1,0 {
				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0>;
				reg = <0x0800 0 0  0 0>; // 0000:00:01.0

				device@0 {
					reg = <0x0 0 0	0 0>; // 0000:01:00.0
					ranges = <0x00000000  0x82000000 0x00000000 0x00000000	0x8000000>;

Which is basically the OF way to describe PCI devices downstream of
the interface and give information about what their BARs should be.

This is useful if there is even more DT stuff below the explicitly
declared device as it allows standard DT address translation to work
properly.

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index c7f396903184..ce0ac5049c1f 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -922,6 +922,42 @@ int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
 						 size, MVEBU_MBUS_NO_REMAP);
 }
 
+/**
+ * mvebu_mbus_get_single_window_by_id() - return the location of the window if
+ * the target/attribute has a single enabled mapping.
+ *
+ * RETURNS:
+ *	-ENODEV if no mapping and -E2BIG if there is more than one mapping
+ */
+int mvebu_mbus_get_single_window_by_id(unsigned int target,
+				       unsigned int attribute,
+				       phys_addr_t *base, phys_addr_t *size)
+{
+	unsigned int win;
+	unsigned int count = 0;
+
+	for (win = 0; win < mbus_state.soc->num_wins; win++) {
+		u64 wbase;
+		u32 wsize;
+		u8 wtarget, wattr;
+		int enabled;
+
+		mvebu_mbus_read_window(&mbus_state, win, &enabled, &wbase,
+				       &wsize, &wtarget, &wattr, NULL);
+		if (enabled && wtarget == target && wattr == attribute) {
+			*base = wbase;
+			*size = wsize;
+			count++;
+		}
+	}
+
+	if (count == 1)
+		return 0;
+	if (count == 0)
+		return -ENODEV;
+	return -E2BIG;
+}
+
 int mvebu_mbus_del_window(phys_addr_t base, size_t size)
 {
 	int win;
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 307f81d6b479..5d5a2687b73e 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -464,6 +464,8 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
 {
 	struct mvebu_sw_pci_bridge *bridge = &port->bridge;
+	int rc;
+	phys_addr_t base, size;
 
 	memset(bridge, 0, sizeof(struct mvebu_sw_pci_bridge));
 
@@ -480,6 +482,26 @@ static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
 
 	/* Add capabilities */
 	bridge->status = PCI_STATUS_CAP_LIST;
+
+	/*
+	 * If the firmware has already setup a window for PCIe then assume
+	 * control of it by defaulting the BAR to the window setting.
+	 */
+	rc = mvebu_mbus_get_single_window_by_id(port->mem_target,
+						port->mem_attr, &base, &size);
+	if (rc == -E2BIG)
+		pr_err(FW_BUG "%s: Too many pre-existing mbus mappings\n",
+		       port->dn->name);
+	if (!rc) {
+		if ((base & 0xFFFFF) != 0 || ((size + base) & 0xFFFFF) != 0)
+			pr_err(FW_BUG "%s: Invalid pre-existing mbus mapping\n",
+			       port->dn->name);
+		port->memwin_base = base;
+		port->memwin_size = size;
+		port->bridge.membase = (base >> 16) & 0xFFF0;
+		port->bridge.memlimit = ((size - 1 + base) >> 16) & 0xFFF0;
+		port->bridge.command |= PCI_COMMAND_MEMORY;
+	}
 }
 
 /*
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index d610232762e3..dfafc27b41b5 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -83,5 +83,8 @@ int mvebu_mbus_init(const char *soc, phys_addr_t mbus_phys_base,
 		    size_t mbus_size, phys_addr_t sdram_phys_base,
 		    size_t sdram_size);
 int mvebu_mbus_dt_init(bool is_coherent);
+int mvebu_mbus_get_single_window_by_id(unsigned int target,
+				       unsigned int attribute,
+				       phys_addr_t *base, phys_addr_t *size);
 
 #endif /* __LINUX_MBUS_H */
-- 
2.1.4
