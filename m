Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412523D7D83;
	Mon, 17 Aug 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958601; cv=none; b=tV5fjgRxM+wuSST3mVTCFg1tHGl9VuFcnyNZKzm6d5YJeFNRzR5eNpXfJDI8wrXURt5PUzA3gBdkIeXECILxB1WefBHyFiQyfAgUA6KMkcdw+cDGFGy31PIzjhJ8MpPomQD95yq5O7Dhm7CoH+haIXXY9M8peHFsPbiVvuTu5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958601; c=relaxed/simple;
	bh=1NpYXnarHj/hKHfKfRtEJYHyf6D9P1eJ1QuW1xd7318=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKDyDRRD9y/aN6jpv2OW0asxk1J6SdPTr3hlPvbtxQ20OR0+HXGpNyduQ7YASPAqvgTIJ2V889+GpJRARaub7MAyfsjLaDb9CZ86c+c8gyBjQrSZLvXqRU4/msvT+WcpmQ4qe9v59FKkR+iDP/4e2wibqcBomBMkvWVurha+80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 2E2FCC16;
	Mon, 17 Aug 2026 11:23:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D4AF16029DF6; Mon, 17 Aug 2026 11:23:15 +0200 (CEST)
Date: Mon, 17 Aug 2026 11:23:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Lowne Onema <lowneonema@gmail.com>
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com,
	alexander.deucher@amd.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: Prevent D3 for Acer Swift SF515-51T Root
 Port to fix audio
Message-ID: <aoLTA0umxhDPGw_4@wunner.de>
References: <CA+1pjEmQgcfhjj56yjuXWVshBM+soFC7RZHaGwaaF=ZFCr1Lyg@mail.gmail.com>
 <am8DEH0wfphdAX0n@wunner.de>
 <CA+1pjEnxg9nVy79QNGTb0Ea3s+q=Z-we5XH_fDvJbOLpXH8HDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1pjEnxg9nVy79QNGTb0Ea3s+q=Z-we5XH_fDvJbOLpXH8HDA@mail.gmail.com>

On Tue, Aug 04, 2026 at 09:40:03PM +0200, Lowne Onema wrote:
>  3. Amending the power resource structures in drivers/acpi/: I looked
>    at this a bit more and noticed RP09 and the SATA port
>    (SAT0.PRT1) each have their own separate power resource in the
>    ACPI tables, but both end up controlling the same physical GPIO
>    pin. I'm not sure if that's something the kernel already knows
>    how to handle safely, or if trying to sync RP09's power to audio
>    activity could accidentally interfere with the SATA port through
>    that shared pin. Still learning this part of the kernel, so
>    wanted to ask before attempting it -- is that a real concern, or
>    is it fine, and a better approach?

If two devices reference the same PowerResource in the ACPI tables,
then the kernel is aware of the dependency.  E.g., when the
PowerResource is turned on, the kernel runtime resumes all "dependents"
of that PowerResource.

However if these are separate PowerResources whose _ON method happens
to toggle the same GPIO, that's opaque to the kernel.  I think it is
then the job of the _ON and _OFF methods to track whether another
device still needs the GPIO to be kept on.

But perhaps the ACPI tables are just completely broken and the right
thing to do is modify the PowerResource assignment such that all
3 devices depend on the same PowerResource?

> +++ b/drivers/pci/quirks.c
> +static void quirk_acer_sf515_rp09_no_d3(struct pci_dev *pdev)
> +{
> +     if (dmi_check_system(acer_sf515_rp_d3_dmi_table))
> +             pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9db0,
> quirk_acer_sf515_rp09_no_d3);

On x86 SoCs introduced in the last about 10 years, keeping a Root Port
in D0 prevents the SoC from entering lower power states.  So the
workaround of keeping RP09 in D0 may reduce battery life.

Usually Root Ports can only be put into D3hot, not D3cold.  If there's
a PowerResource for the Root Port, that's usually for powering off
a device *below* that Root Port.  E.g. if RP09 is an internal,
unoccupied M.2 slot, then the PowerResource allows cutting power
to an NVMe drive or WiFi card in that M.2 slot.

If RP09 isn't exposed physically at all, then it's unclear why the OEM
chose to enable it in the first place, let alone describe a PowerResource
for it in the ACPI tables.

Thanks,

Lukas
