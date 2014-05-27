Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:47673 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbaE0VFX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 17:05:23 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so7922070iec.12
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2014 14:05:22 -0700 (PDT)
Date: Tue, 27 May 2014 15:05:19 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: Re: [PATCH v2 00/13] Refactor pci_is_brdige() to simplify code
Message-ID: <20140527210519.GA11907@google.com>
References: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 04, 2014 at 12:23:35PM +0800, Yijing Wang wrote:
> v1->v2: Add comments for new pci_is_bridge().
> 
> This patchset rename the current pci_is_bridge() to pci_has_subordinate(), 
> and introduce a new pci_is_bridge() which determine pci bridge by check
> dev->hdr_type. The new one is more accurate. PCI Spec define the pci
> device is a bridge by the dev->hdr_type = 0x01 || 0x02.
> 
> There is no guarantee that a PCI bridge must attached a subordinate bus.
> When PCI bridge is created but before the scan child bus, it has no 
> subordinate bus. Also users can remove the pci bus using
> interface pci_remove_bus() in remove.c. 
> 
> So use new pci_is_bridge() check if the PCI device is bridge is better
> choice. If user want check PCI bridge whether has a subordinate bus,
> pci_has_subordinate() is a candidate.
> 
> 
> Yijing Wang (13):
>   PCI: rename pci_is_bridge() to pci_has_subordinate()
>   PCI: Introduce new pci_is_bridge() helper function
>   PCI: Use new pci_is_bridge() to simplify code
>   x86/PCI: Use new pci_is_bridge() to simplify code
>   IA64/PCI: Use new pci_is_bridge() to simplify code
>   powerpc/PCI: Use new pci_is_bridge() to simplify code
>   sparc/PCI: Use new pci_is_bridge() to simplify code
>   PCI, rpaphp: Use new pci_is_bridge() to simplify code
>   PCI, shpchp: Use new pci_is_bridge() to simplify code
>   PCI, cpcihp: Use new pci_is_bridge() to simplify code
>   PCI, acpiphp: Use new pci_is_bridge() to simplify code
>   PCI, pcmcia: Use new pci_is_bridge() to simplify code
>   PCI, pciehp: Use new pci_is_bridge() to simplify code
> 
>  arch/ia64/pci/fixup.c                  |    4 +---
>  arch/powerpc/kernel/pci-hotplug.c      |    3 +--
>  arch/powerpc/kernel/pci_of_scan.c      |    3 +--
>  arch/sparc/kernel/pci.c                |    3 +--
>  arch/x86/pci/fixup.c                   |    4 +---
>  drivers/pci/hotplug/acpiphp_glue.c     |    3 +--
>  drivers/pci/hotplug/cpci_hotplug_pci.c |    3 +--
>  drivers/pci/hotplug/pciehp_pci.c       |    3 +--
>  drivers/pci/hotplug/rpadlpar_core.c    |    3 +--
>  drivers/pci/hotplug/shpchp_pci.c       |    3 +--
>  drivers/pci/pci-acpi.c                 |    8 +-------
>  drivers/pci/pci-driver.c               |    8 ++++----
>  drivers/pci/pci.h                      |    2 +-
>  drivers/pci/probe.c                    |    3 +--
>  drivers/pci/setup-bus.c                |    4 +---
>  drivers/pcmcia/cardbus.c               |    3 +--
>  include/linux/pci.h                    |   13 +++++++++++++
>  17 files changed, 32 insertions(+), 41 deletions(-)

Applied to pci/pci_is_bridge for v3.16, thanks,

Bjorn
