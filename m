Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91E189F30;
	Fri, 20 Feb 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625468; cv=none; b=KotyyBOucbFrh53EzfqmrSarjRPxaseyrqNeM/dwq/NMvZsu4QSKvXkWnvKvfAIZVAzuzFJB85s7bJeuI5oZBiC47eZYal/BKhZVFiKGJ0C6ky1xJW++R9/W98vmoxNJDtWl0PoKizviGvQZENcmivdBST2RIlphMRegSSv7oQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625468; c=relaxed/simple;
	bh=7fXBV0KHj0jjKhrWhkCzl7mJgqHere6H1M/QpsdFeTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cXlB4Nzxf0Xs6eRTIa0F63upfak6Vo9Q6scSTvzSoU/ZNM16WCFoDXy23anPkgyJG/Tkf0BucTcMwW8NUbgFGjDD5vP1926z1g0R7ZbB38HFzfY7iwx62tXl/lNnY1YIHANiiXZo8pH67TwP49WmN4vnmr4dvFOq8BdrpI5O/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmb6QD76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmb6QD76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9023AC19423;
	Fri, 20 Feb 2026 22:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771625467;
	bh=7fXBV0KHj0jjKhrWhkCzl7mJgqHere6H1M/QpsdFeTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nmb6QD76wsft0pwtCp9gzaT4xG5tKzassjsoD37lRfNaLM7tqTFIAhE0otzpw6HNA
	 WdhTH+8xtrAouDsDpuW7e5VCExJKoFli5xn/G2vMpOhE7jaLvJzWIOKlrAcIpNdY6S
	 2peb21ySTUQgUS/NlE0zUSCJt2JMpBU/hBstOuwIpXnaQrWtllQ2Ci8HrJB86cTdmF
	 2mdM1kiL+jUXMGBU0HR70d+1zLuxTSFRwl2UlOVm3dsta8mulvR/0Yd0ojNETAXyfW
	 Xxkdso3pTlYeK8UCr3UN5XkGr5FNt4bsmcYI0NRgcPiASuCdqAYdv0q0Ch/OwREoeH
	 9FpiJ+vL30tAQ==
Date: Fri, 20 Feb 2026 16:11:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build
 time
Message-ID: <20260220221106.GA3552425@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928194651.5393-2-james.quinlan@broadcom.com>

[+cc Hans, Niklas]

On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> The Kconfig is modified so that the pcie_bus_config setting can be done at
> build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> pci_bus_config setting may still be overridden by the bootline param.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
strategy"), which appeared in v5.10.

In retrospect, I think this might have been a mistake because it
forces a build-time configuration for something that may not be known
at build time and can be set via command-line parameter.

But I can't find any discussion about it.  Did you have a use case
where command line parameters weren't usable?

If there's a platform that requires one of these settings, maybe
there's a way to do that programmatically in the host bridge driver
rather than using a Kconfig symbol.

> ---
>  drivers/pci/Kconfig | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c   | 12 ++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 4bef5c2bae9f..15ce948858fb 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -187,6 +187,62 @@ config PCI_HYPERV
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
>  
> +choice
> +	prompt "PCIE default bus config setting"
> +	default PCIE_BUS_DEFAULT
> +	depends on PCI
> +	help
> +	  One of the following choices will set the pci_bus_config at
> +	  compile time.  The choices offered are the same as those offered
> +	  for the bootline parameter 'pci'; i.e. 'pci=pcie_bus_tune_off',
> +	  'pci=pcie_bus_safe', 'pci=pcie_bus_perf', and 'pci=pcie_bus_peer2peer'.
> +	  This is a compile-time setting and is still be overridden by the
> +	  above bootline parameters, if present.  If unsure, chose PCIE_BUS_DEFAULT.
> +
> +config PCIE_BUS_TUNE_OFF
> +	bool "Tune Off"
> +	depends on PCI
> +	help
> +	  Use the BIOS defaults; doesn't touch MPS at all.  This is the same
> +	  as booting with 'pci=pcie_bus_tune_off'.
> +
> +config PCIE_BUS_DEFAULT
> +	bool "Default"
> +	depends on PCI
> +	help
> +	  Default choice; ensures that the MPS matches upstream bridge.
> +
> +config PCIE_BUS_SAFE
> +	bool "Safe"
> +	depends on PCI
> +	help
> +	  Use largest MPS that boot-time devices support.  If you have a
> +	  closed system with no possibility of adding new devices,
> +	  this will use the largest MPS that's supported by all devices.
> +	  This is the same as booting with 'pci=pcie_bus_safe'.
> +
> +config PCIE_BUS_PERFORMANCE
> +	bool "Performance"
> +	depends on PCI
> +	help
> +	  Use MPS and MRRS for best performance.  This setting ensures
> +	  that a given device's MPS is no larger than its parent MPS,
> +	  which allows us to keep all switches/bridges to the max MPS supported
> +	  by their parent and eventually the PHB.  This is the same as
> +	  booting with 'pci=pcie_bus_perf'.
> +
> +config PCIE_BUS_PEER2PEER
> +	bool "Peer2peer"
> +	depends on PCI
> +	help
> +	  Set MPS = 128 for all devices.  MPS configuration effected by
> +	  the other options could cause the MPS on one root port to be
> +	  different than that of the MPS on another.  Simply making the system
> +	  wide MPS be set to the smallest possible value (128B) solves
> +	  this issue.  This is the same as booting with 'pci=pcie_bus_peer2peer'.
> +
> +endchoice
> +
>  source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/controller/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e39c5499770f..dfb52ed4a931 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>  
> +
> +/* PCIE bus config, can be overridden by bootline param */
> +#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> +#elif defined CONFIG_PCIE_BUS_SAFE
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
> +#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
> +#elif defined CONFIG_PCIE_BUS_PEER2PEER
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
> +#else
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> +#endif
>  
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
> -- 
> 2.17.1
> 


