Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752495AbeAWUiE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 15:38:04 -0500
Date: Tue, 23 Jan 2018 14:38:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Assume NoCompl+ for Thunderbolt ports
Message-ID: <20180123203802.GB92112@bhelgaas-glaptop.roam.corp.google.com>
References: <a1332c590cfb8dc8cf8e9ff61af694299f14eccd.1516203379.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1332c590cfb8dc8cf8e9ff61af694299f14eccd.1516203379.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 17, 2018 at 04:48:39PM +0100, Lukas Wunner wrote:
> Certain Thunderbolt 1 controllers claim to support Command Completed events
> (value of 0b in the No Command Completed Support field of the Slot
> Capabilities register) but in reality neither set the Command Completed bit
> in the Slot Status register nor signal a Command Completed interrupt:
> 
> 8086:1513  CV82524  [Light Ridge 4C  2010]
> 8086:151a  DSL2310  [Eagle Ridge 2C  2011]
> 8086:151b  CVL2510  [Light Peak 2C   2010]
> 8086:1547  DSL3510  [Cactus Ridge 4C 2012]
> 8086:1548  DSL3310  [Cactus Ridge 2C 2012]
> 8086:1549  DSL2210  [Port Ridge 1C   2011]
> 
> All newer chips (Redwood Ridge and onwards) set the bit correctly to 1b.
> 
> The user-visible impact is that after unplugging such a device, 2 seconds
> elapse until pciehp is unbound.  That's because on ->remove,
> pcie_write_cmd() is called via pcie_disable_notification() and every call
> to pcie_write_cmd() takes 2 seconds (1 second for each invocation of
> pcie_wait_cmd()):
> 
> [  337.942727] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x1038 (issued 21176 msec ago)
> [  340.014735] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x0000 (issued 2072 msec ago)
> 
> That by itself has always been unpleasant, but the situation has become
> worse with commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services
> during shutdown"):  Now pciehp is unbound on ->shutdown.  Because
> Thunderbolt controllers typically have 4 hotplug ports, every reboot and
> shutdown is now delayed by 8 seconds, plus another 2 seconds for every
> attached Thunderbolt 1 device.
> 
> Thunderbolt hotplug slots are not physical slots that one inserts cards
> into, but rather logical hotplug slots implemented in silicon.  Devices
> appear beyond those logical slots once a PCI tunnel is established on top
> of the Thunderbolt Converged I/O switch.  One would expect commands written
> to the Slot Control register to be executed immediately by the silicon,
> so for simplicity we always assume NoCompl+ for Thunderbolt ports.
> 
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org # v4.12+
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Yehezkel Bernat <yehezkel.bernat@intel.com>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: Andreas Noever <andreas.noever@gmail.com>

Applied to pci/hotplug for v4.16, thanks!

> ---
> Changes since v1:
> - Rephrase code comment for clarity. (Bjorn)
> - Amend commit message with info provided by Mika.
> - Adhere to "Make Bjorn's life easier" guide.
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7bab0606f1a9..a89d8b990228 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -848,6 +848,13 @@ struct controller *pcie_init(struct pcie_device *dev)
>  	if (pdev->hotplug_user_indicators)
>  		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
>  
> +	/*
> +	 * We assume no Thunderbolt controllers support Command Complete events,
> +	 * but some controllers falsely claim they do.
> +	 */
> +	if (pdev->is_thunderbolt)
> +		slot_cap |= PCI_EXP_SLTCAP_NCCS;
> +
>  	ctrl->slot_cap = slot_cap;
>  	mutex_init(&ctrl->ctrl_lock);
>  	init_waitqueue_head(&ctrl->queue);
> -- 
> 2.15.1
> 
