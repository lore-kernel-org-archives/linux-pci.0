Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Jul 2017 14:34:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4] PCI: Add Extended Tags quirk for Broadcom HT2100 Root
 Port
Message-ID: <20170712193432.GD14614@bhelgaas-glaptop.roam.corp.google.com>
References: <1499832255-9845-1-git-send-email-okaya@codeaurora.org>
 <20170712105550.6007fa06.wim.ten.have@oracle.com>
 <CABawtvMCJy1Y0Cv-NhVRv4qKLiZ-PUWfeZhTA6uGiiiswe+g6A@mail.gmail.com>
 <b8ccaffe-d907-db04-a793-86a3b67f61af@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <b8ccaffe-d907-db04-a793-86a3b67f61af@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci <linux-pci@vger.kernel.org>, timur@codeaurora.org,
 LKML <linux-kernel@vger.kernel.org>, Wim ten Have <wim.ten.have@oracle.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ethan Zhao <ethan.kernel@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 08:15:43AM -0400, Sinan Kaya wrote:
> On 7/12/2017 5:44 AM, Ethan Zhao wrote:
> > The dmesg yelled "...Tag handling is broken" , but didn't say how it
> > was handled, that is weird and confusing, just because there is no
> > device under that bridge ?
> > 
> > How about move the messages together "...is broken, disable Extended tag..."

I changed the message this:

  pci 0000:00:07.0: disabling Extended Tags (this device can't handle them)

We don't see any message from 0000:01:00.0 itself because it powered up
with Extended Tags disabled.  If it powered up with Extended Tags *enabled*
(as allowed by the ECN), we would see this:

  pci 0000:00:07.0: disabling Extended Tags (this device can't handle them)
  pci 0000:01:00.0: disabling Extended Tags

Does that seem reasonable?  Complete updated patch attached below.

> This was something requested by Bjorn to inform that user has a broken HW
> when a quirk is matched.
> 
> The new code will disable extended tags only if it was enabled on endpoint
> via power on reset value or via some broken BIOS.
> 
> It looks like we are not seeing any disabling message. This implies that
> both the card and BIOS is good.
> 
> That's why, you are no longer seeing a disabling message on this system
> and code is just not enabling extended tags.


commit 2e6e588b99c4c7fbcea55eb48890fa8d0ab0c3d7
Author: Sinan Kaya <okaya@codeaurora.org>
Date:   Wed Jul 12 00:04:14 2017 -0400

    PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken
    
    Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
    unless its Extended Tag Field Enable is set, but all Receivers/Completers
    must handle 8-bit Tags correctly regardless of their Extended Tag Field
    Enable.
    
    Some devices do not handle 8-bit Tags as Completers, so add a quirk for
    them.  If we find such a device, we disable Extended Tags for the entire
    hierarchy to make peer-to-peer DMA possible.
    
    The Broadcom HT2100 seems to have issues with handling 8-bit tags.  Mark it
    as broken.
    
    The pci_walk_bus() in the quirk handles devices we've enumerated in the
    past, and pci_configure_device() handles devices we enumerate in the
    future.
    
    Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
    Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
    Reported-and-tested-by: Wim ten Have <wim.ten.have@oracle.com>
    Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
    [bhelgaas: changelog, tweak messages, rename bit and quirk]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 03e3d0285aea..9c3d123d358f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -234,6 +234,7 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c31310db0404..c81c9835f4c7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1745,21 +1745,50 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
-static void pci_configure_extended_tags(struct pci_dev *dev)
+int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 {
-	u32 dev_cap;
+	struct pci_host_bridge *host;
+	u32 cap;
+	u16 ctl;
 	int ret;
 
 	if (!pci_is_pcie(dev))
-		return;
+		return 0;
 
-	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &dev_cap);
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
 	if (ret)
-		return;
+		return 0;
+
+	if (!(cap & PCI_EXP_DEVCAP_EXT_TAG))
+		return 0;
 
-	if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
+	ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &ctl);
+	if (ret)
+		return 0;
+
+	host = pci_find_host_bridge(dev->bus);
+	if (!host)
+		return 0;
+
+	/*
+	 * If some device in the hierarchy doesn't handle Extended Tags
+	 * correctly, make sure they're disabled.
+	 */
+	if (host->no_ext_tags) {
+		if (ctl & PCI_EXP_DEVCTL_EXT_TAG) {
+			dev_info(&dev->dev, "disabling Extended Tags\n");
+			pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
+						   PCI_EXP_DEVCTL_EXT_TAG);
+		}
+		return 0;
+	}
+
+	if (!(ctl & PCI_EXP_DEVCTL_EXT_TAG)) {
+		dev_info(&dev->dev, "enabling Extended Tags\n");
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
 					 PCI_EXP_DEVCTL_EXT_TAG);
+	}
+	return 0;
 }
 
 static void pci_configure_device(struct pci_dev *dev)
@@ -1768,7 +1797,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	int ret;
 
 	pci_configure_mps(dev);
-	pci_configure_extended_tags(dev);
+	pci_configure_extended_tags(dev, NULL);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6967c6b4cf6b..f135765555c9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4681,3 +4681,19 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
+
+static void quirk_no_ext_tags(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	if (!bridge)
+		return;
+
+	bridge->no_ext_tags = 1;
+	dev_info(&pdev->dev, "disabling Extended Tags (this device can't handle them)\n");
+
+	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4869e66dd659..3b968d435895 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -451,6 +451,7 @@ struct pci_host_bridge {
 	void *release_data;
 	struct msi_controller *msi;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int no_ext_tags:1;		/* no Extended Tags */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
