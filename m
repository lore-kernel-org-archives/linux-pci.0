Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeDMVQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Apr 2018 17:16:54 -0400
Date: Fri, 13 Apr 2018 16:16:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org,
        Rajat Jain <rajatja@google.com>
Subject: Re: Issue with Enable LTR while pcie_aspm off
Message-ID: <20180413211651.GA80087@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
 <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 13, 2018 at 09:13:42PM +0530, Srinath Mannam wrote:
> Hi Bjorn,
> 
> Thank you very much for quick response.
> 
> I am using samsung NVMe card as EP connected to our platform. As per
> link capabilities device does not support L1.s.
> But LTR is enabled in DEVCAP2.

Interesting that the device advertises LTR support, but not L1.2
support.  As far as I can tell, that's legal per spec, but I don't
know what the LTR info would be used for.  The only use I know about
is comparison with LTR_L1.2_THRESHOLD, as in PCIe r4.0, sec 5.5.1.

Can you attach lspci -vv output for the NVMe device and all the
devices in the path leading to it?

> In my observation after setting LTR without enabling ASPM (common
> clock and link retraining) in software, device stopped responding.

>From sec 5.5.1, it seems clear that LTR would have to be enabled
before L1.2 is enabled, because the decision to enter L1.2 depends on
information from LTR messages.

Since the device advertised LTR support, it seems like a hardware
defect if enabling it breaks something.  But I can imagine that if it
doesn't advertise L1.2 support, nobody expected LTR to be used.  Can
you try the patch below?  It should make it so we don't enable LTR
unless we also support L1.2.  Maybe that's enough to avoid the issue.

Bjorn


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f76eb7704f64..9e2212889e7e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -400,6 +400,16 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 		info->l1ss_cap = 0;
 		return;
 	}
+
+	/*
+	 * If we don't have LTR for the entire path from the Root Complex
+	 * to this device, we can't use L1.2.  PCIe r4.0, secs 5.5.4, 6.18.
+	 */
+	if (!pdev->ltr_path) {
+		info->l1ss_cap &= ~PCI_L1SS_CTL1_PCIPM_L1_2;
+		info->l1ss_cap &= ~PCI_L1SS_CTL1_ASPM_L1_2;
+	}
+
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
 			      &info->l1ss_ctl1);
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..9a224612b3f8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1954,12 +1954,29 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 static void pci_configure_ltr(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCIEASPM
-	u32 cap;
+	u32 cap, l1ss_cap, l1ss;
 	struct pci_dev *bridge;
 
 	if (!pci_is_pcie(dev))
 		return;
 
+	/*
+	 * Per PCIe r4.0, sec 5.5.4, we must program LTR_L1.2_THRESHOLD if
+	 * either L1.2 enable bit is set.  That suggests that LTR must be
+	 * enabled before L1.2.  If the device (and the entire path leading
+	 * to it) advertises L1.2 and LTR support, enable LTR.
+	 */
+	l1ss_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss_cap)
+		return;
+
+	pci_read_config_dword(dev, l1ss_cap + PCI_L1SS_CAP, &l1ss);
+	if (!(l1ss & PCI_L1SS_CAP_L1_PM_SS))
+		return;
+
+	if (!(l1ss & (PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2)))
+		return;
+
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
@@ -1967,7 +1984,7 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	/*
 	 * Software must not enable LTR in an Endpoint unless the Root
 	 * Complex and all intermediate Switches indicate support for LTR.
-	 * PCIe r3.1, sec 6.18.
+	 * PCIe r4.0, sec 6.18.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
 		dev->ltr_path = 1;
