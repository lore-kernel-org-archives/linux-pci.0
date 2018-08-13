Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729858AbeHMVDI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Aug 2018 17:03:08 -0400
Subject: [PATCH 2/2] PCI: Match Root Port's MPS to endpoint's MPSS as
 necessary
From: Myron Stowe <myron.stowe@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: keith.busch@intel.com, jdmason@kudzu.us, okaya@kernel.org
Date: Mon, 13 Aug 2018 12:19:46 -0600
Message-ID: <20180813181946.105655.94535.stgit@tak.stowe>
In-Reply-To: <20180813181931.105655.22182.stgit@tak.stowe>
References: <20180813181931.105655.22182.stgit@tak.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge"), we made
sure every device's MPS setting matches its upstream bridge, making it more
likely that a hot-added device will work in a system with an optimized MPS
configuration.

Recently I've started encountering systems where the endpoint device's MPSS
capability is less than its Root Port's current MPS value, thus the
endpoint is not capable of matching its upstream bridge's MPS setting (see:
bugzilla via "Link:" below).  This leaves the system vulnerable - the
upstream Root Port could respond with larger sized TLPs than the device
can handle, and the device will consider them to be 'Malformed'.

One could use the "pci=pcie_bus_safe" kernel parameter to resolve the
issue, but, it both forces a user to have to supply a kernel parameter to
get the system to function reliable, and may end up limiting MPS settings
of other, non-related, sub-topologies which could benefit from maintaining
their larger values.

This patch augments Keith's approach to include tuning down a Root Port's
MPS setting when its hot-added endpoint device is not capable of matching
it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200527
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Dongdong Liu <liudongdong3@huawei.com>
Acked-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---
 drivers/pci/probe.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b285786..a1a243e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1725,7 +1725,7 @@ int pci_setup_device(struct pci_dev *dev)
 static void pci_configure_mps(struct pci_dev *dev)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
-	int mps, p_mps, rc;
+	int mps, mpss, p_mps, rc;
 
 	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
 		return;
@@ -1753,6 +1753,14 @@ static void pci_configure_mps(struct pci_dev *dev)
 	if (pcie_bus_config != PCIE_BUS_DEFAULT)
 		return;
 
+	mpss = 128 << dev->pcie_mpss;
+	if (mpss < p_mps && pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT) {
+		pcie_set_mps(bridge, mpss);
+		pci_info(dev, "Upstream bridge's Max Payload Size set to %d (was %d, max %d)\n",
+			 mpss, p_mps, 128 << bridge->pcie_mpss);
+		p_mps = pcie_get_mps(bridge);
+	}
+
 	rc = pcie_set_mps(dev, p_mps);
 	if (rc) {
 		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
@@ -1761,7 +1769,7 @@ static void pci_configure_mps(struct pci_dev *dev)
 	}
 
 	pci_info(dev, "Max Payload Size set to %d (was %d, max %d)\n",
-		 p_mps, mps, 128 << dev->pcie_mpss);
+		 p_mps, mps, mpss);
 }
 
 static struct hpp_type0 pci_default_type0 = {
