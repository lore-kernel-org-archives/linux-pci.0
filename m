Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:47388 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbEOGUT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 02:20:19 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 15 May 2015 16:20:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4E1482CE804E
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 16:20:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F6K6QB30343252
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 16:20:15 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F6Jg5u017318
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 16:19:42 +1000
Date: Fri, 15 May 2015 16:19:16 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 05/11] powerpc/powernv: create/release eeh_dev for VF
Message-ID: <20150515061916.GA29805@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-6-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431668786-30371-6-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 15, 2015 at 01:46:20PM +0800, Wei Yang wrote:
>EEH on powerpc platform needs eeh_dev structure to track the PCI device
>status. Since VFs are created/released dynamically, VF's eeh_dev is also
>dynamically created/released in system.
>
>This patch creates/removes eeh_dev when pci_dn is created/removed for VFs,
>and marks it with EEH_DEV_VF type.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

After removing the unnecessary line of code as below.

>---
> arch/powerpc/include/asm/eeh.h |    1 +
> arch/powerpc/kernel/eeh.c      |    4 ++++
> arch/powerpc/kernel/pci_dn.c   |   11 +++++++++++
> 3 files changed, 16 insertions(+)
>
>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>index a52db28..1b3614d 100644
>--- a/arch/powerpc/include/asm/eeh.h
>+++ b/arch/powerpc/include/asm/eeh.h
>@@ -138,6 +138,7 @@ struct eeh_dev {
> 	struct pci_controller *phb;	/* Associated PHB		*/
> 	struct pci_dn *pdn;		/* Associated PCI device node	*/
> 	struct pci_dev *pdev;		/* Associated PCI device	*/
>+	struct pci_dev *physfn;		/* Associated PF PORT		*/
> 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
> };
>
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
>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>index f771130..94806a4 100644
>--- a/arch/powerpc/kernel/pci_dn.c
>+++ b/arch/powerpc/kernel/pci_dn.c
>@@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
> struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
> {
> #ifdef CONFIG_PCI_IOV
>+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> 	struct pci_dn *parent, *pdn;
>+	struct eeh_dev *edev;
> 	int i;
>
> 	/* Only support IOV for now */
>@@ -206,6 +208,8 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
> 				 __func__, i);
> 			return NULL;
> 		}
>+		eeh_dev_init(pdn, hose);
>+		edev = pdn_to_eeh_dev(pdn);

Nothing is done to edev after getting it. So I think the last line of changes
here isn't needed. Could you check and remove it if I'm correct?

Thanks,
Gavin

> 	}
> #endif /* CONFIG_PCI_IOV */
>
>@@ -254,10 +258,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
> 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
> 		list_for_each_entry_safe(pdn, tmp,
> 			&parent->child_list, list) {
>+			struct eeh_dev *edev;
> 			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
> 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
> 				continue;
>
>+			edev = pdn_to_eeh_dev(pdn);
>+			if (edev) {
>+				pdn->edev = NULL;
>+				kfree(edev);
>+			}
>+
> 			if (!list_empty(&pdn->list))
> 				list_del(&pdn->list);
>
>-- 
>1.7.9.5
>

