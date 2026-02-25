Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748129AB1D;
	Wed, 25 Feb 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040698; cv=none; b=ROk5DAfWT/WMB9cYYXTKUifZ9VjVxjS+lczjv0rn5Hc11xdmZXcdijJtj64gymSVFzM5YGoytUFHGYQg6oJXuaMw33QcrBHYmYZK2RY7VLo0Rjqu3Gk1OIYRkVk9U72HAHXPPEAHL02cz+Lwsy5YQzYiawAe8wD1T1UN5MQDy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040698; c=relaxed/simple;
	bh=KZEfuxe3ybnm6fboB6QQpEXmc00abbLOcEZVtVn0oUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdew85UCh4/pMcjQph9PawcmrImqz5q81cFKb98z06xxXCgZfsVjtgPZLuzU/j0niF/ls5zki6gL1YPcpO7zxDVN9r4XS5OfSmi2Qlg1HjEYvXMDvLueTs4fpihRQfru6+L3lDKMTAoQBtH+km1qGq5skp6lUBuhdDJ3PDn59us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM1CMM56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM1CMM56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CD9C116D0;
	Wed, 25 Feb 2026 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772040698;
	bh=KZEfuxe3ybnm6fboB6QQpEXmc00abbLOcEZVtVn0oUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZM1CMM56IoKvjF+ObxWPQ+js/sCsVVDqTdLXe7GR8/tn8kb7FOW78N3RpuD+XiorL
	 S9oVz/EL+7nDbs83AgB2SgX9eUEkthJxg7/U8V4iV/4ts5auZSL8/OCIsO1dxGhSK7
	 36on0spfTDK32GyNUSKbKAkR46Clusoh6GiFqUcar34ZK924CQ0MlLjdq5A4AeZom0
	 mXuauACWqZ3bFt+/+Ga5hao2wDYBPw7dNgJ3Bh6Hjd3ncqxzJI0yBKJ871SY5Dbxbb
	 V6h0G6npOZ5ing+PY5X3XHdHFyAkcf6oiBYMk6Bq8fAh5SeTQqLMYmmY5DTG5sCITn
	 PLeutg36uzLYQ==
Date: Wed, 25 Feb 2026 18:31:31 +0100
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
Subject: Re: [PATCH 2/4] PCI: tegra194: Make BAR0 programmable and remove 1MB
 size limit
Message-ID: <aZ8x80iu6p7XBD2W@ryzen>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
 <20260222193456.2460963-3-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222193456.2460963-3-mmaddireddy@nvidia.com>

On Mon, Feb 23, 2026 at 01:04:54AM +0530, Manikanta Maddireddy wrote:
> BAR0 is capable of supporting various sizes via DBI2 BAR registers
> programmed in dw_pcie_ep_set_bar_programmable(). Remove the 1MB fixed
> size from pci_epc_features and set the BAR type to BAR_PROGRAMMABLE.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4a3b50322204..3c84a230dc79 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2000,11 +2000,11 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +/* Tegra EP: BAR0 = 64-bit programmable BAR */
>  static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.linkup_notifier = true,
>  	.msi_capable = true,
> -	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
> -			.only_64bit = true, },
> +	.bar[BAR_0] = { .type = BAR_PROGRAMMABLE, .only_64bit = true, },

If BAR_PROGRAMMABLE, you don't strictly need .type at all, as
BAR_PROGRAMMABLE is (and has always been) the default, defined as value 0.
(So you could simply drop .type from the initializer.)



Are you sure that the BAR is Programmable and not Resizable though?
Because historically, a lot of BARs were defined as Fixed size BARs with
size 1 MB, because there was no Resizable BAR support yet
(the minimum size of a Resizable BAR is 1 MB).

See e.g.:
6a6b66f7e607 ("PCI: keystone: Describe Resizable BARs as Resizable BARs")
aba2b17810d7 ("PCI: dw-rockchip: Describe Resizable BARs as Resizable BARs")


One easy way to check this is to just do (on the host side):

# lspci -s 0000:01:00.0  -vvv | grep Resizable
        Capabilities: [2e8 v1] Physical Resizable BAR

Here you see e.g. that RK3588 based EP implements the "Physical Resizable BAR"
capability.
(Replace 0000:01:00.0 with the BDF of your Tegra based EP.)


Kind regards,
Niklas
