Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB83128BA;
	Thu, 29 Jan 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696098; cv=none; b=B/06XrtmKCt0Ubu5FdXPobVN75C2LmSjNI0o6DOhNvt6Oz4gLxNaPAXyah9tSTGQJt3GMJj0jD0yqiJi1Sh6H1qwpRiWKX9lROQHJ1LPzXuHhs40aqwBvmTooebnUP221yJ8lcFWIXLnb6a85b1+5FbRfhjkMLBFlbbcc7RTUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696098; c=relaxed/simple;
	bh=UFLIBLZemURTadBKq31YTIO2mVAERtUSgXgTAQFmNBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTXKj9Uc31aQUpFzKuSdAvDYJT9wa8Vs/PPwo1lULgcAh90Y385+97pbldP2+8f9E6im9kRASL2PZBi3UGkakGNeuItl2BrAFprVCtnYuMJ2h4iZnb7GjbF3GpQF96/eMRVddtdHSIH+H2aJB9xLgsX4jDsjLQFP36nxlPH6Ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0VQPGwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0VQPGwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D63C4CEF7;
	Thu, 29 Jan 2026 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769696097;
	bh=UFLIBLZemURTadBKq31YTIO2mVAERtUSgXgTAQFmNBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0VQPGwUKMvBovJNp4/6lO5gdwMMjnYiHbJhgBz77oYqC5ouiMsUQXY3pWlUdf/x3
	 Fv6Pkee4tJO/v7YARY7f9ogvLvRX/gi+bNzvPbE10DOT5DBWikhM1oDgCBYGlV+OPB
	 tq0Y9tVdyBUpNLOnKfSOw9NL1n5vl3ZrvGLHEMcsTC0wf3NML1/eiTDD1eMn59xN1L
	 Na0Jo8SdsjxdFrXdhL523hrPR5WpOGreKprUDJr9M1GE1Dv4oJgE3s7HcDE+NedBIB
	 hFwCi8kpPZJ6ITgLYpCVsi8Yo/2SUxlPoDoaJesRMKCvaJSbE/GQLVQRTuF9RSnUHM
	 rGECoPlJDBMZg==
Date: Thu, 29 Jan 2026 15:14:51 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>, Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <aXtrW7viGZfMNZur@ryzen>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129091753.490167-3-a-garg7@ti.com>

On Thu, Jan 29, 2026 at 02:47:52PM +0530, Aksh Garg wrote:
> -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
>  {
> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  	unsigned int i, num;
> @@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
>  	u32 *indexes;

Hello Aksh,

Considering that all other functions that you have modified, you have added a:

if (!ep_func)
	return;


I think you should do the same to this function.


>  
>  	/* Tear down the BAR Match Mode mapping, if any. */
> -	if (ep->bar_to_atu[bar]) {
> -		atu_index = ep->bar_to_atu[bar] - 1;
> +	if (ep_func->bar_to_atu[bar]) {
> +		atu_index = ep_func->bar_to_atu[bar] - 1;
>  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
>  		clear_bit(atu_index, ep->ib_window_map);
> -		ep->bar_to_atu[bar] = 0;
> +		ep_func->bar_to_atu[bar] = 0;

Not related to your patch,

Koichiro (he is on To:),

don't you think that it would be clearer if we had a:
		return;

here...

I mean, a BAR can either have a BAR match mode mapping or a subrange mapping,
but not both... So continuing executing code beyond this point seems pointless,
possibly even confusing.


>  	}
>  
>  	/* Tear down all Address Match Mode mappings, if any. */
> -	indexes = ep->ib_atu_indexes[bar];
> -	num = ep->num_ib_atu_indexes[bar];
> -	ep->ib_atu_indexes[bar] = NULL;
> -	ep->num_ib_atu_indexes[bar] = 0;
> +	indexes = ep_func->ib_atu_indexes[bar];
> +	num = ep_func->num_ib_atu_indexes[bar];
> +	ep_func->ib_atu_indexes[bar] = NULL;
> +	ep_func->num_ib_atu_indexes[bar] = 0;
>  	if (!indexes)
>  		return;

Sure, I see that this code will do a return here...

So there will be no harm done, but, having a simple return above
would make it extra clear to the reader that is is always one or
the other... you cannot have both.

If you agree, perhaps you could send a one liner patch?


>  	for (i = 0; i < num; i++) {
