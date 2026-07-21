Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7071A275;
	Tue, 21 Jul 2026 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592646; cv=none; b=Qo2g4CNqTwNDNEKEkv09wOvhXsjyyx8e9Pwf4MJSNWlXgn0MalCG9WJH01+B9EEKM8bPr73/jFPavjUaoQIe+8179kgZumlxB9ViogEXxj7vH8Gr0S6laddB28I6H5WUxfqmMFUGS7S50Sk9i4WTzpNJTPDoHKB2hO0tZBm9EEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592646; c=relaxed/simple;
	bh=nUA1efcEvGIA//r4oJNEhm44nknbBpvGKUZpdCh+mDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdHOgigowR9ZnXeK1mNuMVhBTAIexLFiVNtahsLwnwLJI/vjMTNnfIogLK5F6fX2nL39v5c9+Ra23c/YA6QZfNFxAcsVi60qwVnn2HSawk8WlzDTq9AoX0ypENAcuB2TY0w9kwTOLPdgPY4Wl+dApTHqywBAGh7nuYrw+5XxVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCdOFSaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCdOFSaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7861F000E9;
	Tue, 21 Jul 2026 00:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784592644;
	bh=SU7NTZV6ctCmaLjoIpubALICGle8Rsbisa8IJw6vOYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GCdOFSaVTBcd3wvW6vYIJ/3ZigDnTHY1FKRMuNdeOw4ahdDa34XAYMPIJ/el+goF8
	 xr3/Ffndunr0z1CE4DL31ZaL0zXTHzpU6F/TJeT/ppenqrA0U3Ao9BLUyAwJ723jEi
	 7vKyEYVgHhBn/lB96KfVsQh0vlpkYFWldKIWhdlAAFFyZg4P1D6wY4W8Wm89J1uVn8
	 4+R83+SGAeAUsqFfNjIZSYFvt3kbVwL4R1c9c8926jGfK0xW/eTEHFXrrejrNWobSo
	 FsX/g3DUbZL0F7xjl8aJGgw6ZIYwggtzajJIJVXk5argfJbfGTSPiuA7obuw28ZwuQ
	 X8i61yLh2oK4A==
Date: Tue, 21 Jul 2026 01:10:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 12/13] PCI/CXL: Mask/Unmask CXL protocol errors
Message-ID: <20260721011036.0227e6a8@jic23-huawei>
In-Reply-To: <20260717222706.3540281-13-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-13-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:27:05 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL protocol errors are not enabled for all CXL devices after boot.
> They must be enabled in order to process CXL protocol errors. Provide
> matching teardown helpers so the masks are restored when a CXL Port
> or dport goes away.
> 
> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for the cxl_core
> module.
> 
> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
> or non-PCI @dev so callers do not have to special-case it.
> 
> Wire cxl_unmask_proto_interrupts() into the success path of
> cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask
> only runs when the RAS register block was actually mapped. Pair each
> unmask with a devm_add_action_or_reset() registration of
> cxl_mask_proto_irqs() scoped to the host device so the mask is
> restored when devres is released. This applies to dports, Endpoints,
> Upstream Switch Ports, Downstream Switch Ports, and Root Ports.
> 
> Remove the dev_is_pci(dport->dport_dev) guard in
> devm_cxl_dport_rch_ras_setup(). On RCH systems dport->dport_dev is the
> pci_host_bridge device, which is not on pci_bus_type, so this guard
> caused the function to return early on real hardware without mapping
> dport RAS or AER registers. The caller already gates on dport->rch,
> which is sufficient to exclude cxl_test mock devices.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 

One minor thing inline and maybe take another spin at a more concise
patch description

Either way on both of them.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


...


> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0bd23a65e7ebc..be6dc2cbd4491 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1143,12 +1143,32 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> -/*
> - * Internal errors are too device-specific to enable generally, however for CXL
> - * their behavior is standardized for conveying CXL protocol errors.
> +/**
> + * pci_aer_mask_internal_errors - mask internal errors
> + * @dev: pointer to the pci_dev data structure
> + *
> + * Mask internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask |= PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
Could do
	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
				       0, PCI_ERR_COR_INTERNAL);
or something along those lines.

Maybe it is worth wrapping that in some helpers to make it a bit
more regmap like in that it could have set and clear only variants.

> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask |= PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");

