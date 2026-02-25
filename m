Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B725EF9C;
	Wed, 25 Feb 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040122; cv=none; b=RfD05aeJ4RXZKxJLMz4j9TG0Erqys8YTxVjd9OJQegopxNajNs1luzK3qPHIPtV3/+5rqpUCT8h3ytMEWWEnME+ENDQz24iVXJ/twiUVpa+94hjtxJm/ZK2H/jESA5NnZr1uR1EQpHDcM4XvE038TPbHmbTwdkMqmCLxw5+08wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040122; c=relaxed/simple;
	bh=fA4J8XS4SAnpo6NE5zuDvbC7ny+RG1AxY7iwWzrc0js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlpIU+9U/j7O/4/ayv4bfsuh+DMAJHqsPkdtvr5loZurFwxESPVJ9FmTU92H4G0SpIyeeh4w9KT8gZ0BwvOZyJVri/YrJnH4G+hMED0wH8Rv4lNrrwwNefxEhU7QNiED64xq5t4rHxuWmI+0arq6bv8M3REBabF9YcycHw7T3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtLbnSG0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtLbnSG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0251C116D0;
	Wed, 25 Feb 2026 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772040122;
	bh=fA4J8XS4SAnpo6NE5zuDvbC7ny+RG1AxY7iwWzrc0js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtLbnSG0CtTKhS/IylLnI0QglhPhZidLEv4yZIhLyxVBLrspb6VJRhs8HtLhCAsnJ
	 ugs+ALV8IhqvMH0vHaekhdxJmqbaDo8vVZIonOFaF1uiqg1gnNjKLmTo20WvPRlsj4
	 yr7+X8KyLAfNSEk0K2Bsrq9w9esAgnnq0HIFywyLgJaAJmOMuffBSo+t+gNDr2Ru13
	 JNlHHv4XJCW+m5wv9oFFljcqBNxc0IACwZm44Dz1jHNEA0VT3pJlqicSrcHOSLDyQ0
	 OxbRUJbGQdGd5IDE2kp4eFEQdDp0DR90c9+/dEfsP+NhSkJ+T892JotuVLvoax+6ml
	 AwTcJ6TVlFRig==
Date: Wed, 25 Feb 2026 18:21:55 +0100
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
Subject: Re: [PATCH 1/4] PCI: endpoint: Add reserved region type for MSI-X
 Table and PBA
Message-ID: <aZ8vs4uMUj-PLqvJ@ryzen>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
 <20260222193456.2460963-2-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222193456.2460963-2-mmaddireddy@nvidia.com>

On Mon, Feb 23, 2026 at 01:04:53AM +0530, Manikanta Maddireddy wrote:
> Add PCI_EPC_BAR_RSVD_MSIX_CTRL_MMIO to enum pci_epc_bar_rsvd_region_type
> so that endpoint controllers can describe hardware-owned MSI-X Table and
> PBA (Pending Bit Array) regions behind a BAR_RESERVED BAR.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  include/linux/pci-epc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c181c6d107b7..89ab7d07c5d6 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -214,6 +214,7 @@ enum pci_epc_bar_type {
>  /**
>   * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
>   * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
> + * @PCI_EPC_BAR_RSVD_MSIX_CTRL_RAM: MSI-X table and PBA structures

Is it perhaps better to have MSI-X table and PBA structure as two separate
entries?

E.g. in RK3588 TRM:

BAR4: MSI-X Table
Offset: 0x4000
MSI-X Table

BAR4: MSI-X PBA
Offset: 0x5000
MSI-X PBA

Because, at least on RK3588, these seem to have two separate fixed offsets.

Yes, you can probably read PCI_MSIX_TABLE_SIZE in the MSI-X capability.

But, AFAICT from reading the RK3588 TRM (regardless of the size of the
MSI-X table), the PBA is always at offset 0x5000.


Kind regards,
Niklas


>   *
>   * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
>   * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
> @@ -221,6 +222,7 @@ enum pci_epc_bar_type {
>   */
>  enum pci_epc_bar_rsvd_region_type {
>  	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
> +	PCI_EPC_BAR_RSVD_MSIX_CTRL_RAM,
>  };
>  
>  /**
> -- 
> 2.34.1
> 
