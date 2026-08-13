Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17492331ED3;
	Thu, 13 Aug 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640153; cv=none; b=PCStXZeBNmOG25Yv8TTEtAZu1cXHQ33BDAIbf//osBnFUh/amA+Mruf6SQSRmJTQKgJPL7uVj3Ol5HXV9d9t2oTRzbwCW9imP6/fpug6fQaGFTgHcI9qwC1tDM6gAKYvEaxaYPjOTd2qHWNBP7yIb5gW0dp6QlN2KmHbYqo+YMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640153; c=relaxed/simple;
	bh=Zv5o0SHQTncQAW6YUYvW2MVxlBiqHwG0omIZb6cl/Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f8gKbPFt/pNcEc/llnKXQqxwHxRGjX32vb1EOmWWLcSNK9z5NEB+F27YGfVvRqDHPLFu6Q1aHFsEE42gXxugtu6TZMpGz7UuPksthy/KNZQiquyFCFcJ3FnnOGkH7S1wKaROWncVjZpyB4Cf6vOoGCzNumtNA2Lv49hrhz6Xbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G59OR5O1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G59OR5O1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7771F000E9;
	Thu, 13 Aug 2026 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640152;
	bh=j1RttWiTjaY52255xEPE0Lhej03QMUfsKVp50o+E/Fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=G59OR5O1w6mvCga2Aly1seWK/YBF1/KPdgm2xdH7gPAyPXtCZDvXva/IqipsBAeyE
	 1OfBt6f3YBsVeIxfJE/1fwgUmnR+XZcvGojZCaskLhZT4FM6LZnISfvBdZMwNiAah+
	 Mms7EbI7gp5VaF2zjmMW6zheoDeYbgTk2HN/+2enbLe5C3o6srHm+ddbLapvXt4Wp+
	 wxW10trBJkt+GIowrvHewu142n75UZDiqXXQwbJZmrQ8BaLmNKae6OH5dIoRQt3dIn
	 a3jZeTIhUIhwdiFj6oxo21JgHVEI+S7aTR8VjKQKMavy1mqiKNdq0EbOSJQrY6VBcG
	 KgITYAQ8Z7iRA==
Date: Thu, 13 Aug 2026 11:55:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, alex@shazbot.org, skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix 32-bit config write in Intel RP MPC ACS quirk
Message-ID: <20260813165550.GA1140467@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723171203.4892-1-raizudeen.kerneldev@gmail.com>

On Thu, Jul 23, 2026 at 10:42:03PM +0530, Mohamad Raizudeen wrote:
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
> 
> Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Applied with stable tag to pci/virtualization for v7.3, thank you!

> ---
> Changes in v2:
> - Added "Fixes:" tag and CC'd Alex Williamson as requested by Bjorn Helgaas.
> 
> Link to v1: https://lore.kernel.org/linux-pci/20260723160641.GC836122@bhelgaas/T/#t
> 
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
