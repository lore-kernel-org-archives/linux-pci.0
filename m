Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9F34D4D6;
	Thu, 23 Jul 2026 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840057; cv=none; b=L6Saa4utuzlkbFPy2CZM9pUMOLBEPdNdPUBoM02HXfnniF21eNgPxJhm85r6y7ZjDoSKB05DmcEoogVU5FhoztfH4UxaL7Zv63eDcIJqIqub8wgbJsdqK2PN3BYWOJzaUvSChis81/cR+bZ3AuAjH73+l4D/JFMeyYvRp1+gs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840057; c=relaxed/simple;
	bh=pI8aqobKzz0iWHWAJbvjLHXVHMcfqkP/hwuo+2ixbEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Sl1wP4abfbCeatgsURqT/EdLxj+3liaeC5jTlpM24XmRNXcmo587me4BUE5+UikEVA35Uqm0jaEbElweCk8AwzxrijwKkx4LVxKRTsj+rL9RDo6MKgWFsC6+/4flFaQUa35i1UzNiR9xzmlIVdOqamKY2cddD9JhwKBs5WVn+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRrHoaTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRrHoaTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD201F000E9;
	Thu, 23 Jul 2026 20:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784840055;
	bh=QNxF/LKObWlFqOnkUewRFESeaZ8PQQj5RvuT5SMLnMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HRrHoaTcQxpwdjDBwnwcoPY1WKeerifDXNPK1avXT9j6RsTCNIya3BWLxep9fmo9J
	 kFUQP4yj0VUsHCVWR64UCFQw1yPOKz9s4mHHATWC0PUQlGwCeFl46qdfFWLwbXj1n3
	 iJ/wDqpCbgDvPVc2CvOd8gRqDbKN+vW6GW6ZEha+OpwkWH6+miHtkK0a0fMNiIdyi3
	 vQH7BYPUx9FNbE3olaHhdsE0aJ8YhFSOfeKlyoigpyD1nDAbiXXplgwO+NxBrLzyTo
	 7J+NzKQoBweH2shOWJLv0O5obyIEQbyNmQ2sZ/hVnE8Nbcosym2GDgjFa/wHdB+vIG
	 rwTGqtC/qj4ZA==
Date: Thu, 23 Jul 2026 15:54:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, JC Chen <jc_chen@diodes.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR
 erratum
Message-ID: <20260723205413.GA852929@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723161010.2638956-1-nirmoyd@nvidia.com>

[+cc Ilpo, this sounds really weird from a resource perspective]

On Thu, Jul 23, 2026 at 09:10:00AM -0700, Nirmoy Das wrote:
> The Pericom PI7C9X3G606GPC PCIe switch has an erratum where downstream
> Port 4 retains a default MSI-X table and PBA decode when BAR 0 is zero.
> Memory reads that match this window are dropped with an Unsupported
> Request completion, which may cause the SoC to report a timeout.

Help me understand what's going on here.  Can you share the dmesg log
of enumeration and resource assignment and the "lspci -v" output for
the whole switch (both upstream and downstream ports) without this
patch?

I guess without this patch, MSI-X from the downstream port doesn't
work correctly?

> The workaround is to make Port 4 BAR 0 mirror BAR 0 of the immediate
> upstream port. Firmware may establish this at boot, but PCI resource
> assignment can move upstream BAR 0 without updating Port 4.

By "mirror", I guess you mean you want the same value in BAR 0 of both
the switch upstream port and the downstream port?  I don't know what
that even means, because the upstream port BAR 0 can't be inside its
memory window, so reads should never reach the downstream port.

