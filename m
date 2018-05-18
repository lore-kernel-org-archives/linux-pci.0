Return-Path: <SRS0=dr+E=IF=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=dr+E=IF=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 18 May 2018 14:49:46 +0530
From: poza@codeaurora.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH INTERNAL 2/3] PCI: iproc: Fix up corrupted PAXC root
 complex config registers
In-Reply-To: <1526577692-21104-3-git-send-email-ray.jui@broadcom.com>
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
 <1526577692-21104-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <e9ab14238c88540f65be015482f3c189@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-17 22:51, Ray Jui wrote:
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
>  drivers/pci/quirks.c | 95 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 47dfea0..0cdbd0a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2198,6 +2198,101 @@
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0,
> quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, 
> quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, 
> quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, 
> quirk_paxc_bridge);
> +
> +/*
> + * The PCI capabilities list for certain revisions of Broadcom PAXC 
> root
> + * complexes is incorrectly terminated due to corrupted configuration 
> space
> + * registers in the range of 0x50 - 0x5f
> + *
> + * As a result, the capability list becomes broken and prevent 
> standard PCI
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
:%s /theIntel /Intel
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
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 
> PCI_DEVICE_ID_NX2_57810,
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
