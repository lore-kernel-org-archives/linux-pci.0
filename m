Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29041484246
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042829; cv=none; b=pf7yf3UzmveoeDmXp0L1yUO76lV9SZJYIrhvYHt7mA8qPatp9ecuJkvPM+gDC68xGATM2vLDprUkderodH+bM3lsZ0CkpAGhTHuO9i9fzIycZ4Td/Mj8nf9s9TsW6dJljVg+dd4w0Pah9f4o6QCTCZB8tdwHpxniPgD+daOvQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042829; c=relaxed/simple;
	bh=Xb9DTr9CLDy+JQ7Xuo+3MVAIbjjNef1X14qqUKHzVsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH2kNbelFVJWoLGwoNL3dvOzJ/AHN1gyFENux91rWVf0LZxAN0fg1YNeCW3GZ98YAdLwBgJCdlOGOlDaNH3bTDSjHehIpb/ZU3x9/g8trjoPfFRejeCYhFDUwFWp3W4MXUNoYgEOSRyNMoMZfW/xi+GXZ1DYMP2u7RgcGUq5XVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZe1fBxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZe1fBxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518711F000FF;
	Thu, 10 Sep 2026 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042828;
	bh=eaW8xUp+8z+6T5aZeIWMNSul/RKkiKjVtZ7DYCwqBOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MZe1fBxyYih0wyjbZELCXfqFBNJ3zcQaaprp9AEGZc1KMHFkPBpp7xMB62jDIVtfp
	 hKF5dPq8ecx1ragJb7W6hYJZIm6+1/Js7QGoq4nro6ldY1hTWwSaO2qnEKkpzae6o+
	 wKNvdf6bdARLFfBHbCbV3pnThuGXZYOPf6QhRzJOIoDB7wRJO5NDJ/zv2LCg/Nsk2L
	 rdIHYXLzxtH4MWGxaDhRYLPKppkjdfw9qjrtjyYr7xR+sRkp5Z3z0uLd59MvzQV6ck
	 8WQGz4XHl5QgLKJwLEm7RlUPnafzwRrJJYr1ygc+r23FXsPWx81povapB9ZFDlJEds
	 BnDoyqxrlPtxg==
Date: Thu, 10 Sep 2026 14:20:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-pci@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] PCI: Add quirk for ID mutation of MSI Claw A8 cardreader
Message-ID: <ojta2igag7ecwdp5qbd7xi3cuju62jmzduuksljq25m3my6k3k@e5beqrrk4gmm>
References: <36578f6e0829bbcdf68659ffad27b65715a97768.1786698126.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36578f6e0829bbcdf68659ffad27b65715a97768.1786698126.git.lukas@wunner.de>

On Fri, Aug 14, 2026 at 11:06:50AM +0200, Lukas Wunner wrote:
> Derek reports a lockup on resume of the MSI Claw A8 if a card is inserted
> into the onboard Realtek RTS525A cardreader.  He has root-caused it to a
> mutation of the cardreader's Subsystem Vendor and Device ID:  Firmware
> sets an MSI-specific ID on boot, but neglects to reset it on resume.
> The ID thus changes to the generic Realtek Vendor and Device ID.
> 
> The firmware also incorrectly sets the Hot-Plug Capable bit on the Root
> Port and the PCIe hotplug driver interprets the ID mutation as removal of
> the cardreader during system sleep (see pciehp_device_replaced()).
> 
> The lockup is caused by the block layer being unaware of the hot-removal
> and waiting indefinitely in sync_filesystem().  That is fixed with a
> separate commit for the cardreader driver.  However despite that other
> commit, the cardreader is still hot-removed and re-enumerated the first
> time the system is put to sleep.  This is undesirable because it prevents
> using an MMC card as root filesystem.
> 
> Avoid hot-removal of the cardreader by mutating the cached copy of the
> Subsystem Vendor and Device ID.  This needs to be done before going to
> sleep, not afterwards, because pci_pm_resume_noirq() is executed top-down
> across the hierarchy and hence a pci_fixup_resume_early quirk of the
> cardreader would run after hot-removal at its parent Root Port.
> 
> In the unlikely event that a fixed firmware becomes available, the quirk
> can either be reverted or constrained to specific BIOS versions by way of
> a dmi_get_date() conditional.
> 
> Reported-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Closes: https://lore.kernel.org/r/20260806214808.1202819-1-derekjohn.clark@gmail.com/
> Link: https://github.com/ValveSoftware/SteamOS/issues/2473
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>  arch/x86/pci/fixup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c..9da7ae0 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1080,4 +1080,20 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
> +
> +/*
> + * MSI Claw A8 firmware initializes the onboard Realtek RTS525A cardreader
> + * with an MSI-specific Subsystem Vendor and Device ID on boot, but neglects
> + * to re-initialize it on resume.  Avoid hot-removal of the cardreader due to
> + * the spurious ID change.
> + */
> +static void quirk_msi_claw_cardreader(struct pci_dev *pdev)
> +{
> +	if (pdev->subsystem_vendor == 0x1462 &&
> +	    pdev->subsystem_device == 0x14af) {
> +		pdev->subsystem_vendor = pdev->vendor;
> +		pdev->subsystem_device = pdev->device;
> +	}

Don't you need DMI check to limit this quirk to MSI hosts?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
