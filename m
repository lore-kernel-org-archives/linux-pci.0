Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65431 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933158AbcE3NiC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2016 09:38:02 -0400
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4UDY3kD026717
	for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 09:38:01 -0400
Message-Id: <201605301338.u4UDY3kD026717@mx0a-001b2d01.pphosted.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 238jhvp7q2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 09:38:01 -0400
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Mon, 30 May 2016 19:07:57 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 5/6] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
Date: Mon, 30 May 2016 21:32:12 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Any IODA host bridge have the capability of IRQ remapping.
So we set PCI_BUS_FLAGS_MSI_REMAP when this kind of host birdge
is detected.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c5baaf3..9011268 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3094,6 +3094,12 @@ static void pnv_pci_ioda_fixup(void)
 	pnv_npu_ioda_fixup();
 }
 
+int pnv_pci_ioda_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+	return 0;
+}
+
 /*
  * Returns the alignment for I/O or memory windows for P2P
  * bridges. That actually depends on how PEs are segmented.
@@ -3395,6 +3401,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 
+	ppc_md.pcibios_root_bridge_prepare = pnv_pci_ioda_root_bridge_prepare;
+
 	if (phb->type == PNV_PHB_NPU)
 		hose->controller_ops = pnv_npu_ioda_controller_ops;
 	else
-- 
1.7.9.5

