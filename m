Return-Path: <SRS0=dJFU=HA=oracle.com=james.puthukattukaran@kernel.org>
Return-Path: <SRS0=dJFU=HA=oracle.com=james.puthukattukaran@kernel.org>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH 1/2] PCI: Workaround hardware bugs in ACS functionality by
 implementing it as a quirk
Message-ID: <e6a55432-8c56-9c99-ce99-4ae80a0ed3ba@oracle.com>
Date: Wed, 11 Apr 2018 11:58:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


There are bugs in ACS implementations by certain switch vendors that 
cause ACS violations in perfectly normal accesses. This patch provides 
the framework for enabling and disabling the functionality at certain 
points during endpoint bringup in the form of a quirk.

Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>

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
-v9: changed function name from pci_dev_specific_fixup_acs_quirk to
      pci_bus_acs_quirk. Also, tested for FLR and hot reset scenarios 
and did
      not see issues where workaround was required. The issue seems to be
      related only to cold reset/power on situation.
-v10: Moved the contents of pci_bus_read_vendor_id into an internal function
       __pci_bus_read_vendor_id
-v11: Split the patch into two patches. The first a general quirk framework.

---

  drivers/pci/pci.h    |  7 +++++++
  drivers/pci/probe.c  | 33 ++++++++++++++++++++++++++++-----
  drivers/pci/quirks.c | 41 +++++++++++++++++++++++++++++++++++++++++
  3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 023f7cf..a9e2a8c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -387,11 +387,18 @@ struct pci_dev_reset_methods {

  #ifdef CONFIG_PCI_QUIRKS
  int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+int pci_bus_specific_acs_quirk(struct pci_bus *bus , int devfn,
+					int enable, bool found);
  #else
  static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
  {
  	return -ENOTTY;
  }
+static inline int pci_bus_specific_acs_quirk(struct pc_bus *bus,
+					int devfn, int enable, bool found)
+{
+	return -ENOTTY;
+}
  #endif

  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6f..0c93b3e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2097,21 +2097,44 @@ static bool pci_bus_wait_crs(struct pci_bus 
*bus, int devfn, u32 *l,
  	return true;
  }

-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+static bool __pci_bus_read_dev_vendor_id(struct pci_bus *bus, int 
devfn, u32 *l,
  				int timeout)
  {
+
+	int found = false;
+
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
+	return found;
+
+}
+
+
+bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+				int timeout)
+{
+	bool ret;
+	int enable = -1;
+
+	enable = pci_bus_specific_acs_quirk(bus, devfn, false, false);
+
+	ret = __pci_bus_read_dev_vendor_id(bus, devfn, l, timeout);
+
+	if (enable > 0)
+		pci_bus_specific_acs_quirk(bus, devfn, enable, ret);
+
+	return ret;
  }
  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 26141b1..bf423e3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4737,3 +4737,44 @@ static void quirk_gpu_hda(struct pci_dev *hda)
  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
+
+
+
+static const struct pci_dev_acs_quirk{
+	u16 vendor;
+	u16 device;
+	int (*acs_quirk)(struct pci_bus *bus, int devfn, int enable, bool found);
+} pci_dev_acs_quirks[] = {
+	{0}
+};
+
+int pci_bus_specific_acs_quirk(struct pci_bus *bus, int devfn, int enable,
+				bool found)
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
+	  * Allow devices that have HW bugs in the ACS implementations to
+	  * control enabling or disabling that ACS feature here.
+	  */
+	for (i = pci_dev_acs_quirks; i->acs_quirk; i++) {
+	if ((i->vendor == dev->vendor ||
+		i->vendor == (u16)PCI_ANY_ID) &&
+		(i->device == dev->device ||
+		 i->device == (u16)PCI_ANY_ID)) {
+			ret = i->acs_quirk(bus, devfn, enable, found);
+			if (ret >= 0)
+				return ret;
+		}
+	}
+
+	return -ENOTTY;
+}
+
