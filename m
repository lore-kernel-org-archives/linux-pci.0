Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB23859F5;
	Thu, 27 Aug 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850241; cv=none; b=UAA8x3mqy+JPVbd+zKVQFpvIzPlUfvS1SLRth2T+/+iI9jHSNuN9pPVEAMFUPcnjIQHmNcVBYs4WwnjmdQYgZNSGVQLVUJEe2COhXFiYwXQMjOyqXGkfYokDkkB9Erf6rizgwPnKKrH0DbUu3FQ1CfY2dYOe/mUI/Om98nfhaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850241; c=relaxed/simple;
	bh=AEDt3/xqtAXQnDiiVH4vwMnE4DlllrmtPoFnHvyi/Is=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OhTIrISEOHCQl6wp8tPsMM+KmvMUh6ZFi5/S6jJUcTh8VdK2Az3E/q+hWMQAfXwVzKtBpJ13aaW2SI6tWU2MU0oTdFyOdVmQbBCXhC8FOSTT7hku1IWvdb2ee0/jiTIFa/zYh4ETvrZ76SWURaygskPSDf4iBdVNjvPM7bM5hsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHM4N6AA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHM4N6AA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7792E1F000E9;
	Thu, 27 Aug 2026 17:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850239;
	bh=9HsenF4HL0pSppXNJ0aCXrQ177zIDCyB3GDzhRJCen4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VHM4N6AAuXOiqH7530U6z0VZl5sOcEq80bCG6ZZEIwuKlMS92IGY0s+UKMpjZ7htr
	 L1BXbrG58L3v0sfeGRRaGEACxY7k1D7+iZbK+2U1XfpDD1dlBP1Mu2aoE2ts2Mw/ux
	 QzDcBmGaoqEEhntyO0nfw0ug9kmuwdwe9YyvyhpFe4wqwhZQOj8Agw2FhjfXBBcWe2
	 /G0JCS2XHRBzT1itYRVj79Pz6nNe5lrlrYGQ0xaeKK18rkEdPwl2oFEFgwKEr2q4rU
	 L6UL5OFJEdRTbpzAkbiFv/X/1q6M+UOAmlmw90/xda+tmRT3MfEkTIjP5udHKVKkMp
	 vVbb8nF0WACRw==
Date: Thu, 27 Aug 2026 12:03:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: thierry.reding@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jonathanh@nvidia.com, mmaddireddy@nvidia.com,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
Message-ID: <20260827170358.GA1610989@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827093919.2825467-1-lilinmao@kylinos.cn>

On Thu, Aug 27, 2026 at 05:39:19PM +0800, Linmao Li wrote:
> The PCI Express Link Capabilities and Link Status registers are at offsets
> 0x0c and 0x12 from the capability header, respectively.  Since the driver
> uses 0x5a for Link Status, Link Capabilities starts at 0x54, not 0x56.
> 
> Reading a 16-bit value at 0x56 returns the upper half of the Link
> Capabilities register.  When a hotplug-capable port has no link during
> probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> width from unrelated bits and requests the wrong interconnect bandwidth.
> 
> Use the correct Link Capabilities offset.
> 
> Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/pci/controller/pcie-tegra264.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> index 653136db401e0..3a672d18c4d2d 100644
> --- a/drivers/pci/controller/pcie-tegra264.c
> +++ b/drivers/pci/controller/pcie-tegra264.c
> @@ -49,7 +49,7 @@
>  #define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
>  
>  /* XTL registers */
> -#define XTL_RC_PCIE_CFG_LINK_CAPS		0x56
> +#define XTL_RC_PCIE_CFG_LINK_CAPS		0x54
>  #define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a

If this is a standard PCIe Capability, and since we use the standard
#defines like PCI_EXP_LNKSTA_CLS and PCI_EXP_LNKCAP_SLS for values
read from it, it appears to be, I think these XTL_RC* #defines should
somehow be based on the existing PCI_EXP_LNKSTA and PCI_EXP_LNKCAP.

E.g., we could read from pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKSTA.
That way grep would be more useful.

>  #define XTL_RC_MGMT_PERST_CONTROL		0x218
> -- 
> 2.25.1
> 
