Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34270 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMGqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2018 02:46:47 -0400
Received: by mail-ot0-f194.google.com with SMTP id m7-v6so8787825otd.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Apr 2018 23:46:47 -0700 (PDT)
MIME-Version: 1.0
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Fri, 13 Apr 2018 12:16:46 +0530
Message-ID: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
Subject: Issue with Enable LTR while pcie_aspm off
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

In our platform we disable aspm using boot_arg "pcie_aspm=off".
But with the below patch, LTR is enabled which is part of ASPM.
even we keep disable aspm using "pcie_aspm=off" then why we need to
enable LTR. This is causing issues with few NVMe cards.

Please advice us how can we proceed in this scenario.

commit c46fd358070f22ba68d6e74c22016a33b914c20a
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Nov 28 16:43:50 2017 -0600

    PCI/ASPM: Enable Latency Tolerance Reporting when supported

    Enable Latency Tolerance Reporting (LTR).  Note that LTR must be enabled in
    the Root Port first, and must not be enabled in any downstream device
    unless the Root Port and all intermediate Switches also support LTR.
    See PCIe r3.1, sec 6.18.

    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1..3761b13 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1875,6 +1875,38 @@ static void
pci_configure_relaxed_ordering(struct pci_dev *dev)
        }
 }

+static void pci_configure_ltr(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCIEASPM
+       u32 cap;
+       struct pci_dev *bridge;
+
+       if (!pci_is_pcie(dev))
+               return;
+
+       pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+       if (!(cap & PCI_EXP_DEVCAP2_LTR))
+               return;
+
+       /*
+        * Software must not enable LTR in an Endpoint unless the Root
+        * Complex and all intermediate Switches indicate support for LTR.
+        * PCIe r3.1, sec 6.18.
+        */
+       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+               dev->ltr_path = 1;
+       else {
+               bridge = pci_upstream_bridge(dev);
+               if (bridge && bridge->ltr_path)
+                       dev->ltr_path = 1;
+       }
+
+       if (dev->ltr_path)
+               pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
+                                        PCI_EXP_DEVCTL2_LTR_EN);
+#endif
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
        struct hotplug_params hpp;
@@ -1883,6 +1915,7 @@ static void pci_configure_device(struct pci_dev *dev)
        pci_configure_mps(dev);
        pci_configure_extended_tags(dev, NULL);
        pci_configure_relaxed_ordering(dev);


Regards,
Srinath.
