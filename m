Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584430;
	b=QnfURZSBqM+BilAHg3YAVJ6Amvo0UePbYw4o2VNbQ4NAQIqjG2Z8IDQSizKP2rmc+x0U
	 7WbOwIXX4hd+c7ye/KGcSmyK00KpQHWIhC72zhqa7sErgjtf35GP4MyeM2fGGDoBXQ05L
	 rjmMQ8PIg5YAHJRDWqJrmgtb55SF9NmljnizJLU51EhhZ5MaxzFDI+8vmy/dCB6ktM++g
	 uzXucEunZVHzdZ48a4O7fDK9wQD2tGPaX5rlVVH+CZ/uvno/zd7QeIZ6YXszVaQHRWQU8
	 HBE94apdYxRwVvpLIUDKSJReSTxrCqXN5ZadgYFsB6WiDz37o9eFPwgVUgWmWR1wZsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584430;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ANQ3/bg3Uk8FuOZwxlcjmLvpGxkRq2me1jlvChXTFBg=;
	b=L5ohJplSV+B21LdQTCukmatGC8AXMuzZ2sAIBBWDNExj7ztFZrgOeqVln4es4eqGwlXO
	 Mu7D3JbrEtWVxvDrMUV/+p+xWQxWFx2jQvJSu+cnm0ERrCXB0hWYgeD3xzebIK7+PZ2vr
	 hC+4tEjdZm+hu95ZGLhglAW/LbXbsfK7GWL8e5uYvnJ5aKWBCJ+eNxr/7fBdRmNHHhD0J
	 062H9m8t2Oy7LHyaFUSOht+WOf8/4SIElwM0vBDxF2SpL2DkXqNHRPo6uki5ghku5/dn0
	 mFeJ0RZdAGGHJiVHyQ2jMOW3/gTstRyCcvbnsLrk9HRBzt42CrBdOZHF2mFjfDxYf7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMLGVTvr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2A606A323;
	Fri, 13 Nov 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMLGVTvr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584429;
	b=xvG/+qFZG0nZqR+D/A/DPPapUiTeBIs/CBdJ2WxUb7KJvQ11hT2+Bk/CojiUZ5TzWD5Q
	 UtG0oBxlYyUmjLKpA/mn/5JMWlHuREmWElJqJ5OSa2Ua3s8FTSYfDCPWL6F+LE5eP9Bgx
	 XivgBq+2a1ZBA6bA0XqaykoT3R69N+Trx6bXO+er5qURKNbdmCitCb6hSeBJ3wSFEHsqT
	 osVEhBpfBNgCf/FVcrBx3mDId91ldwvUWOpzkIMxF0qLlkwPsW/bCtLapdLdG3qvlyrQP
	 mf+tC+xgJr5mTI3DzHW5PpzFTz1AQwMx7VQjIaFTZmA65BIvWDyiT7EFdRUI7M7KB4A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584429;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ANQ3/bg3Uk8FuOZwxlcjmLvpGxkRq2me1jlvChXTFBg=;
	b=npz/DpYg+aArr+amwRgXciPG8hl9yBKtFHYHSogTVSjlRcW1R71AXMzrOfQEGCpt1HNL
	 ZlbtTAuyuI3n324aCbmB5Ak5HsZQ6m78DncI4G8CTusqS6D2aEwmIrYv63B8By6Sx60o3
	 jVMfkzZaOdeGpwWbDEldhvc//+GDCsHsnDELyfrIdbtWNr+QfwSCtCeIlVvKJoQaNmbXw
	 R1TwKTWncFMc1EqHd0LRFqVVo5N1yPBh2vwYG4nNhagh8JweuDUZF/RNXERE+T1KPv++q
	 wk0xIGN19hb+dy5qKrTMk31IlT5Y46s/vC/VFdB4lrAoE5b+66IHyRo/7hfvKEvC7JA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 73B141F000C7;
	Fri, 13 Nov 2026 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584429;
	bh=ANQ3/bg3Uk8FuOZwxlcjmLvpGxkRq2me1jlvChXTFBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZMLGVTvrDMUiRvPrWXkZXBEcdbAok8tErr2+Iix9+yLBy85gq/xmAqJBKJTQxAPv+
	 mjrQdPUckFOBXXKRJH+kQOAgDZcV913L0dyWaUSM3E5BHfLFGDs+CBUlT9+2NkofAR
	 BAx2NxoApM7/HoH8mO9O+MP3Gp8ltroO0Zs/pLpTrcoFsp5YOMdEkCL2JyKVZBq4QY
	 VCsZzfcegEOyrhTUGzpPw+3dkC52tVSJNVC2NY4rJ6NgQ3wl5an9ZsCIH1LwmmqGGb
	 xwnH6Po7Coi0UEDkA8ILQDX9yP5QxsyezYJJuyz2VUu0sEsZqZhhhJVe8aaWbUng5Q
	 suhvIGkopDv7Q==
Date: Fri, 13 Nov 2026 16:40:25 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <20261113164025.00003eab@kernel.org>
In-Reply-To: <20261113-pci-remove-dont-use-autosuspend-v1-1-413cb01fa0f6@kernel.org>
References: <20261113-pci-remove-dont-use-autosuspend-v1-1-413cb01fa0f6@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 16:14:59 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
> 
> Remove the redundant function calls.
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  drivers/pci/pcie/portdrv.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 32fc623dd41087c7f92552117499359fae4c73d8..3ce960b4ea25e4a2bec1c9991398bc445871085d 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -728,7 +728,6 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  	if (pci_bridge_d3_possible(dev)) {
>  		pm_runtime_forbid(&dev->dev);
>  		pm_runtime_get_noresume(&dev->dev);
> -		pm_runtime_dont_use_autosuspend(&dev->dev);
>  	}
>  
>  	pcie_port_device_remove(dev);
> @@ -741,7 +740,6 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  	if (pci_bridge_d3_possible(dev)) {
>  		pm_runtime_forbid(&dev->dev);
>  		pm_runtime_get_noresume(&dev->dev);
> -		pm_runtime_dont_use_autosuspend(&dev->dev);
>  	}
>  
>  	pcie_port_device_remove(dev);
> 

Ah, made a mistake, it can only be removed in pcie_portdrv_remove() and not in
pcie_portdrv_shutdown(). I'll send a new version, unless you can fix this up when
applying.

Thanks!

-- 
Kind regards,
Joshua Crofts
