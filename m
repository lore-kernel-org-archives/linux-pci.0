Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbeISEaa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 00:30:30 -0400
Date: Tue, 18 Sep 2018 17:55:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        David Yang <mmyangfl@gmail.com>
Subject: Re: [PATCH v2 0/8] PCI hotplug diet
Message-ID: <20180918225539.GI13616@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1536341821.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1536341821.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 08, 2018 at 09:59:01AM +0200, Lukas Wunner wrote:
> Rebase of my PCI hotplug material for the next merge window on current
> pci/hotplug branch:
> 
> * Patch [1/8] makes pciehp work with broken hardware which hardwires
>   Presence Detect to zero.  Originally submitted August 24 in response
>   to a user report:
>   https://patchwork.ozlabs.org/patch/961860/
> 
> * Patches [2/8] to [8/8] contain cleanups and code reduction.
>   Originally submitted August 19:
>   https://patchwork.ozlabs.org/project/linux-pci/list/?series=61434&state=*
> 
> 
> Changes since v1:
> 
> * Separate struct unification from renaming of struct members in
>   patches [2/8] and [3/8]. (Sinan Kaya)
> 
> * Do not change unsigned int to bool in patch [4/8] per commit
>   d729593e492e ("checkpatch: add a --strict test for structs with
>   bool member definitions").  For the same reason use unsigned int
>   instead of bool in patch [6/8] for newly added latch_status and
>   adapter_status members in cpci_hotplug.h.
> 
> * Add all collected Acked-by and Reviewed-by tags.
> 
> 
> Lukas Wunner (8):
>   PCI: pciehp: Tolerate Presence Detect hardwired to zero
>   PCI: pciehp: Unify controller and slot structs
>   PCI: pciehp: Rename controller struct members for clarity
>   PCI: pciehp: Reshuffle controller struct for clarity
>   PCI: hotplug: Constify hotplug_slot_ops
>   PCI: hotplug: Drop hotplug_slot_info
>   PCI: hotplug: Embed hotplug_slot
>   PCI: hotplug: Document TODOs

This is fantastic, thank you very much!

Applied (with updated [2/8] "PCI: pciehp: Unify controller and slot
structs" from [1]) to pci/hotplug for v4.20.

[1] https://lkml.kernel.org/r/20180918194617.x7ab5kilj4ipghuv@wunner.de
