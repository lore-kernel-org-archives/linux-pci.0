Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97835CBA3;
	Thu, 12 Feb 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916153; cv=none; b=Ha3hzGXGdZR+pWiWJvf8v3JRrupHijV0EeilamBCI020J+Pe7Xt4TWrP8qeDyaRx5TuCkbedGOvGwFz4MrkuiwrPTtsuygHvahwSjzJzr21bBiZMKjwctDtl5cq+vHmuRgsDopuNdimtZHo+CWLiO3AcB5W1Mz+yRvObfrD/ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916153; c=relaxed/simple;
	bh=wCZvkCr5CCWsMzFm1KQKhBpii7dDwhTD7XL3vgVQ3HA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cSxrHEWS+649o46tSY1gaifzfFa72TcCjsevORj+761lo3xoP9RW4qDuQOWV4/XT70DpNuj5hHsGuogMDD9MyluPEtSX+DFO0HmEqH8E9BZ+gspXpNIH6Dc6GDFismex2SDBRxEixoOuBSE1oaXgdKYDxUi7PMeto+UYC02uZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCIIBSwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCIIBSwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C591EC16AAE;
	Thu, 12 Feb 2026 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770916153;
	bh=wCZvkCr5CCWsMzFm1KQKhBpii7dDwhTD7XL3vgVQ3HA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iCIIBSwHkVHg7WxEgVzCaBcO3XTGTfmIOrw5NelQvLMjb6VeDQlAdHus17ChFZUGh
	 O+trF93NYG9uvnkW+bFDx8Ri2cc+LCkxXidLGG787SXqJZ9ayGZYx8+EmHZBGDo2Qp
	 Mqe9Vv22Ro9oKoWzC6q0pTJTklzgoFvxJRR9bx2HKLu4uELnJAtBwx6qlq5RW4m85w
	 TUui6zEulK9ShjYr1JnpBVaFcLn6RwUUSvX8F0RvXI28YRT5NTF2N4S80J0pyERWT0
	 o3IiMPN2asKFYpB7Rh4jT3ghujopV73aQ1Igxw43A483NVCdLMYjkEqbQEVDTPPj/I
	 HICaIPPsL386g==
Date: Thu, 12 Feb 2026 11:09:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Validate window resource type in
 pbus_select_window_for_type()
Message-ID: <20260212170911.GA936496@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210142058.82701-1-kaihengf@nvidia.com>

On Tue, Feb 10, 2026 at 10:20:57PM +0800, Kai-Heng Feng wrote:
> Afer commit ebe091ad81e1 ("PCI: Use pbus_select_window_for_type() during
> IO window sizing") and commit ae88d0b9c57f ("PCI: Use
> pbus_select_window_for_type() during mem window sizing"), many bridge
> window can't get resource assigned:
> pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> 
> Those commits replace find_bus_resource_of_type() with
> pbus_select_window_for_type(), and the latter lacks resource type
> validation.
> 
> This commit adds the resource type validation back to
> pbus_select_window_for_type() to match the original behavior.
> 
> Fixes: 74afce3dfcba ("PCI: Add bridge window selection functions")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221072
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Applied to for-linus for v7.0, thanks!

> ---
>  drivers/pci/setup-bus.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e680f75a5b5e..1b5185697011 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -224,14 +224,21 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
>  
>  	switch (iores_type) {
>  	case IORESOURCE_IO:
> -		return pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> +		win = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> +		if (win && (win->flags & IORESOURCE_IO))
> +			return win;
> +		return NULL;
>  
>  	case IORESOURCE_MEM:
>  		mmio = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_MEM_WINDOW);
>  		mmio_pref = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_PREF_MEM_WINDOW);
>  
> -		if (!(type & IORESOURCE_PREFETCH) ||
> -		    !(mmio_pref->flags & IORESOURCE_MEM))
> +		if (mmio && !(mmio->flags & IORESOURCE_MEM))
> +			mmio = NULL;
> +		if (mmio_pref && !(mmio_pref->flags & IORESOURCE_MEM))
> +			mmio_pref = NULL;
> +
> +		if (!(type & IORESOURCE_PREFETCH) || !mmio_pref)
>  			return mmio;
>  
>  		if ((type & IORESOURCE_MEM_64) ||
> -- 
> 2.43.0
> 
