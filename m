Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E90397E89;
	Wed, 30 Sep 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797596; cv=none; b=rgEJWYfUphn6x2BnvUvFNURwRs4MYZLcxfhPkI97vkh8bIPylWGatFHwXZNQKZB101EBJQxX1/JxhRWSeSmQHtOE4HYZIrZvBmN17fO789psoNvttb/+vJ7Ky6R8d1hv3sATey+4noFCc5ru3tNVupsXW6mrx2R97635ezBIYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797596; c=relaxed/simple;
	bh=yWvRIrIIC2ATUIzDYcgVJe4rk8o6AMxeL9FiadJE0Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g8PyoAlum3+aDfjYhcGidU6P1DQdUEhiaLxfRyv0uQGozq2NqXNzgflENcxXGvz67wXsBOZgdONNUEQ5XQhZYmk70sxjXHsfXaTd3OD6+yc9ObJO+UAONo59w4WPeaNyGUnXPE/b5zZm236bIKfvbx3cAa/EQ8IJjaZ56edhWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckwG5i4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckwG5i4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC5D1F000FF;
	Wed, 30 Sep 2026 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797594;
	bh=XcaU1EeYTj9ChThUgcg8lylYN4iYIjCihvnyJuiFscw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ckwG5i4gaGhqWuqUDaFRrCkGQJ9NETlmlIQFnRAP30rib0++iRKj7nvFZfUxQu1CW
	 HHn0LL+MhxMu579o5KNK6XNQXrIwN6pxPfGF6Q01TGDp1amJXogXbaxjagnoolS1Nj
	 /ChJPbJLU7ooOMOIWXnPaClklwNJBJHfE3ZmGvX1tFlvccUBo15poyCd55No0wDGrU
	 +wEW/VhG2LAVr68UCu9QwWm6e0RdhPp5tSQp+BcHJSissEfMG7J88sjXFit5y227zg
	 tMxtjcR40AMmZCfBrQesOWf8AkeEu3tzIsaGfGUmywgXK6glnuQjvBdlqg1vBcdo3d
	 RFxmj4ufXW6nQ==
Date: Wed, 30 Sep 2026 14:46:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>,
	Thierry Reding <thierry.reding@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: tegra264: Fix Link Capabilities register offset
Message-ID: <20260930194633.GA2564345@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923195719.1933175-2-bhelgaas@google.com>

On Wed, Sep 23, 2026 at 02:57:20PM -0500, Bjorn Helgaas wrote:
> The PCI Express Capability begins at 0x48.  Link Capabilities is a 32-bit
> register at offset 0xc, and Link Status is a 16-bit register at offset
> 0x12:
> 
>   Link Capabilities is at 0x48 + 0xc  = 0x54
>   Link Status       is at 0x48 + 0x12 = 0x5a
> 
> Previously the driver read Link Capabilities with a 16-bit read from
> XTL_RC_PCIE_CFG_LINK_CAPS (0x56), which incorrectly read just the upper
> half of the register.  When a hotplug-capable port has no link during
> probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> width from unrelated bits and requests the wrong interconnect bandwidth.
> 
> Correct the Link Capabilities usage by adding a XTL_RC_PCIE_CAP definition
> for the base of the PCIe Capability, using the existing PCI_EXP_LNKCAP
> (0xc) and PCI_EXP_LNKSTA (0x12) offsets so they're easily searchable, and
> reading the entire 32 bits of Link Capabilities.
> 
> Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> Based-on-patch-by: Linmao Li <lilinmao@kylinos.cn>
> Link: https://lore.kernel.org/20260827093919.2825467-1-lilinmao@kylinos.cn
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> This fixes a real bug, so I'd like to get this in pci/next for v7.4.  I
> can't test this though, so need a review and test from somebody with the
> hardware.

I haven't seen any review or testing, but I replaced the patch from
https://lore.kernel.org/20260827093919.2825467-1-lilinmao@kylinos.cn
on pci/controller/tegra264 with this one, headed for v7.4.

>  drivers/pci/controller/pcie-tegra264.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> index 653136db401e..c97576ab4a31 100644
> --- a/drivers/pci/controller/pcie-tegra264.c
> +++ b/drivers/pci/controller/pcie-tegra264.c
> @@ -49,8 +49,7 @@
>  #define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
>  
>  /* XTL registers */
> -#define XTL_RC_PCIE_CFG_LINK_CAPS		0x56
> -#define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
> +#define XTL_RC_PCIE_CAP				0x48	/* PCIe Capability */
>  
>  #define XTL_RC_MGMT_PERST_CONTROL		0x218
>  #define XTL_RC_MGMT_PERST_CONTROL_PERST_O_N	BIT(0)
> @@ -118,11 +117,11 @@ static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
>  	 * possible, so this is as good as it gets for now.
>  	 */
>  	if (pcie->link_up) {
> -		value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +		value = readw(pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKSTA);
>  		speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
>  		width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
>  	} else {
> -		value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_CAPS);
> +		value = readl(pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKCAP);
>  		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, value);
>  		width = FIELD_GET(PCI_EXP_LNKCAP_MLW, value);
>  	}
> @@ -263,7 +262,7 @@ static bool tegra264_pcie_supports_hotplug(struct tegra264_pcie *pcie)
>  static bool tegra264_pcie_link_up(struct tegra264_pcie *pcie,
>  				  enum pci_bus_speed *speed)
>  {
> -	u16 value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	u16 value = readw(pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKSTA);
>  
>  	if (value & PCI_EXP_LNKSTA_DLLLA) {
>  		if (speed)
> -- 
> 2.53.0
> 
