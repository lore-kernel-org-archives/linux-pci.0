Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934623AbdJQUZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 16:25:07 -0400
Date: Tue, 17 Oct 2017 15:25:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: hch@lst.de, linux-pci@vger.kernel.org, stable@vger.kernel.org,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V4 1/2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port
 service drivers
Message-ID: <20171017202505.GN5641@bhelgaas-glaptop.roam.corp.google.com>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
 <1507719178-112556-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507719178-112556-2-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 06:52:57PM +0800, Dongdong Liu wrote:
> After removing and adding back the PCI root port device,
> we see the PCIe port service drivers request irq failed.
> pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
> aer: probe of 0000:00:00.0:pcie002 failed with error -22
> pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
> PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
> pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
> dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
> dpc: probe of 0000:00:00.0:pcie010 failed with error -22
> 
> The current code basically does this:
> 
>   - allocate 32 vectors
>   - figure out vector used by PME and hotplug
>   - figure out vector used by AER
>   - figure out vector used by DPC
>   - free the 32 vectors we allocated
>   - allocate only as many vectors as we need
> 
> but it is broken as calling pci_free_irq_vectors()
> invalidates the IRQ numbers returned before by pci_irq_vectors();
> 
> The hardware works:
>   - PME and hotplug use the Interrupt Message Number from the PCIe
>     Capability register.
> 
>   - AER uses the AER Interrupt Message Number from the AER Root Error
>     Status register.
> 
>   - DPC uses the DPC Interrupt Message Number from the DPC Capability
>     register.
> 
>   - FRS (not supported by Linux yet) uses the FRS Interrupt Message
>     Number from the FRS Queuing Capability register.
> 
>   - That's a total of 4 possible MSI/MSI-X vectors used for PME,
>     hotplug, AER, DPC, and FRS, so there's no point in trying to
>     allocate more than 4 vectors (we currently start with 32).
> 
>   - All these Interrupt Message Numbers are read-only to software but
>     are updated by hardware when software writes the Multiple Message
>     Enable field of the MSI Message Control register.  Thanks for
>     pointing this out; I didn't realize this before.
> 
>   - Therefore, we must read the Interrupt Message Numbers *after* we
>     write Multiple Message Enable.
> 
> Since we can use at most 4 vectors, this patch is to optimize the
> interrupt vector allocation strategy in pcie_port_enable_irq_vec().
> First figure out how many vectors we need,allocate them, and then fill
> in the slots in the irqs[] table.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()")
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Thanks a lot for all your work on this.  This was a confusing issue
with code to match.  I tried to simplify the changelog as below;
please correct anything I messed up.

A few hopefully last questions:

  - Your subject suggested that this was a bug for both MSI and MSI-X,
    but I think it only affected MSI, because the spec says MSI-X
    Interrupt Message Numbers must remain constant.  What do you
    think?

  - I think the problem was probably exposed by a1d5f18cafe6
    ("PCI/portdrv: Support multiple interrupts for MSI as well as
    MSI-X"), not 3674cc49da9a, because prior to a1d5f18cafe6, we only
    used a single MSI vector, and we didn't do the "allocate vectors,
    see which ones were used, reallocate only the required number of
    vectors" dance.
    
    It looks like we only allocated a single vector, so all the
    Interrupt Message Numbers should have been zero.  Or did you
    actually bisect it to 3674cc49da9a?

Bjorn


commit e402a536cf7122cda6b3bef420de36c22d2907e6
Author: Dongdong Liu <liudongdong3@huawei.com>
Date:   Wed Oct 11 18:52:57 2017 +0800

    PCI/portdrv: Fix MSI multiple interrupt setup
    
    When removing and adding back a PCIe Root Port device that uses MSI (not
    MSI-X), the port service driver IRQ request fails:
    
      pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
      aer: probe of 0000:00:00.0:pcie002 failed with error -22
      pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
      pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
      pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
      dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
      dpc: probe of 0000:00:00.0:pcie010 failed with error -22
    
    The previous code basically did this:
    
      - Write MSI Multiple Message Enable to enable 32 vectors
      - Read Interrupt Message Numbers for PME & hotplug, AER, and DPC
      - Rewrite MSI Multiple Message Enable to enable only as many vectors as
        we think we need
      - Assume the Interrupt Message Numbers are still valid
    
    The problem is that when we change the Multiple Message Enable field to
    what we think is the minimal number of vectors required, the hardware may
    change which vectors it uses.  See the "Interrupt Message Number"
    discussion in PCIe r3.1, sec 7.8.2 (PME & hotplug), 7.10.10 (AER), 7.31.2
    (DPC).
    
    Read the Interrupt Message Numbers *after* we write the Multiple Message
    Enable field so we use the correct IRQ vectors.
    
    Note that we can't predict how hardware will select Interrupt Message
    Numbers, so even if we allocate as many vectors as there are interrupt
    sources, the hardware may still select Message Numbers that result in
    sharing a vector.  E.g., on HiSilicon hip08, if we have 3 sources
    (PME/hotplug, AER, DPC) and 4 MSI vectors, hardware selects Message
    Numbers 0 for PME/hotplug and 2 for AER and DPC.  That leaves vectors 1
    and 3 unused, while AER and DPC share vector 2.
    
    Even though MSI-X doesn't have the issue with Interrupt Message Numbers
    changing, this patch may result in more IRQ sharing because we no longer
    read those Message Numbers and use them to determine how many MSI-X vectors
    to request.
    
    Fixes: a1d5f18cafe6 ("PCI/portdrv: Support multiple interrupts for MSI as well as MSI-X")
    Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org      # v4.13+
