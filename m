Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932828AbeGIXlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Jul 2018 19:41:46 -0400
Date: Mon, 9 Jul 2018 18:41:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 0/1] PCI: Support to workaround bus level HW issues
 in IDT switch
Message-ID: <20180709234143.GB188359@bhelgaas-glaptop.roam.corp.google.com>
References: <4117c119-c754-bf4e-544c-19cb6e239f38@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4117c119-c754-bf4e-544c-19cb6e239f38@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 09, 2018 at 11:28:54AM -0400, James Puthukattukaran wrote:
> There are bugs in certain PCIe switches that cause access violations when an
> endpoint device is hotplugged. In particular, there's an issue with
> certain IDT switches that trigger a ACS violation when bringing up a newly
> plugged PCIe endpoint device. This is a major issue for platforms
> designed to issue a fatal reset in the case of this event.
> 
> This patch checks if the endpoint device lies behind this errant IDT switch
> and if so, implements the suggested workaround
> 
> James
> 
> -v2: move workaround to pci_bus_read_dev_vendor_id() from pci_bus_check_dev()
>      and move enable_acs_sv to drivers/pci/pci.c -- by Yinghai
> -v3: add bus->self check for root bus and virtual bus for sriov vfs.
> -v4: only do workaround for IDT switches
> -v5: tweak pci_std_enable_acs_sv to deal with unimplemented SV
> -v6: Added errata verbiage verbatim and resolved patch format issues
> -v7: changed int to bool for found and idt_workaround declarations. Also
>      added bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=196979
> -v8: Rewrote the patch by adding a new acs quirk to keep the workaround
>      out of the main code path
> -v9: changed function name from pci_dev_specific_fixup_acs_quirk to
>      pci_bus_acs_quirk. Also, tested for FLR and hot reset scenarios and did
>      not see issues where workaround was required. The issue seems to be
>      related only to cold reset/power on situation.
> -v10: Moved the contents of pci_bus_read_vendor_id into an internal function
>       __pci_bus_read_vendor_id
> -v11: Split the patch into two patches. The first a general quirk framework.
> -v12: Add pci_bus_generic_read_dev_vendor_id() to carry out default behavior
>       when detecting endpoint and pci_bus_specific_read_dev_vendor_id for
>       bus quirk behavior
> -v13: Fixed build errors found for non-x86 platforms via cross compiles when
>       CONFIG_QUIRKS is not defined
> -v14: Remove the general quirk framework as per Bjorn; it was deemed an
>       overkill. Simplified the code requiring just one patch
> 
> James Puthukattukaran(1):
>   Workaround for ACS related bug in certain IDT switches
> 
>  drivers/pci/pci.h    |  5 ++++
>  drivers/pci/probe.c  | 17 +++++++++++++-
>  drivers/pci/quirks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 1 deletion(-)

Thanks for persevering with this.

I applied this to pci/misc for v4.18.  I cleaned up a bunch of
whitespace and comments, so the actual patch I applied is below.  I
also added an ifdef to handle the case where CONFIG_PCI_QUIRKS is
unset and pci_idt_bus_quirk() is undefined.

v14 is significantly changed from the version Alex reviewed, so I
think it was a bit of a stretch to keep his reviewed-by, but I did
check with him on IRC (where he pointed out the issue when
CONFIG_PCI_QUIRKS is unset).


