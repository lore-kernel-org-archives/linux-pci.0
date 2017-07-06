Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44858 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbdGFQHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2017 12:07:33 -0400
Message-ID: <595E610A.5000900@oracle.com>
Date: Thu, 06 Jul 2017 12:10:50 -0400
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v5] PCI: Workaround wrong flags completions for IDT switch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: James Puthukattukaran <james.puthukattukaran@oracle.com>

The IDT switch incorrectly flags an ACS source violation on a read config
request to an end point device on the completion (IDT 89H32H8G3-YC,
errata #36) even though the PCI Express spec states that completions are
never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1).

The suggested workaround by IDT is to issue a configuration write to the
downstream device before issuing the first config read. This allows the
downstream device to capture its bus number, thus avoiding the ACS
violation on the completion.

The patch does the following -

1. Disable ACS source violation if enabled
2. Wait for config space access to become available by reading vendor id
3. Do a config write to the end point (errata workaround)
4. Enable ACS source validation (if it was enabled to begin with)

-v2: move workaround to pci_bus_read_dev_vendor_id() from 
pci_bus_check_dev()
      and move enable_acs_sv to drivers/pci/pci.c -- by Yinghai
-v3: add bus->self check for root bus and virtual bus for sriov vfs.
-v4: only do workaround for IDT switches
-v5: tweak pci_std_enable_acs_sv to deal with unimplemented SV and 
clarify return value

Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>

--


  drivers/pci/pci.c   | 37 +++++++++++++++++++++++++++++++++++++
  drivers/pci/pci.h   |  1 +
  drivers/pci/probe.c | 38 ++++++++++++++++++++++++++++++++++++--
  3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 563901c..4645bfd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2835,6 +2835,43 @@ static bool pci_acs_flags_enabled(struct pci_dev 
*pdev, u
16 acs_flags)
  }

  /**
+ *  pci_std_enable_acs_sv - enable/disable ACS source validation if 
supported b
y the switch
+ *  @dev - pcie switch/RP
+ *  @enable - enable (1) or disable (0) source validation
+ *
+ *  Returns : < 0 on failure (if SV capability is not implemented)
+ *           previous acs_sv state (0 or 1)
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
++/**
   * pci_acs_enabled - test ACS against required flags for a given device
   * @pdev: device to test
   * @acs_flags: required PCI ACS flags
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f8113e5..3960c2a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -343,6 +343,7 @@ static inline resource_size_t 
pci_resource_alignment(struct
pci_dev *dev,
  }

  void pci_enable_acs(struct pci_dev *dev);
+int pci_std_enable_acs_sv(struct pci_dev *dev, bool enable);

  #ifdef CONFIG_PCIE_PTM
  void pci_ptm_init(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..c154a90 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1763,8 +1763,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
  }
  EXPORT_SYMBOL(pci_alloc_dev);

-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int crs_timeout)
+static bool __pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn,
+					 u32 *l, int crs_timeout)
  {
  	int delay = 1;

@@ -1801,6 +1801,40 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus 
*bus, int
devfn, u32 *l,

  	return true;
  }
+
+bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+				int crs_timeout)
+{
+	int found;
+	int enable = -1;
+	int idt_workaround = (bus->self && (bus->self->vendor == PCI_VENDOR_ID_I
DT));
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
  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
