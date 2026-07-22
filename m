Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5E3112A5;
	Wed, 22 Jul 2026 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698376; cv=none; b=t/rwtwCEf68nisSl9BwytucKQZUPrXXC65ZghdAKUa1X0oIJer/gMlP1ULGdobvUHJhf0msj++bL9DWawcWEruFgRDz1T1vTavCyyjtKQ/1CEnOYIK/8GmAbhRL4B9FkI1IjQfKNvySMSM66NHEPZoIMAIl9n80NqNB4LV2LLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698376; c=relaxed/simple;
	bh=IcBkDJyTXDxD+R7kfh8cKQI0Anl48nl+wvgQ1oMyKL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM3FmEDMHyUNxYkhT0JfHgf8KVHNAINfCRNEse4d+m+fqfI+Twp9/+9hf/rRBmW9IuHkwcIC3IevbzNJzhs2Rs8o+Rg2nEeZrp6uaExeHQtuO7I7U2KlJPD93BYVNug/q2b4rpwlzDcJ30+NaDVrBCgmYz5QQOlu7d8J2FULltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYJWB/uN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYJWB/uN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB011F000E9;
	Wed, 22 Jul 2026 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784698375;
	bh=Q6PtCYLiv3L0QCsqbceCxK/QFIlULsxOAKiXVhFhwWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BYJWB/uNrWQPb95NJxtGOx0/M6Bq6unTuN7Og+gQ1NalDszWXO4E2IOr6UoaA4zcy
	 TMJEPL7Palx3KgH/CjgijQTGH0Jfq5sIe65qU8AJ9AsvYXajXpb4NK4eEAgA+Oy+wC
	 TV5PbklMZSFiINKQffv/D1zBRMnumIt3PsSHEoTFFJjUnCHcd2RiiJOMyjkzYDHiEy
	 zEDHaDhRr31TPtNCCZjM5oi9G0QYBHEfbb1s9Vnin4POfdH55q5yIuEU8CxpwRS27k
	 tB65G0BXNyRFFGeZjv21xqubD1WHCVAMFA9/eb2cYbQ3SQ0yp84C2koX/xCGc7Z44L
	 ogb+MaeTqJ/pw==
Date: Wed, 22 Jul 2026 08:32:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Nvidia Vera Rubin device to P2P whitelist
Message-ID: <20260722053248.GQ110966@unreal>
References: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>

On Sun, Jul 05, 2026 at 12:54:07PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Nvidia Vera Rubin platforms support PCI peer‑to‑peer transactions.
> Add them to the P2P whitelist to enable this functionality.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/p2pdma.c | 5 +++++
>  1 file changed, 5 insertions(+)

Bjorn,

Is anything else missing? Can you please merge it?

Thanks

> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b2d5266f8653..9334eb314663 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -564,6 +564,11 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_6XXX, 0},
>  	/* Google SoCs. */
>  	{PCI_VENDOR_ID_GOOGLE,	PCI_ANY_ID, 0},
> +	/* Nvidia CPUs */
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f95, 0},
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f96, 0},
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f97, 0},
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f98, 0},
>  	{}
>  };
>  
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260615-p2p-vr-514bd262a839
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 
> 
