Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771B2F3C10;
	Sun, 11 Oct 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791732451; cv=none; b=Bkh7FBxigxy2NdOkcvfQpM39aBQlEJP6abBid7Eu9bVmjW/HRz5G+0WpTUnk+uwYcq9JdD0hWnBX0tG9D8nClwp/cLP/R6/gLzoa+oGrQ+C2jHyTfn++DOINzf8eoeP5UdWrNpIYJ4XYRrtYpqbT9hjOlKhfDN7xr9kQbv3B6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791732451; c=relaxed/simple;
	bh=3w9kcLVMlLXG4AJK0NQ/APm043LQ4Wp5TxCV1yK9bws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7UwjfICvx9VzesTQrqB+56mlXyoSXPSziKlFUcHWxbsdoYSge9EuIomhb6mMsSPR0zyIliRh4vPEP/EGq2Ir2dig2xIpsKcKMQbOu4SiLOw54tYu+r6W6XY9W2NhcBxnFujuqXbI8SRR3E4q42FaGSJEKiMGokw3/26AvT2YYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 1F7171A22;
	Sun, 11 Oct 2026 17:27:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EB4066107905; Sun, 11 Oct 2026 17:27:20 +0200 (CEST)
Date: Sun, 11 Oct 2026 17:27:20 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krittikun Wongnin <krittikunwongnin@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [RESEND] PCI: NVIDIA GeForce MX230 (10de:1d11) falls off the bus
 right after "Enabling HDA controller" quirk on Acer Aspire A515-53G
Message-ID: <asuq2JLh5ExyJP1I@wunner.de>
References: <CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=UBKS=EFCDFuaxw@mail.gmail.com>
 <asskafIxufz8abQa@wunner.de>
 <CADS-TgDakQUvB8Sy3zpGrYMiv_pGEaQ_m9KcsmTSD+4XqJEo5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADS-TgDakQUvB8Sy3zpGrYMiv_pGEaQ_m9KcsmTSD+4XqJEo5Q@mail.gmail.com>

[cc += Rafael, linux-acpi; start o thread is here:
https://lore.kernel.org/r/CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=UBKS=EFCDFuaxw@mail.gmail.com/
]

On Sun, Oct 11, 2026 at 06:10:59PM +0700, Krittikun Wongnin wrote:
> I then looked at what else runs in that window. Right after the ACPI
> bus scan, acpi_scan_init() calls acpi_turn_off_unused_power_resources().
> The root port above the GPU has two power resources:
> 
>   \_SB_.PCI0.RP05.PC01  resource_in_use=1
>   \_SB_.PCI0.RP05.PCRP  resource_in_use=0
> 
> and the firmware's second definitions of RP05._PR0/_PR2/_PR3/_S0W fail
> to load with AE_ALREADY_EXISTS (see my first mail). My guess is that
> those failed objects are what reference PCRP, so the kernel thinks it
> is unused and turns it off, cutting power to the dGPU. This looks very
> similar to the existing THUNDEROBOT ZERO entry in
> dmi_leave_unused_power_resources_on.
> 
> Adding this machine to that DMI table fixes it. The GPU stays on the
> bus, the HDA quirk runs normally, and the nvidia driver works
> (nvidia-smi shows the MX230 with 2048 MiB):
[...]
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -1048,6 +1048,17 @@
>   }
> 
>   },
> + {
> + /*
> + * Acer Aspire A515-53G: duplicate RP05 _PR0/_PR3 in firmware
> + * leaves power resource 'PCRP' unreferenced, so it is shut
> + * down on initialization and the NVIDIA dGPU falls off the bus.
> + */
> + .matches = {
> + DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> + DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A515-53G"),
> + },
> + },
>   {}
>  };

The whitespace got mangled in the patch, but otherwise it looks
sane to me.  Please go ahead and submit it to the ACPI subsystem.

You may want to double-check with e.g. powertop or an external
powermeter that the power resource is still disabled when the
dGPU is not in use as otherwise you'd see dramatically worse
battery life.

Thanks,

Lukas
