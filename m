Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbdJRWdw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Oct 2017 18:33:52 -0400
Date: Wed, 18 Oct 2017 17:33:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: hch@lst.de, linux-pci@vger.kernel.org, stable@vger.kernel.org,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V4 1/2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port
 service drivers
Message-ID: <20171018223346.GC6332@bhelgaas-glaptop.roam.corp.google.com>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
 <1507719178-112556-2-git-send-email-liudongdong3@huawei.com>
 <20171017202505.GN5641@bhelgaas-glaptop.roam.corp.google.com>
 <b793f1b5-cf6d-dc52-09d8-0be6d58a72ab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b793f1b5-cf6d-dc52-09d8-0be6d58a72ab@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 06:50:05PM +0800, Dongdong Liu wrote:
> Hi Bjorn
> 在 2017/10/18 4:25, Bjorn Helgaas 写道:
> >On Wed, Oct 11, 2017 at 06:52:57PM +0800, Dongdong Liu wrote:
> >>After removing and adding back the PCI root port device,
> >>we see the PCIe port service drivers request irq failed.
> >>pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
> >>aer: probe of 0000:00:00.0:pcie002 failed with error -22
> >>pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
> >>PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> >>pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
> >>pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
> >>dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
> >>dpc: probe of 0000:00:00.0:pcie010 failed with error -22
> >>
> >>The current code basically does this:
> >>
> >>  - allocate 32 vectors
> >>  - figure out vector used by PME and hotplug
> >>  - figure out vector used by AER
> >>  - figure out vector used by DPC
> >>  - free the 32 vectors we allocated
> >>  - allocate only as many vectors as we need
> >>
> >>but it is broken as calling pci_free_irq_vectors()
> >>invalidates the IRQ numbers returned before by pci_irq_vectors();
> >>
> >>The hardware works:
> >>  - PME and hotplug use the Interrupt Message Number from the PCIe
> >>    Capability register.
> >>
> >>  - AER uses the AER Interrupt Message Number from the AER Root Error
> >>    Status register.
> >>
> >>  - DPC uses the DPC Interrupt Message Number from the DPC Capability
> >>    register.
> >>
> >>  - FRS (not supported by Linux yet) uses the FRS Interrupt Message
> >>    Number from the FRS Queuing Capability register.
> >>
> >>  - That's a total of 4 possible MSI/MSI-X vectors used for PME,
> >>    hotplug, AER, DPC, and FRS, so there's no point in trying to
> >>    allocate more than 4 vectors (we currently start with 32).
> >>
> >>  - All these Interrupt Message Numbers are read-only to software but
> >>    are updated by hardware when software writes the Multiple Message
> >>    Enable field of the MSI Message Control register.  Thanks for
> >>    pointing this out; I didn't realize this before.
> >>
> >>  - Therefore, we must read the Interrupt Message Numbers *after* we
> >>    write Multiple Message Enable.
> >>
> >>Since we can use at most 4 vectors, this patch is to optimize the
> >>interrupt vector allocation strategy in pcie_port_enable_irq_vec().
> >>First figure out how many vectors we need,allocate them, and then fill
> >>in the slots in the irqs[] table.
> >>
> >>Cc: <stable@vger.kernel.org>
> >>Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()")
> >>Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> >>Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >>Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >
> >Thanks a lot for all your work on this.  This was a confusing issue
> >with code to match.  I tried to simplify the changelog as below;
> >please correct anything I messed up.
> >
> >A few hopefully last questions:
> >
> >  - Your subject suggested that this was a bug for both MSI and MSI-X,
> >    but I think it only affected MSI, because the spec says MSI-X
> >    Interrupt Message Numbers must remain constant.  What do you
> >    think?
> 
> Yes, for a given MSI-X implementation, the entry must remain constant.
> But in fact, the bug PCIe port service drivers request irq failed does
> not relate with this. As we said in PATCH V2,
> The current code does:
> 
>   pci_alloc_irq_vectors(dev, ...)
>   irqs[x] = pci_irq_vector(dev, entry)
>   pci_free_irq_vectors(dev)
>   pci_alloc_irq_vectors(dev, ...)
> 
> The problem is that the second pci_alloc_irq_vectors() call gets different
> vectors than the first one. For MSI-X, It maybe also have such bug.

OK, I'm not sure I understand yet how this works with MSI-X, but I
suspect the current patch still breaks MSI-X.  Let me see if I can
make sense of what happens when the root port supports MSI-X:

  - The MSI-X Table Size (in Message Control) is fixed; this field is
    read-only in hardware.

  - When MSI-X is enabled, the Interrupt Message Numbers for PME/HP,
    AER, DPC, etc., are fixed, contain an MSI-X Table index, and must
    be less than 32.

  - pci_alloc_irq_vectors(3) will allocate 3 MSI-X vectors (0-2).
    There's no reason to assume the Interrupt Message Numbers (which
    can be 0-31) will be in that range.

