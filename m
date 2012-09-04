Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:45024 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756621Ab2IDD2D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Sep 2012 23:28:03 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 3 Sep 2012 23:28:02 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 09E5F6E803F
	for <linux-pci@vger.kernel.org>; Mon,  3 Sep 2012 23:27:22 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q843RLTG082648
	for <linux-pci@vger.kernel.org>; Mon, 3 Sep 2012 23:27:21 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q843RLCe007996
	for <linux-pci@vger.kernel.org>; Mon, 3 Sep 2012 23:27:21 -0400
Date: Tue, 4 Sep 2012 11:27:17 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
Message-ID: <20120904032717.GD2438@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120822101533.GA2332@ram-ThinkPad-T61>
 <CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
 <CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
 <CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
 <20120823050958.GB2332@ram-ThinkPad-T61>
 <CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
 <20120827073335.GE20843@ram-ThinkPad-T61>
 <CAE9FiQVEuH=ZwL4R+wyO0H0853hQ8bpGBYKQJwkAJ5g7FKtY7g@mail.gmail.com>
 <20120903090821.GC2438@ram-ThinkPad-T61>
 <CAE9FiQV+_cuDV1WqVZK5SO4JYuJ8_=Gj3qG3Rz9bJsGhUSLV4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQV+_cuDV1WqVZK5SO4JYuJ8_=Gj3qG3Rz9bJsGhUSLV4w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 03, 2012 at 11:20:45AM -0700, Yinghai Lu wrote:
> On Mon, Sep 3, 2012 at 2:08 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> > On Mon, Sep 03, 2012 at 01:07:46AM -0700, Yinghai Lu wrote:
> >
> > Anyway I am ok with either patch.
> 
> please check -v7.

Looks good to me. I am inlining the patch for others to comment.
BTW: your patch that introduces pci_dev_resource_n() will have 
to be applied before applying this patch.


From: Ram Pai <linuxram@us.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v7]pci: pci resource iterator

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

Finally we can re-organize the resource structure in the pci_dev
structure and correspondingly update the methods.

-v2: Consolidated iterator interface as per Bjorn's suggestion.
-v3: Add the idx back - Yinghai Lu
-v7: Change to use bitmap for searching - Yinghai Lu

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/probe.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |   24 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -360,6 +360,30 @@ struct pci_dev {
 struct resource *pci_dev_resource_n(struct pci_dev *dev, int n);
 int pci_dev_resource_idx(struct pci_dev *dev, struct resource *res);
 
+#define PCI_STD_RES		(1<<0)
+#define PCI_ROM_RES		(1<<1)
+#define PCI_IOV_RES		(1<<2)
+#define PCI_BRIDGE_RES		(1<<3)
+#define PCI_RES_BLOCK_NUM	4
+
+#define PCI_ALL_RES		(PCI_STD_RES | PCI_ROM_RES | PCI_BRIDGE_RES | PCI_IOV_RES)
+#define PCI_NOSTD_RES		(PCI_ALL_RES & ~PCI_STD_RES)
+#define PCI_NOIOV_RES		(PCI_ALL_RES & ~PCI_IOV_RES)
+#define PCI_NOROM_RES		(PCI_ALL_RES & ~PCI_ROM_RES)
+#define PCI_NOBRIDGE_RES	(PCI_ALL_RES & ~PCI_BRIDGE_RES)
+#define PCI_STD_ROM_RES		(PCI_STD_RES | PCI_ROM_RES)
+#define PCI_STD_IOV_RES		(PCI_STD_RES | PCI_IOV_RES)
+#define PCI_STD_ROM_IOV_RES	(PCI_STD_RES | PCI_ROM_RES | PCI_IOV_RES)
+
+int pci_next_resource_idx(int i, int flag);
+
+#define for_each_pci_resource(dev, res, i, flag)	\
+	for (i = pci_next_resource_idx(-1, flag),	\
+		res = pci_dev_resource_n(dev, i);	\
+	     res;					\
+	     i = pci_next_resource_idx(i, flag),	\
+		res = pci_dev_resource_n(dev, i))
+
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -123,6 +123,53 @@ int pci_dev_resource_idx(struct pci_dev
 	return -1;
 }
 
+static void __init_res_idx_mask(unsigned long *mask, int flag)
+{
+	bitmap_zero(mask, PCI_NUM_RESOURCES);
+	if (flag & PCI_STD_RES)
+		bitmap_set(mask, PCI_STD_RESOURCES,
+			PCI_STD_RESOURCE_END - PCI_STD_RESOURCES + 1);
+	if (flag & PCI_ROM_RES)
+		bitmap_set(mask, PCI_ROM_RESOURCE, 1);
+#ifdef CONFIG_PCI_IOV
+	if (flag & PCI_IOV_RES)
+		bitmap_set(mask, PCI_IOV_RESOURCES,
+			PCI_IOV_RESOURCE_END - PCI_IOV_RESOURCES + 1);
+#endif
+	if (flag & PCI_BRIDGE_RES)
+		bitmap_set(mask, PCI_BRIDGE_RESOURCES,
+			PCI_BRIDGE_RESOURCE_END - PCI_BRIDGE_RESOURCES + 1);
+}
+
+static DECLARE_BITMAP(res_idx_mask[1 << PCI_RES_BLOCK_NUM], PCI_NUM_RESOURCES);
+static int __init pci_res_idx_mask_init(void)
+{
+	int i;
+
+	for (i = 0; i < (1 << PCI_RES_BLOCK_NUM); i++)
+		__init_res_idx_mask(res_idx_mask[i], i);
+
+	return 0;
+}
+postcore_initcall(pci_res_idx_mask_init);
+
+static inline unsigned long *get_res_idx_mask(int flag)
+{
+	return res_idx_mask[flag & ((1 << PCI_RES_BLOCK_NUM) - 1)];
+}
+
+int pci_next_resource_idx(int i, int flag)
+{
+	i++;
+	if (i < PCI_NUM_RESOURCES)
+		i = find_next_bit(get_res_idx_mask(flag), PCI_NUM_RESOURCES, i);
+
+	if (i < PCI_NUM_RESOURCES)
+		return i;
+
+	return -1;
+}
+
 static u64 pci_size(u64 base, u64 maxbase, u64 mask)
 {
 	u64 size = mask & maxbase;	/* Find the significant bits */

