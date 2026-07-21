Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE817372EF7;
	Tue, 21 Jul 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631375; cv=none; b=ctX7eGqVhwLnm8LMOxFfGWfioyPgE9tOP8ghg3fhGZx3PZK6M58oq9acZYlzl+ZZ/TwUkJeHzD2rBCNPzx0mCcZhLYyAa+m/389jweBgVsq/7Y3oxywopqMSTW5TbnPVneJa15SLPj9x9k9VPf/y5qgp+bQhv2mwdCJ77sQjoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631375; c=relaxed/simple;
	bh=KyIOxOoDdBAs4KSRu9aLmSWLfdIFzYZWetCKtt1vVgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG2sBt8Lj68Whv04CBt991Pp7YsNnhEGhqa922JjPn+ehkey8wCVPgHav6cbJJfRPXr82kfnMZ7GS4aT5KUibOZ+PZRt1Muk9JpnNv5pEUYtvVfA/fHWhZa3iQA3KiG9J1sLZ4CcFtHvsbz4EZu+5+JqF2PxHn4ARwiVDQ2wFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liFrF1u8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liFrF1u8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 78A561F000E9;
	Tue, 21 Jul 2026 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784631371;
	bh=okHY/JiU2kBs+oDZ4vo0gxjN3oGqMmtAuO7URmWs3A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=liFrF1u86Dgalf5E9CBRJDGuB9kEKRLieFGUGa0EGnMYfpjEyEaEVmfFpwG2J8tXM
	 yFR6tfl6ss6fg+xtJqydG/eqvZAlavce33I+x6To1TsbwM8AGcxxKLV9QXAHIRwOGb
	 6BuwBl1s8ZS+qdzL5fSZKggD2L/U3wkCaAJI+uuffCfPrqly4AO6psCPTmPnEeye9b
	 /nOeyAPxKFUY1FXTkr6XxGHTkMfdmuuLuMz4xpL4kaCUBlLM+TqTwfJ212ccpFnH3Q
	 PAlR1IfkuLEo3bKyRoYUFfuSBZdQmB2UDsGc7VhFrj7IrX2kvG395oGEaBbqryHjJE
	 KYD0rm9W7db/Q==
Date: Tue, 21 Jul 2026 13:56:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] treewide: Add a flag to detect the Apple T2 chip
Message-ID: <al9QR4v0Z_jkS44N@kernel.org>
References: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
 <20260721054506.11871-2-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721054506.11871-2-atharvatiwarilinuxdev@gmail.com>

On Tue, Jul 21, 2026 at 01:45:01AM -0400, Atharva Tiwari wrote:
> Add a flag to detect Apple T2 chips on Intel Macs.
> Cache the result to avoid repeated checks. That will
> be used in upcoming patches.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  arch/x86/kernel/quirks.c                      | 105 ++++++++++++++++++
>  include/linux/platform_data/x86/apple.h       |   5 +
>  security/integrity/platform_certs/load_uefi.c |  38 ++-----
>  3 files changed, 118 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index a92f18db9610..74b29738d404 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -664,8 +664,113 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
>  bool x86_apple_machine;
>  EXPORT_SYMBOL(x86_apple_machine);
>  
> +bool has_apple_t2_chip;
> +EXPORT_SYMBOL(has_apple_t2_chip);
> +
> +static const struct dmi_system_id apple_t2_devices[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,2"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,4"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,2"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,3"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir8,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir8,2"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Macmini8,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacPro7,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,1"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,2"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "iMacPro1,1"),
> +		},
> +	},
> +	{ }
> +};
> +
>  void __init early_platform_quirks(void)
>  {
>  	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
>  			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
> +
> +	has_apple_t2_chip = dmi_check_system(apple_t2_devices);
>  }
> diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
> index 079e816c3c21..50bbcc5134fc 100644
> --- a/include/linux/platform_data/x86/apple.h
> +++ b/include/linux/platform_data/x86/apple.h
> @@ -6,8 +6,13 @@
>   * x86_apple_machine - whether the machine is an x86 Apple Macintosh
>   */
>  extern bool x86_apple_machine;
> +/**
> + * has_apple_t2_chip - whether the machine has the Apple T2 chip
> + */
> +extern bool has_apple_t2_chip;
>  #else
>  #define x86_apple_machine false
> +#define has_t2_chip false
>  #endif
>  
>  #endif
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index c0d6948446c3..b4096d4c828d 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -3,42 +3,16 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/cred.h>
> -#include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/efi.h>
>  #include <linux/slab.h>
>  #include <linux/ima.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
>  #include "../integrity.h"
>  #include "keyring_handler.h"
>  
> -/*
> - * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
> - * certificates causes occurrence of a page fault in Apple's firmware and
> - * a crash disabling EFI runtime services. The following quirk skips reading
> - * these variables.
> - */
> -static const struct dmi_system_id uefi_skip_cert[] = {
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,1") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,2") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,3") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,4") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,1") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,2") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,3") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,4") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,1") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,2") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir9,1") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "Macmini8,1") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacPro7,1") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,1") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,2") },
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMacPro1,1") },
> -	{ }
> -};
> -
>  /*
>   * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
>   * it does.
> @@ -165,10 +139,14 @@ static int __init load_uefi_certs(void)
>  	unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
>  	efi_status_t status;
>  	int rc = 0;
> -	const struct dmi_system_id *dmi_id;
>  
> -	dmi_id = dmi_first_match(uefi_skip_cert);
> -	if (dmi_id) {
> +	/*
> +	 * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
> +	 * certificates causes occurrence of a page fault in Apple's firmware and
> +	 * a crash disabling EFI runtime services. The following quirk skips reading
> +	 * these variables.
> +	 */
> +	if (has_apple_t2_chip) {
>  		pr_err("Reading UEFI Secure Boot Certs is not supported on T2 Macs.\n");
>  		return false;
>  	}
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
