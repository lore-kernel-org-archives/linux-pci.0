Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:42767 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbcDTBNJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 21:13:09 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 20 Apr 2016 11:13:07 +1000
Date: Wed, 20 Apr 2016 11:12:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dja@axtens.net, bhelgaas@google.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 21/45] powerpc/powernv: Create PEs at PCI hot plugging
 time
Message-ID: <20160420011205.GA21871@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-22-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715B12A.6020203@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715B12A.6020203@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 02:16:42PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>Currently, the PEs and their associated resources are assigned
>>in ppc_md.pcibios_fixup() except those used by SRIOV VFs.
>
>But this new code does not affect IOV and VF's PEs will still be created
>somewhere else rather than pnv_pci_setup_bridge()?
>

Correct. VF PEs cannot be created in pnv_pci_setup_bridge() as the PF's
IOV capability isn't enabled at that point.

>
>>The
>>function is called for once after PCI probing and resources
>>assignment is completed. So it isn't hotplug friendly.
>>
>>This creates PEs dynamically by ppc_md.pcibios_setup_bridge(), which
>>is called on the event during system bootup and PCI hotplug: updating
>>PCI bridge's windows after resource assignment/reassignment are done.
>>For partial hotplug case, where not all PCI devices belonging to the
>>PE are unplugged and plugged again, we just need unbinding/binding
>>the affected PCI devices with the corresponding PE without creating
>>new one.
>>
>>As there is no upstream bridge for root bus that needs to be covered
>>by PE, we have to create PE for root bus in ppc_md.pcibios_setup_bridge()
>>before any other PEs can be created, as PE for root bus is the ancestor
>>to anyone else.
>
>We did not need a root bus PE before? What is the other PE reserved for?
>Comments only say "reserved"...
>

No, A PE for root bus is needed before. other PEs can be for the PCI bus
originated from root port and the subordinate domains.
 
>>
>>Also, the windows of root port or the upstream port of PCIe switch behind
>>root port are extended to be PHB's apertures to accommodate the additional
>>resources needed by newly plugged devices based on the fact: hotpluggable
>>slot is behind root port or downstream port of the PCIe switch behind
>>root port. The extension for those PCI brdiges' windows is done in
>>ppc_md.pcibios_setup_bridge() as well.
>
>
>This patch seems to be doing way too many things, hard to follow.
>
>Could you please split the patch into smaller chunks? For example (you can do
>it totally different):
>- move pnv_pci_ioda_setup_opal_tce_kill()
>- move PE creation from pnv_pci_ioda_fixup() to pnv_pci_setup_bridge();
>- add pnv_pci_fixup_bridge_resources()
>- add an extra reserved PE for the root bus (and all this magic with
>root_pe_idx/root_pe_populated)
>- ...
>

I'll evaluate it later. It's always nice to have small patches. Thanks
for the comments.

>
>
>
>-- 
>Alexey
>