Here's the flow through this path for MSI-X with the current patch
applied, with all services enabled.  You can see that in
msix_setup_entries(), we'll allocate 3 entries and they will use
indexes 0-2 in the MSI-X table.  The Interrupt Message Numbers index
that table, and they can be in the range 0-31.

  pcie_init_service_irqs
    pcie_port_enable_irq_vec
      nvec = 3            # PME/HP, AER, DPC
      pci_alloc_irq_vectors(..., 1, 3, PCI_IRQ_MSIX | PCI_IRQ_MSI)
        pci_alloc_irq_vectors_affinity(..., 1, 3, PCI_IRQ_MSIX | PCI_IRQ_MSI)
          __pci_enable_msix_range(entries==NULL, 1, 3)
            __pci_enable_msix(entries==NULL, nvec=3)
              msix_capability_init(entries==NULL, nvec=3)
                base = msix_map_region(dev, msix_table_size(control))
                msix_setup_entries(base, entries==NULL, nvec=3)
                  for (i = 0; i < nvec; i++)
                    entry = alloc_msi_entry()
                    entry->msi_attrib.entry_nr = i  # <-- MSI-X table index
                    entry->mask_base = base         # MSI-X table base
                msix_program_entries
                  for_each_pci_msi_entry()
                    writel(PCI_MSIX_ENTRY_CTRL_MASKBIT,
                           pci_msix_desc_addr(entry) + 
                           PCI_MSIX_ENTRY_VECTOR_CTRL)

        nr_entries = 3    # returned from pci_alloc_irq_vectors()
        # read message numbers:
        entry = <PME/HP, AER, or DPC message number>
        # assume entry == 4
        if (entry > nr_entries)
          goto out_free_irqs   # we should take this error path

I would expect pcie_port_enable_irq_vec() to fail on many root ports
with MSI-X, because one of PME/HP, AER, DPC may use an Interrupt
Message Number greater than 3.

The previous code (before this patch) first allocates 32 MSI-X
vectors, then reads all the Interrupt Message Numbers, then allocates
just enough MSI-X vectors so all the message numbers are valid table
indexes.

In the current patch, we don't know the message numbers until after
we've already enabled MSI-X with some number of vectors.

So for MSI, we have the constraint that we have to enable MSI before
reading the Message Numbers.  For MSI-X, we can't know how many
vectors to request until after we read the Message Numbers.  I wonder
if we need to split these two paths?

> >  - I think the problem was probably exposed by a1d5f18cafe6
> >    ("PCI/portdrv: Support multiple interrupts for MSI as well as
> >    MSI-X"), not 3674cc49da9a, because prior to a1d5f18cafe6, we only
> >    used a single MSI vector, and we didn't do the "allocate vectors,
> >    see which ones were used, reallocate only the required number of
> >    vectors" dance.
> 
> Yes, 3674cc49da9a, for MSI, it should be work ok as it just use used a
> single MSI vector(not get the irq and free and alloc irq agian as MSI-X).
> But for MSI-X, I think it maybe still have a bug.
> >
> >    It looks like we only allocated a single vector, so all the
> >    Interrupt Message Numbers should have been zero.  Or did you
> >    actually bisect it to 3674cc49da9a?
> 
> I think 3674cc49da9a is beeter as a1d5f18cafe6 maybe still have the bug for MSI-X.
> a1d5f18cafe6 PCI/portdrv: Support multiple interrupts for MSI as well as MSI-X
> 3674cc49da9a PCI/portdrv: Use pci_irq_alloc_vectors().
> 
> >
> >Bjorn
> >
> >
> >commit e402a536cf7122cda6b3bef420de36c22d2907e6
> >Author: Dongdong Liu <liudongdong3@huawei.com>
> >Date:   Wed Oct 11 18:52:57 2017 +0800
> >
> >    PCI/portdrv: Fix MSI multiple interrupt setup
> >
> >    When removing and adding back a PCIe Root Port device that uses MSI (not
> >    MSI-X), the port service driver IRQ request fails:
> >
> >      pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
> >      aer: probe of 0000:00:00.0:pcie002 failed with error -22
> >      pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> >      pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
> >      pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
> >      dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
> >      dpc: probe of 0000:00:00.0:pcie010 failed with error -22
> >
> >    The previous code basically did this:
> >
> >      - Write MSI Multiple Message Enable to enable 32 vectors
> >      - Read Interrupt Message Numbers for PME & hotplug, AER, and DPC
> >      - Rewrite MSI Multiple Message Enable to enable only as many vectors as
> >        we think we need
> >      - Assume the Interrupt Message Numbers are still valid
> >
> >    The problem is that when we change the Multiple Message Enable field to
> >    what we think is the minimal number of vectors required, the hardware may
> >    change which vectors it uses.  See the "Interrupt Message Number"
> >    discussion in PCIe r3.1, sec 7.8.2 (PME & hotplug), 7.10.10 (AER), 7.31.2
> >    (DPC).
> >
> >    Read the Interrupt Message Numbers *after* we write the Multiple Message
> >    Enable field so we use the correct IRQ vectors.
> >
> >    Note that we can't predict how hardware will select Interrupt Message
> >    Numbers, so even if we allocate as many vectors as there are interrupt
> >    sources, the hardware may still select Message Numbers that result in
> >    sharing a vector.  E.g., on HiSilicon hip08, if we have 3 sources
> >    (PME/hotplug, AER, DPC) and 4 MSI vectors, hardware selects Message
> >    Numbers 0 for PME/hotplug and 2 for AER and DPC.  That leaves vectors 1
> >    and 3 unused, while AER and DPC share vector 2.
> >
> >    Even though MSI-X doesn't have the issue with Interrupt Message Numbers
> >    changing, this patch may result in more IRQ sharing because we no longer
> >    read those Message Numbers and use them to determine how many MSI-X vectors
> >    to request.
> >
> >    Fixes: a1d5f18cafe6 ("PCI/portdrv: Support multiple interrupts for MSI as well as MSI-X")
> >    Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> >    Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >    [bhelgaas: changelog]
> >    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >    Cc: stable@vger.kernel.org      # v4.13+
> >
> 
> The commit message looks good to me.
> I think Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()") is better as
> it still has a bug for MSI-X.
> 
> Thanks,
> Dongdong
> >.
> >
> 
