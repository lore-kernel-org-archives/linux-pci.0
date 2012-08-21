Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:60758 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317Ab2HUPP5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Aug 2012 11:15:57 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Tue, 21 Aug 2012 09:15:55 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 362E719D803E
	for <linux-pci@vger.kernel.org>; Tue, 21 Aug 2012 09:14:47 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7LFEFAS013624
	for <linux-pci@vger.kernel.org>; Tue, 21 Aug 2012 09:14:25 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7LFDxUG018437
	for <linux-pci@vger.kernel.org>; Tue, 21 Aug 2012 09:14:02 -0600
Date: Tue, 21 Aug 2012 23:13:44 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: linux-pci@vger.kernel.org
Cc: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH v2 ]pci: pci resource iterator
Message-ID: <20120821151245.GA2356@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
 <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
 <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
 <20120816032602.GN2449@ram-ThinkPad-T61>
 <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
 <20120816044104.GQ2449@ram-ThinkPad-T61>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120816044104.GQ2449@ram-ThinkPad-T61>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI: pci resource iterator
    
Currently pci_dev structure holds an array of 17 PCI resources; six base
BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
A bridge device just needs the 4 bridge resources. A non-bridge device
just needs the six base resources and one ROM resource. The sriov
resources are needed only if the device has SRIOV capability.
    
The pci_dev structure needs to be re-organized to avoid unnecessary
bloating.  However too much code outside the pci-bus driver, assumes the
internal details of the pci_dev structure, thus making it hard to
re-organize the datastructure.
    
As a first step this patch provides generic methods to access the
resource structure of the pci_dev.
    
Once this patch is accepted, I have another 40+ patches that modify all
the files that directly access the resource structure, to use the new
methods provided in the first step.
    
Finally we can re-organize the resource structure in the pci_dev
structure and correspondingly update the methods.

This patch is compile tested only.

Changelog: 
	Consolidated iterator interface as per Bjorn's suggestion.
    
Signed-off-by: Ram Pai <linuxram@us.ibm.com>

diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..ab897fd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1351,6 +1351,49 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 	 (pci_resource_end((dev), (bar)) -		\
 	  pci_resource_start((dev), (bar)) + 1))
 
+#define PCI_STD_RES 		0x01
+#define PCI_ROM_RES 		0x02
+#define PCI_BRIDGE_RES		0x04
+#define PCI_IOV_RES 		0x08
+#define PCI_ALL_RES 		PCI_STD_RES|PCI_ROM_RES|PCI_BRIDGE_RES|PCI_IOV_RES
+#define PCI_NOSTD_RES 		PCI_ALL_RES&(^PCI_STD_RES)
+#define PCI_NOIOV_RES 		PCI_ALL_RES&(^PCI_IOV_RES)
+#define PCI_NOROM_RES 		PCI_ALL_RES&(^PCI_ROM_RES)
+#define PCI_NOBRIDGE_RES 	PCI_ALL_RES&(^PCI_BRIDGE_RES)
+#define PCI_STD_ROM_RES 	PCI_STD_RES|PCI_ROM_RES
+#define PCI_STD_IOV_RES 	PCI_STD_RES|PCI_IOV_RES
+#define PCI_STD_ROM_IOV_RES 	PCI_STD_RES|PCI_ROM_RES|PCI_IOV_RES
+
+#define pci_get_std_resource(dev, bar)     (((dev)->resource)+bar)
+#define pci_get_sriov_resource(dev, bar)     (((dev)->resource)+bar+PCI_IOV_RESOURCES)
+#define pci_get_bridge_resource(dev, bar)    (((dev)->resource)+bar+PCI_BRIDGE_RESOURCES)
+#define pci_get_rom_resource(dev)    	     (((dev)->resource)+PCI_ROM_RESOURCE)
+#define pci_resource_number(dev, res)	     (res - (dev)->resource)
+
+
+static inline struct resource *pci_next_resource(struct pci_dev *pdev,
+			struct resource *res, int flag)
+{
+	int i = res? pci_resource_number(pdev, res) : -1;
+
+	while (++i < PCI_NUM_RESOURCES) {
+		if ((i >= 0 && i < PCI_ROM_RESOURCE) && (flag & PCI_STD_RES))
+			return pci_get_std_resource(pdev, i);
+		else if ((i == PCI_ROM_RESOURCE) && (flag & PCI_ROM_RES))
+			return pci_get_rom_resource(pdev);
+		else if ((i <= PCI_IOV_RESOURCE_END) && (flag & PCI_IOV_RES))
+			return pci_get_sriov_resource(pdev, i-PCI_IOV_RESOURCES);
+		else if ((i <= PCI_BRIDGE_RESOURCE_END) && (flag & PCI_BRIDGE_RES))
+			return pci_get_bridge_resource(pdev, i-PCI_BRIDGE_RESOURCES);
+	}
+	return NULL;
+}
+
+
+#define for_each_pci_resource(dev, res, flag) \
+	for (res = pci_next_resource(dev, NULL, flag); res; \
+			res = pci_next_resource(dev, res, flag))
+
 /* Similar to the helpers above, these manipulate per-pci_dev
  * driver-specific data.  They are really just a wrapper around
  * the generic device structure functions of these calls.

