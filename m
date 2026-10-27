Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142045;
	b=D6Mx2hvKsuMWydNgHA0wl9ckkl8P6pZLCO0Ydkbfj/Kvw77CdydNq0KHrGc+QrgkB7/X
	 PFTowSvrMNWLWV8NmAVvCpbD2NuaJJGBIY+UcOWdZbsKJ7FZfpoN4wsT3e00Ym78s63KA
	 HSCFM3yE24lSpwUGqbXAVkrHuxeLQo5c2IV/61w40LeGJlDuy6vVIAn1On82XjITcwxFv
	 a/rEFNlMnBPKP44oPhBXCt2w3ItredJgxS2q2lCX6ciijwGJDQQu3n3825wIUXxjTlTP2
	 gbc35MxlqX58ibH0XWLD/JWMxTMJfluq6Zjcx6XV94a3nFsk5qmbe6Qgp7BztRI2C4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142045;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xdcwz2J0ViafkvJlhahLT/XzWeMevy88xwVh6TrPYbc=;
	b=4b4sjJz7uILk/uIinro0q6e+zBockjI7X0cmcvdfMjIyqD0hEzZntxmvlSTc7cD+/MtL
	 pMwNBGH+XrK5qT1l8nG1traAqFFqFUw7uO497KLb6tBRprJejYBf2gzeOYONCaem+KHfZ
	 cLi2ITtiQhbLEANy2QMQK6OZjBlu56a34KfEOcFwmURTf18Bv/Jp5AKR7iUkISNsFLrhw
	 bgXBUUqisinCmtfl4kiCUX7SMVJC6J/LJSDXLAxVnCvSQVRDgcu58buUGAWDXnGOLCJ/B
	 nYs4FCY01f4YpyxwWR+YWhauKgt9UUEN/kw58Ew0ZYg8kJ913jbUe2i3mBp5vxKTNlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmZebDL8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3771606A31E;
	Tue, 27 Oct 2026 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmZebDL8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133671F01825;
	Tue, 27 Oct 2026 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142044;
	bh=xdcwz2J0ViafkvJlhahLT/XzWeMevy88xwVh6TrPYbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lmZebDL8yRqLM+Wh/deQQ76tvi8l8JU1S5SVzREGnKnCGkYrs8CFKQPbV7gBuyyRZ
	 74IkyIL+66EnqWwbU1AzUGlaIvq8+IWUw5SkeVPl3PcsJRtpv4pDee4cO/eq2xiS4V
	 y/RR/5ihw4wzrT0BHjxLQONiMLWKrfUpnqwXA/XAYM2ReGp3nFzrFdwZXOwVFPcVfo
	 bavBhn9rhhvOeWv7/Ptgu8NvBgAEUVFYEDgBr3vAfzBE9gS+E5hXtV0NFop/nXyzsn
	 ZnqrMiAx6J9uT9VDTh8fD/UPivifim82POVYIJ9mKgCed3urVNWgzCkpG6F9Hquocu
	 6UsNpJAhLlb8A==
Date: Tue, 27 Oct 2026 18:00:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on
 specific amd devices
Message-ID: <20261027230042.GA516670@bhelgaas>
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
In-Reply-To: <20261025040046.1602-3-atharvatiwarilinuxdev@gmail.com>

On Sat, Oct 24, 2026 at 11:59:38PM -0400, Atharva Tiwari wrote:
> As mentioned in the previous commit, PWRD turns off the entire
> bridge, and if we read/write anything to the config space
> or the PCIE space when the bridge is dead, the CPU CATERR's,

Reading or writing to PCI devices in D3cold is a problem on every
system and we should avoid it in generic ways.  I don't know what's
special about these MacBooks.

> so to avoid interaction when the bridge is dead,
> we remove pcieport support for the bridges, and we restrict
> access to those bridges when the bridge is dead.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  arch/x86/pci/fixup.c       | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/access.c       | 18 ++++++++++++++++++
>  drivers/pci/pcie/portdrv.c |  2 +-
>  include/linux/pci.h        |  7 +++++++
>  4 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 795d81c7a..66829941e 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1094,6 +1094,35 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
>  
> +static const struct dmi_system_id quirk_disable_pcie_port_dmi_table[] = {
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
> +		while ((upstream = pci_upstream_bridge(upstream))) {
> +			upstream->no_pcie_port = 1;
> +			upstream->ignore_access_d3 = 1;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_disable_pcie_port);
> +
>  #ifdef CONFIG_SUSPEND
>  /*
>   * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
> @@ -1179,4 +1208,5 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
> +
>  #endif /* CONFIG_SUSPEND */
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b..5e9513067 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -559,6 +559,9 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
>  
>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;

This doesn't seem like something we should do for a few special
systems.

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

Nor does this.  I don't know what the purpose of this is.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107..8835b1c82 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -420,6 +420,8 @@ struct pci_dev {
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>  	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
>  	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
> +	unsigned int	no_pcie_port:1; /* PCIE Port driver is forbidden */
> +	unsigned int	ignore_access_d3:1;	/* Ignore access when device is in D3Cold */
>  	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
>  	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
>  						   decoding during BAR sizing */
> @@ -2747,6 +2749,11 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
>  }
>  
> +static inline bool pci_dev_ignore_access(const struct pci_dev *dev)
> +{
> +	return dev->ignore_access_d3 && dev->current_state == PCI_D3cold;
> +}
> +
>  void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
> -- 
> 2.55.0
> 
