Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4A358D14;
	Thu, 22 Jan 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106209; cv=none; b=neMOabSbP0CxQoYFmBdk7fCd66rZNbVC3TM6/s3lAbyUwn3nL5iAv0CcphbmUmv0PGanzHuGxblRAMx5B4Pgk0LBAPF7xUxZNEzmpLYq+MU2EQuVTbT1KikJClvRQwODcmVV4x/qPsoocGKWpZ4aGX935HOLsduFw/QLrw6oyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106209; c=relaxed/simple;
	bh=4v/AVp8nijTC+uKCnCV8ws0aA8LIXuQFjOYCQy64ccA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ONIpwwxe7QrX1yxLSlWslxBO0qv/cWFykkpJkKQSj5XkHnEZE8cLfQPP8GYVcvXqRmHiOQtMRxyfU/Qetj3rD2YIniSLtG5vqb+4YtiErlwe1fXdpT2YFFDHH6Ogd2wF4yGnJ0pbCQ041avJW7nogp7p8f7HRqvf62l+1xMmewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv2/IULj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv2/IULj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4B1C116C6;
	Thu, 22 Jan 2026 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769106208;
	bh=4v/AVp8nijTC+uKCnCV8ws0aA8LIXuQFjOYCQy64ccA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Kv2/IULjXY5zv3Ryf35bWX87p4mRtkC/7NB3sMoJa1j+pthmdt5c8kIUxodtfBPj4
	 mSmuRag5KnQp7UpV0DhdfHa+aGbPVzKRn0zjYQEIwKEe4foy+2YMx59JrUxwhraZLa
	 4t3meGXT9PYa2wpNHRHpdq3TrhF7unaM4TbDsMhVvYdqSftPncY5HRuYHXZwR/nZcl
	 kd/3oOsJehx0CWNypm1IpHXnPw1rJ18hUqtl6pyNpVB3ggejFWKxSvbgxKw4JsUx9D
	 mFNj/tl14iJDQKvhm6S1OfBiJMU1pWUHX1ZnTcdIqXzwwfJt/c5qCf3WIq9aqAEYWT
	 VuaG5PmBcP5eg==
Date: Thu, 22 Jan 2026 12:23:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 06/34] PCI: Replace cxl_error_is_native() with
 pcie_aer_is_native()
Message-ID: <20260122182326.GA16726@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-7-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:27PM -0600, Terry Bowman wrote:
> The AER driver includes a CXL support function cxl_error_is_native(). This
> function adds no additional value from pcie_aer_is_native().
> 
> Simplify the codebase by removing cxl_error_is_native() and replace
> occurrences of cxl_error_is_native() with pcie_aer_is_native().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> Changes in v13->v14:
> - New commit (Dan)
> ---
>  drivers/pci/pcie/aer.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa896803..c99ba2a1159c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1166,13 +1166,6 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>  	return true;
>  }
>  
> -static bool cxl_error_is_native(struct pci_dev *dev)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> -
> -	return (pcie_ports_native || host->native_aer);
> -}
> -
>  static bool is_internal_error(struct aer_err_info *info)
>  {
>  	if (info->severity == AER_CORRECTABLE)
> @@ -1186,7 +1179,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	struct aer_err_info *info = (struct aer_err_info *)data;
>  	const struct pci_error_handlers *err_handler;
>  
> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> +	if (!is_cxl_mem_dev(dev) || !pcie_aer_is_native(dev))
>  		return 0;
>  
>  	/* Protect dev->driver */
> @@ -1227,7 +1220,7 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>  	bool *handles_cxl = data;
>  
>  	if (!*handles_cxl)
> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +		*handles_cxl = is_cxl_mem_dev(dev) && pcie_aer_is_native(dev);
>  
>  	/* Non-zero terminates iteration */
>  	return *handles_cxl;
> -- 
> 2.34.1
> 
