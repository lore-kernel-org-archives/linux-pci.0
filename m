Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860625;
	b=O0cqYyQuEkUugECLCr1VtFLWNhbQ6+GpkFFjA52zgjWWJIbnMIC8ntnpXqYidkktXsRy
	 HLlzoEDeclvPQbPyWy4gSDXQhC0prIwcd50nemZ5Yd6HzGsZIGt519zVKzfwIyJ/IzrPc
	 xL67emykm81r/oZ6R8TknYHW6RC33c8P7ur99A4GpSDf3Y5CFKUyezq2bYMs6kXwpoR9V
	 FRTQeKEq8a3tQJgvJQXYfiM6c2x31vVxPUIF81lV+6zmGKY8/YGrniJFvwOp+Mz9Esz4c
	 da+v0vk576l9BtNB60zj+bcwCDVdbBZjVLPjI2FNTPkqOor/zkOMIiJPQs8/dzVjLeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Z3v2Fdi5knvShxlL6luSo+yW+hrEoKkQcOMpcIN//6U=;
	b=4/OsqQkiNPR4UMKQzlYH94fY1VdYCIMwhy830qf5QlfxN18ZnT2gkgxNcSUjSMUPg5Ja
	 e1XcOMlahMWJ2uAfJMtkznJM2xmtxqG0g1rTnsYhSRp5bvhETY0+MVH3kdhMAWXPeLZIf
	 O2zIq4HGKeqyCAv9AQ67VuNHrmmqzQpWQVA612CVOyk5Qn575t5baDW9A6a9pCXwbShZV
	 Q+re67Cx4S8DH4vP4ykgtNx+L3NL4sKBU4K8VgjxByGdJ32YaVmMe3dDETY83xEFYG8Nr
	 lQ+JF8yPEMwsRnKtlRf/PbYwbSi8QrvN2OkxFD6DW+VSC6vaG8BnD1NbxrKDtLJi0uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G31L1HzH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6D606A322;
	Mon, 16 Nov 2026 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G31L1HzH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6CD1F000C8;
	Mon, 16 Nov 2026 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794860625;
	bh=Z3v2Fdi5knvShxlL6luSo+yW+hrEoKkQcOMpcIN//6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=G31L1HzHZLpv7LltQKlqqdOkkjPa7E+nyJ8S3uVY5uQ3rrkZ5bY8ahACP5Xyk4Oyy
	 gzT4Q0qx2+2NA25jSfMFe0gUrmkM9yADzZkEPVpXsHxLbtaDQ9+zt+sOWqLPNNtCjL
	 1tHTZiW2jk4f6FnJ7Cv8TYzGwkzw1ZHwIQZJBkb3v31BWGi/3Xzy/6K4bfDvJLDRCl
	 SwDznO4D2l70OtS8BfDIr+0LPdZh+TbWbagCKZ/55u8WO2nGlPqwUya9JHRqhRgKLp
	 daMN1gLJmLHuumVObY8XQI41437GxOO22Dr4wI2Qpq+0hEHIP2z8lAKYz9+F0sO8TX
	 77srtzrVxrnoQ==
Date: Mon, 16 Nov 2026 14:23:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Sebastian Zygadlo <szgit@icloud.com>,
	Yossef Osman <yossef.osman@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 02/12] PCI: Disable pcie port on specific amd devices
Message-ID: <20261116202343.GA205416@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114160457.3034-3-atharvatiwarilinuxdev@gmail.com>

On Sat, Nov 14, 2026 at 11:03:49AM -0500, Atharva Tiwari wrote:
> As mentioned in the previous commit, PWRD turns off the entire
> bridge, and if we read/write anything to the config space
> or the PCIE space when the bridge is dead, the CPU CATERR's,
> so to avoid interaction when the bridge is dead,
> we remove pcieport support for the bridges..

I don't know what's going on here, but it doesn't sound like typical
PCIe behavior.  If a device is powered off, accesses to it end with
some kind of PCIe error that is not normally fatal.

It's basically the same thing that happens when the OS enumerates
devices by reading the Vendor and Device IDs.  This has to work even
if there's no device present, which is essentially the same as a
device being powered off.

So I'm not in favor of trying to avoid some accesses to devices based
on DMI checks.  Even if that works, it doesn't cover other paths like
sysfs.

> Tested-by: Sebastian Zygadlo <szgit@icloud.com>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  arch/x86/pci/fixup.c       | 43 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.c |  2 +-
>  include/linux/pci.h        |  1 +
>  3 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 795d81c7a..b1697cc4a 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1094,6 +1094,48 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
>  
> +static const struct dmi_system_id quirk_disable_pcie_port_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void quirk_disable_pcie_port(struct pci_dev *pdev)
> +{
> +	struct pci_dev *upstream = pdev;
> +
> +	if (dmi_check_system(quirk_disable_pcie_port_dmi_table)) {
> +		while ((upstream = pci_upstream_bridge(upstream)))
> +			upstream->no_pcie_port = 1;
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x67ef, quirk_disable_pcie_port);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x69af, quirk_disable_pcie_port);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_disable_pcie_port);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7360, quirk_disable_pcie_port);
> +
>  #ifdef CONFIG_SUSPEND
>  /*
>   * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
> @@ -1179,4 +1221,5 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
> +
>  #endif /* CONFIG_SUSPEND */
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a9cbfc1d2..d2f19e566 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	int type = pci_pcie_type(dev);
>  	int status;
>  
> -	if (!pci_is_pcie(dev) ||
> +	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
>  	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
>  	     (type != PCI_EXP_TYPE_UPSTREAM) &&
>  	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107..fcb4f5893 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -420,6 +420,7 @@ struct pci_dev {
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>  	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
>  	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
> +	unsigned int	no_pcie_port:1; /* PCIE Port driver is forbidden */
>  	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
>  	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
>  						   decoding during BAR sizing */
> -- 
> 2.55.0
> 
