Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:53268 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbbEOIy0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 04:54:26 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 15 May 2015 18:54:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id CB66B357804C
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 18:54:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F8sDuu32178180
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 18:54:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F8rmwx009393
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 18:53:49 +1000
Date: Fri, 15 May 2015 16:53:30 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 05/11] powerpc/powernv: create/release eeh_dev for VF
Message-ID: <20150515085330.GA26681@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150515061916.GA29805@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150515061916.GA29805@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 15, 2015 at 04:19:16PM +1000, Gavin Shan wrote:
>On Fri, May 15, 2015 at 01:46:20PM +0800, Wei Yang wrote:
>>EEH on powerpc platform needs eeh_dev structure to track the PCI device
>>status. Since VFs are created/released dynamically, VF's eeh_dev is also
>>dynamically created/released in system.
>>
>>This patch creates/removes eeh_dev when pci_dn is created/removed for VFs,
>>and marks it with EEH_DEV_VF type.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>After removing the unnecessary line of code as below.
>
>>---
>> arch/powerpc/include/asm/eeh.h |    1 +
>> arch/powerpc/kernel/eeh.c      |    4 ++++
>> arch/powerpc/kernel/pci_dn.c   |   11 +++++++++++
>> 3 files changed, 16 insertions(+)
>>
>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>index a52db28..1b3614d 100644
>>--- a/arch/powerpc/include/asm/eeh.h
>>+++ b/arch/powerpc/include/asm/eeh.h
>>@@ -138,6 +138,7 @@ struct eeh_dev {
>> 	struct pci_controller *phb;	/* Associated PHB		*/
>> 	struct pci_dn *pdn;		/* Associated PCI device node	*/
>> 	struct pci_dev *pdev;		/* Associated PCI device	*/
>>+	struct pci_dev *physfn;		/* Associated PF PORT		*/
>> 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
>> };
>>
>>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>index 6c7ce1b..221e280 100644
>>--- a/arch/powerpc/kernel/eeh.c
>>+++ b/arch/powerpc/kernel/eeh.c
>>@@ -1135,6 +1135,10 @@ void eeh_add_device_late(struct pci_dev *dev)
>> 	}
>>
>> 	edev->pdev = dev;
>>+#ifdef CONFIG_PCI_IOV
>>+	if (dev->is_virtfn)
>>+		edev->physfn = dev->physfn;
>>+#endif
>> 	dev->dev.archdata.edev = edev;
>>
>> 	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
>>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>index f771130..94806a4 100644
>>--- a/arch/powerpc/kernel/pci_dn.c
>>+++ b/arch/powerpc/kernel/pci_dn.c
>>@@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>> struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>> {
>> #ifdef CONFIG_PCI_IOV
>>+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>> 	struct pci_dn *parent, *pdn;
>>+	struct eeh_dev *edev;
>> 	int i;
>>
>> 	/* Only support IOV for now */
>>@@ -206,6 +208,8 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>> 				 __func__, i);
>> 			return NULL;
>> 		}
>>+		eeh_dev_init(pdn, hose);
>>+		edev = pdn_to_eeh_dev(pdn);
>
>Nothing is done to edev after getting it. So I think the last line of changes
>here isn't needed. Could you check and remove it if I'm correct?

You are right, removed.

>
>Thanks,
>Gavin
>
>> 	}
>> #endif /* CONFIG_PCI_IOV */
>>
>>@@ -254,10 +258,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
>> 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>> 		list_for_each_entry_safe(pdn, tmp,
>> 			&parent->child_list, list) {
>>+			struct eeh_dev *edev;
>> 			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
>> 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
>> 				continue;
>>
>>+			edev = pdn_to_eeh_dev(pdn);
>>+			if (edev) {
>>+				pdn->edev = NULL;
>>+				kfree(edev);
>>+			}
>>+
>> 			if (!list_empty(&pdn->list))
>> 				list_del(&pdn->list);
>>
>>-- 
>>1.7.9.5
>>

-- 
Richard Yang
Help you, Help me

