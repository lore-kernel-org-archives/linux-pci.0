Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728821AbeHMVDB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Aug 2018 17:03:01 -0400
Subject: [PATCH 1/2] PCI: Skip MPS logic for Virtual Functions (VFs)
From: Myron Stowe <myron.stowe@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: keith.busch@intel.com, jdmason@kudzu.us, okaya@kernel.org
Date: Mon, 13 Aug 2018 12:19:39 -0600
Message-ID: <20180813181939.105655.50410.stgit@tak.stowe>
In-Reply-To: <20180813181931.105655.22182.stgit@tak.stowe>
References: <20180813181931.105655.22182.stgit@tak.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Section 9.3.5.4 "Device Control Register" specifically shows both
Max_Payload_Size (MPS) and Max_Read_request_Size (MRRS) to be 'RsvdP' for
VFs in Table 9-16 [1].  Just prior to the table it states:
  "PF and VF functionality is defined in Section 7.5.3.4 except where
   noted in Table 9-16.  For VF fields marked 'RsvdP', the PF setting
   applies to the VF."

All of which implies that with respect to Max_Payload_Size Supported
(MPSS), MPS, and MRRS values, we should not be paying any attention to the
VF's fields, but rather only to the PF's.  Only looking at the PF's fields
also logically makes sense as it's the sole physical interface to the PCIe
bus.

[1] PCI Express Base Specification, Revision 4.0 Version 1.0 (2017).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200527
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Dongdong Liu <liudongdong3@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>
Fixes: 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
Cc: stable@vger.kernel.org # 4.3+
Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---
 drivers/pci/probe.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 611adcd..b285786 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1730,6 +1730,10 @@ static void pci_configure_mps(struct pci_dev *dev)
 	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
 		return;
 
+	/* MPS and MRRS fields are of type 'RsvdP' for VFs, short-circuit out */
+	if (dev->is_virtfn)
+		return;
+
 	mps = pcie_get_mps(dev);
 	p_mps = pcie_get_mps(bridge);
 
