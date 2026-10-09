Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4C4E8DFB;
	Fri,  9 Oct 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559694; cv=none; b=O6CSUd19gHgzS3cR899BBS6rE80/UWqfMY060JFe2cYcH3QfjwJVfWtHoBhQhNKL4D0n4uMCRa3oeGuci13/u5Gmd1BC9FgzKgda8vaLwyc66qnquT5ka0SwWegYfKDKA8LQN7aT3Rymt4skD0YiIfmDsf5tJzVDrLkP7WSJ+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559694; c=relaxed/simple;
	bh=UMgR9dCHcN4iVzNNM85msr5wtoaf9Nzv7D6wEWjvOhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lNVrgjMv6mHjZk/30/ECkB86pWtNrO8APszglFVmLsHmqQ8yy59qNmWTsIU4cBwsjV69VGaXScVqgHI6r8djwjCWKYyvuQ5cA8UXUvM3zcecYettsjsdtfApGd3aDnKO96RKI1lIVVRh8IUV5tPDcH/++X90t7bSEt/6PGSdKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP9T9/2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP9T9/2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A309A1F000FF;
	Fri,  9 Oct 2026 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559684;
	bh=IiS1UvmOMWNqNjEpqtlrQxFdLJAgjIxDH8wds6VmHdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QP9T9/2y5bUFVqiIG9z/gf01T9noOv3mU/SGs2umbpBDYnQR2beitZJzKdRklZRN3
	 8vmgGx5NeFzzOAFOMXR/HNevFimKpVZbs4orTCXPXAwPG2TI16Sazjp7Sqo7nFh+tt
	 bADiFscufd+CQalNenQ/3/fLjKNlctJAv8e+DwboJVcvAeovxv7g+DbJo5lH3IYz3s
	 G6U17Na71nisZJIDD63krlHPo8WcWclnIlSKPROlZntmfmIe6BUGgKPtqtrISIdoPH
	 MEybWQ+fO95yE0U9paQyNgKhLC1iZxV48n7E6rN26O/2T2BUCb1XKTbWJkz2LV7p0a
	 zA16RkUj6ThgQ==
Date: Fri, 9 Oct 2026 10:28:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Avinash Roy <avinash@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
	npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: Re: [PATCH v2] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
Message-ID: <20261009152803.GA975637@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821123401.1375297-1-avinash@linux.ibm.com>

On Fri, Aug 21, 2026 at 06:04:01PM +0530, Avinash Roy wrote:
> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
> reset method for reliable EEH recovery on pSeries/ppc64 platforms.

It sounds like if you plugged a Spyre into an x86/arm64/etc platform,
it would still need a dedicated warm reset quirk because the issue is
with Spyre, not with pSeries.

> FLR alone is insufficient because it does not re-initialize firmware
> state machine for the current version of the card. The existing API
> pci_set_pcie_reset_state() is used to drive the platform-level
> PERST# using the EEH interfaces by adding a device specific quirk.
> 
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
>   - Wait 250 ms for PCIe link retrain 	
> 
> Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> ---
> Changelog
> v1: https://lore.kernel.org/linux-pci/20260805125100.1-1-avinash.roy1@linux.ibm.com/
> 
>    Reworded the commit message to highlight the warm reset requirement being
>    a need of the current card and not a platform deficiency.
> 
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

This comment still suggests that the issue is related to the platform,
not the adapter itself.  I know reset_spyre() will only *work* on
pSeries because pcibios_set_pcie_reset_state() is only implemented
there.

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

Given that we need these ifdefs anyway, I think it would be simpler to
just include the reset_spyre() implementation here.  It doesn't look
like it needs anything pSeries-specific, since
pci_set_pcie_reset_state() is already available.

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