> For a 64-bit BAR, also mirror BAR 1 while memory decoding is disabled,
> matching the PCI core update sequence. Port 4 BAR 0 may read back as zero
> after a successful write, so do not use readback to validate the update.
> 
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>  drivers/pci/quirks.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..fa8098d77adb5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6264,6 +6264,98 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
>  			 pci_fixup_pericom_acs_store_forward);
>  
> +#define PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC 0xc008
> +
> +/*
> + * Pericom PI7C9X3G606GPC switch erratum E15 -
> + * Downstream Port 4 BAR 0 must mirror the immediate upstream port BAR 0
> + *
> + * Port 4 uses BAR 0 for its MSI-X table and PBA. Firmware may program this
> + * mirror at boot, but Linux resource assignment can move the upstream BAR
> + * and leave Port 4 with a stale mirror.
> + *
> + * Diodes confirmed Tile0/P4 appears to Linux as device 4, function 0 on the
> + * bus below the upstream port. Match that downstream function and re-apply
> + * the mirror after resource assignment and early resume.
> + */
> +static void pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror(struct pci_dev *pdev)
> +{
> +	struct pci_dev *upstream;
> +	bool bar0_64, disable_mem;
> +	u16 cmd = 0;
> +	u32 bar = 0, bar1 = 0, upstream_bar = 0, upstream_bar1 = 0;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
> +		return;
> +
> +	if (PCI_SLOT(pdev->devfn) != 4 || PCI_FUNC(pdev->devfn))
> +		return;
> +
> +	upstream = pci_upstream_bridge(pdev);
> +	if (!upstream || upstream->vendor != PCI_VENDOR_ID_PERICOM ||
> +	    upstream->device != PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC ||
> +	    pci_pcie_type(upstream) != PCI_EXP_TYPE_UPSTREAM)
> +		return;
> +
> +	pci_read_config_dword(upstream, PCI_BASE_ADDRESS_0, &upstream_bar);
> +	if (upstream_bar & PCI_BASE_ADDRESS_SPACE_IO)
> +		return;
> +
> +	bar0_64 = (upstream_bar & PCI_BASE_ADDRESS_MEM_TYPE_MASK) ==
> +		  PCI_BASE_ADDRESS_MEM_TYPE_64;
> +	if (bar0_64)
> +		pci_read_config_dword(upstream, PCI_BASE_ADDRESS_1,
> +				      &upstream_bar1);
> +
> +	if (!(upstream_bar & PCI_BASE_ADDRESS_MEM_MASK) &&
> +	    (!bar0_64 || !upstream_bar1)) {
> +		pci_warn(pdev, "skipping PI7C9X3G606GPC BAR 0 mirror workaround because upstream BAR 0 is unassigned\n");
> +		return;
> +	}
> +
> +	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar);
> +	if (bar0_64) {
> +		pci_read_config_dword(pdev, PCI_BASE_ADDRESS_1, &bar1);
> +		if (bar == upstream_bar && bar1 == upstream_bar1)
> +			return;
> +	} else {
> +		if (bar == upstream_bar)
> +			return;
> +	}
> +
> +	/*
> +	 * Port 4 BAR 0 may read back as zero even after a successful write.
> +	 * If BAR 0 is configured as 64-bit, BAR 1 is the upper half.
> +	 * Disable memory decoding while updating both dwords, matching PCI
> +	 * core's 64-bit BAR update sequence.
> +	 */
> +	disable_mem = bar0_64 && !pdev->mmio_always_on;
> +	if (disable_mem) {
> +		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +		pci_write_config_word(pdev, PCI_COMMAND,
> +				      cmd & ~PCI_COMMAND_MEMORY);
> +	}
> +
> +	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, upstream_bar);
> +	if (bar0_64)
> +		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_1, upstream_bar1);
> +	if (disable_mem)
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	if (bar0_64)
> +		pci_info(pdev, "wrote upstream BAR 0/1 %#x/%#x to Port 4 BAR 0/1 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
> +			 upstream_bar, upstream_bar1);
> +	else
> +		pci_info(pdev, "wrote upstream BAR 0 %#x to Port 4 BAR 0 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
> +			 upstream_bar);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM,
> +			PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
> +			pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_PERICOM,
> +			       PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
> +			       pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
> +
>  static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  {
>  	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> -- 
> 2.43.0
> 
