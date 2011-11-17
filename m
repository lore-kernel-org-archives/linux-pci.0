Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47596 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab1KQATX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Nov 2011 19:19:23 -0500
Message-ID: <4EC452E1.9010601@redhat.com>
Date: Wed, 16 Nov 2011 19:18:41 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Paradis <jparadis@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, jbarnes@virtuousgeek.org
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com> <4EBD73C8.8070407@redhat.com> <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com> <4EBD8714.30401@redhat.com> <4EC12962.2040105@redhat.com> <20111114181418.GE4387@parisc-linux.org> <4EC28B93.1060101@redhat.com> <20111115201536.GF4387@parisc-linux.org> <4EC3EA8B.6030108@redhat.com>
In-Reply-To: <4EC3EA8B.6030108@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


[v2]
- ddutile@redhat.com requested drivers/pci/quirks.c code
- matthew@wil.cx requested that dmi_name_in_vendors() be called only once with a static var check
- added a kernel parameter to enable scanning of all PCIE devices.

[v3]
- matthew@wil.cx requested a clean up of is_broken_pcie_port(
- eike-kernel@sf-tec.de requested a clean up of the printk level and message

[v4]
- ddutile pointed out a logic error in is_broken_pcie_port.  It was no longer
being called only once on failure.

----8<----

pci: Workaround Stratus broken PCIE hierarchy

Stratus systems have a hierarchy that includes a PCIE Downstream bridge
connected to a PCIE Upstream bridge and a PCI Downstream bridge.  The system
boots with this wrong hierarchy into a crippled mode (USB doesn't work,
network doesn't work ...).  Avoiding the Downstream bridge check in
only_one_child() causes all the bridges to be enumerated and the system
to function properly.

Unfortunately this hardware is currently available so we should at least
keep it functional.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a0c5c5f..7af458f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2069,6 +2069,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				on: Turn ECRC on.
 		realloc		reallocate PCI resources if allocations done by BIOS
 				are erroneous.
+		pcie_scan_all	Scan all possible PCIE devices.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6f45a73..8c96fff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3589,6 +3589,9 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PERFORMANCE;
 			} else if (!strncmp(str, "pcie_bus_peer2peer", 18)) {
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
+			} else if (!strncmp(str, "pcie_scan_all", 13)) {
+				printk(KERN_INFO HW_ERR "PCIE: User request scan of all PCIE devices.  Your PCIE hardware is broken if you require this to boot.\n");
+				pcie_scan_all = 1;
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b74084e..5a07895 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -309,11 +309,16 @@ struct pci_dev_reset_methods {
 
 #ifdef CONFIG_PCI_QUIRKS
 extern int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+extern int is_broken_pcie_port(void);
 #else
 static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 {
 	return -ENOTTY;
 }
+static inline int is_broken_pcie_port(void)
+{
+	return 0;
+}
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 04e74f4..fc88a9b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1270,13 +1270,18 @@ static unsigned no_next_fn(struct pci_dev *dev, unsigned fn)
 	return 0;
 }
 
+int pcie_scan_all = 0; /* set via pci=pcie_scan_all */
 static int only_one_child(struct pci_bus *bus)
 {
 	struct pci_dev *parent = bus->self;
+	if (pcie_scan_all)
+		return 0;
 	if (!parent || !pci_is_pcie(parent))
 		return 0;
-	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
-	    parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
+	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
+		return 1;
+	if (parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM &&
+	    !is_broken_pcie_port())
 		return 1;
 	return 0;
 }
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7285145..6c9f72b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3092,3 +3092,21 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 	return -ENOTTY;
 }
+
+static int is_broken_pcie_port_called;
+int is_broken_pcie_port(void)
+{
+	if (is_broken_pcie_port_called)
+		return pcie_scan_all;
+	/*
+	 * Stratus/NEC ftServer systems have a broken PCIE hierarchy in which
+	 * one upstream and one downstream port are plugged into a downstream
+	 * port.  Avoiding the downstream port check in only_one_child() results
+	 * in a functional system.
+	 */
+	if (dmi_name_in_vendors("ftServer"))
+		pcie_scan_all = 1;
+
+	is_broken_pcie_port_called = 1;
+	return pcie_scan_all;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 337df0d..745b98e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1647,5 +1647,7 @@ static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
  */
 struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
 
+/* set via pci=pcie_scan_all in order to enumerate all possible PCIE busses */
+extern int pcie_scan_all;
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
