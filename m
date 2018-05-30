Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753604AbeE3R1j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 13:27:39 -0400
Date: Wed, 30 May 2018 12:27:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH INTERNAL 2/3] PCI: iproc: Fix up corrupted PAXC root
 complex config registers
Message-ID: <20180530172733.GN39853@bhelgaas-glaptop.roam.corp.google.com>
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
 <1526577692-21104-3-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526577692-21104-3-git-send-email-ray.jui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 17, 2018 at 10:21:31AM -0700, Ray Jui wrote:
> On certain versions of Broadcom PAXC based root complexes, certain
> regions of the configuration space are corrupted. As a result, it
> prevents the Linux PCIe stack from traversing the linked list of the
> capability registers completely and therefore the root complex is
> not advertised as "PCIe capable". This prevents the correct PCIe RID
> from being parsed in the kernel PCIe stack. A correct RID is required
> for mapping to a stream ID from the SMMU or the device ID from the
> GICv3 ITS
> 
> This patch fixes up the issue by manually populating the related
> PCIe capabilities based on readings from the PCIe capability structure
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pci/quirks.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 47dfea0..0cdbd0a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2198,6 +2198,101 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> +
> +/*
> + * The PCI capabilities list for certain revisions of Broadcom PAXC root
> + * complexes is incorrectly terminated due to corrupted configuration space
> + * registers in the range of 0x50 - 0x5f
> + *
> + * As a result, the capability list becomes broken and prevent standard PCI
> + * stack from being able to traverse to the PCIe capability structure
> + */
> +static void quirk_paxc_pcie_capability(struct pci_dev *pdev)
> +{
> +	int pos, i = 0;
> +	u8 next_cap;
> +	u16 reg16, *cap;
> +	struct pci_cap_saved_state *state;
> +
> +	/* bail out if PCIe capability can be found */
> +	if (pdev->pcie_cap || pci_find_capability(pdev, PCI_CAP_ID_EXP))
> +		return;
> +
> +	/* locate the power management capability */
> +	pos = pci_find_capability(pdev, PCI_CAP_ID_PM);
> +	if (!pos)
> +		return;
> +
> +	/* bail out if the next capability pointer is not 0x50/0x58 */
> +	pci_read_config_byte(pdev, pos + 1, &next_cap);
> +	if (next_cap != 0x50 && next_cap != 0x58)
> +		return;
> +
> +	/* bail out if we do not terminate at 0x50/0x58 */
> +	pos = next_cap;
> +	pci_read_config_byte(pdev, pos + 1, &next_cap);
> +	if (next_cap != 0x00)
> +		return;
> +
> +	/*
> +	 * On these buggy HW, PCIe capability structure is expected to be at
> +	 * 0xac and should terminate the list
> +	 *
> +	 * Borrow the similar logic from theIntel DH895xCC VFs fixup to save
> +	 * the PCIe capability list
> +	 */
> +	pos = 0xac;
> +	pci_read_config_word(pdev, pos, &reg16);
> +	if (reg16 == (0x0000 | PCI_CAP_ID_EXP)) {
> +		u32 status;
> +
> +#ifndef PCI_EXP_SAVE_REGS
> +#define PCI_EXP_SAVE_REGS     7
> +#endif
> +		int size = PCI_EXP_SAVE_REGS * sizeof(u16);
> +
> +		pdev->pcie_cap = pos;
> +		pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
> +		pdev->pcie_flags_reg = reg16;
> +		pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> +		pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;

Is there any way you can fix this in iproc_pcie_config_read() instead,
by making it notice when we're reading a corrupted part of config
space, and then returning the correct data instead?  Is it just the
next capability pointer that's corrupted?

If you could fix it in the config accessor, lspci would automatically
show all the correct data (I think lspci will still show the wrong
data with this patch).

The quirk seems like a maintenance issue because anything that calls

  pci_find_capability(pdev, PCI_CAP_ID_EXP)

will get the wrong answer.

> +
> +		pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
> +		if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status) !=
> +		    PCIBIOS_SUCCESSFUL || (status == 0xffffffff))
> +			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
> +
> +		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
> +			return;
> +
> +		state = kzalloc(sizeof(*state) + size, GFP_KERNEL);
> +		if (!state)
> +			return;
> +
> +		state->cap.cap_nr = PCI_CAP_ID_EXP;
> +		state->cap.cap_extended = 0;
> +		state->cap.size = size;
> +		cap = (u16 *)&state->cap.data[0];
> +		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap[i++]);
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &cap[i++]);
> +		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &cap[i++]);
> +		pcie_capability_read_word(pdev, PCI_EXP_RTCTL,  &cap[i++]);
> +		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap[i++]);
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKCTL2, &cap[i++]);
> +		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL2, &cap[i++]);
> +		hlist_add_head(&state->next, &pdev->saved_cap_space);
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_57810,
> +			quirk_paxc_pcie_capability);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd,
> +			quirk_paxc_pcie_capability);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0,
> +			quirk_paxc_pcie_capability);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802,
> +			quirk_paxc_pcie_capability);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804,
> +			quirk_paxc_pcie_capability);
>  #endif
>  
>  /* Originally in EDAC sources for i82875P:
> -- 
> 2.1.4
> 
