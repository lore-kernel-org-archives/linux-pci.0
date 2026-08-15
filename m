Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D63C3F48;
	Sat, 15 Aug 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778652; cv=none; b=FuuW7twQI8sju00IqfjaQeUWvpjoJGWqs+dMkiIPwTFl9oySKsH0WEf8T5lo0vy1h9uDTijoy/NbQIb7QA4TmDfV566SMeqsrAA9h9UYb5vgykQ2L95JivHvJOlR6K799esv+mw1vbdvPEMZeT061Ao+ND50Xt1py9Zqo5i4WiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778652; c=relaxed/simple;
	bh=Z8fw3JDUeCgSL0umK7qZ2jwTKHXrrQlLjEY9cVZ/jG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHv7Im5h/SlIBVWB9tqAb6yRRYdqUgh07R7p7nmd0s1Wnaalp/fjBUPl6cYyQA2raZklHsZvFiMj7hsloQOnoNaPnECsezhkPx3c/8lB5npQ4dwTPiXRF380HHEu6cZtW070o3QxixOmqzKKo5zN3kTolC6MMfi204YASBV0TnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 3C2A7C2D;
	Sat, 15 Aug 2026 09:24:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 05C216031472; Sat, 15 Aug 2026 09:24:09 +0200 (CEST)
Date: Sat, 15 Aug 2026 09:24:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, mmaddireddy@nvidia.com, kumarahul@nvidia.com,
	sagar.tv@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/5] PCI: pciehp: Clear stale 14-Bit Tag Requester
 Enable on hot add
Message-ID: <aoAUGPdr9nKj7OZm@wunner.de>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-6-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814201621.2281245-6-vidyas@nvidia.com>

On Sat, Aug 15, 2026 at 01:46:21AM +0530, Vidya Sagar wrote:
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -302,6 +302,14 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	if (ctrl->inband_presence_disabled)
>  		pcie_wait_for_presence(pdev);
>  
> +	/*
> +	 * The link is up, but a newly inserted card may have trained it in a
> +	 * different mode than the card that was removed left it in.  Drop a
> +	 * now stale 14-Bit Tag Requester Enable on the Port before the first
> +	 * config read below, which the Port issues as the requester.
> +	 */
> +	pci_bridge_refresh_14bit_tag(pdev);
> +
>  	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
>  					PCI_DEVFN(0, 0));

pciehp_check_link_status() should only do what its name implies,
i.e. return whether the link is up.  It should not have side effects
like mutating register state.

I instead suggest clearing 10-Bit and 14-Bit enablement in
pciehp_unconfigure_device(), i.e. on removal.

Thanks,

Lukas
