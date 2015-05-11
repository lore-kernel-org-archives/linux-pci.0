Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:50401 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbEKCt7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 May 2015 22:49:59 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 11 May 2015 12:49:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 307482BB0052
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 12:49:55 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4B2nkR617236222
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 12:49:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4B2nMu1024404
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 12:49:22 +1000
Date: Mon, 11 May 2015 12:48:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 6/9] powerpc/powernv: create/release eeh_dev for VF
Message-ID: <20150511024856.GB8816@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430723258-21299-7-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 04, 2015 at 03:07:35PM +0800, Wei Yang wrote:

Please order this patch and PATCH[5] because EEH device is expected to
be created before EEH PE.

>EEH on powerpc platform needs eeh_dev structure to track the pci device
                                                              ^^^
							      PCI

>status. Since VFs are created/released dynamically, VF's eeh_dev is also
>dynamically created/released in system.
>
>This patch creates/removes eeh_dev when pci_dn is created/removed for VFs,
>and marks it with EEH_DEV_VF type.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/include/asm/eeh.h |    7 +++++++
> arch/powerpc/kernel/eeh.c      |    4 ++++
> arch/powerpc/kernel/eeh_dev.c  |   20 ++++++++++++++++++++
> arch/powerpc/kernel/pci_dn.c   |    7 +++++++
> 4 files changed, 38 insertions(+)
>
>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>index 56e8cd9..2067de4 100644
>--- a/arch/powerpc/include/asm/eeh.h
>+++ b/arch/powerpc/include/asm/eeh.h
>@@ -124,6 +124,7 @@ static inline bool eeh_pe_passed(struct eeh_pe *pe)
> #define EEH_DEV_NO_HANDLER	(1 << 8)	/* No error handler	*/
> #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
> #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
>+#define EEH_DEV_VF		(1 << 11)	/* VF port		*/
>

Why you need this flag? I guess "edev->physfn" can be used to distinguish
it's a normal or VF eeh_dev.

> struct eeh_dev {
> 	int mode;			/* EEH mode			*/
>@@ -139,6 +140,9 @@ struct eeh_dev {
> 	struct pci_controller *phb;	/* Associated PHB		*/
> 	struct pci_dn *pdn;		/* Associated PCI device node	*/
> 	struct pci_dev *pdev;		/* Associated PCI device	*/
>+#ifdef CONFIG_PCI_IOV
>+	struct pci_dev *physfn;		/* Associated PF PORT		*/
>+#endif /* CONFIG_PCI_IOV */
> 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
> };
>
>@@ -273,6 +277,7 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe);
> struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
>
> void *eeh_dev_init(struct pci_dn *pdn, void *data);
>+void eeh_dev_remove(struct pci_dn *pdn);
> void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
> int eeh_init(void);
> int __init eeh_ops_register(struct eeh_ops *ops);
>@@ -328,6 +333,8 @@ static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
> 	return NULL;
> }
>
>+void eeh_dev_remove(struct pci_dn *pdn) { }
>+
> static inline void eeh_dev_phb_init_dynamic(struct pci_controller *phb) { }
>
> static inline int eeh_check_failure(const volatile void __iomem *token)
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 6c7ce1b..221e280 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -1135,6 +1135,10 @@ void eeh_add_device_late(struct pci_dev *dev)
> 	}
>
> 	edev->pdev = dev;
>+#ifdef CONFIG_PCI_IOV
>+	if (dev->is_virtfn)
>+		edev->physfn = dev->physfn;
>+#endif
> 	dev->dev.archdata.edev = edev;
>
> 	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
>diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
>index aabba94..ab88e61 100644
>--- a/arch/powerpc/kernel/eeh_dev.c
>+++ b/arch/powerpc/kernel/eeh_dev.c
>@@ -72,6 +72,26 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
> }
>
> /**
>+ * eeh_dev_remove - Release EEH device according to OF node
>+ * @pdn: PCI device node
>+ */
>+void eeh_dev_remove(struct pci_dn *pdn)
>+{
>+	struct eeh_dev *edev;
>+
>+	if (!pdn)
>+		return;
>+
>+	edev = pdn_to_eeh_dev(pdn);
>+	if(!edev)
>+		return;
>+

You don't have to have the check "if (!pdn)" here because edev should
be NULL if pdn is NULL, which is covered by pdn_to_eeh_dev().

	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);

	if (!edev)
		return;

>+	eeh_rmv_from_parent_pe(edev);
>+	kfree(edev);
>+	pdn->edev = NULL;
>+}
>+

[A]

The function itself isn't correct enough. When VF's pci_dev is released,
eeh_remove_device(), detaching eeh_dev from parent PE and destroying EEH
address cache, should be called. The function isn't complete and you don't
have to detach eeh_dev from parent PE again.

>+/**
>  * eeh_dev_phb_init_dynamic - Create EEH devices for devices included in PHB
>  * @phb: PHB
>  *
>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>index bf0fb873..a35f865 100644
>--- a/arch/powerpc/kernel/pci_dn.c
>+++ b/arch/powerpc/kernel/pci_dn.c
>@@ -179,7 +179,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
> struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
> {
> #ifdef CONFIG_PCI_IOV
>+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> 	struct pci_dn *parent, *pdn;
>+	struct eeh_dev *edev;
> 	int i;
>
> 	/* Only support IOV for now */
>@@ -205,6 +207,9 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
> 				 __func__, i);
> 			return NULL;
> 		}
>+		eeh_dev_init(pdn, hose);
>+		edev = pdn_to_eeh_dev(pdn);
>+		edev->mode |= EEH_DEV_VF;
> 	}
> #endif /* CONFIG_PCI_IOV */
>
>@@ -257,6 +262,8 @@ void remove_dev_pci_data(struct pci_dev *pdev)
> 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
> 				continue;
>
>+			eeh_dev_remove(pdn);
>+

Remove the function in [A] and you just need:

	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);

	if (edev) {
		pdn->edev = NULL;
		kfree(edev);
	}

> 			if (!list_empty(&pdn->list))
> 				list_del(&pdn->list);
>
>-- 
>1.7.9.5
>

