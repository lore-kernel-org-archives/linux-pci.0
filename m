Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267220;
	b=Y26kQ895AZWPwualVYPjs1/vyH9M3Nz781ubsjeCd9DgesDYcenilbWcwyFG3bKZl3dD
	 JzwPLlJMKmY7A4ne7GOuXEBkd6rI971UIPdx1YMg7bltfFZeL+XAhB1mmYgJdAxFDlQY6
	 Q9iuN+DEkMJQRD0tGXU3nlBddviz/iN8q4iBYqPBQIrz5VbTWmnlxtA3xZOp/9ECzP4+Z
	 NRrqbQezeBHtQncfebtEVL9DVJPn0dvw3n7aognitQOR9aAPei+9kJHpWYEwPrM1AcMPX
	 YBH5L2KD48gARs5Y+91Yez8pziE1lPb2oXW0MLS31U9JhB1ZhgtBsl86JvRtxWi/xhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267220;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Hz8e4WryqgQOGcpyR3Tt5FcQfkJAOeVGtP6iTBx8Cpo=;
	b=ttrgjXwOqgy644M/MytRv9286P/20+CwTQnFic7+eM0O/nb9KPrOoh9Gyk4u7AvESNCm
	 65klcTtsn8nJzTsxlUfFbhUUBsjSO3oD0mmo5u6MhU725tOW344A/0qiJ8LGhAJPb+4mU
	 jCdR09/d6tZ8HXxwTOAeqSaa+QBnW1SytTqOgC+ZQ2dvYyclE8pV4hAMz/IAc/JepBw6g
	 JzfRjGp5jTo6kpsVJexwd1/jzTNT9v5oaunTta64oOrXPburIYs4kuMO3v38SYfC8VV+2
	 oRHyrBbPJPuctvorMY601fmAgVl4ub+YDkFGNfc1dSCy+/0HcuB8EMNnr/h9HuLrKvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fc/tfL4J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3449606A321;
	Mon,  9 Nov 2026 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc/tfL4J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E2E1F0089F;
	Mon,  9 Nov 2026 23:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267219;
	bh=Hz8e4WryqgQOGcpyR3Tt5FcQfkJAOeVGtP6iTBx8Cpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Fc/tfL4J0xrgTzp5GBoebWdQEAeMt53mzTZCtylGdEm3yGjUW5c+tn6u6ofIhbLVo
	 W0KnFkTc6gz6e7l31fbF5BhZmPTrMre3uEUc7DHHDOEOI0LHhPy3I9q3ndtwo+AIFa
	 CVFB1Y1x+NO+kzfj2q992UCAkLBQdGUkd2pVXh0u8pG9tigX8WZypS2KNExDkvp5Th
	 hj1laTj7XQ5cfPa+xOWsyqDHTeJcR8XlwHa+nwJDxHSEvB4YssT3SbAncW9iAyJalw
	 pdLb2fo7YpHX3yKZgCRz+W8oaG0UH8T2KA3xtGUy1gUGTVOlR7PuN97uIrnhSO7x0o
	 tR8eO/AlfA2xA==
Date: Mon, 9 Nov 2026 17:33:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix pcim_iomap_regions() error path rollback and
 leak
Message-ID: <20261109233337.GA347778@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109113136.2295-1-lirongqing@baidu.com>

On Mon, Nov 09, 2026 at 07:31:36PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> pcim_iomap_regions() has two problems in its error path.
> 
> First, the rollback loop walks every bar index below the failing one
> and unmaps it, regardless of whether that bar is in the mask this call
> was asked to map. pcim_iounmap_region() matches devres entries by
> (type, bar) only, so it can release a mapping that an earlier
> pcim_iomap_region()/pcim_iomap_regions() call made. The driver is then
> left with an __iomem pointer that has been unmapped and a legacy table
> entry cleared. Restrict the rollback to bars in mask.
> 
> Second, when pcim_add_mapping_to_legacy_table() fails, the current
> bar's mapping is not released: the rollback loop starts at --bar, so
> the failing bar itself is skipped, and the mapping stays registered
> until the driver detaches. Release it on this path as well.
> 
> Fixes: bbaff68bf4a4 ("PCI: Add managed partial-BAR request and map infrastructure")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Hoping for a Reviewed-by from Philipp.

If there's a v2, s/bar/BAR/ above to match other usage.  If no v2,
I'll tweak that when applying.

> ---
>  drivers/pci/devres.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index f075e78..9bdb4de 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -689,14 +689,18 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
>  			goto err;
>  		}
>  		ret = pcim_add_mapping_to_legacy_table(pdev, mapping, bar);
> -		if (ret != 0)
> +		if (ret != 0) {
> +			pcim_iounmap_region(pdev, bar);
>  			goto err;
> +		}
>  	}
>  
>  	return 0;
>  
>  err:
>  	while (--bar >= 0) {
> +		if (!mask_contains_bar(mask, bar))
> +			continue;
>  		pcim_iounmap_region(pdev, bar);
>  		pcim_remove_bar_from_legacy_table(pdev, bar);
>  	}
> -- 
> 2.9.4
> 
