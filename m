Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61DE29D29F;
	Thu, 26 Mar 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541761; cv=none; b=jen3ZVH5fOt2odGO5wHBwgOQhpthjGm6aCu8XFzJfWmCADC4oFUpkIdVFtlWf8EwA5scgG3g9U+VEi1VhXtKPjwRYij9Af4ubOh7ziEm/o9v99XEUIiX0+R0Xk/yCo044kiaBVxLD2LWD3c42rLYCtt5DityzgTZ+vZKqiEx0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541761; c=relaxed/simple;
	bh=JameW4ladWrxC5pFev9BgCn4v4NhZUd6ZyGSaPwx+Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZffJxWT5fLm5Ed5CP/w25B8AXhpgu9oyuIsIJXft0ccpFaczwMMt7UlirjUQZws/sNvD/iz006jV/yjP+/fqVdf7RsnIWihCyDRRmnYcDD5o51h1jk4nvV4UKvuJtQzHP9T9TVMZWncxVlbZQ5vybpmoMVXRqRWwHBIiE5NKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY1YDLNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY1YDLNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FEAC116C6;
	Thu, 26 Mar 2026 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774541761;
	bh=JameW4ladWrxC5pFev9BgCn4v4NhZUd6ZyGSaPwx+Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hY1YDLNnxT5UrkfSI/3QmtXREcG01zVBNYsazDkSFm0Zykdkz9mUMjTICsLh4AvqD
	 nAzx4+AXB3A1St+nmJ9kGWNXU21k23SgqTQOv+oSwUb6FYYDGDdZRyDBaa1ej8f72c
	 XATH//JfaJQb8zy0+r9hjFnVlcf2pZQn4BimXeVKPsKRIWQwQ5KGBmJsFAIEfwRDWZ
	 o5x1V24V0uy4rzRuuelqbYCsikgBrW1D7EjNCk/beEFdfZBiLCql9TT6e8f8ZiOv3A
	 zKhePq6XsPLWqrF6CwdBSS6MyriEjqZTc/XCGihwM3UVgO2Rv20MWtUkjyYNKxj9UP
	 VuEJTnfZ+ZEVA==
Date: Thu, 26 Mar 2026 21:45:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: intel-gw: Remove atu base assignment
Message-ID: <eu7z775hpux7vo4p2nzzmyqw6fpvehpuabxs7zfjqhhv4hcsnu@d4dns7uuwu2d>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-4-7fe13726ad4f@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-pcie-intel-gw-v1-4-7fe13726ad4f@dev.tdt.de>

On Tue, Mar 17, 2026 at 11:12:52AM +0100, Florian Eckert wrote:
> In the current implementation, only one PCIe bridge is recognised. This
> change removes the assignment of the ATU base address during host setup.
> Instead, the ATU base address is read from the device tree. To do this,
> the 'atu' range of the DTS entry must be changed for PCIe.
> 
> Old DTS entry for PCIe:
> reg = <0xd1000000 0x1000>,
> 	<0xd3000000 0x20000>,
> 	<0xd0c41000.0x1000>;
> reg-names = "dbi", "config", "app";
> 
> New DTS entry for PCIe
> reg = <0xd1000000 0x1000>,
> 	<0xd10c0000 0x1000>,
> 	<0xd3000000 0x20000>,
> 	<0xd0c41000.0x1000>;
> reg-names = "dbi", "atu", "config", "app";
> 

You just broke the DT backwards compatibility here. What if the driver is used
with an old DT that doesn't provide this 'atu' entry? The driver will break.
Moreover, this entry should be added to the DT binding first before any driver
change.

- Mani

> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 6bd25f8da605032bfdb97596fb3a1f6a03e88bfc..cec972d5aa9107d4708338bd7349415a31f0e688 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -311,8 +311,6 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  		goto clk_err;
>  	}
>  
> -	pci->atu_base = pci->dbi_base + 0xC0000;
> -
>  	ret = phy_init(pcie->phy);
>  	if (ret)
>  		goto phy_err;
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்
