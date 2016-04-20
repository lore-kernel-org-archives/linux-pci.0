Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:49926 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbcDTCPN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 22:15:13 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 20 Apr 2016 12:15:09 +1000
Date: Wed, 20 Apr 2016 12:13:18 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dja@axtens.net, bhelgaas@google.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 30/45] powerpc/pci: Delay populating pdn
Message-ID: <20160420021318.GB28594@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-31-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715EA08.3040901@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715EA08.3040901@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 06:19:20PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>The pdn (struct pci_dn) instances are allocated from memblock or
>>bootmem when creating PCI controller (hoses) in setup_arch(). PCI
>>hotplug, which will be supported by proceeding patches, releases
>>PCI device nodes and their corresponding pdn on unplugging event.
>>The memory chunks for pdn instances allocated from memblock or
>>bootmem are hard to reused after being released.
>>
>>This delays creating pdn by pci_devs_phb_init() from setup_arch()
>>to core_initcall() so that they are allocated from slab. The memory
>>consumed by pdn can be released to system without problem during
>>PCI unplugging time. It indicates that pci_dn is unavailable in
>>setup_arch() and the the fixup on pdn (like AGP's) can't be carried
>>out that time. We have to do that in ppc_md.pcibios_root_bridge_prepare()
>>on maple/pasemi/powermac platforms where/when the pdn is available.
>>
>>At the mean while, the EEH device is created when pdn is populated,
>>meaning pdn and EEH device have same life cycle. In turn, we needn't
>>call eeh_dev_init() to create EEH device explicitly.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>
>Uff. It would not hurt to mention that  pcibios_root_bridge_prepare is called
>from subsys_initcall() which is executed after core_initcall() so the code
>flow does not change.
>

Yes, will do in next revision.

>Have you checked if there is anything in between
>core_initcall(pci_devs_phb_init) and subsys_initcall(pcibios_init) which
>might need device tree nodes? For example, subsys_initcall(pcibios_init)
>calls (eventually) pnv_pci_ioda_fixup(), if we are unlucky and pcibios_init()
>(and therefore pnv_pci_ioda_fixup() or what pseries/others do) is called
>before pcibios_init() - won't we crash or something?
>

I don't catch what you were asking. device-tree nodes (struct device_node)
are always there. This patch doesn't affect them. Perhaps you were talking
about pdn (PCI_DN). If it's the case, this patch delays creating pdn from
setup_arch() to core_initcall(pci_devs_phb_init). I don't see anything need
pdn between setup_arch() and core_initcall().

The changes introduced to powermac/pasemi platforms are: move fixing the child
pdns of the specifiec PHB's pdn from setup_arch() to subsys_initcall(pcibios_init).
I don't see anything between them needs the fixed pdns.

I don't understand how pcibios_init() is called before pcibios_init() in your
context. Sorry for my bad English. Perhaps you're asking the the called sequence
on core_initcall() and subsys_init()? If so, they're defined like below:

#define core_initcall(fn)		__define_initcall(fn, 1)
#define subsys_initcall(fn)		__define_initcall(fn, 4)

>
>-- 
>Alexey
>