commit f1790969d71e
Author: James Puthukattukaran <james.puthukattukaran@oracle.com>
Date:   Mon Jul 9 11:31:25 2018 -0400

    PCI: Workaround IDT switch ACS Source Validation erratum
    
    Some IDT switches incorrectly flag an ACS Source Validation error on
    completions for config read requests even though PCIe r4.0, sec 6.12.1.1,
    says that completions are never affected by ACS Source Validation.  Here's
    the text of IDT 89H32H8G3-YC, erratum #36:
    
      Item #36 - Downstream port applies ACS Source Validation to Completions
      Section 6.12.1.1 of the PCI Express Base Specification 3.1 states that
      completions are never affected by ACS Source Validation.  However,
      completions received by a downstream port of the PCIe switch from a
      device that has not yet captured a PCIe bus number are incorrectly
      dropped by ACS Source Validation by the switch downstream port.
    
      Workaround: Issue a CfgWr1 to the downstream device before issuing the
      first CfgRd1 to the device.  This allows the downstream device to capture
      its bus number; ACS Source Validation no longer stops completions from
      being forwarded by the downstream port.  It has been observed that
      Microsoft Windows implements this workaround already; however, some
      versions of Linux and other operating systems may not.
    
    When doing the first config read to probe for a device, if the device is
    behind an IDT switch with this erratum:
    
      1. Disable ACS Source Validation if enabled
      2. Wait for device to become ready to accept config accesses (by using
         the Config Request Retry Status mechanism)
      3. Do a config write to the endpoint
      4. Enable ACS Source Validation (if it was enabled to begin with)
    
    The workaround suggested by IDT is basically only step 3, but we don't know
    when the device is ready to accept config requests.  That means we need to
    do config reads until we receive a non-Config Request Retry Status, which
    means we need to disable ACS SV temporarily.
    
    Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
    [bhelgaas: changelog, clean up whitespace]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a07f3f..70808c168fb9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -225,6 +225,10 @@ enum pci_bar_type {
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
+bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
+					int crs_timeout);
+int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int crs_timeout);
+
 int pci_setup_device(struct pci_dev *dev);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int reg);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..17a5651951ea 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2156,8 +2156,8 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
 	return true;
 }
 
-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int timeout)
+bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+					int timeout)
 {
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 		return false;
@@ -2172,6 +2172,24 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 
 	return true;
 }
+
+bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+				int timeout)
+{
+	struct pci_dev *bridge = bus->self;
+
+#ifdef CONFIG_PCI_QUIRKS
+	/*
+	 * Certain IDT switches have an issue where they improperly trigger
+	 * ACS Source Validation errors on completions for config reads.
+	 */
+	if (bridge && bridge->vendor == PCI_VENDOR_ID_IDT &&
+	    bridge->device == 0x80b5)
+		return pci_idt_bus_quirk(bus, devfn, l, timeout);
+#endif
+
+	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
+}
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de848658..cab2d5f922a9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4753,3 +4753,58 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
+
+/*
+ * Some IDT switches incorrectly flag an ACS Source Validation error on
+ * completions for config read requests even though PCIe r4.0, sec
+ * 6.12.1.1, says that completions are never affected by ACS Source
+ * Validation.  Here's the text of IDT 89H32H8G3-YC, erratum #36:
+ *
+ *   Item #36 - Downstream port applies ACS Source Validation to Completions
+ *   Section 6.12.1.1 of the PCI Express Base Specification 3.1 states that
+ *   completions are never affected by ACS Source Validation.  However,
+ *   completions received by a downstream port of the PCIe switch from a
+ *   device that has not yet captured a PCIe bus number are incorrectly
+ *   dropped by ACS Source Validation by the switch downstream port.
+ *
+ * The workaround suggested by IDT is to issue a config write to the
+ * downstream device before issuing the first config read.  This allows the
+ * downstream device to capture its bus and device numbers (see PCIe r4.0,
+ * sec 2.2.9), thus avoiding the ACS error on the completion.
+ *
+ * However, we don't know when the device is ready to accept the config
+ * write, so we do config reads until we receive a non-Config Request Retry
+ * Status, then do the config write.
+ *
+ * To avoid hitting the erratum when doing the config reads, we disable ACS
+ * SV around this process.
+ */
+int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l, int timeout)
+{
+	int pos;
+	u16 ctrl = 0;
+	bool found;
+	struct pci_dev *bridge = bus->self;
+
+	pos = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ACS);
+
+	/* Disable ACS SV before initial config reads */
+	if (pos) {
+		pci_read_config_word(bridge, pos + PCI_ACS_CTRL, &ctrl);
+		if (ctrl & PCI_ACS_SV)
+			pci_write_config_word(bridge, pos + PCI_ACS_CTRL,
+					      ctrl & ~PCI_ACS_SV);
+	}
+
+	found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
+
+	/* Write Vendor ID (read-only) so the endpoint latches its bus/dev */
+	if (found)
+		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
+
+	/* Re-enable ACS_SV if it was previously enabled */
+	if (ctrl & PCI_ACS_SV)
+		pci_write_config_word(bridge, pos + PCI_ACS_CTRL, ctrl);
+
+	return found;
+}
