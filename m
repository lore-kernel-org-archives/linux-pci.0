Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D23CE096;
	Wed,  5 Aug 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950323; cv=none; b=mHH/avdEN0lo5WpmucrFAwA2R5G0WqTO/tjRyXFg8gdwYAFGFNIyG9u5WNFP0NomG2yJ9nDOBz5pfww8f6rYRt90JOoyikOF+lDs96dtZ0qa/qBmrvWuCWWWQ04ypDXLPASirfg76BRHA5+yAuWNatLET+yNzKqFSvJ4BjwhE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950323; c=relaxed/simple;
	bh=ZYas7iAbegBnESMCIuQtfTs6Dk0qFddxJOEQxCcG8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PThW/sKWSMRr9S6LMPAqA+L+cu8hYeErhpk5t8qQxqOy3qnuw6nF3mHcAdQrxRRCEBhFy5nzmC49L/JwexJvaxTTdpIp7JHh0e5zvZYihQym8GEI0sr6hsEl3ooqrx8tNF6afg/+SPtREWQNTioJY69JbamvfKkaRgdIf5MklW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/HuuOGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/HuuOGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C71F000E9;
	Wed,  5 Aug 2026 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785950321;
	bh=cS+1OPt43LY9PVcLmNXnPTuZJ4WgQujUCM/knEjl0HU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=N/HuuOGdJ4jfuVsLPVIvPkgZ2xNnrprRB7r/nUGJooGCbWrE139e6SSrx7FR0hjRI
	 +TyBc/fziElSkTuwBIQAVqWtVWSFfwAcdYNOi3cJjZv8O6rbCo2qlNMk63qoF5/wk5
	 kuZWcKDDZ932oqPNnVIJ+HdWY6q2GH3ORzcRGbgpxJc6OsqQTQgTp6+UQfiw0a8KpW
	 fRMjh+lGP77i/eMjTki89xfFrULwI18IME78CpglYlx2twmiBE640OTeGkyE+XGHs7
	 lu3yg5x/qAc7tkFFRUugrtpqqTt9jvM9chRi8C/NK+tbdlisXGkYjQrMrjYN9XQEGn
	 ogQhEdgpLFOFQ==
Date: Wed, 5 Aug 2026 12:18:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Avinash Roy <avinash@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
	npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: Re: [PATCH] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
Message-ID: <20260805171840.GA2126423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805125132.941270-1-avinash@linux.ibm.com>

On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
> reset method for reliable EEH recovery on pSeries/ppc64 platforms.
> 
> FLR alone is insufficient because it does not re-initialize the Spyre
> firmware state machine. On ppc64 with EEH enabled,
> pcibios_set_pcie_reset_state() is overridden in
> arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
> EEH PE operations, which is the correct mechanism for full device
> recovery after an EEH event.

This makes it sound like this mechanism is needed for EEH recovery for
*all* devices, not just Spyre.  If that's the case it sounds like we
need more than just a Spyre-specific quirk.

> The reset function is placed in arch/powerpc/platforms/pseries/pci.c
> where the EEH infrastructure is already present, declared in
> pseries.h, and registered in the generic pci_dev_reset_methods[] table
> in drivers/pci/quirks.c under a CONFIG_PPC_PSERIES guard.
> 
> This reset method is only registered when CONFIG_PPC_PSERIES is enabled, 
> so it is not available on other platforms.
> 
> Reset sequence:
>   - Assert PERST# via pcie_warm_reset, hold 250 ms
>   - Deassert PERST# via pcie_deassert_reset
>   - Wait 250 ms for PCIe link retrain and device recovery
> 
> Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 84e4ffe957a8..7aa58d57208f 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/string.h>
> +#include <linux/delay.h>
>  
>  #include <asm/eeh.h>
>  #include <asm/pci-bridge.h>
> @@ -236,6 +237,41 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
>  			 fixup_winbond_82c105);
>  
> +/*
> + * Reset Spyre adapter using pci_set_pcie_reset_state()
> + * This is specifically for PPC platforms where EEH (Enhanced Error Handling)
> + * requires this reset method for proper device recovery.
> + */
> +int reset_spyre(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (probe)
> +		return 0;
> +
> +	/* Assert warm reset */
> +	ret = pci_set_pcie_reset_state(dev, pcie_warm_reset);
> +	if (ret) {
> +		pci_err(dev, "Failed to assert reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for reset to take effect */
> +	msleep(250);
> +
> +	/* Deassert reset */
> +	ret = pci_set_pcie_reset_state(dev, pcie_deassert_reset);
> +	if (ret) {
> +		pci_err(dev, "Failed to deassert reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for device to recover */
> +	msleep(250);
> +
> +	return 0;
> +}
> +
>  static enum pci_bus_speed prop_to_pci_speed(u32 prop)
>  {
>  	switch (prop) {
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 3968a6970fa8..79c194aeb3c6 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -92,6 +92,10 @@ extern struct pci_controller_ops pseries_pci_controller_ops;
>  int pseries_msi_allocate_domains(struct pci_controller *phb);
>  void pseries_msi_free_domains(struct pci_controller *phb);
>  
> +/* PCI device reset method for Spyre adapter */
> +struct pci_dev;
> +int reset_spyre(struct pci_dev *dev, bool probe);
> +
>  extern int CMO_PrPSP;
>  extern int CMO_SecPSP;
>  extern unsigned long CMO_PageSize;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..1b8ab5d9764b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4237,6 +4237,11 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PPC_PSERIES
> +/* Defined in arch/powerpc/platforms/pseries/pci.c */
> +int reset_spyre(struct pci_dev *dev, bool probe);
> +#endif
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4252,6 +4257,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +#ifdef CONFIG_PPC_PSERIES
> +	{ PCI_VENDOR_ID_IBM, 0x06a7,
> +		reset_spyre},
> +#endif
>  	{ 0 }
>  };
