Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:59661 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbbBDXoq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 18:44:46 -0500
Received: by mail-oi0-f41.google.com with SMTP id z81so3964701oif.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Feb 2015 15:44:45 -0800 (PST)
Date: Wed, 4 Feb 2015 17:44:42 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 00/17] Enable SRIOV on Power8
Message-ID: <20150204234442.GC20072@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 15, 2015 at 10:27:50AM +0800, Wei Yang wrote:
> This patchset enables the SRIOV on POWER8.
> 
> The gerneral idea is put each VF into one individual PE and allocate required
> resources like MMIO/DMA/MSI. The major difficulty comes from the MMIO
> allocation and adjustment for PF's IOV BAR.
> 
> On P8, we use M64BT to cover a PF's IOV BAR, which could make an individual VF
> sit in its own PE. This gives more flexiblity, while at the mean time it
> brings on some restrictions on the PF's IOV BAR size and alignment.
> 
> To achieve this effect, we need to do some hack on pci devices's resources.
> 1. Expand the IOV BAR properly.
>    Done by pnv_pci_ioda_fixup_iov_resources().
> 2. Shift the IOV BAR properly.
>    Done by pnv_pci_vf_resource_shift().
> 3. IOV BAR alignment is calculated by arch dependent function instead of an
>    individual VF BAR size.
>    Done by pnv_pcibios_sriov_resource_alignment().
> 4. Take the IOV BAR alignment into consideration in the sizing and assigning.
>    This is achieved by commit: "PCI: Take additional IOV BAR alignment in
>    sizing and assigning"

I was hoping to merge this during the v3.20 merge window, but that will
likely open next week, and none of these patches have been in linux-next at
all yet, so I think next week would be rushing it a bit.  

Most of the changes are in arch/powerpc, which does help, but there are
some changes in pci/setup-bus.c that I would like to have some runtime on.
The changes aren't extensive, but I don't understand that code well enough
to be comfortable based on just reading the patch.

I pushed the current state of this patchset to my pci/virtualization
branch.  I think the best way forward would be for you to start with that
branch, since I've made quite a few tweaks to the patches you posted to the
list.  Then you can post a v12 with any changes you make for the next
round.

Ben, I know you chimed in earlier to help explain PEs.  Are you or another
powerpc maintainer planning to ack all this?

Bjorn
