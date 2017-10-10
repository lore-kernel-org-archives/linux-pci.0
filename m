Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754810AbdJJVdd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Oct 2017 17:33:33 -0400
Date: Tue, 10 Oct 2017 16:32:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: hch@lst.de, linux-pci@vger.kernel.org, stable@vger.kernel.org,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V3] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service
 drivers
Message-ID: <20171010213259.GZ25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1507553167-27833-1-git-send-email-liudongdong3@huawei.com>
 <20171009233029.GA6094@bhelgaas-glaptop.roam.corp.google.com>
 <b25f980f-bafb-527d-ac8a-1849739df380@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b25f980f-bafb-527d-ac8a-1849739df380@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[BTW, can you please wrap your responses so they fit in 70 columns, so
they fit in an 80-column window even if they're quoted in responses?]

On Tue, Oct 10, 2017 at 08:13:53PM +0800, Dongdong Liu wrote:
> Hi Bjorn
> 
> Many thanks for your review.
> 
> 在 2017/10/10 7:30, Bjorn Helgaas 写道:
> >On Mon, Oct 09, 2017 at 08:46:07PM +0800, Dongdong Liu wrote:
> >>Current code is broken as calling pci_free_irq_vectors()
> >>invalidates the IRQ numbers returned before by pci_irq_vectors();
> >>so we need to move all the assignment of the Linux IRQ numbers at
> >>the bottom of the function.
> >>
> >>After removing and adding back the PCI root port device,
> >>we see the PCIe port service drivers request irq failed.
> >>
> >>pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
> >>aer: probe of 0000:00:00.0:pcie002 failed with error -22
> >>pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
> >>PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> >>pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
> >>pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
> >>dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
> >>dpc: probe of 0000:00:00.0:pcie010 failed with error -22
> >
> >Here's my understanding of how the hardware works:
> >
> >  - PME and hotplug use the Interrupt Message Number from the PCIe
> >    Capability register.
> >
> >  - AER uses the AER Interrupt Message Number from the AER Root Error
> >    Status register.
> >
> >  - DPC uses the DPC Interrupt Message Number from the DPC Capability
> >    register.
> >
> >  - FRS (not supported by Linux yet) uses the FRS Interrupt Message
> >    Number from the FRS Queuing Capability register.
> >
> >  - That's a total of 4 possible MSI/MSI-X vectors used for PME,
> >    hotplug, AER, DPC, and FRS, so there's no point in trying to
> >    allocate more than 4 vectors (we currently start with 32).
> >
> >  - All these Interrupt Message Numbers are read-only to software but
> >    are updated by hardware when software writes the Multiple Message
> >    Enable field of the MSI Message Control register.  Thanks for
> >    pointing this out; I didn't realize this before.
> >
> >  - Therefore, we must read the Interrupt Message Numbers *after* we
> >    write Multiple Message Enable.
> 
> Yes, thanks for explaining this, very clear.
> 
> >
> >The patch below contains this sequence:
> >
> >  pci_alloc_irq_vectors(32)
> >    ...
> >     write Multiple Message Enable   <-- Interrupt Message Numbers change
> >  idx[x] = PME/hotplug Interrupt Message Number
> >  idx[y] = AER Interrupt Message Number
> >  idx[z] = DPC Interrupt Message Number
> >  pci_free_irq_vectors()
> >  pci_alloc_irq_vectors()
> >    ...
> >     write Multiple Message Enable   <-- Interrupt Message Numbers change
> >  for (i = 0; ...)
> >    irqs[i] = pci_irq_vector(idx[i])
> >
> >This incorrectly assumes the Interrupt Message Numbers remain the same
> >after we write Multiple Message Enable.
> 
> Here should be the same, as the second pci_alloc_irq_vectors() allocate only as many vectors as we need.

Let me see if I understand this: You're assuming that if we write the
maximum possible value to Multiple Message Enable, read the Interrupt
Message Numbers, then write a different value (but at least large
enough to accomodate the largest Interrupt Message Number) to Multiple
Message Enable, we don't need to read the Interrupt Message Numbers
again because they "shouldn't have changed."

It's *likely* that they won't change, but I don't think we can be
sure: the hardware is entitled to randomize those Interrupt Message
Numbers when we write Multiple Message Enable.

I don't like to write code that assumes things not required by the
spec.  That makes it harder to match up the code with the spec and
there's always the possibility that we'll assume something different
than the hardware designer did.

> >Since we can use at most 4 vectors, I'm not sure it's worth trying to
> >optimize this too much, but it seems like we could do this:
> >
> >  nvec = 0;
> >  if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP))
> >    nvec++;
> >  if (mask & PCIE_PORT_SERVICE_AER)
> >    nvec++;
> >  if (mask & PCIE_PORT_SERVICE_DPC)
> >    nvec++;
> >
> >  pci_alloc_irq_vectors(dev, 1, nvec, PCI_IRQ_MSIX | PCI_IRQ_MSI);
> >
> >  if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
> >    pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
> >    pme_msg = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
> >    if (mask & PCIE_PORT_SERVICE_PME)
> >      irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme_msg);
> >    if (mask & PCIE_PORT_SERVICE_HP)
> >      irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme_msg);
> >  }
> >
> >  if (mask & PCIE_PORT_SERVICE_AER) {
> >    pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_ROOT_STATUS, &reg32);
> >    aer_msg = reg32 >> 27;
> >    irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer_msg);
> >  }
> >
> >  if (mask & PCIE_PORT_SERVICE_DPC) {
> >    pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
> >    pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
> >    dpc_msg = reg16 & 0x1f;
> >    irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc_msg);
> >  }
> 
> 
> The above code is different from current patch in below case.
> HP/PME --- vector 0
> AER --- vector 2
> DPC--- vector 6
> Sure, this case is not common.
> Current patch still works ok on such case.
> But above code , DPC maybe not work as we expect.
> It maybe still work ok, but the vector is not 6.
> So how about we accept the patch firstly, then we can add a separate patch if we still think it is worth.

If I understand correctly, your patch will set Multiple Message Enable
to 0x3 (0b011) to allocate 8 vectors, and we assume vectors 0, 2, and
6 will be used and the other 5 vectors unused.

Whereas my approach would allocate 4 vectors, and we don't actually
know what the hardware would do in that case.  We might guess that
HP/PME and AER would still be on vectors 0 and 2, but it might put DPC
on any of 0, 1, 2, or 3.

I guess I just feel like the algorithm of "set a trial value of
Multiple Message Enable, read the Interrupt Message Numbers to see
what hardware did, then set a real value of Multiple Message Enable"
is a little hacky.

It feels like we're trying to compensate for laziness on the part of
the hardware by guessing what it might do.  If hardware wants to avoid
interrupt sharing, it can certainly pick vector numbers spread out
through the MME space.  If it doesn't want to go to the effort, well,
I guess we can live with sharing.

Bjorn
