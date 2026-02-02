Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F222301;
	Mon,  2 Feb 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038315; cv=none; b=jpQ76HhOXNDRya21Ar4aXteLVeTlxcJQIr41T9i0z742u5REfdtsKwI1FnBoagz4yf4tGCZKDN4WoOdXJypnIQzzb7Nacde5nJpk4b+332VdZEllfQOBYqYrE45g/gfNX4Sr0c3+dQ3O6T+CfEs80ow9I39+rLXWuivT7GixAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038315; c=relaxed/simple;
	bh=W7c7pgUrTFjdZTelEf6hNNG1gxYMmfAV5JcXC1NB+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7RzK4BHo85hltLkB3GRgnM6u/JEMmGQI0UY6DW/ZfXmb7WAh0VqwLnjseJlqOnZ8d2zHHTLduCx8GFvEi0+oQ8oPYxffWu49wdYTgSoHkI6dlcXByflDfwHhsoxu1Z8xWOeC3c3WHooLi2NwUncR890BVgBwBdvJAQk4k2SXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRIBkGyW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRIBkGyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E454BC116C6;
	Mon,  2 Feb 2026 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770038314;
	bh=W7c7pgUrTFjdZTelEf6hNNG1gxYMmfAV5JcXC1NB+I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRIBkGyWjmofVDdhDf4qT/1saarer8FexlI+HfYk38vNj7Hp1/RkpETs/5gAzuuJ8
	 dfcUOwvKq6hULlaaDJCsoyjx0svRibm8LFhU1Bj7T92B2qc65vdajDYpGT7s2LykXm
	 5P0BvVreH4WRULQl6lFppKMLFwjpb6FgZ+ItNnW29P969Z+sQyY/lLqLRHQ4zkeCKS
	 VG6XpKO/IsNKVpwnyCLUZTCcTyI8p0ki8cO97T+piNd2yCtk8ZWPceaL2yis7+9uCy
	 Ak3GxNh0PLIVfJxzwKXYoaByN7BQ0+pUAjPLdfSP6PB2EkvBl7Ow1edws1mbLNvbU5
	 iwt1uhgzFpdYw==
Date: Mon, 2 Feb 2026 18:48:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: s32g: Fix ports parsing
Message-ID: <scnf5gh3h5pwvnbe4bwtztdlgcpvvtse4fg64bto2jgyotfpwl@sle4k4ky3gtu>
References: <20260202130756.1421488-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202130756.1421488-1-vincent.guittot@linaro.org>

On Mon, Feb 02, 2026 at 02:07:56PM +0100, Vincent Guittot wrote:
> No error return is missing after the loop resulting in removing the
> ports from the list.
> 
> Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> index 47745749f75c..767f5a622441 100644
> --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> @@ -285,6 +285,8 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
>  			goto err_port;
>  	}
>  
> +	return 0;
> +

Hmm. So the initial 'ret = -ENOENT' will become redundant and you'll return
success even if there are no Root Ports in DT.

You should do:

	if (!of_get_available_child_count(dev->of_node))
		return -ENOENT;

at the start and remove the 'ret' initialization.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
