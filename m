Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54305 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2HPELF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 00:11:05 -0400
Received: by vcbfk26 with SMTP id fk26so2076128vcb.19
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 21:11:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120816032602.GN2449@ram-ThinkPad-T61>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
	<CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
	<CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
	<20120816032602.GN2449@ram-ThinkPad-T61>
Date: Wed, 15 Aug 2012 21:11:03 -0700
Message-ID: <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
Subject: Re: [RFC PATCH] methods to access resources of a struct pci_dev
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2012 at 8:26 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Wed, Aug 15, 2012 at 03:25:06PM -0600, Bjorn Helgaas wrote:
>
> I am fine with this approach. I have never encountered the need for 'no'
> based iterator like 'for_each_pci_dev_noiov_resource' or
> 'for_each_pci_dev_base_norom_resource'. While abstracting the code and
> replacing explicit references to the resources in various peices of code
> including the drivers, I just encountered the need for the 'yes' based
> iterators like the one that I added.
>
> However if there is a need for 'no' based iterators, it should be easy
> to incorporate them using flags. Something like
>
> for_each_pci_resource(dev, res, i, flags)
>
> where flags can be
> #define PCI_STD_RES 0x01
> #define PCI_ROM_RES 0x02
> #define PCI_BRIDGE_RES 0x04
> #define PCI_IOV_RES 0x08
> #define PCI_ALL_RES PCI_STD_RES|PCI_ROM_RES|PCI_BRIDGE_RES|PCI_IOV_RES
> #define PCI_NOSTD_RES PCI_ALL_RES&(^PCI_STD_RES)
> #define PCI_NOIOV_RES PCI_ALL_RES&(^PCI_IOV_RES)
> so on and so forth
>
> Yinghai if you are ok with this approach, let me code up all the
> iterators. You can incorporate your patches based on those iterators and
> I can change all my 40+ patches that change various driver sources to
> use this iterator.

Do you mean that you will have updated patch for
http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=cd192f0ed93203ef6bac2a44c138899190fb5793
?

if it is that case, i am ok, and then I could use scripts to update
following patches.

>From cd192f0ed93203ef6bac2a44c138899190fb5793 Mon Sep 17 00:00:00 2001
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 26 Jun 2012 17:02:04 -0700
Subject: [PATCH] PCI: Add for_each_resource helpers to make resource loop
 easier.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/pci.h |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77778cb..dd577e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,61 @@ struct pci_dev {

 struct resource *pci_dev_resource_n(struct pci_dev *dev, int n);

+#define resno_is_for_bridge(n)						\
+	((n) >= PCI_BRIDGE_RESOURCES && (n) <= PCI_BRIDGE_RESOURCE_END)
+
+/* all (include bridge) resources */
+#define for_each_pci_dev_all_resource(dev, res, i)			\
+	for (i = 0;							\
+	     (res = pci_dev_resource_n(dev, i)) || i < PCI_NUM_RESOURCES; \
+	     i++)
+/* exclude bridge resources */
+#define for_each_pci_dev_nobridge_resource(dev, res, i)			\
+	for (i = 0;							\
+	     (res = pci_dev_resource_n(dev, i)) || i < PCI_NUM_RESOURCES; \
+	     i = (i != (PCI_BRIDGE_RESOURCES - 1)) ? (i+1) : PCI_NUM_RESOURCES)
+/* exclude bridge and IOV resources */
+#define for_each_pci_dev_base_resource(dev, res, i)			\
+	for (i = 0;							\
+	     (res = pci_dev_resource_n(dev, i)) || i < PCI_NUM_RESOURCES; \
+	     i = (i != PCI_ROM_RESOURCE) ? (i+1) : PCI_NUM_RESOURCES)
+/* exclude ROM and bridge and IOV resources */
+#define for_each_pci_dev_base_norom_resource(dev, res, i)		\
+	for (i = 0;							\
+	     (res = pci_dev_resource_n(dev, i)) || i < PCI_NUM_RESOURCES; \
+	     i = (i != (PCI_ROM_RESOURCE-1)) ? (i+1) : PCI_NUM_RESOURCES)
+/* exclude ROM and bridge resources */
+#define for_each_pci_dev_base_iov_norom_resource(dev, res, i)		\
+	for (i = 0;							\
+	     (res = pci_dev_resource_n(dev, i)) || i < PCI_NUM_RESOURCES; \
+	     i = (i != (PCI_ROM_RESOURCE-1) && i !=
(PCI_BRIDGE_RESOURCES-1)) ? (i+1) : \
+	           ((i == PCI_ROM_RESOURCE-1) ? (PCI_ROM_RESOURCE+1) :
PCI_NUM_RESOURCES))
+/* exclude IOV resources */
+#define for_each_pci_dev_noiov_resource(dev, res, i)			\
+	for (i = 0;							\
+	     (res = pci_dev_resource_n(dev, i)) || i < PCI_NUM_RESOURCES; \
+	     i = (i != PCI_ROM_RESOURCE) ? (i+1) : PCI_BRIDGE_RESOURCES)
+/* only std resources */
+#define for_each_pci_dev_std_resource(dev, res, i)			\
+	for (i = PCI_STD_RESOURCES;					\
+	   (res = pci_dev_resource_n(dev, i)) && i < (PCI_STD_RESOURCE_END+1); \
+	     i++)
+/* only IOV resources */
+#define for_each_pci_dev_iov_resource(dev, res, i)			\
+	for (i = PCI_IOV_RESOURCES;					\
+	   (res = pci_dev_resource_n(dev, i)) && i < (PCI_IOV_RESOURCE_END+1); \
+	     i++)
+/* only bridge resources */
+#define for_each_pci_dev_bridge_resource(dev, res, i)			\
+	for (i = PCI_BRIDGE_RESOURCES;					\
+	(res = pci_dev_resource_n(dev, i)) && i < (PCI_BRIDGE_RESOURCE_END+1); \
+	     i++)
+/* only addon resources */
+#define for_each_pci_dev_addon_resource(dev, res, i)			\
+	for (i = PCI_NUM_RESOURCES;					\
+	     (res = pci_dev_resource_n(dev, i));			\
+	     i++)
+
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
-- 


Actually that for-pci-for-each-res-addon branch depends on
other branches like
   for-pci-res-alloc
   for-pci-root-bus-hotplug
   for-pci-busn-alloc
   for-pci-next

I'd like to have busn-alloc and root-bus-hotplug setting down into
pci-next tree at first.
Hope we can get result in this pci min-summit 8/27.

Thanks

Yinghai
