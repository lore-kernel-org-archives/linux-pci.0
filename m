Return-Path: <SRS0=dJFU=HA=oracle.com=james.puthukattukaran@kernel.org>
Return-Path: <SRS0=dJFU=HA=oracle.com=james.puthukattukaran@kernel.org>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH 2/2] PCI: Workaround ACS hw bug for IDT switch
Message-ID: <2e297847-323a-09b6-f42e-e179a9306b91@oracle.com>
Date: Wed, 11 Apr 2018 12:06:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


This patch implements the hw workaround found in the IDT switch.

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

--

  drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
  1 file changed, 38 insertions(+)

---

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bf423e3..932e0ff 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4738,13 +4738,51 @@ static void quirk_gpu_hda(struct pci_dev *hda)
  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);

+static int pci_idt_acs_quirk(struct pci_bus *bus, int devfn, int enable,
+				bool found)
+{
+	int pos;
+	u16 cap;
+	u16 ctrl;
+	int retval;
+	struct pci_dev *dev = bus->self;
+
+
+	/* Write 0 to the devfn device under the PCIE switch (bus->self)
+	 * as part of forcing the devfn number to latch with the device below
+	 */
+	if (found)
+		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
+
+
+	/* Enable/disable ACS SV feature (based on enable flag) */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+
+	if (!(cap & PCI_ACS_SV))
+		return -ENODEV;

+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	retval = !!(ctrl & cap & PCI_ACS_SV);
+	if (enable)
+		ctrl |= (cap & PCI_ACS_SV);
+	else
+		ctrl &= ~(cap & PCI_ACS_SV);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+	return retval;
+}

  static const struct pci_dev_acs_quirk{
  	u16 vendor;
  	u16 device;
  	int (*acs_quirk)(struct pci_bus *bus, int devfn, int enable, bool found);
  } pci_dev_acs_quirks[] = {
+	{ PCI_VENDOR_ID_IDT, 0x80b5, pci_idt_acs_quirk},
  	{0}
  };
