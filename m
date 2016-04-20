Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:40675 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbcDTB07 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 21:26:59 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 20 Apr 2016 11:26:56 +1000
Date: Wed, 20 Apr 2016 11:25:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dja@axtens.net, bhelgaas@google.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 28/45] powerpc/pci: Introduce
 pci_remove_device_node_info()
Message-ID: <20160420012523.GA24704@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-29-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715C6AA.2060606@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715C6AA.2060606@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 03:48:26PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>This implements and exports pci_remove_device_node_info(). It's
>>used to remove the pdn (struct pci_dn) for the indicated device
>>node. The function is going to be used by PowerNV PCI hotplug
>>driver.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Kind of strange that there is no such helper for pseries, is there?
>

I don't find one actually. If you find one, pls let me know, thanks!

>
>Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>
>>---
>>  arch/powerpc/include/asm/pci-bridge.h |  1 +
>>  arch/powerpc/kernel/pci_dn.c          | 23 +++++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index 72a9d4e..c6310e2 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -240,6 +240,7 @@ extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
>>  extern void remove_dev_pci_data(struct pci_dev *pdev);
>>  extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>>  					       struct device_node *dn);
>>+extern void pci_remove_device_node_info(struct device_node *dn);
>>
>>  static inline int pci_device_from_OF_node(struct device_node *np,
>>  					  u8 *bus, u8 *devfn)
>>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>index 0a249ff..ce10281 100644
>>--- a/arch/powerpc/kernel/pci_dn.c
>>+++ b/arch/powerpc/kernel/pci_dn.c
>>@@ -331,6 +331,29 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_add_device_node_info);
>>
>>+void pci_remove_device_node_info(struct device_node *dn)
>>+{
>>+	struct pci_dn *pdn = dn ? PCI_DN(dn) : NULL;
>>+#ifdef CONFIG_EEH
>>+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>+
>>+	if (edev)
>>+		edev->pdn = NULL;
>>+#endif
>>+
>>+	if (!pdn)
>>+		return;
>>+
>>+	WARN_ON(!list_empty(&pdn->child_list));
>>+	list_del(&pdn->list);
>>+	if (pdn->parent)
>>+		of_node_put(pdn->parent->node);
>>+
>>+	dn->data = NULL;
>>+	kfree(pdn);
>>+}
>>+EXPORT_SYMBOL_GPL(pci_remove_device_node_info);
>>+
>>  /*
>>   * Traverse a device tree stopping each PCI device in the tree.
>>   * This is done depth first.  As each node is processed, a "pre"
>>
>
>
>-- 
>Alexey
>

