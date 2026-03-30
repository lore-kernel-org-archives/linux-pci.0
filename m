Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE33E1237;
	Mon, 30 Mar 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909804; cv=none; b=BEe+aH9Csq+mr/j+wnahCn4IEIl8xMQqhEedhZ/MHTIWSuGi6HjxUnIUPR86k1ajBSe7FYAUaV5wzfnj63Uvv1bUVpV4OH/Io9geKZTGcUQW1LXYHEigW/zoqSeAzeacMovmGl3XabMfuiu84M/atNdr87FOLIvcsJLJHzjC6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909804; c=relaxed/simple;
	bh=jxcZzJmtHdWLL8FThM+LMzcWiHOr2Xk7LoP2K9faT0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WRVtaee/22tbIN7WGRDRHZqHknukVkrwlYQdGY5Dvl7EAjvQ1pxLapQAcpCeOtv1s1/2X3tBLWZqMO+lZnWpUyQXfNCo4vM6AQs7liv2+w/NCg7OQpdqv8MTiwQe/9g6Knq2EACvkMhfQGrqQmNvwpYwB+JxjDQOMQlKGF/zDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoDQWFsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoDQWFsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB1CC4CEF7;
	Mon, 30 Mar 2026 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774909803;
	bh=jxcZzJmtHdWLL8FThM+LMzcWiHOr2Xk7LoP2K9faT0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EoDQWFsDwvABymFJZucJrrs6CY98BwAsyQYy43Tc/BIEjK28lTAs5BS2yrdhpoAE6
	 YZK55RFY4Qd10lSO/mw6tRyI/GFUuxJjFPyeWRQfyVaTBHnk4t1lOEAsX0UjQY0Av3
	 y92TigpLrhkhHT9Cq7GSnba/gn4Q9ipPsPvL0mX6LX4lsPP8+iKiUm6/Zi+jMbEEqK
	 UvEmjz0KaFQNoSMnumFNbqPPvK9ZnR3EECI5yH76/2vn1IgWMzTQhD2zasNzaCfSd6
	 nPIxtYqnpWXBi4A9hCnr8AxZ/FCzh5Gim4rSRlhoc28pbA1tjiDlnhnXc+35ZHIkos
	 WsrwSglYevWxA==
Date: Mon, 30 Mar 2026 17:30:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU
 drivers
Message-ID: <20260330223002.GA111329@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327211649.3816010-1-dmatlack@google.com>

On Fri, Mar 27, 2026 at 09:16:40PM +0000, David Matlack wrote:
> Ensure that PCI devices with ATS disabled via quirk have it disabled
> before IOMMU drivers are notified about the device rather than after.
> Fix this by converting the existing quirks from final to early fixups
> and changing the quirk logic to set a new no_ats bit in struct pci_dev
> that prevents pci_dev.ats_cap from ever gettting set.
> 
> This change ensures that pci_ats_supported() takes quirks into account
> during iommu_ops.probe_device(), when IOMMU drivers are first notified
> about devices. It also ensures that pci_ats_supported() returns the same
> value when the device is released in iommu_ops.release_device().
> 
> Notably, the Intel IOMMU driver uses pci_ats_supported() in
> probe/release to determine whether to add/remove a device from a data
> structure, which easily leads to a use-after-free without this fix.
> 
> This change also makes disabling ATS via quirk behave the same way as
> the pci=noats command line option, in that pci_ats_init() bails
> immediately and never intializes pci_dev.ats_cap.
> 
> Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
> Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> Signed-off-by: David Matlack <dmatlack@google.com>

Applied to pci/enumeration for v7.1, thank you!

> ---
> v2:
>  - Update the commit message with reasons why this is being fixed in the
>    PCI core, rather than applying a point fix to the Intel IOMMU driver
>    (Andy)
>  - Condense the pci_ats_disabled() and dev->no_ats checks into a single
>    line in pci_ats_init()
>  - Reorder the no_ats bitfield to be after ats_stu since there is likely
>    u8-sized gap there for alignment purposes
> 
> v1: https://lore.kernel.org/linux-pci/20260223184017.688212-1-dmatlack@google.com/
> 
> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
>  drivers/pci/ats.c    |  2 +-
>  drivers/pci/quirks.c | 50 ++++++++++++++++++++++----------------------
>  include/linux/pci.h  |  1 +
>  3 files changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ec6c8dbdc5e9..ceb6f5d3cb10 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
>  
> -	if (pci_ats_disabled())
> +	if (pci_ats_disabled() || dev->no_ats)
>  		return;
>  
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be7..2c7e11830e45 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5653,7 +5653,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  static void quirk_no_ats(struct pci_dev *pdev)
>  {
>  	pci_info(pdev, "disabling ATS\n");
> -	pdev->ats_cap = 0;
> +	pdev->no_ats = 1;
>  }
>  
>  /*
> @@ -5676,25 +5676,25 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  }
>  
>  /* AMD Stoney platform GPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
>  /* AMD Iceland dGPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
>  /* AMD Navi10 dGPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
>  /* AMD Navi14 dGPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
>  /* AMD Raven platform iGPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
>  
>  /*
>   * Intel IPU E2000 revisions before C0 implement incorrect endianness
> @@ -5705,15 +5705,15 @@ static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
>  	if (pdev->revision < 0x20)
>  		quirk_no_ats(pdev);
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>  
>  /* Freescale PCIe doesn't support MSI in RC mode */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..850100f209e3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -539,6 +539,7 @@ struct pci_dev {
>  	};
>  	u16		ats_cap;	/* ATS Capability offset */
>  	u8		ats_stu;	/* ATS Smallest Translation Unit */
> +	unsigned int	no_ats:1;	/* ATS disabled via quirk */
>  #endif
>  #ifdef CONFIG_PCI_PRI
>  	u16		pri_cap;	/* PRI Capability offset */
> 
> base-commit: 7df48e36313029e4c0907b2023905dd7213fd678
> -- 
> 2.53.0.1018.g2bb0e51243-goog
> 
