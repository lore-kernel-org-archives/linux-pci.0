Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:51201 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab3LGFLc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 00:11:32 -0500
MIME-Version: 1.0
In-Reply-To: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
Date: Sat, 7 Dec 2013 13:11:31 +0800
Message-ID: <CABawtvObh1_6usvtFL8==s49t5zMwnj312HeFiSX6mrNsXOSiw@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai,
    Does this workaround have any known side effect to 'other'
platform ?  for example, some old platforms don't have such buggy
chipset/FPPA logic.  have you tested it on those hotplug capable box ?
    If the issue is caused by commit
2debd9289997fc5d1c0043b41201a8b40d5e11d0, should we revert it
first ?
    And if the workaround is specific to any vendor's platform, could
we introduce a method of only workaround the specific vendor id /
device id instead of  patching generic code ?


Thanks,
Ethan

On Sat, Dec 7, 2013 at 4:22 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> During hotplug test on platform, found slot status register does not
> report present status correctly. That present bit does not get cleared
> even after that card is removed.
>
> That problem is caused by commit:
> | commit 2debd9289997fc5d1c0043b41201a8b40d5e11d0
> |
> |    PCI: pciehp: Disable/enable link during slot power off/on
>
> It looks like chipset bug, that PresDet bit is "OR" operation between
> sideband input from FPGA, and chipset inband detection from pcie link.
> It does not like if we disable pcie link at first and power off
> other side device, and it has input from inband detection
> always 1.
>
> Workaround: Try turn on link a while after power off.
>
> After this patch, PresDet report correct status when removing or adding
> card later.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Cc: <stable@vger.kernel.org> 3.4+
>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> @@ -637,6 +637,15 @@ int pciehp_power_off_slot(struct slot *
>         }
>         ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>                  pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
> +
> +       /*
> +        * Enable link for a while so chipset could settle down
> +        * inband presence detection logic
> +        */
> +       pciehp_link_enable(ctrl);
> +       msleep(20);
> +       pciehp_link_disable(ctrl);
> +
>         return 0;
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
