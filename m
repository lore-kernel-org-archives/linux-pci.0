Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BC3AFD0D;
	Tue, 28 Jul 2026 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269162; cv=none; b=tDN2U83evw+T1RwewmToqaQaZvZREUEHOzqaHP3yWdwDrQiYmgZQfwXfPS3gBhlxMo79l6CLX+qLJ5C64jy6HUDlrlE8FmRugLEnvGdJEyANIu1vMvxFskjrmb/GHZhwhIZGVjCxtCuNK+Zd2mXCRlLHH1FjCk1evB19FKXcYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269162; c=relaxed/simple;
	bh=/oCaNw5yRbrmN89A0dA7t6SOx5Q6jYq9xqFsMBooKw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qD6iM8rC4mkn3K835zBV7indf+uhRQxc9zUsYbxIH1fUoAVzVZZVDzadoktpkQAh6EWoFKCHWhZbgScYK7Qgg4g29MNo6KlT8fXbd9WU0T9Ifhw32/UMfCehV9T/vYj8vvb9xK6603RgObck+w/XCYaj0d1BTTIU/ml+tsvLpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddJcIB33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddJcIB33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6BA1F000E9;
	Tue, 28 Jul 2026 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785269161;
	bh=8edTI/LrWFAMszhuSGomMKMzImgqA7B9rey8X/gxcuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ddJcIB33hxJDI9TzoLbqwdvVwUq3umVPCHrsygvKWz9dp1Dqk9wqwikcOzGEzCUhk
	 F4HimzPjkZdZafYxFvtP5sLo7Q4BqrF5pmbT9wunPKBCVdp8kXU6OJewwz1pGsgjCY
	 RBmkPN72MUMF/PE90M5p+rZMBXpxR+rcuZDNRGGy900MsH2Hvae3eRvAF46VeGjkN7
	 Qxt9lAYp6wZUS80Vdnc2OuZdRXbI8j/gJpyAK+Q8pQdaISZrFg1SPXK8WiWA712NVI
	 MkAWLwjMZ1Yc8V9cQsUz7/ctki5qAqT1i3ioa/AUlqn/GV69x0dM/ksYwT9kzGgGox
	 8dAMQUP3K59Bg==
Date: Tue, 28 Jul 2026 15:05:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nika Krasnova <nika@nikableh.moe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Mark Pearson <markpearson@lenovo.com>
Subject: Re: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo
 IdeaPad Pro 5 14IAH10
Message-ID: <20260728200559.GA1391432@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722021321.68902-1-nika@nikableh.moe>

[+cc Emmanuel, Mark]

On Wed, Jul 22, 2026 at 04:13:15AM +0200, Nika Krasnova wrote:
> On the Lenovo IdeaPad Pro 5 14IAH10, the Intel BE200 Wi-Fi (8086:272b,
> iwlwifi) fails to power back on from D3cold after a suspend-to-idle
> (s2idle) cycle.  On resume the platform reports a successful ACPI D0
> transition, but the device is left unpowered: config space reads back
> as 0xffffffff, the firmware reset times out, and the wiphy fails to
> resume:
> 
>   iwlwifi 0000:01:00.0: power state changed by ACPI to D0
>   iwlwifi 0000:01:00.0: restore config 0x2c: 0xffffffff -> 0x00f48086
>   ieee80211 phy0: PM: failed to resume async: error -110
> 
> The device stays unusable until a full power cycle; an iwlwifi module
> reload and a PCI remove/rescan do not recover it, confirming the device
> is genuinely unpowered rather than in a bad software state.

I guess this means "lspci -xs01:00.0" after resume shows all 0xff?

> Setting the device's d3cold_allowed to 0 keeps it in D3hot across
> suspend and resumes reliably, so the platform does not correctly restore
> power to the M.2 Wi-Fi slot on the s2idle resume path.  This mirrors the
> untested-vendor-transition pattern already handled for the Asus B1400
> NVMe (see asus_disable_nvme_d3cold): the reference OS does not appear to
> exercise the D3cold->D0 path, so it is left untested.
> 
> Add a DMI-matched fixup that forbids D3cold for the BE200 on this model.
> Match on the product rather than the BIOS version so the workaround
> survives BIOS updates that do not address the issue.
> 
> Signed-off-by: Nika Krasnova <nika@nikableh.moe>
> Assisted-by: Claude:claude-opus-4-8
> ---
> 
> Not sure arch/x86/pci/fixup.c is the right home versus a PCI quirk in
> drivers/pci/quirks.c; would be happy to move it.
> 
> The latest BIOS from Lenovo for this model (QLCN35WW, 2025-12-23) is
> installed and the failure is still present, so there is currently no
> firmware-level fix.
> 
> Tested on the affected machine: with this patch applied and my local
> d3cold_allowed=0 udev workaround removed, the BE200 resumes from s2idle
> across repeated suspend/resume cycles with no iwlwifi errors.
> 
>  arch/x86/pci/fixup.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df75..3117f313930e 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -995,6 +995,39 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
>  
> +/*
> + * Disable D3cold on the Intel BE200 Wi-Fi on Lenovo IdeaPad Pro 5 14IAH10
> + *
> + * On this platform the BE200 (8086:272b) fails to power back on from D3cold
> + * after an s2idle cycle: all config and CSR reads return 0xffffffff, the
> + * driver's firmware reset times out ("timeout waiting for FW reset ACK
> + * (inta_hw=0xffffffff)") and re-probe fails with -EIO.  A module reload and a
> + * PCI remove/rescan cannot revive the device; only a full platform power cycle
> + * does.  This looks like an untested transition by the vendor: the reference
> + * OS does not appear to exercise the D3cold->D0 path.
> + *
> + * Forbidding D3cold keeps the card in D3hot across suspend, which resumes
> + * reliably at the cost of a small amount of power while suspended.  Match on
> + * the product only (not the BIOS version) so the workaround survives BIOS
> + * updates that do not address the issue.
> + */
> +static const struct dmi_system_id lenovo_be200_broken_d3cold_table[] = {
> +	{
> +		.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +				DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Pro 5 14IAH10"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void lenovo_disable_be200_d3cold(struct pci_dev *pdev)
> +{
> +	if (dmi_check_system(lenovo_be200_broken_d3cold_table) > 0)
> +		pci_d3cold_disable(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x272b, lenovo_disable_be200_d3cold);
> +
>  #ifdef CONFIG_SUSPEND
>  /*
>   * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
> -- 
> 2.54.0
> 
