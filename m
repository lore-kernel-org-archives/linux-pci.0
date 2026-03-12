Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2C2BCF5D;
	Thu, 12 Mar 2026 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352321; cv=none; b=OT623IbTVth0QgGKBrPgZ984NZ/DAb14XC6UXJUWTTXuL6+G6lOrkbXa9Y7j/uxMgMvweNvcvM6ErlpHPJDt0058j9VEHDu6SoxccJKbd5+azluFFZglSewY//Nx5AtTfTQRzD0iL5ODs426l+Rvd6RcUsBwnKAt06zbc9n49X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352321; c=relaxed/simple;
	bh=lwfGo0qtV/Ia8a2qLDU52ja8CekcQlMzEIsHtn4P9vM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NsJ84hGifNCEMm0fbQ+EU9aJPhDYBZXtYIYK9rLGhmRk19piXFshl8xmYejUgbKEIrPXfz/OJYsXFBnaL3Y9gZZo3PiDyNmSHFgwuPKqXEHsgFWP1JhAoQIMLjopR7N8DRmdPifhSQMaHnTmuDYlTRbrbKjSUN30Av7VTR2SnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r25spFbb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r25spFbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B9AC4CEF7;
	Thu, 12 Mar 2026 21:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773352321;
	bh=lwfGo0qtV/Ia8a2qLDU52ja8CekcQlMzEIsHtn4P9vM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r25spFbbHoz47mqu4PG6YHIiOx/rjPEqe7WM+3I7gBHIOREBELFv6c4XMMmNnvIXG
	 GiwMVWby0e1oaK6BaXLzNBXo0SkTFv3mj5oMp0su/wg5mWsRCNpQpJRIMBJDLJaGd8
	 XA0rucrxhtgo1PwFQ0d3O/lX9XMFZ46P3OduDgJCMz57JrFkZOCq9gNmwJRg5eKJK5
	 8aEeYHKqU0JzrInnr6SZDqS2HGHCj8aogBtJPasr/vPDAP4cTOjuhiEGXlEckNMeHT
	 dnJb0/eiZ4PWZ7EiP+0PheO/vgz2Iox7U0DrNv/+flF3XzjcJVejCUigc0DtGwEPAL
	 Nul2C8nDneuxA==
Date: Thu, 12 Mar 2026 16:52:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kristinc@nvidia.com,
	newtonl@nvidia.com, kaihengf@nvidia.com, tdave@nvidia.com
Subject: Re: [PATCH] PCI: use pr_warn_once for ACS parameter parse failure
Message-ID: <20260312215200.GA1232914@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312115441.8168-1-icheng@nvidia.com>

On Thu, Mar 12, 2026 at 07:54:41PM +0800, Richard Cheng wrote:
> When the ACS command line parameter cannot be parsed, the kernel skips
> applying the requested ACS override. This indicates an invalid boot
> parameter and should not be logged at informational level.
> 
> Use pr_warn_once() so the message is surfaced as a warning while still
> avoiding repeated log spam during device enumeration.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Acked-by: Tushar Dave <tdave@nvidia.com>

Applied to pci/misc for v7.1, thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..4e3b051c0f5f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -953,7 +953,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  
>  		ret = pci_dev_str_match(dev, p, &p);
>  		if (ret < 0) {
> -			pr_info_once("PCI: Can't parse ACS command line parameter\n");
> +			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
>  			break;
>  		} else if (ret == 1) {
>  			/* Found a match */
> -- 
> 2.51.0
> 
> 
