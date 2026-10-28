Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793229316;
	b=pckOgk/j8RBtJZu4Go3v4M8EwJmezmJMDdLTiogAmeBsVvyZwrhxLCuC+AP0cf/IQs9P
	 /PV/PydwUJpMCit0BzYDDH3KQyTrM+bazLKRGokD1eD8+OfC4dpcANuNhPsahviQQ43wH
	 R0Kgo6/7HHe42P8MudZPsBBA72atxZVXlqyyUBpugvUIIQ1pZfnAhRjTsQpw8dNZDIWUW
	 Pt4BN6qP2u61gTdfyF+c0+isIUlniS36CbuKOxxN1gCefsGhwgpkRcpJwtb0dXQEd5ItO
	 0yCYG66WeeLKUPyjZ9RIj0egpL6s1oelkuWnnkYs+xb7a5SvzLPpvl+nf12MyoOr0gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229316;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DhpSOR12/rHCUhOJ1uYI7366QFpKc66f+uuFcRu/hhQ=;
	b=AAQE0EZoHA/8Qwuklj0PXmmri/NIzESFeSi5em2Nhanf8KpAJLjWuMvMAejxPrqQ7m9e
	 qhalmNC3a6+vY8TdAzHTQR5Q7F+yZGvWQln2JDyMPibA9OiSS+67CkEQDSElCc/HLayeO
	 mYDGn6W+eaS2grA+H493NYRjg3MvnY7YSzft+DcFhqHwKtP/EIz3gNbBIwB3cmWtumxcm
	 RBDu/tTu+EPdc7FVLz9YqFRQtYvkKkArrg++eX/D1skhAMY8HB5Ar++OY8hu6c/gqhBS4
	 YVuYaEVNcId0GLgOQ/nnQp4rvJpIxSuqkdMShuwtEiUALher3a0DdZ8TEB7vfHVlnHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="o21s/8x+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D9606A320;
	Wed, 28 Oct 2026 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o21s/8x+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E545C1F01825;
	Wed, 28 Oct 2026 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793229316;
	bh=DhpSOR12/rHCUhOJ1uYI7366QFpKc66f+uuFcRu/hhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=o21s/8x+8uvTF9En4VEKmOQb097E+uWKBQO1wfD1YpkcIq+XwJhtliMn0BgHxH+A6
	 OYM90bMhe/EtKsU16CJes/Ot0cRx5IQcjrH7v3R31x/HuUYUFvseO/BW/4JJXBc5AX
	 FmSYENZ1lPi2ygfDZ0kX7W4zH8CwwhEP4OusyaCKX7ogDfkjNLdbqlOZtOTKQu/9QG
	 tdHTTHQht5Kc/8Z3oFjP75cgTCU61zPzIhN5XY365EUgmFeGia2VVXdEstKVAuBMoK
	 N2ju2Y8RfSSDHYDGYvNJRw4+YALzZxpIYVGLNoSKG18E4iqrF0SGbnH6x+QgCNxgsz
	 FktRzhIOQWdwQ==
Date: Wed, 28 Oct 2026 18:15:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: wuqianhai@loongson.cn
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, tzimmermann@suse.de,
	javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] PCI/VGA: Fix boot device detection after framebuffer
 relocation
Message-ID: <20261028231514.GA577494@bhelgaas>
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
In-Reply-To: <20261028094634.766723-1-wuqianhai@loongson.cn>

On Wed, Oct 28, 2026 at 05:46:34PM +0800, wuqianhai@loongson.cn wrote:
> From: wuqianhai <wuqianhai@loongson.cn>
> 
> PCI resource assignment can relocate the firmware framebuffer BAR, which
> leaves the base address in screen_info stale.  The VGA arbiter then calls
> screen_info_pci_dev() from vga_is_firmware_default(), which fails to match
> the framebuffer against any PCI device's BARs.  As a result, the boot VGA
> device is not recognized and the arbiter may select the wrong default
> device.
> 
> Fix this by calling screen_info_apply_fixups() in vga_arb_device_init()
> before adding the VGA devices.  This relocates lfb_base to the assigned
> BAR address so that vga_is_firmware_default() matches the boot device
> again.
> 
> Tested on a LoongArch platform, with vga_is_firmware_default()
> additionally enabled for CONFIG_LOONGARCH via local changes.
> 
> Fixes: 337bf13aa9ddab8ae47f2677ab75cf69ae33437b ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
> ---
>  drivers/pci/vgaarb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3e58b2c05c85..aca594651f58 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1527,6 +1527,14 @@ static int __init vga_arb_device_init(void)
>  	int rc;
>  	struct pci_dev *pdev;
>  
> +	/*
> +	 * PCI resource assignment may have relocated the firmware
> +	 * framebuffer BAR. Update screen_info's lfb_base so that
> +	 * vga_is_firmware_default() can match it against the boot
> +	 * device's relocated resource.
> +	 */
> +	screen_info_apply_fixups();

I'm really confused about this.  vga_is_firmware_default() relies on
screen_info_pci_dev(&sysfb_primary_display.screen):

  vga_is_firmware_default
    screen_info_pci_dev(&sysfb_primary_display.screen)
      numres = screen_info_resources(&sysfb_primary_display.screen, res, ...)
      for (i = 0; i < numres; ++i)
        pdev = __screen_info_pci_dev(&res[i])

screen_info_resources() returns resource structs with PCI bus
addresses in them.  These are not valid CPU addresses, so that seems
broken on any system where bus addresses are not the same as CPU
addresses.

screen_info_fixup_lfb() and screen_info_apply_fixups() may fix the
issue you see, but I think the way this happens is questionable.

screen_info_fixup_lfb() captures the framebuffer PCI bus address in
screen_info_lfb_res_start.  Then screen_info_apply_fixups() compares
that PCI bus address with the CPU address in pdev->resource[].  That's
broken on any system where bus addresses are not the same as CPU
addresses.  I think it's also broken because screen_info_lfb_res_start
may not be at the beginning of the BAR.

I think screen_info_fixup_lfb() should only capture the pci_dev, the
BAR number, and the framebuffer offset into the BAR.  When we need the
CPU or bus address, we can always compute it from those values.

>  	rc = misc_register(&vga_arb_device);
>  	if (rc < 0)
>  		pr_err("error %d registering device\n", rc);
> -- 
> 2.34.1
> 
