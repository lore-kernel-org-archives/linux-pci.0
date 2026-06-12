Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745F29B8D0;
	Fri, 12 Jun 2026 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278562; cv=none; b=iGDfwuyqYFwXsysHWK4icYAPZSrNVZTKPcxxunUeS69yKrqffJLcJgQw0hdQ+FXDbEhpIeUaT4y/0xXo3vRCEVQlRCRTXoKZQJnY6uzc716nrkZHPY/0AnB6dMnuKBdRXf5hkhntZJpUqz7jM1PLq3/+5+DgaTeJ0QpEWB/03Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278562; c=relaxed/simple;
	bh=0HkHpGqNdEltJeYzBM5zmlxVbVdX6X6lFM+zac4lju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btqXzis7PH35VVnDvxjvCYDD+C1TtDmEHxOrwzrp5v050bRf8ruRTPIEeUI7mAKTqiBfiXZxu9l1BV9I0IQxN1MjD1G9ku1f5cW10ZJTTJ8BL2SIxJVT2joFbyRoovIwUA3j8EyffU3HuUJXRfmP30J1urepmefs4R7roYpOxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ0erxgk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ0erxgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729861F000E9;
	Fri, 12 Jun 2026 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781278560;
	bh=hQCZKxKvkDpnPl+zzZRxKvokiXAFmUYWGGAQketIbJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TZ0erxgk7x4rAjnfq6hP+rDy7OGNmrJTKBEDD4niSSuXTpcHq9FD8wi8jjmMWuinZ
	 Bs3G2WSUSpiomGX/o+lLWGD3jRIoIHF3zv8Rosa72QZQIAt9Rtqy8xha7XbgLLzTBd
	 khzRwzRhKKL8MxzmjqO4xASQvbX88n7xiXRkqhSY5CluvQMrDKQRbX5CsP9pJHzFAm
	 zoYiGWRig1AISdLfasWRpK+TH1aHxqRqGgYjynGNFQyf5rikGdcFBP73wT/sl3tt+t
	 Uudz0Hhgcm9XMlG5x3PajSx0NjvYFx3yFXW2DO+NjC6iE3kDc/Tm93q6O7aDtRlWTq
	 FDGQEthieY+hQ==
Date: Fri, 12 Jun 2026 10:35:59 -0500
From: Rob Herring <robh@kernel.org>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, xen-devel@lists.xenproject.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v16 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Message-ID: <20260612153559.GA1082302-robh@kernel.org>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>

On Wed, Jun 03, 2026 at 12:43:11PM +0530, Vijayanand Jitta wrote:
> So far our parsing of {iommu,msi}-map properties has always blindly
> assumed that the output specifiers will always have exactly 1 cell.
> This typically does happen to be the case, but is not actually enforced
> (and the PCI msi-map binding even explicitly states support for 0 or 1
> cells) - as a result we've now ended up with dodgy DTs out in the field
> which depend on this behaviour to map a 1-cell specifier for a 2-cell
> provider, despite that being bogus per the bindings themselves.
> 
> Since there is some potential use[1] in being able to map at least
> single input IDs to multi-cell output specifiers (and properly support
> 0-cell outputs as well), add support for properly parsing and using the
> target nodes' #cells values, albeit with the unfortunate complication of
> still having to work around expectations of the old behaviour too.
> 							-- Robin.
> 
> Unlike single #{}-cell, it is complex to establish a linear relation
> between input 'id' and output specifier for multi-cell properties, thus
> it is always expected that len never going to be > 1.
> 
> These changes have been tested on QEMU for the arm64 architecture and
> on the glymur platform [3].
> 
> Since, this would also need update in dt-schema, raised PR[2] for the
> same.
> 
> [1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> [2] PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184
> [3] https://lore.kernel.org/all/20260515-glymur-v6-5-f6a99cb43a24@oss.qualcomm.com/
> 
> V16:
>   - Patch 2: Fix potential NULL pointer dereference in of_msi_xlate()
>     when msi_np is NULL. Guard the of_check_msi_parent() call with
>     "if (msi_np && ...)" to handle the case where the caller passes
>     NULL for msi_np, as documented. Reported by Sashiko [1].
>   - Patch 2: Fix OF node refcount leak in of_msi_map_get_device_domain():
>     np was never released after of_msi_xlate() transferred ownership.
>   - Patch 3: Default to 1-cell output specifier when the target node
>     lacks the #iommu-cells/#msi-cells property, for backward
>     compatibility with controllers that predate the property
>     (e.g. arm,gic-v2m-frame). Reported by Sashiko [1].
>   - Patch 3: Add !cells_name to the initial parameter guard in
>     of_map_id() to prevent a crash if cells_name is NULL.
>     Reported by Sashiko [1].

I've applied the series, thanks.

Rob
