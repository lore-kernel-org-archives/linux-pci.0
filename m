Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419D26A0A7;
	Tue,  3 Mar 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545593; cv=none; b=gUg5W7JG6G+c/2+uD543HDMhPC1zPPoNs/f1o4H3p/1ULRnEgpDe0goPLPHYHsyS0J73ryslJfLqKoHSG88Ii3eEZlR8u6vHhs50YrO1CYjD9NRTeRTOScwgt3R3mO6gaIxR0+Hi0ig/L0vr0i0Up+uDgFFbQg0moaTmn4coMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545593; c=relaxed/simple;
	bh=I6nlM+ZxE9hQVDxgtUYptvOOVzk2HWPvx36MyOq0BNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkI3MPEflSJQ9Kkx3M6is+D7L0H++55L/MjpRmthQs+4AnQTyj6lx1OxC7x+5AVQ1lY7zvuf4piefJM4OfF+qD3Daqan5h8+vlbWOPr23zwhCBwp7YFISPYQPAkC3KOg6KXsEQbGQ9iNa6O2dPfBpvvDg2z2XcQvrZJWhqs8B7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK4EdymV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK4EdymV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494B0C116C6;
	Tue,  3 Mar 2026 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545592;
	bh=I6nlM+ZxE9hQVDxgtUYptvOOVzk2HWPvx36MyOq0BNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KK4EdymVeESIGrAZ5oL8TBxcdP/5CxeMhMHn9zovgoqmjxbgp1/+akksJzGOnXjrz
	 QOj34AdS5RgEL+AJ8e4TKbW1BKIYLUX5qWTvH/RKfke0bwtH4sP5okGQhT9mxnCbUA
	 SvTTGJilr2wrPLeick56Wrej3jXwGrds3DT5IhnyB/iIGydIp6pIMyk1JZodOaX7A/
	 PSCkjmSoBke2UQBkNEbtJJHzsZLUtCy6d/BTsdw6UWcqbCx8uQxsqxF/vxVU1FAd3b
	 3CIk/yoL7neBxoTAtmN25VNubMWvDXuj1pXvOhLDO9Le0sWXeWW/ScfjcjEfYCh7kA
	 weDuu8RoNuHiA==
Date: Tue, 3 Mar 2026 14:46:25 +0100
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
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add reserved region type for MSI-X
 Table and PBA
Message-ID: <aabmMURUq9YubIRi@ryzen>
References: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
 <20260303072004.2384079-2-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303072004.2384079-2-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:50:00PM +0530, Manikanta Maddireddy wrote:
> Add PCI_EPC_BAR_RSVD_MSIX_TBL_RAM and PCI_EPC_BAR_RSVD_MSIX_PBA_RAM to
> enum pci_epc_bar_rsvd_region_type so that Endpoint controllers can
> describe hardware-owned MSI-X Table and PBA (Pending Bit Array) regions
> behind a BAR_RESERVED BAR.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> v2: Split MSI-X pci_epc_bar_rsvd_region_type for both MSI-X table and PBA
> 
>  include/linux/pci-epc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c181c6d107b7..fb3f34829d2b 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -214,6 +214,8 @@ enum pci_epc_bar_type {
>  /**
>   * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
>   * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
> + * @PCI_EPC_BAR_RSVD_MSIX_TBL_RAM: MSI-X table structure
> + * @PCI_EPC_BAR_RSVD_MSIX_PBA_RAM: MSI-X PBA structures

s/MSI-X PBA structures/MSI-X PBA structure/

PCIe 6.0 7.7.2 MSI-X Capability and Table Structure
references this as:
MSI-X Table structure and an MSI-X PBA structure


With that:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
