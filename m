Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527D3B776A;
	Thu, 30 Apr 2026 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583685; cv=none; b=jvAEz+Gou2rZ93IJH1IBvRTIeDDvXnfAc9RuERdfhO001vcO7M32jeKEyNYdhO2H0b0vKke377rTgLLED7be9pDkJKg+OCOAjX5GNcgUZWdLlsZofHfszdRD6zzaP6WTF/jbLqWZUWD+ZSeEEWiWh7OcGjJwWC3DELJiOcU1B2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583685; c=relaxed/simple;
	bh=jExc9ThFJh5G6uRoarH4ZYtA+yWxsZXYal1m+NQwiSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hn7O74kbQUk4ev2ODSp0BTeyRjVnJkeN09hukWt7rabYSRyHcJ76iNTwjCXIRTomV1LRs0t7v/R3YL8Af8OOcGBVeFGy1JKS2nysU+yf88Q1F5H08exvthdeNAV7YLGN1+1Q2rXdtbgpelfbmdXGc/iuVq4so6p/X1tL2pRTRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB6UvPiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB6UvPiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E437C2BCB3;
	Thu, 30 Apr 2026 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777583685;
	bh=jExc9ThFJh5G6uRoarH4ZYtA+yWxsZXYal1m+NQwiSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QB6UvPivTiYRt+vDiYJx/8sd6EhpdJ2trnqgU+5o6tvhrZ8N9uRATlIeKOcY7HpDa
	 VQvviXfNIM1lW7NKurpjJKDO0jdXvpLopueUvz15uYa5HIM6j40TXXJummc/mo2see
	 CkTcrmQ5xrv/Ot/u0uTtJ3PnYcLWiuqGF6L4vmT8UX7wADE87nzSSUx6Ps9Lpd8/OE
	 k7pn6uGckkjnWFHcb2Q+wu5PcqpDWoakBOXxfXR0KSysGTTuc7vkGopEZSW3ltVkp5
	 f/ecEjFnJty6BzmBDMKeIgK7zGz2rcfyg8JXarzpdZjYik2J/UPOqIMyy7lbNvWl2d
	 VFCF1JQwGMUAQ==
Date: Thu, 30 Apr 2026 16:14:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: quirks: Advertise D3cold capability for UPD720201
Message-ID: <20260430211443.GA440215@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-d3cold_support-v1-1-6734f280c481@oss.qualcomm.com>

On Thu, Apr 30, 2026 at 10:12:18AM +0530, Sushrut Shree Trivedi wrote:
> PCIe-to-USB bridge UPD720201 does not advertise D3cold
> support until firmware is loaded post pci enumeration.
> This results in upd blocking D3cold entry during system
> suspend and causing overall failure to enter XO
> shutdown.

I think you're saying that the PM Capability in config space changes
when the firmware is loaded.  That makes me worry about what *other*
config space changes might happen when the firmware is loaded.
There's all sorts of stuff we do during enumeration that depends on
what's in config space.

> Hence, add a quirk to advertise D3cold PME capability
> since the HW actually supports and advertises it post
> firmware loading.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..c32617ed33aa 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6381,3 +6381,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +/*
> + * Renesas PCIe-to-USB bridge UPD720201 does not advertise D3cold
> + * capability by default until firmware is loaded post-enumeration.

There are several mentions of "Renesas UPD720201/UPD720202 USB 3.0
xHCI Host Controller" in the tree.  I assume this is the same device?
If so, I think it'd be worth using similar terminology, i.e., "USB
xHCI host controller" instead of "PCIe-to-USB bridge"

> +static void quirk_enable_d3cold(struct pci_dev *dev)
> +{
> +	dev->pme_support = dev->pme_support | (1 << PCI_D3cold);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RENESAS, 0x0014, quirk_enable_d3cold);

How do we know that FINAL fixups happen after firmware loading?
