Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107541324C;
	Mon,  2 Mar 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467781; cv=none; b=dqEX7dSBImKBn4t0E5YCHTDdC1ZJZ+MdH+5Lkv2xo5H2IVNGKSCCEcugjZJVhxwxutRZypPnaZwPuFXESiMDZrvESdjV/6eWunZUdPY6oQo4kj9ckLpQx9TOiE9Er7ZDjwbuefOPmdnuN9iiW9OKKIw4C7HORRDgu1xSTYqG3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467781; c=relaxed/simple;
	bh=hmLkt2fr0iWDzyNi/rFRc0FAr91etT4RAQgX+D/cr/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBw3NWFYfkh/chBB73ktPrjkoukMGaeMekWWSsffu9m44YfDhhMmXKu+eUYQDDsIdR3aZAtM5+R2G+LGP4qh0f8OMaQesp6qIhdSlMmKfM4eVZ2xMcsoRO++jKt/XxTPFiHT6tNaXTYI9zsyc8DgV5XeHrAzRCwrNhhFdwVHHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdB2ulnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdB2ulnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044F8C2BC87;
	Mon,  2 Mar 2026 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772467781;
	bh=hmLkt2fr0iWDzyNi/rFRc0FAr91etT4RAQgX+D/cr/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdB2ulnQRVpMkAbz4BjY4cFNS7nlxbqSK+l7snw94iFM0ZEcvqMC2bYcDWgara4et
	 KqmzEC/C1P+mYvEwQB5Pu7Sg0m2GjivvwG8VecLhjMF/OBOYxZabRrdUWe/y/LWMz0
	 JFuOwHW+hXe9hf09dfq+jW9Dte46o6T+BujfViMNH3otQJvphagfkLP+UkFc+XFsse
	 y/mbkBNwWZDJHxF/jk8uiznA+xnBs6YSEc7OjxUsta9NGuqg9IUX86ik7RCk9books
	 2VOgobs6SIlK8tY/8XmQnZmN/q5e5i2sDpX7doiEyVAjlV3HWE4N1K4KcVqwbRuUGT
	 fd5CmKKTiUIvw==
Date: Mon, 2 Mar 2026 21:39:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, kwilczynski@kernel.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ye Bin <yebin10@huawei.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] PCI: endpoint: pci-epf-vntb: Switch
 vpci_scan_bus() to use pci_scan_root_bus()
Message-ID: <3tgrcel5fl55ulf3zjya4fkz4t2ms7iwwjif5rnzn2rafsydd6@i4e5etm7uqvz>
References: <20260226084142.2226875-1-den@valinux.co.jp>
 <20260226084142.2226875-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226084142.2226875-5-den@valinux.co.jp>

On Thu, Feb 26, 2026 at 05:41:41PM +0900, Koichiro Den wrote:
> vpci_scan_bus() currently uses pci_scan_bus(), which creates a root bus
> without a parent struct device. In a subsequent change we want to tear
> down the virtual PCI root bus using pci_remove_root_bus(). For that to
> work correctly, the root bus must be associated with a parent device,
> similar to what the removed pci_scan_bus_parented() helper used to do.
> 
> Switch vpci_scan_bus() to use pci_scan_root_bus() and pass
> &ndev->epf->epc->dev as the parent. Build the resource list in the same
> way as pci_scan_bus(), so the behavior is unchanged except that the
> virtual root bus now has a proper parent device. This avoids crashes in
> the pci_epf_unbind() -> epf_ntb_unbind() -> pci_remove_root_bus() ->
> pci_bus_release_domain_nr() path once we start removing the root bus in
> a follow-up patch.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v4:
>   - Correct the subject prefix
>     s/NTB: epf: vntb:/PCI: endpoint: pci-epf-vntb:/
> 
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 805353528967..f353e9a57194 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1220,8 +1220,19 @@ static int vpci_scan_bus(void *sysdata)
>  {
>  	struct pci_bus *vpci_bus;
>  	struct epf_ntb *ndev = sysdata;
> -
> -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> +	LIST_HEAD(resources);
> +	static struct resource busn_res = {
> +		.start = 0,
> +		.end = 255,
> +		.flags = IORESOURCE_BUS,
> +	};
> +
> +	pci_add_resource(&resources, &ioport_resource);
> +	pci_add_resource(&resources, &iomem_resource);
> +	pci_add_resource(&resources, &busn_res);
> +
> +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> +				     &vpci_ops, sysdata, &resources);

Don't you need pci_lock_rescan_remove()/pci_unlock_rescan_remove()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
