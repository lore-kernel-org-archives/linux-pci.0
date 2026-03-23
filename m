Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8237DE86;
	Mon, 23 Mar 2026 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267660; cv=none; b=gvRIbUmy6cZThk+vF3gYHqDu7yDKsXxhbcqVOKfEdZX9c5qTvA0PLSbgxIV7bhYIXpiu3BmIeDJWKT8Hy3lpQMplc4rvQ+3ypaMzyg8pv73f/Px8nRjCAL0djlr9QSvkpd82JKIunyaqZpZYcfaNm1kIWzKPxvF03dwmTg8dg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267660; c=relaxed/simple;
	bh=rwjik0cr5rcJGjHLJrO+of4Yl5E08A10pT+yTjv6m5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFs4CrpzQjYuH6SH8ttfzYn802ED9esHX1Ciww17CfsrkH6cop+HN8hGhHpK7fKfMJNi4WBinZTHizG4QnVbYkfTeLeJT0DbN/ECGn9LdO74zM6UnwRq3ND7JGu2u9qraKnJ8XdgByZcx+6UxGslRpQJIOFAiqyLtWiEFfrnxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkhvuBUV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkhvuBUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FA7C4CEF7;
	Mon, 23 Mar 2026 12:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267659;
	bh=rwjik0cr5rcJGjHLJrO+of4Yl5E08A10pT+yTjv6m5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkhvuBUVJeCOw+Njo5ohWnM6Z8qAGIdLJuo0n6AIPrdCFPUvM0J9xlLGG8EQAZPJM
	 plM3IxEjNVAgbO6GbAOX4X5DgGTKSxI+5K0SH56yqEW5tOvkNeqSa9PVHHk66VnYup
	 NorCoA/8ZbogFv1qMDhkF9SCn61j7CUrWJ7arjRZSAR2+Q9G7eN9xaRxJMIsrYUETh
	 pPM821Jzc/CeAfeCAv2wHout9NOzylmHTBSmovUdHP1b5q1pesBZOy+BBGJwmzw6sG
	 XbK4m1kegZWqnYEc/C4U9cQPUfcodWioD/RTVK+6+SSLooIsdnMz8ovPlqUhuthNkX
	 uxYi+qXL1kgVg==
Date: Mon, 23 Mar 2026 17:37:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Fix device node leak in
 pci_pwrctrl_is_required()
Message-ID: <qbpappn7f2jxbk7n6vq7o52qbewuigjj7aqokeu5eujfquipef@kj3zlqbbzzem>
References: <20260323-pwctrl-v1-1-f5c03a2df7fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323-pwctrl-v1-1-f5c03a2df7fb@gmail.com>

On Mon, Mar 23, 2026 at 07:05:22PM +0800, Felix Gu wrote:
> The for_each_endpoint_of_node() macro requires calling of_node_put() on
> the endpoint node when breaking out of the loop early.
> 
> Add of_node_put(endpoint) before the early return to properly release
> the reference.
> 
> Fixes: cf3287fb2c1f ("PCI/pwrctrl: Ensure that remote endpoint node parent has supply requirement")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Err...

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/pwrctrl/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 7754baed67f2..97cff5b8ca88 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -299,8 +299,10 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
>  			struct device_node *remote __free(device_node) =
>  				of_graph_get_remote_port_parent(endpoint);
>  			if (remote) {
> -				if (of_pci_supply_present(remote))
> +				if (of_pci_supply_present(remote)) {
> +					of_node_put(endpoint);
>  					return true;
> +				}
>  			}
>  		}
>  	}
> 
> ---
> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
> change-id: 20260323-pwctrl-fe840d733443
> 
> Best regards,
> -- 
> Felix Gu <ustc.gu@gmail.com>
> 

-- 
மணிவண்ணன் சதாசிவம்
