Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265742;
	b=CYT8WQ+F8Xd4a1GQHJr2zeLQmM3v0kWMQNusDIImvm6MsqiucqPKrrK0WxiEttuXXC4a
	 3KFRBBuA1dthzciopOel72v0UBGpSzfXN8i/aSi2v0KawTtRQ9xO8rrCxjEdehqq+FZAY
	 hZ5PkKKvJXydFg6YwifKg3864Bzb8PWUoDmqpRUEd+ak+3emYG9NT/8sX46QLoHlK2t2B
	 5+TGePRWKxSMNAnsboBfxB1gEERGCXIYSDAfholVJQGxZVfgrRexsvyhn7+qDaerhQpqk
	 v8FmZnSU+ChlRYfAZGU5ThatXRz+z3ao6QLWSIEsUrBG5GWoH8k4a+WP3ordMDdN/uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265742;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AcgadcQRBl1O+iRHgLwVWevrBizvw2JrP61jxHDS3iE=;
	b=yQrdzhvmzsSIwz29uuTM/RGQoFmhUp5RorJ92he/Pm5cB7ytuzL9WbjcQjJej6hw99pG
	 ABmRMl9luZKVOIJkX6hE+GpUKT31rI+fRSBA1metUF3eyL7HV/z/umsG8TgqSPdAfudzP
	 DtWF+ywH1G9Ad8JkcDNB+32LHn8eZEIBgYwGCOM+2NlxbvDWfga3AbkuZITVye/53Qs7m
	 7UgOn8z9yyRta6TEkHc6OXtPqZyecVF/KzAjSmDKy3mwg6Yh3AkrfU9cYpKW4l3QoMa1F
	 l4O8UgvCarsqh19FjCm335cucYUHOihEpIj+ZpFpDA262+O8X17bcinlwR/Feo9b8EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6p3tTJH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72A606A31C;
	Mon,  9 Nov 2026 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6p3tTJH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E819F1F0089F;
	Mon,  9 Nov 2026 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265742;
	bh=AcgadcQRBl1O+iRHgLwVWevrBizvw2JrP61jxHDS3iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=k6p3tTJHDJmiCK0f0JTPUFjRhIO/kCFKVmEsAqtaRyOg+fO8ywqM65KyTbcCfIkp6
	 iAP3rtv7ts8DVUYpb1p+AuQYUZENnLbAFi4s9s+BZ3hoIYKl6sbdJwQARJD7Oa6GWw
	 0+SFmdGC7MYyv9UVp/EQILm9gIeHl1+236/W9zhOLhDwixkZ4CvIaKb8ynQDFvuLMU
	 9zoZ2KaVabQXgQZVz37PjWAERc1Z3DMwGcAi4FHdRZod/T9Gxv1ebsbzWG6IuHyQLM
	 VIG/Zr5qTgRQTOGDjJG0JaK4v24E2kzeEHch6uVm1/85ITXvwanEBmmkaKd3y9Db4w
	 YM1a8R/jJWZVQ==
Date: Mon, 9 Nov 2026 17:09:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VPD: Add Realtek 8126 to VPD blacklist
Message-ID: <20261109230900.GA342555@bhelgaas>
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
In-Reply-To: <20260522114135.2104890-1-18255117159@163.com>

On Fri, May 22, 2026 at 07:41:34PM +0800, Hans Zhang wrote:
> The Realtek 8126 Ethernet controller advertises VPD capability but
> returns invalid data when VPD is read, leading to kernel messages
> like:
> 
>   r8169 ... invalid VPD tag 0x00 (size 0) at offset 0; assume
>   missing optional EEPROM
> 
> and pcilib reporting "sysfs_read_vpd: read failed: No such device".
> 
> Add the device to the VPD blacklist to suppress these errors.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Applied to pci/misc for v7.5, thank you!

> ---
>  drivers/pci/vpd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 153394a652d3..fbc34cd842ac 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -590,6 +590,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8126, quirk_blacklist_vpd);
>  /*
>   * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
>   * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> -- 
> 2.43.0
> 
