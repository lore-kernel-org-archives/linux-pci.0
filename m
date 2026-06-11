Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3638E129;
	Thu, 11 Jun 2026 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215804; cv=none; b=AFO65oAbgqPqF9jw8EGqGcNMKvE60Ka18Wy2HXEgvsozCGDvg9FyJvtBFt3oKEmHXhVGFNzes6IvobOxDIF/jRy0xYr6HyfjitjAexu8ijcpDsymQ6TTZtuzfyASsBDNm0paIdVoXIDRplq068niSJgeif2ErvnH2Nwv3c95vuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215804; c=relaxed/simple;
	bh=865w9fZBcCWpZ8bfo9NmSFiRhVhRtUx2f56KBYcegwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pnqOV76HdL8PEoQF9Xb1QMQiAs5lM3DEKIL5KVhHpq9CHg0skOF2PxmmlAdSyW+pn49kK4M+dQ4xflLafTfeAysFMnYYpb5lh79oY2YxmeEKB0kfV4BIKISxk+6q/L1xMsUnLV2IbrLdjzjbvNlop/hvXDvwxxTybxngSC8UK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT9pt1f2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT9pt1f2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0C71F000E9;
	Thu, 11 Jun 2026 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781215801;
	bh=uzVD5s+95WmQgg4kuThSYNI11+iYet9ftNMS9PZCYWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WT9pt1f23qU4nuc0lOmfmxft1w4QZmMjX0jSY3qNiMo/1MI3uhXlQpq1dU8bwe3ws
	 dKLDI9s1ONUJa4yXyoaJP1GZ9nxqesa1kBVF+o+9GacgWztrt8CWjXRKjOfgAhLDSw
	 MOLaWjmN3IAie74C3apbYLj1TiMSoyaHRJ7y7k1cAgiE2wALhPxRD/FJdZn/U3Gxa0
	 UnA10NC75Jc3M3lzyMnV/CezfGkg7AcMp0Uv1WuBWQEeL/euBhKlgBvM5nYjHfxMBT
	 09RFTPlAH+VaP87iW/ufGpEEasyjaqL9KCEcILJ2A2RoDVcy5Im37as4iryc2s27r9
	 /4YGpGUI5HtTA==
Date: Thu, 11 Jun 2026 17:10:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Fan Ni <fan.ni@samsung.com>, Shradha Todi <shradha.t@samsung.com>,
	Hanjie Lin <hanjie.lin@amlogic.com>, linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Guard RAS DES debugfs deinit
Message-ID: <20260611221000.GA524832@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f97352506d8d813f70f441de4d63fcd5b7d1c3e.1779123847.git.shuvampandey1@gmail.com>

On Mon, May 18, 2026 at 10:44:17PM +0545, Shuvam Pandey wrote:
> dwc_pcie_rasdes_debugfs_init() returns success when the controller has
> no RAS DES capability, leaving pci->debugfs->rasdes_info unset. The
> common debugfs teardown path still calls
> dwc_pcie_rasdes_debugfs_deinit(), which dereferences rasdes_info
> unconditionally.
> 
> Return early when no RAS DES state was allocated. In that case no RAS DES
> mutex was initialized, so there is nothing to destroy.
> 
> Fixes: 4fbfa17f9a07 ("PCI: dwc: Add debugfs based Silicon Debug support for DWC")
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index d0884253b..c3671cb2f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -557,6 +557,9 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>  
> +	if (!rinfo)
> +		return;

I guess this prevents a NULL pointer dereference, right?

>  	mutex_destroy(&rinfo->reg_event_lock);
>  }
>  
> -- 
> 2.50.1 (Apple Git-155)
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
