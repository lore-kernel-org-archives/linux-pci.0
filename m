Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbdL0Xh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Dec 2017 18:37:56 -0500
Date: Wed, 27 Dec 2017 17:37:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc: "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH v6] mfd:
 Add support for RTS5250S power saving
Message-ID: <20171227233750.GB79892@bhelgaas-glaptop.roam.corp.google.com>
References: <1504772799-15173-1-git-send-email-rui_feng@realsil.com.cn>
 <20171214222522.GL30595@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8150B@RS-MBS01.realsil.com.cn>
 <20171215151522.GT30595@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8193C@RS-MBS01.realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <2A308283684ECD4B896628E09AF5361E01A8193C@RS-MBS01.realsil.com.cn>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 08:15:24AM +0000, 冯锐 wrote:
> > On Fri, Dec 15, 2017 at 09:42:45AM +0000, 冯锐 wrote:
> > > > [+cc Hans, Dave, linux-pci]
> > > >
> > > > On Thu, Sep 07, 2017 at 04:26:39PM +0800, rui_feng@realsil.com.cn
> > wrote:
> > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > >
> > > > I wish this had been posted to linux-pci before being merged.
> > > >
> > > > I'm concerned because some of this appears to overlap and conflict
> > > > with PCI core management of ASPM.
> > > >
> > > > I assume these devices advertise ASPM support in their Link
> > > > Capabilites registers, right?  If so, why isn't the existing PCI
> > > > core ASPM support sufficient?
> > > >
> > > When L1SS is configured, the device(hardware) can't enter L1SS status
> > > automatically, it need driver(software) to do some work to achieve the
> > function.
> > 
> > So this is a hardware defect in the device?  As far as I know, ASPM and L1SS
> > are specified such that they should work without special driver support.
> > 
> Yes, you can say that.
> 
> > > > > Enable power saving for RTS5250S as following steps:
> > > > > 1.Set 0xFE58 to enable clock power management.
> > > >
> > > > Is this clock power management something specific to RTS5250S, or is
> > > > it standard PCIe architected stuff?
> > > >
> > > 0xFE58 is specific register to RTS5250S not standard PCIe architected stuff.
> > 
> > OK.  I asked because devices often mirror architected PCIe config things in
> > device-specific MMIO space, and if I squint just right, I can sort of match up the
> > register bits you used with things in the PCIe spec.
> > 
> > > > > 2.Check cfg space whether support L1SS or not.
> > > >
> > > > This sounds like standard PCIe ASPM L1 Substates, right?
> > > >
> > > Yes.
> > >
> > > > > 3.If support L1SS, set 0xFF03 to free clkreq.
> > > > > 4.When entering idle status, enable aspm
> > > > >   and set parameters for L1SS and LTR.
> > > > > 5.Wnen entering run status, disable aspm
> > > > >   and set parameters for L1SS and LTR.
> > > >
> > > > In general, drivers should not configure ASPM, L1SS, and LTR
> > > > themselves; the PCI core should do that.
> > > >
> > > > If a driver needs to tweak ASPM at run-time, it should use
> > > > interfaces exported by the PCI core to do so.
> > > >
> > > Which interface I can use to set ASPM? I use "pci_write_config_byte" now.
> > 
> > What do you need to do?  include/linux/pci-aspm.h exports
> > pci_disable_link_state(), which is mainly used to avoid ASPM
> > states that have hardware errata.
> > 
> I want to enable ASPM(L0 -> L1) and disable ASPM(L1 -> L0), which
> interface can I use?

You can use pci_disable_link_state() to disable usage of L1.

Currently there is no corresponding pci_enable_link_state().  What if
we added something like the following (untested)?  Would that work for
you?


commit 209930d809fa602b8aafdd171b26719cee6c6649
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Dec 27 16:56:26 2017 -0600

    PCI/ASPM: Add pci_enable_link_state()
    
    Some drivers want control over the ASPM states their device is allowed to
    use.  We already have a pci_disable_link_state(), and drivers can use that
    to prevent the device from entering L0 or L1s.
    
    Add a corresponding pci_enable_link_state() so a driver can enable use of
    L0 or L1s again.

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3b9b4d50cd98..ca217195f800 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1028,6 +1028,67 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
+/**
+ * pci_enable_link_state - Enable device's link state, so the link may
+ * enter specific states.  Note that if the BIOS didn't grant ASPM
+ * control to the OS, this does nothing because we can't touch the LNKCTL
+ * register.
+ *
+ * @pdev: PCI device
+ * @state: ASPM link state to enable
+ */
+void pci_enable_link_state(struct pci_dev *pdev, int state)
+{
+	struct pci_dev *parent = pdev->bus->self;
+	struct pcie_link_state *link;
+	u32 lnkcap;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	if (pdev->has_secondary_link)
+		parent = pdev;
+	if (!parent || !parent->link_state)
+		return;
+
+	/*
+	 * A driver requested that ASPM be enabled on this device, but
+	 * if we don't have permission to manage ASPM (e.g., on ACPI
+	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
+	 * the _OSC method), we can't honor that request.  Windows has
+	 * a similar mechanism using "PciASPMOptOut", which is also
+	 * ignored in this situation.
+	 */
+	if (aspm_disabled) {
+		dev_warn(&pdev->dev, "can't enable ASPM; OS doesn't have ASPM control\n");
+		return;
+	}
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+	link = parent->link_state;
+	if (state & PCIE_LINK_STATE_L0S)
+		link->aspm_disable &= ~ASPM_STATE_L0S;
+	if (state & PCIE_LINK_STATE_L1)
+		link->aspm_disable &= ~ASPM_STATE_L1;
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+
+	/*
+	 * Enable Clock Power Management if requested by the driver,
+	 * supported by the device, and allowed by the current policy.
+	 */
+	if (state & PCIE_LINK_STATE_CLKPM) {
+		pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &lnkcap);
+		if (lnkcap & PCI_EXP_LNKCAP_CLKPM) {
+			link->clkpm_capable = 1;
+			pcie_set_clkpm(link, policy_to_clkpm_state(link));
+		}
+	}
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+}
+EXPORT_SYMBOL(pci_enable_link_state);
+
 static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 {
 	struct pci_dev *parent = pdev->bus->self;
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
index df28af5cef21..cd0736b384ae 100644
--- a/include/linux/pci-aspm.h
+++ b/include/linux/pci-aspm.h
@@ -24,10 +24,12 @@
 #define PCIE_LINK_STATE_CLKPM	4
 
 #ifdef CONFIG_PCIEASPM
+void pci_enable_link_state(struct pci_dev *pdev, int state);
 void pci_disable_link_state(struct pci_dev *pdev, int state);
 void pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 #else
+static inline void pci_enable_link_state(struct pci_dev *pdev, int state) { }
 static inline void pci_disable_link_state(struct pci_dev *pdev, int state) { }
 static inline void pcie_no_aspm(void) { }
 #endif
