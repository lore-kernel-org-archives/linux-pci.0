Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB143BDD9;
	Thu, 23 Jul 2026 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822810; cv=none; b=VylEMe/OoxRmaQAKBsULb49KeCqlW+z6RQtaN7NeGKmovCRcLdlbMgcZ7ceuDp2mMNfw9qBRfrDJhdQFonHmSZS0jqStqxf9kmhGB4d7qVAEHgYpgLSTz1FvtLRYKjfLYScgas9kpsfY6DTkif15ydCQovZjtdaW8xKSK0v/0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822810; c=relaxed/simple;
	bh=p6UKfM4cU8K7O/Ef9Nid8sCBmRypsZNsb+90tEB5RcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIsfljY6HsF4/5fbUupjccl8TQQe1BPKWiFtzHM6ka/zVYwcWttyAsG6Wxgq8ecUAst/5rARjeQu0oDdn/qjVAOREpHwKt4XkDmqEX9EpqRt3ELf1MxYjMFLCgbUOyAeDpZe673JjmfovFxL+OeSOEdk4CV4+7Gvslr9rvQwuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AA61F000E9;
	Thu, 23 Jul 2026 16:06:44 +0000 (UTC)
Date: Thu, 23 Jul 2026 11:06:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] PCI: Fix 32-bit config write in Intel RP MPC ACS quirk
Message-ID: <20260723160641.GC836122@bhelgaas>
References: <20260723064300.8081-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723064300.8081-1-raizudeen.kerneldev@gmail.com>

[+cc Alex, author of d99321b63b1f]

On Thu, Jul 23, 2026 at 12:13:00PM +0530, Mohamad Raizudeen wrote:
> The pci_quirk_enable_intel_rp_mpc_acs() reads a 32 bit DWORD from the
> MPC register, sets bit 26 (INTEL_MPC_REG_IRBNCE), but it writes it back
> using pci_write_config_word().
> 
> Because bit 26 resides in the upper 16 bits of the 32 bit register, a 16
> bit write to offset 0xd8 completely drops the newly set bit. The quirk
> logs that it is enabling IRBNCE, but the hardware never actually
> receives the command.
> 
> Fix this by using pci_write_config_dword() to ensure the full 32 bit
> value is written back to the hardware.

Needs a Fixes: tag, probably for d99321b63b1f ("PCI: Enable quirks for PCIe
ACS on Intel PCH root ports")

That's 12 years old, surprising this hasn't been noticed before :)
Google does find several mentions of "Enabling MPC IRBNCE", so maybe there
have been issues but not debugged.

> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..0d0cf6f86173 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5361,7 +5361,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>  	if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
>  		pci_info(dev, "Enabling MPC IRBNCE\n");
>  		mpc |= INTEL_MPC_REG_IRBNCE;
> -		pci_write_config_word(dev, INTEL_MPC_REG, mpc);
> +		pci_write_config_dword(dev, INTEL_MPC_REG, mpc);
>  	}
>  }
>  
> -- 
> 2.53.0
> 
