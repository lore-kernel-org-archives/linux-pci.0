Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58747 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750922AbdBOGpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 01:45:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1F6hS7q170899
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 01:45:18 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0b-001b2d01.pphosted.com with ESMTP id 28mf8pcwwy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 01:45:18 -0500
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Tue, 14 Feb 2017 23:45:17 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com,
        aik@ozlabs.ru, benh@kernel.crashing.org, mpe@ellerman.id.au,
        paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: [PATCH v9 2/3] PCI: Add a macro to set default alignment for all PCI devices
Date: Wed, 15 Feb 2017 14:45:05 +0800
In-Reply-To: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1487141106-2503-3-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When vfio passthroughs a PCI device of which MMIO BARs are
smaller than PAGE_SIZE, guest will not handle the mmio
accesses to the BARs which leads to mmio emulations in host.

This is because vfio will not allow to passthrough one BAR's
mmio page which may be shared with other BARs. Otherwise,
there will be a backdoor that guest can use to access BARs
of other guest.

This patch adds a macro to set default alignment for all
PCI devices. Then we could solve this issue on some platforms
which would easily hit this issue because of their 64K page
such as PowerNV platform by defining this macro as PAGE_SIZE.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci.h |    4 ++++
 drivers/pci/pci.c              |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index e9bd6cf..5e31bc2 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -28,6 +28,10 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+#ifdef CONFIG_PPC_POWERNV
+#define PCIBIOS_DEFAULT_ALIGNMENT	PAGE_SIZE
+#endif
+
 struct pci_dev;
 
 /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a881c0d..2622e9b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4965,6 +4965,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 	resource_size_t align = 0;
 	char *p;
 
+#ifdef PCIBIOS_DEFAULT_ALIGNMENT
+	align = PCIBIOS_DEFAULT_ALIGNMENT;
+#endif
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
 	if (!*p)
-- 
1.7.1
