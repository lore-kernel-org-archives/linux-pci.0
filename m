Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B63D9557;
	Sat, 15 Aug 2026 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778430; cv=none; b=SeUh7s32TiS5NI5icjlz8YIiv9gV9T2qUselF/IXJJ7pwYa16oUdoZkLGfHN/KappM5ONAaltPc1b3dG/EX4hxZr1bQESF7qcQc9GzwZehc12XFekIpxvQ8PhzIamF46/pVnFKnBTaoKpc1oC0p36ySIKKxbKfC+Qr5vTjKcqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778430; c=relaxed/simple;
	bh=XYrAbTmlK8ZCpjGqY2W1KtZ5xeY6XiCx0AKFg8aOH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqzqHm6+9NVpjtdhy6NRuILW7K/JP8c+FchiwwcW0+/A5fkBtS9dmGWFvWF4zWFaFaDpSQUSsqr3WTQtQZArQYNcuJhA5ud0SuAJJwVShcd+yn+drDy1v8i2TXhq+Yx6NX/JPu4V9NdCYfe1hhOdkesfAc9cRSd7D6G4/acNHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 9F24410627;
	Sat, 15 Aug 2026 09:20:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 87B716031472; Sat, 15 Aug 2026 09:20:19 +0200 (CEST)
Date: Sat, 15 Aug 2026 09:20:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, mmaddireddy@nvidia.com, kumarahul@nvidia.com,
	sagar.tv@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] PCI: Clear stale 14-Bit Tag Requester Enable when
 a link leaves Flit Mode
Message-ID: <aoATM42xAn07Rpn_@wunner.de>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-5-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814201621.2281245-5-vidyas@nvidia.com>

On Sat, Aug 15, 2026 at 01:46:20AM +0530, Vidya Sagar wrote:
> @@ -4874,6 +4985,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
>  
> +		/*
> +		 * The link has had a chance to come back; refresh the
> +		 * bridge's (and subtree's) DEV3_CTL.14-Bit Tag Requester
> +		 * Enable against the live LNKSTA2.Flit_Mode before we issue
> +		 * the first config TLP to the child.
> +		 */
> +		pci_bridge_refresh_14bit_tag(dev);
> +
>  		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
>  			return 0;

pci_bridge_wait_for_secondary_bus() should just do what it says,
i.e. wait.  It shouldn't have side effects like mutating register
state.

I'm wondering if this is a quirk of the PCIe IP used on Nvidia's
arm64 CPUs, as I can't find a spec section that says software
needs to clean up 14 Bit Tag enablement when the link switches
from Flit Mode to Non-Flit Mode.

Thanks,

Lukas
