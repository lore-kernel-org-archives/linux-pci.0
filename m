Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:60825 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbcCGHuW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2016 02:50:22 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Mon, 7 Mar 2016 17:50:14 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
	alex.williamson@redhat.com, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 3/7] PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
Date: Mon,  7 Mar 2016 15:48:34 +0800
Message-Id: <1457336918-3893-4-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The resource_alignment will releases memory resources
allocated by firmware so that kernel can reassign new
resources later on. But this will cause the problem
that no resources can be allocated by kernel if
PCI_PROBE_ONLY was set, e.g. on pSeries platform
because PCI_PROBE_ONLY force kernel to use firmware
setup and not to reassign any resources.

To solve this problem, this patch ignores
resource_alignment if PCI_PROBE_ONLY was set.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt |    2 ++
 drivers/pci/probe.c                 |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index d8b29ab..8028631 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2922,6 +2922,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				windows need to be expanded.
 				noresize: Don't change the resources' sizes when
 				reassigning alignment.
+				Note that this option will not work if
+				PCI_PROBE_ONLY is set.
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..bc31cad 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1719,7 +1719,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	pci_fixup_device(pci_fixup_header, dev);
 
 	/* moved out from quirk header fixup code */
-	pci_reassigndev_resource_alignment(dev);
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_reassigndev_resource_alignment(dev);
 
 	/* Clear the state_saved flag. */
 	dev->state_saved = false;
-- 
1.7.9.5

