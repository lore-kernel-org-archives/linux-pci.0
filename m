Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649F175A6B;
	Tue, 31 Mar 2026 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935286; cv=none; b=RO+YjDx30sgDi2IuaLCmaetxjnGEVGs8QYFhtJrIgrnGhXBtVOxiKcoUOQD4PhrEdB0EI1ZcWASL6W/k1SIEK5P+C3b9VZ54J353QYFFYTylAjHItg8Wizw4yOJx3yy2wJzsHm9jHcSzBA7aBpHibgMD+4roGlKkTZCF8StzAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935286; c=relaxed/simple;
	bh=ERgkL2Rh8Uk73V3Zb2z9UjJCCMin0IIArfID3g+LSbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpFD+T5H2bLaWqqAcF18LQNawjo2WSThSItk7uNlz2IYBwPr/EevyKGUSLdQ2IecZ6DftU2yeFR1/xnz+nPu2cRCIwjZhhupoElmta9W4uRmlLucURJlz5R9Up1tgHsFxX2czdYtM7SoK2yC2tzIB0mqYSWPT+crzB+4iIt18Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwzrqdnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwzrqdnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A73DC19424;
	Tue, 31 Mar 2026 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774935286;
	bh=ERgkL2Rh8Uk73V3Zb2z9UjJCCMin0IIArfID3g+LSbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwzrqdnYKdEzHYC3yTxdkylUQ1f/98RlsJ5axnZ7I7R/tVsGV4biNd2hgONpDJ7g2
	 qW0H0i8yTJug3ZPpHlP9XeHTf92syolzyfxB+PMYIEkPZh5EotX/7F6Bl4gOFUNg0+
	 wpOKKjZKVm4/Xr8jpVZciDfs/7fEMb2hMBUpznpkyoaDs8t2lzZxTqRmPg3aGm3tWn
	 mip77J2Rgp93M0L2OHVAcbZepnWHmf2Ax7+S2C9Fq5BIXr8aBETGODFOJzoxQUFqRE
	 uCmh100aL7SEvftal4YMDH/TFg1hb4jk5Agu6UC4YtvaNMS04nAzVpoC2zzrlI5ncE
	 nnMkoYZM8k0wQ==
Date: Tue, 31 Mar 2026 11:04:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: rafael@kernel.org, jonathan.cameron@huawei.com, helgaas@kernel.org, 
	guohanjun@huawei.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Shiju Jose <shiju.jose@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/3] PCI: hisi: Use
 devm_ghes_register_vendor_record_notifier()
Message-ID: <i4pg4fvo3vulzevo5cnjb5qku73cqtucuxqwhiw73dfxcufhqi@ofsvdrffsegl>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
 <20260330094203.38022-3-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330094203.38022-3-kaihengf@nvidia.com>

On Mon, Mar 30, 2026 at 05:41:56PM +0800, Kai-Heng Feng wrote:
> Switch to the device-managed variant so the notifier is automatically
> unregistered on device removal, allowing the open-coded remove callback
> to be dropped entirely.
> 
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Since there is an API dependency, feel free to take it through ACPI tree.

- Mani

> ---
> v3:
>  - No change.
> v2:
>  - New patch.
> 
>  drivers/pci/controller/pcie-hisi-error.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
> index aaf1ed2b6e59..36be86d827a8 100644
> --- a/drivers/pci/controller/pcie-hisi-error.c
> +++ b/drivers/pci/controller/pcie-hisi-error.c
> @@ -287,25 +287,16 @@ static int hisi_pcie_error_handler_probe(struct platform_device *pdev)
>  
>  	priv->nb.notifier_call = hisi_pcie_notify_error;
>  	priv->dev = &pdev->dev;
> -	ret = ghes_register_vendor_record_notifier(&priv->nb);
> +	ret = devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb);
>  	if (ret) {
>  		dev_err(&pdev->dev,
>  			"Failed to register hisi pcie controller error handler with apei\n");
>  		return ret;
>  	}
>  
> -	platform_set_drvdata(pdev, priv);
> -
>  	return 0;
>  }
>  
> -static void hisi_pcie_error_handler_remove(struct platform_device *pdev)
> -{
> -	struct hisi_pcie_error_private *priv = platform_get_drvdata(pdev);
> -
> -	ghes_unregister_vendor_record_notifier(&priv->nb);
> -}
> -
>  static const struct acpi_device_id hisi_pcie_acpi_match[] = {
>  	{ "HISI0361", 0 },
>  	{ }
> @@ -317,7 +308,6 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
>  		.acpi_match_table = hisi_pcie_acpi_match,
>  	},
>  	.probe		= hisi_pcie_error_handler_probe,
> -	.remove		= hisi_pcie_error_handler_remove,
>  };
>  module_platform_driver(hisi_pcie_error_handler_driver);
>  
> -- 
> 2.50.1 (Apple Git-155)
> 

-- 
மணிவண்ணன் சதாசிவம்
