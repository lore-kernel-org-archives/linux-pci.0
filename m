Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <59C02719.5050103@oracle.com>
Date: Mon, 18 Sep 2017 16:05:45 -0400
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        okaya@codeaurora.org
Subject: [PATCH v7] PCI: Workaround wrong flags completions for IDT switch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Subject: [PATCH v7] PCI: Workaround wrong flags completions for IDT switch
From: James Puthukattukaran <james.puthukattukaran@oracle.com>

The IDT switch incorrectly flags an ACS source violation on a read config
request to an end point device on the completion (IDT 89H32H8G3-YC,
errata #36) even though the PCI Express spec states that completions are
never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1). 
Here's
the specific copy of the errata text

"Item #36 - Downstream port applies ACS Source Validation to Completions
Section 6.12.1.1 of the PCI Express Base Specification 3.1 states
that completions are never affected
by ACS Source Validation. However, completions received by a
downstream port of the PCIe switch from a device that has not yet
captured a PCIe bus number are incorrectly dropped by ACS source
validation by the switch downstream port.

Workaround: Issue a CfgWr1 to the downstream device before issuing
the first CfgRd1 to the device.
This allows the downstream device to capture its bus number; ACS
source validation no longer stops
completions from being forwarded by the downstream port. It has been
observed that Microsoft Windows implements this workaround already;
however, some versions of Linux and other operating systems may not. "

The suggested workaround by IDT is to issue a configuration write to the
downstream device before issuing the first config read. This allows the
downstream device to capture its bus number, thus avoiding the ACS
violation on the completion. In order to make sure that the device is ready
for config accesses, we do what is currently done in making config reads
till it succeeds and then do the config write as specified by the errata.
However, to avoid hitting the errata issue when doing config reads, we
disable ACS SV around this process.

The patch does the following -

1. Disable ACS source violation if enabled.
2. Wait for config space access to become available by reading vendor id
3. Do a config write to the end point (errata workaround)
4. Enable ACS source validation (if it was enabled to begin with)

Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>

--

-v2: move workaround to pci_bus_read_dev_vendor_id() from 
pci_bus_check_dev()
      and move enable_acs_sv to drivers/pci/pci.c -- by Yinghai
-v3: add bus->self check for root bus and virtual bus for sriov vfs.
-v4: only do workaround for IDT switches
-v5: tweak pci_std_enable_acs_sv to deal with unimplemented SV
-v6: Added errata verbiage verbatim and resolved patch format issues
-v7: changed int to bool for found and idt_workaround declarations. Also
      added bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=196979


  drivers/pci/pci.c   | 40 ++++++++++++++++++++++++++++++++++++++++
  drivers/pci/pci.h   |  1 +
  drivers/pci/probe.c | 42 ++++++++++++++++++++++++++++++++++++++++--
  3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6078dfc..4bca302 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2857,6 +2857,46 @@ static bool pci_acs_flags_enabled(struct pci_dev 
*pdev, u
16 acs_flags)
  }

  /**
+ *  pci_std_enable_acs_sv - enable/disable ACS source validation if 
supported
+ *  by the switch
+ *  @dev - pcie switch/RP
+ *  @enable - enable (1) or disable (0) source validation
+ *
+ *  Returns : < 0 on failure (if SV capability is not implemented)
+ * 	    previous acs_sv state (0 or 1)
+ */
+int pci_std_enable_acs_sv(struct pci_dev *dev, bool enable)
+{
+	int pos;
+	u16 cap;
+	u16 ctrl;
+	int retval;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+
+	if (!(cap & PCI_ACS_SV))
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	retval = !!(ctrl & cap & PCI_ACS_SV);
+	if (enable)
+		ctrl |= (cap & PCI_ACS_SV);
+	else
+		ctrl &= ~(cap & PCI_ACS_SV);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+
+	return retval;
+}
+
+
+
+/**
   * pci_acs_enabled - test ACS against required flags for a given device
   * @pdev: device to test
   * @acs_flags: required PCI ACS flags
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a6560c9..9d9a365 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -339,6 +339,7 @@ static inline resource_size_t 
pci_resource_alignment(struct
pci_dev *dev,
  }

  void pci_enable_acs(struct pci_dev *dev);
+int pci_std_enable_acs_sv(struct pci_dev *dev, bool enable);

  #ifdef CONFIG_PCIE_PTM
  void pci_ptm_init(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ff94b69..0aa6e02 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1945,8 +1945,8 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, 
int devf
n, u32 *l,
  	return true;
  }

-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int timeout)
+static bool __pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn,
+					u32 *l, int timeout)
  {
  	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
  		return false;
@@ -1961,6 +1961,44 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus 
*bus, int
devfn, u32 *l,

  	return true;
  }
+
+
+bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+                               int crs_timeout)
+{
+	bool found;
+	int enable = -1;
+	bool idt_workaround = (bus->self && (bus->self->vendor == PCI_VENDOR_ID_
IDT));
+	/*
+	 * Some IDT switches flag an ACS violation for config reads
+	 * even though the PCI spec allows for it (PCIe 3.1, 6.1.12.1)
+	 * It flags it because the bus number is not properly set in the
+	 * completion. The workaround is to do a dummy write to properly
+	 * latch number once the device is ready for config operations
+	 */
+
+	if (idt_workaround)
+		enable = pci_std_enable_acs_sv(bus->self, false);
+
+	found = __pci_bus_read_dev_vendor_id(bus, devfn, l, crs_timeout);
+
+	/*
+	 * The fact that we can read the vendor id indicates that the device
+	 * is ready for config operations. Do the write as part of the errata
+	 * workaround.
+	 */
+	if (idt_workaround) {
+		if (found)
+			pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
+		if (enable > 0)
+			pci_std_enable_acs_sv(bus->self, enable);
+	}
+
+	return found;
+}
+
+
+
  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);

  /*
