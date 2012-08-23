Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60451 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab2HWFKF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Aug 2012 01:10:05 -0400
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Thu, 23 Aug 2012 01:10:04 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2609D6E8039
	for <linux-pci@vger.kernel.org>; Thu, 23 Aug 2012 01:10:03 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7N5A2vR38207620
	for <linux-pci@vger.kernel.org>; Thu, 23 Aug 2012 01:10:02 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7N5A1wX011911
	for <linux-pci@vger.kernel.org>; Thu, 23 Aug 2012 02:10:02 -0300
Date: Thu, 23 Aug 2012 13:09:58 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linuxram@us.ibm.com
Subject: [RFC PATCH v3 ]pci: pci resource iterator
Message-ID: <20120823050958.GB2332@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
 <20120816032602.GN2449@ram-ThinkPad-T61>
 <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
 <20120816044104.GQ2449@ram-ThinkPad-T61>
 <20120821151245.GA2356@ram-ThinkPad-T61>
 <CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
 <20120822101533.GA2332@ram-ThinkPad-T61>
 <CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
 <CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
 <CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

    PCI: pci resource iterator
    
    Currently pci_dev structure holds an array of 17 PCI resources; six
    base BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is
    wasteful. A bridge device just needs the 4 bridge resources. A
    non-bridge device just needs the six base resources and one ROM
    resource. The sriov resources are needed only if the device has
    SRIOV capability.
    
    The pci_dev structure needs to be re-organized to avoid unnecessary
    bloating.  However too much code outside the pci-bus driver, assumes
    the internal details of the pci_dev structure, thus making it hard
    to re-organize the datastructure.
    
    As a first step this patch provides generic methods to access the
    resource structure of the pci_dev.
    
    Next step, change the code in all the drivers that access the
    resource structure to use the new iterator.
    
    Finally we can re-organize the resource structure in the pci_dev
    structure and correspondingly update the methods.
    
    This patch is compile tested only.
    
    Changelog v2:
            Consolidated iterator interface as per Bjorn's suggestion.
    
    Changelog v3:
    	ability to get index of the returned resource. Suggested by Yinghai.
    	Incorporates Yinghai's code snippets.
    
<TODO get Yinghai's SOB>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>

diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..7101da2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1351,6 +1351,48 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 	 (pci_resource_end((dev), (bar)) -		\
 	  pci_resource_start((dev), (bar)) + 1))
 
+#define PCI_STD_RES		(1<<0)
+#define PCI_ROM_RES		(1<<1)
+#define PCI_BRIDGE_RES		(1<<2)
+#define PCI_IOV_RES		(1<<3)
+#define PCI_ALL_RES	(PCI_STD_RES|PCI_ROM_RES|PCI_BRIDGE_RES|PCI_IOV_RES)
+#define PCI_NOSTD_RES		(PCI_ALL_RES & ~PCI_STD_RES)
+#define PCI_NOIOV_RES		(PCI_ALL_RES & ~PCI_IOV_RES)
+#define PCI_NOROM_RES		(PCI_ALL_RES & ~PCI_ROM_RES)
+#define PCI_NOBRIDGE_RES	(PCI_ALL_RES & ~PCI_BRIDGE_RES)
+#define PCI_STD_ROM_RES		(PCI_STD_RES | PCI_ROM_RES)
+#define PCI_STD_IOV_RES		(PCI_STD_RES | PCI_IOV_RES)
+#define PCI_STD_ROM_IOV_RES	(PCI_NOBRIDGE_RES)
+
+static inline struct resource *pci_dev_resource_n(struct pci_dev *dev, int n)
+{
+	if (n >= 0 && n < PCI_NUM_RESOURCES)
+		return &dev->resource[n];
+
+	return NULL;
+}
+
+static inline int pci_next_resource_idx(int i, int flag)
+{
+	while (++i < PCI_NUM_RESOURCES) {
+		if ((i >= 0 && i < PCI_ROM_RESOURCE && (flag & PCI_STD_RES)) ||
+		    (i == PCI_ROM_RESOURCE && (flag & PCI_ROM_RES)) ||
+#ifdef CONFIG_PCI_IOV
+		    (i <= PCI_IOV_RESOURCE_END && (flag & PCI_IOV_RES)) ||
+#endif
+		    (i <= PCI_BRIDGE_RESOURCE_END && (flag & PCI_BRIDGE_RES)))
+			return i;
+	}
+	return -1;
+}
+
+#define for_each_pci_resource(dev, res, flag) \
+	for (i = pci_next_resource_idx(-1, flag), \
+			res = pci_dev_resource_n(dev, i); \
+	     res; \
+	     i = pci_next_resource_idx(i, flag), \
+			res = pci_dev_resource_n(dev, i))
+
 /* Similar to the helpers above, these manipulate per-pci_dev
  * driver-specific data.  They are really just a wrapper around
  * the generic device structure functions of these calls.

