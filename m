Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98133065D
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171369; cv=none; b=bORPPuVJPecN0wHjEs964VxVhDmXduIsqazRfA60yB937JnJKerirjj08kgDHe/VLoDKsqGoQ4TXEI/pbmsVdV9yo83poPEqZO2PccIWCM4pnU+1BBMxAPLQrgo01KJswRn/PhSvqRghXn5lJvgCF4TOZeJiYQj5CCtTyxCmdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171369; c=relaxed/simple;
	bh=4ZB5QRZ9q+mJ16oIdgit5rGeLj+b4Z5voROWRVfX1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QTDJjrUyOIBIqJGoU6zUQY/cSb404pVLy+bbEUN0V/gvP+83y3r8xO7uk+jLK6yPOrfxR0CZsHTWiWWmyjysPqgQKF9xUCJnG52QcTAYgKpCWJexySFICcIbbet2tyPYNOmT3pxvKhIS6E0KKDwwePa4g0G5xN5zegYRBDo+62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiMzwqZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiMzwqZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B6DC19423;
	Tue, 10 Mar 2026 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773171369;
	bh=4ZB5QRZ9q+mJ16oIdgit5rGeLj+b4Z5voROWRVfX1vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BiMzwqZk8ym2F5+BdBpNRjBWNtwpv/5VcjzFhvNJf9HhdiWoIWwNa69cp3UbAfMib
	 1Y5b5ogsFUKbI4LW2UqumhHUB5QWuK6mDmhTxyFKpx6G3LnBq7DahhMmM6PL2M135D
	 2awm9qVtdozMUHPj3JijL9+c43xO1/+pOMknf9lG9jgLojfDQjbQpAPUrxXRIQDOWT
	 Rycl3tcrLtNSYdL6zhOVnToeJrlBV9EQ4OmCgI52zUPa1E/cJqa3FIScL201ylhzQf
	 oMgGFlNXg3LNR8PhK37Rzuz8LK1pbQ0nm15f+mA++b5l9HSIlSWu5wiiTuhFDOB6Xx
	 eG0FM+FL+bjbQ==
Date: Tue, 10 Mar 2026 14:36:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 5/5] pci: mark pci_set_vga_state() as __must_check
Message-ID: <20260310193607.GA774938@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307173538.763188-6-Simon.Richter@hogyros.de>

On Sun, Mar 08, 2026 at 02:35:38AM +0900, Simon Richter wrote:
> This function can return an error, usually on non-x86 or virtualized
> environments.
> 
> The only caller so far is __vga_tryget() in vgaarb.

Is there any reason for pci_set_vga_state() to be in pci.c while the
only caller is in vgaarb.c?  If not, we could move it there, make it
static, and drop it from include/linux/pci.h.

> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> ---
>  include/linux/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..aa1451d402d1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1720,8 +1720,8 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
>  
> -int pci_set_vga_state(struct pci_dev *pdev, bool decode,
> -		      unsigned int command_bits, u32 flags);
> +int __must_check pci_set_vga_state(struct pci_dev *pdev, bool decode,
> +				   unsigned int command_bits, u32 flags);
>  
>  /*
>   * Virtual interrupts allow for more interrupts to be allocated
> -- 
> 2.47.3
> 
