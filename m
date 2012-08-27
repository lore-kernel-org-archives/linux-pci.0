Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:60739 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab2H0Hdn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Aug 2012 03:33:43 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 27 Aug 2012 01:33:42 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9A1A519D803C
	for <linux-pci@vger.kernel.org>; Mon, 27 Aug 2012 01:33:40 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7R7XejP194268
	for <linux-pci@vger.kernel.org>; Mon, 27 Aug 2012 01:33:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7R7XdHk010322
	for <linux-pci@vger.kernel.org>; Mon, 27 Aug 2012 01:33:40 -0600
Date: Mon, 27 Aug 2012 15:33:35 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
Message-ID: <20120827073335.GE20843@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
 <20120816044104.GQ2449@ram-ThinkPad-T61>
 <20120821151245.GA2356@ram-ThinkPad-T61>
 <CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
 <20120822101533.GA2332@ram-ThinkPad-T61>
 <CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
 <CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
 <CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
 <20120823050958.GB2332@ram-ThinkPad-T61>
 <CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 23, 2012 at 12:30:05PM -0700, Yinghai Lu wrote:
> Hi, Ram and Bjorn,
> 
> On Wed, Aug 22, 2012 at 10:09 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> > +static inline int pci_next_resource_idx(int i, int flag)
> > +{
> > +       while (++i < PCI_NUM_RESOURCES) {
> > +               if ((i >= 0 && i < PCI_ROM_RESOURCE && (flag & PCI_STD_RES)) ||
> > +                   (i == PCI_ROM_RESOURCE && (flag & PCI_ROM_RES)) ||
> > +#ifdef CONFIG_PCI_IOV
> > +                   (i <= PCI_IOV_RESOURCE_END && (flag & PCI_IOV_RES)) ||
> > +#endif
> > +                   (i <= PCI_BRIDGE_RESOURCE_END && (flag & PCI_BRIDGE_RES)))
> > +                       return i;
> > +       }
> > +       return -1;
> > +}
> 
> no, you can not merge them.
> when it start as -1, and user only need the bridge resource, it will
> loop from 0 to 16.

True. But the logic by itself is not wrong. It is sub-optimal.

> 
> I optimized it more to skip some searching. please check v5 and v6.
> v5 will store aside the mask, and use the bit map later.
> v6 will still to do the local checking, but will skip some ++i loop.

:) The v5 patch; the bitmask one, took me some time to understand. 
But yes it does a good job. 

There is one thing I dont like in that patch. You have to call to 
pci_dev_resource_n(), but that function is not there anywhere in
upstream tree. Its only in your tree. Can we bring pci_dev_resource_n()
into this patch and make it self-sustained?

Also, please find below, one other patch proposal, which improves upon
your v5 patch. Instead of having a array of bitmask, this patch
maintains a single dimensional array with an entry for each resource.
Each entry captures its type; ie PCI_RES_*,  and index of the starting location 
of the next resource type.  Using this information one can quickly cut down on
the number of useless iterations. It also does compile time
initialization of the array, unlike the v5 patch which does runtime
initialization. 

Please decide which version you want and lets take the next step. I
think we have iterated over this interface quite a lot. Time to move on
:)


---------------------------------------------------------------------
Signed-off-by: Ram Pai <linuxram@us.ibm.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5e1ca3c..d95a31c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -146,6 +146,54 @@ static int __init pcibus_class_init(void)
 }
 postcore_initcall(pcibus_class_init);
 
+
+#define PCI_RES_SHIFT 4
+/*
+ * capture the starting index of the next resource type
+ * as well as the type of the resource
+ */
+int res_idx[PCI_NUM_RESOURCES] = {
+(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES   */
+(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+1 */
+(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+2 */
+(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+3 */
+(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+4 */
+(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+5 */
+(PCI_IOV_RESOURCES << PCI_RES_SHIFT) | PCI_ROM_RES, /* PCI_ROM_RESOURCE */
+(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START */
+(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+1 */
+(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+2 */
+(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+3 */
+(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+4 */
+(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+5 */
+(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START */
+(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+1 */
+(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+2 */
+(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+3 */
+};
+#define res_type(idx)  (res_idx[idx] &  ((0x1 << PCI_RES_SHIFT) - 1))
+#define res_next(idx)  (res_idx[idx] >> PCI_RES_SHIFT)
+
+int pci_next_resource_idx(int i, int flag)
+{
+	i++;
+	while (i < PCI_NUM_RESOURCES) {
+		if (res_type(i) & flag)
+			return i;
+		i = res_next(i);
+	}
+	return -1;
+}
+
+struct resource *pci_dev_resource_n(struct pci_dev *dev, int n)
+{
+	if (n >= 0 && n < PCI_NUM_RESOURCES)
+		return &dev->resource[n];
+
+	return NULL;
+}
+
+
 static u64 pci_size(u64 base, u64 maxbase, u64 mask)
 {
 	u64 size = mask & maxbase;	/* Find the significant bits */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..adae706 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1351,6 +1351,25 @@ static inline int pci_domain_nr(struct pci_bus *bus)
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

