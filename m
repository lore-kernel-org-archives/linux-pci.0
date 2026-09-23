Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824C4ACC8F;
	Wed, 23 Sep 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183531; cv=none; b=rPESXpZNlHxSV2qMApCWZcBZbU4R0bZ05M4z3+WXtSgZpDz4Jv+cwTF1/o65SUEq+BwnGEl7Tl01pP4moyQURMY0IL+O+voU8NxOiynDs658opdsfO8mUZw65GDiC5hFhjHmwkPhxjKIMKK+Wd0uI62JbQ0WhwxL53cNpzVTxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183531; c=relaxed/simple;
	bh=SKMgkhOE8Vb7Mwvaw/rGHloh4v7Cso10ZKN0IJsHntk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cURmzN7TMOIhkaxLj8mOyDsFuyJgiu/p3p+3IzHVbyrmDxI1VvRy761pLKD2e4cDEnpFzj+bVBzk5WXdwQjiVOlsuBycB0rgznNsk8izO4RVGYJSevMofJzwNJAtGHm4qSmhZxYMkOvCEumgD6ftjDPPsQfIEZPjY1U8djPg558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI2aurFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI2aurFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896121F000FF;
	Wed, 23 Sep 2026 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790183527;
	bh=HJpJX3NmuvoOa1Cvg9brSR1FfHAXTAOMXUfV033vrTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=cI2aurFcewXDMuO1ZCdAYmH0kNvM3AyYQ+vm7sP8x5cm1YahiZoMCBWzAaQUvlsW5
	 lgsihg3yT1zROnG/KPbqRE2XE7jU2wm8TYFQNt3u2jDIPTugS9o+ceKjCzlo5I0mvK
	 iIOV5LjYg/8Kc7bsU2ZSxGLjv/r2zsaeKADoAts9QKtE46DjEs8F2/XaCwscOWld+M
	 77h+zdwsKec9d/lZDLgz5//gqJohSwucNq2dxy8S4wLOvpahCu/tUMDUCo6WBzm7Qp
	 72FFdywRfpYiyDGOCc6gopMUeG4heVJBufptvbvu4r2pdn18/PxNaf0NlirH5MqOaA
	 ec+q6pA/7lD7g==
Date: Wed, 23 Sep 2026 12:12:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	david.laight.linux@gmail.com,
	John Smith <imjohnsmith4000@gmail.com>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Roland Waltersson <roland.waltersson@netinsight.net>,
	Mikael Etienne <mikael1022bzh@gmail.com>,
	Arthur Husband <artmoty@gmail.com>,
	Alvin Lim <alvinwylim@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/PCI: Disable enhanced atomics on some AMD
 PCIe ports
Message-ID: <20260923171206.GA1866939@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908190600.226485-2-mario.limonciello@amd.com>

On Tue, Sep 08, 2026 at 02:05:59PM -0500, Mario Limonciello wrote:
> There have been multiple reports of data corruption that can occur
> with 64-bit DMA when the IOMMU is enabled. This occurs due to some
> BIOSes enabling enhanced atomic operations on PCIe ports.
> 
> When enhanced atomic operations are enabled on PCIe ports for some
> models, data corruption occurs when the 32-bit IOVA space is exhausted.
> The problem is reported on storage devices, but can affect any device
> that uses 64 bit DMA.
> 
> Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.

Can this issue happen without IOMMU?  Devices can do 64-bit DMA even
without an IOMMU being enabled.

When I asked Gemini to explain this, it suggested that "enhanced
atomics" is an AMD NBIO feature that translates PCIe AtomicOps into
native Infinity Fabric atomic transactions.  But I guess the issue
affects any DMA above 4GB, not just AtomicOps, right?

> Cc: david.laight.linux@gmail.com
> Cc: John Smith <imjohnsmith4000@gmail.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Roland Waltersson <roland.waltersson@netinsight.net>
> Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
> Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361573@gmail.com/
> Reported-by: Arthur Husband <artmoty@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
> Reported-by: Alvin Lim <alvinwylim@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Apply to suspend/resume as well.
> ---
>  arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df753..79e4338e4b876 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -886,6 +886,105 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
> +
> +/*
> + * Enhanced atomic operations can cause corruption with 64-bit IOVA
> + * on these devices.
> + */
> +#define RX_ENH_ATOMIC_EN		BIT(8)
> +
> +static const u32 nbio_7_7_pcie_smn_addrs[] = {
> +	0x111401d0,
> +	0x111411d0,
> +	0x111421d0,
> +	0x111431d0,
> +	0x111441d0,
> +	0x112401d0,
> +	0x112411d0,
> +	0x112421d0,
> +	0x112431d0,
> +	0x112441d0,
> +	0x112451d0,
> +	0x113401d0,
> +	0x114401d0,
> +};
> +
> +static const u32 nbio_7_11_pcie_smn_addrs[] = {
> +	0x112401d0,
> +	0x112411d0,
> +	0x112421d0,
> +	0x112431d0,
> +	0x112441d0,
> +	0x112451d0,
> +	0x113401d0,
> +	0x113411d0,
> +	0x113421d0,
> +	0x113431d0,
> +	0x113441d0,
> +	0x113451d0,
> +};
> +
> +static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
> +					   const u32 *smn_addrs,
> +					   size_t nr_smn_addrs)
> +{
> +	bool changed = false;
> +	size_t i;
> +	u32 data;
> +	int ret;
> +
> +	for (i = 0; i < nr_smn_addrs; i++) {
> +		ret = amd_smn_read(0, smn_addrs[i], &data);
> +		if (ret)
> +			continue;
> +		if (!(data & RX_ENH_ATOMIC_EN))
> +			continue;
> +		data = data & ~RX_ENH_ATOMIC_EN;
> +		ret = amd_smn_write(0, smn_addrs[i], data);
> +		if (ret)
> +			continue;
> +		if (changed)
> +			continue;
> +		ret = amd_smn_read(0, smn_addrs[i], &data);
> +		if (ret)
> +			continue;
> +		if (data & RX_ENH_ATOMIC_EN)
> +			continue;
> +		changed = true;
> +	}
> +
> +	if (changed)
> +		pci_info(host_bridge, "enhanced atomics disabled\n");
> +}
> +
> +static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev *dev)
> +{
> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
> +				       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
> +}
> +
> +static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct pci_dev *dev)
> +{
> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
> +				       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
> +}
> +
> +/* Phoenix, Hawk Point (NBIO 7.7) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
> +
> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +
>  #endif
>  
>  /*
> -- 
> 2.43.0
> 
