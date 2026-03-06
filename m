Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BA41324C;
	Fri,  6 Mar 2026 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822721; cv=none; b=ikxUJ/5xl4w83lT7dS1f/lYdRI+rvaQsvDlbYb9D1rahCDFfd8YlzKfs6o2G2UAHBKcefUDwJXkVPh23i2mFwgiBouy57XvLCP3Aw9dOngcxbpwmw+aTxK7ErhFXfejW48DLmVRyEK60a81GXIB9bD5IGy0MZ68UEiWVsFO9E/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822721; c=relaxed/simple;
	bh=TAPEMoUBdbqiMr5CXBvVzsVUqO0KPRqErDje7YwlSrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IGaATpXgUHn9xb3qHYg4u14S48EOCvP3NNPW8Oc6offdXVCcmprXDFeIgwONLIQyZUSudge847Mqqy0546nS0tJblxXEMHYwx8G43K7Is/1ZGcLXULE8F1+FgeT4vQQcUfUZQRo408ba0WiYy1rGx/+AZW6Q2peGQbwSssYkepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6+980zh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6+980zh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41770C4CEF7;
	Fri,  6 Mar 2026 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772822720;
	bh=TAPEMoUBdbqiMr5CXBvVzsVUqO0KPRqErDje7YwlSrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C6+980zh2V2zzVdWHkclZcGT8fGLhNKvxrq4lP/nCmBHw2VmFMDjL3M7Ghf/Zk5Qy
	 L2gVoFh7mCtrAQsqSk4N4kAiS/C4rwKkEvGBw3Z3Ql/2vUPJt9wkbZdMPjtpL+QG5Q
	 s3TbBU4WMh3pMjmqZ5BYCoM81fk2NnJTP6m/SId2SdmMxk+rxeWVWjHbcwh60vXdjc
	 cfYfvF0fwgHE9kgWg+PNz1KRUt7eatGYQsFmEaOtbNZIfPnP08iqWd9qJ6yUUM4K+5
	 Np0EPpnUCzSs7xuKD0GOndhDeae4KEhcvQMjb17Vv6AwPjf7bQqXQdOv9QLfN0C1bp
	 x1L22+WIAbnmQ==
Date: Fri, 6 Mar 2026 12:45:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, yoshihiro.shimoda.uh@renesas.com,
	fancer.lancer@gmail.com, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, cassel@kernel.org,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to
 correct physical function
Message-ID: <20260306184519.GA131984@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224083817.916782-2-a-garg7@ti.com>

On Tue, Feb 24, 2026 at 02:08:16PM +0530, Aksh Garg wrote:
> The MSI-X configuration code reads from the correct physical function's
> register space using dw_pcie_ep_readw_dbi(), but writes back only to
> PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
> MSI-X configuration for other PFs.
> 
> Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
> register space, matching the read operation.

Is this another case of using "PF" in a non-SR-IOV context, as I asked
about here?

  https://lore.kernel.org/all/20260223185558.GA3701139@bhelgaas

I do not want to use "PF" unless we're talking about a device with an
SR-IOV Capability and we're doing something specific to SR-IOV.

> Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> Changes since v1:
> - None
> 
> v1: https://lore.kernel.org/all/20260202072758.101845-2-a-garg7@ti.com/
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..771241e1a2c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	val &= ~PCI_MSIX_FLAGS_QSIZE;
>  	val |= nr_irqs - 1; /* encoded as N-1 */
> -	dw_pcie_writew_dbi(pci, reg, val);
> +	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
>  
>  	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
>  	val = offset | bir;
> -- 
> 2.34.1
> 
