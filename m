Return-Path: <SRS0=T00u=F4=oracle.com=james.puthukattukaran@kernel.org>
Return-Path: <SRS0=T00u=F4=oracle.com=james.puthukattukaran@kernel.org>
Subject: [PATCH v8] PCI: Workaround wrong flags completions for IDT switch
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <59C02719.5050103@oracle.com>
 <9741d204-1dd6-2cc2-c133-2ef49c8a404b@codeaurora.org>
 <59CAB001.10207@oracle.com>
 <7084085b-89e7-80fa-d10b-06f121eb57be@codeaurora.org>
 <20171011192704.GN25517@bhelgaas-glaptop.roam.corp.google.com>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Message-ID: <ce8e9a3e-474d-961c-eb0a-c021077f2dca@oracle.com>
Date: Tue, 6 Mar 2018 14:15:38 -0500
MIME-Version: 1.0
In-Reply-To: <20171011192704.GN25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

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
-v8: Rewrote the patch by adding a new acs quirk to keep the workaround
      out of the main code path
---

  drivers/pci/pci.h    |  7 ++++
  drivers/pci/probe.c  | 16 ++++++---
  drivers/pci/quirks.c | 95 
++++++++++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd8191..f12cb58 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -376,11 +376,18 @@ struct pci_dev_reset_methods {

  #ifdef CONFIG_PCI_QUIRKS
  int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+int pci_dev_specific_fixup_acs_quirk(struct pci_bus *bus , int devfn,
+                               int enable, bool found);
  #else
  static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
  {
  	return -ENOTTY;
  }
+static inline int pci_dev_specific_fixup_acs_quirk(struct pc_bus *bus,
+                                       int devfn, int enable, bool found)
+{
+       return -ENOTTY;
+}
  #endif

  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef53774..9497d33 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2041,18 +2041,26 @@ static bool pci_bus_wait_crs(struct pci_bus 
*bus, int de
vfn, u32 *l,
  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
  				int timeout)
  {
+	bool found = false;
+	int enable = -1;
+
+	enable = pci_dev_specific_fixup_acs_quirk(bus, devfn, false, found);
  	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
-		return false;
+		goto out;

  	/* Some broken boards return 0 or ~0 if a slot is empty: */
  	if (*l == 0xffffffff || *l == 0x00000000 ||
  	    *l == 0x0000ffff || *l == 0xffff0000)
-		return false;
+		goto out;

+	found = true;
  	if (pci_bus_crs_vendor_id(*l))
-		return pci_bus_wait_crs(bus, devfn, l, timeout);
+		found = pci_bus_wait_crs(bus, devfn, l, timeout);

-	return true;
+out:
+	if (enable > 0)
+		pci_dev_specific_fixup_acs_quirk(bus, devfn, enable, found);
+	return found;
  }
  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8b14bd3..7222853 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4839,3 +4839,98 @@ static void quirk_fsl_no_msi(struct pci_dev *pdev)
  		pdev->no_msi = 1;
  }
  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, 
quirk_fsl_no_msi);
+
+
+
+/*
+ * Some IDT switches flag an ACS violation for config reads even though 
the
+ * PCI spec allows for it (PCIe 3.1, 6.1.12.1). It flags it because the 
bus
+ * number is not properly set in the completion. The workaround is to do a
+ * dummy write to properly latch number once the device is ready for 
config
+ * operations.
+ *
+ * So, the caller would disable ACS source validation, wait for the device
+ * hanging off this switch to be ready for config operations, and then
+ * call this routine again to enable it (if it was eabled to begin with)
+ */
+static int pci_idt_acs_quirk(struct pci_bus *bus, int devfn, int enable,
+                               bool found)
+{
+	int pos;
+	u16 cap;
+	u16 ctrl;
+	int retval;
+	struct pci_dev *dev = bus->self;
+
+
+	/* Write 0 to the devfn device under the PCIE switch (bus->self)
+ 	* as part of forcing the devfn number to latch with the device below
+ 	*/
+	if (found)
+        	pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
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
+	return retval;
+}
+
+static const struct pci_dev_acs_quirk{
+        u16 vendor;
+        u16 device;
+        int (*fixup_acs)(struct pci_bus *bus, int devfn, int enable, 
bool found
);
+} pci_dev_acs_quirks[] = {
+        { PCI_VENDOR_ID_IDT, 0x80b5, pci_idt_acs_quirk},
+        {0}
+};
+
+int pci_dev_specific_fixup_acs_quirk(struct pci_bus *bus, int devfn, 
int enable
,
+                                       bool found)
+{
+	const struct pci_dev_acs_quirk *i;
+	struct pci_dev *dev;
+	int ret;
+
+	if (!bus || !bus->self)
+		return -ENOTTY;
+
+	dev = bus->self;
+
+	 /*
+	  * Allow devices that do not expose standard PCIe ACS capabilities
+	  * or control to indicate their support here.  Multi-function express
+	  * devices which do not allow internal peer-to-peer between functions,
+	  * but do not implement PCIe ACS may wish to return true here.
+	  */
+	 for (i = pci_dev_acs_quirks; i->fixup_acs; i++) {
+		if ((i->vendor == dev->vendor ||
+		      i->vendor == (u16)PCI_ANY_ID) &&
+		     (i->device == dev->device ||
+		      i->device == (u16)PCI_ANY_ID)) {
+			 ret = i->fixup_acs(bus, devfn, enable, found);
+			 if (ret >= 0)
+				 return ret;
+		}
+	}
+
+	return -ENOTTY;
+}
+
+


On 10/11/2017 03:27 PM, Bjorn Helgaas wrote:
> On Tue, Sep 26, 2017 at 04:03:13PM -0400, Sinan Kaya wrote:
>> On 9/26/2017 3:52 PM, James Puthukattukaran wrote:
>>>> I think you want to do the part above as part of a quirk that runs before
>>>> the probe.
>>>
>>> I don't think there's a way to run this early enough?
>>
>> Bjorn?
>>
>> I have seen multiple quirk types in quirks.c some prefixed with EARLY and
>> other LATE.
> 
> I'm hoping an early quirk on the switch would be early enough, since
> the workaround needs to be done for devices downstream from the
> switch.
> 
> Bjorn
> 
