Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B627B353;
	Wed, 25 Feb 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042342; cv=none; b=VRUqQx4ROdzqdu+Tx+OaCqgBiiulY7XEoEcx1iAGVX+hiQnTzx8Yod7SO5hvezBi8qphxZiKoW2ChvL9cK6aZ1hag72SS7hkIXGrqtW2DFT29zXkMe8ksJQoK7oOiZyulyqsssuorcNP4xljbLufGCgY0Gsm91S8TmovSP83Lrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042342; c=relaxed/simple;
	bh=N4wXMQlWHmTX1LiqSpKdHAChcSwxUp7ndYxlO5ZdoSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMyNuQByJlWlCmb4aRnoKygAwtv6MX4HT4oVXkIr1rEiINw8jOecj/Juyh4qVGmDXfbW5TryQKBjV610WpZIFhybkeEI+Zhzn03MYY+QIKzEIORl799X48tQxeJat4YIU7Fb4ckIVPVSxAWb2DXx8Ph6EPwY9KNqRd2n84Ci3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BktQS4Om; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BktQS4Om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C5C19421;
	Wed, 25 Feb 2026 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772042341;
	bh=N4wXMQlWHmTX1LiqSpKdHAChcSwxUp7ndYxlO5ZdoSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BktQS4Omv4DfG1VuGpfSVk2VBRCHZJLtT0N/q443lfcQQ36bLOE6y5o7S5v1fhula
	 mP418zNCOUVRMvyQKFn8nqdmwO1mBnZgrMOn2B3y4EMGdOM9IrP5C1hu93iExT8sPc
	 GXRIfU4H562eMxIUIF3Lt5Lo5V6MaDN26+LoV/c0110mX2BrFu69cf+kDTIUNGC/gi
	 qwl29SI8gZhHi9K8TY2U4V8RJy5jV1Tgm38sz5DhZ3SmiuPDoCMDqEye87vFPgGcJ6
	 MtsqiCMWyWwNK+mYcvAF1hyqNuQ3yqRsxRMMeor7TbTkcePyEu0UwIpMXl39BEuUek
	 8i3RXVYM4mTVw==
Date: Wed, 25 Feb 2026 18:58:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, 18255117159@163.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] misc: pci_endpoint_test: Add Tegra194 and Tegra234
 device table entries
Message-ID: <aZ84XkM3RzJLCIYX@ryzen>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
 <20260222193456.2460963-5-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222193456.2460963-5-mmaddireddy@nvidia.com>

On Mon, Feb 23, 2026 at 01:04:56AM +0530, Manikanta Maddireddy wrote:
> Add PCI device IDs and test data for Tegra194 (0x1ad4) and Tegra234
> (0x229b) endpoints so pci_endpoint_test can bind and run on these
> controllers (64K BAR alignment).
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index f166b6fea698..43545dbad26f 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -106,6 +106,9 @@
>  
>  #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
>  
> +#define PCI_DEVICE_ID_NVIDIA_TEGRA194_EP	0x1ad4
> +#define PCI_DEVICE_ID_NVIDIA_TEGRA234_EP	0x229b
> +
>  static DEFINE_IDA(pci_endpoint_test_ida);
>  
>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
> @@ -1202,6 +1205,10 @@ static const struct pci_endpoint_test_data rk3588_data = {
>  	.alignment = SZ_64K,
>  };
>  
> +static const struct pci_endpoint_test_data tegra_ep_data = {
> +	.alignment = SZ_64K,
> +};

An explcit .alignment is not needed anymore, it was only needed before we
introduced capabilities. New entries should be added without an explicit
alignment, since it will be provided by the capabilties register.


> +
>  /*
>   * If the controller's Vendor/Device ID are programmable, you may be able to
>   * use one of the existing entries for testing instead of adding a new one.
> @@ -1246,6 +1253,12 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
>  	  .driver_data = (kernel_ulong_t)&rk3588_data,
>  	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),
> +	  .driver_data = (kernel_ulong_t)&tegra_ep_data,
> +	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),
> +	  .driver_data = (kernel_ulong_t)&tegra_ep_data,
> +	},


Just add the PCI device and vendor ID without providing any additional
driver data. See e.g. these existing entries:


	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},

        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),




Kind regards,
Niklas
