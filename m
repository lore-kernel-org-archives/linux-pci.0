Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4C367B60;
	Tue, 21 Jul 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647769; cv=none; b=F0vmhPAAGOtDe+WLtcinpNv/JOkt/R77B0pvulpHRu4zAh6v96Zy3Wzbzi+0Luh4Ct/2kLDRvlmkZTgpShm6LIBSObQO72SSh+WtAfsxB9XPQrB5kloQw4weT434IUdiFc7k0h/5yYSFHrG5Otw8swB6o/aKcWZV/grVT+IwBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647769; c=relaxed/simple;
	bh=6YNNZIFpa1OsYiAePENW2CYKRSiDbIY4qh/xUvVrYXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzXhe0Wq7LxTmPVipYCxRbTNzTwEtxkygUwGEZHXft0UIBbBr7NhTiG5TQu1ONqihSjJmu5wXtmr86FzMXkZGt1Obt2R04ILVvxXJG91R3gOMegCwDTAhoZ5NOivn+a3M094t7zc3qLXOiH6XbTsy4UQAkz1xcES5s1JfQQmOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5GtKRfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5GtKRfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642351F00A3A;
	Tue, 21 Jul 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784647768;
	bh=vKR0zlu4bK2eye4JJSxzjC3UQbyoedFDIfb+cFpF7yI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P5GtKRfCBc3xqCC+TlINJzdnXVxCjDemORr98LEM7iXwLwu4yz4RT8DrZSjAtEFoU
	 3kA0E7mWKVBNs/9BurxF5ZwULBFcnTvqN6jR75eYS9VlJPFA8316RTtLVSvXT+Fcsc
	 3QvzzKNYPzS/VCtbrXkbtrg0gmMfttl2OM4JhsNEWMdlkOAl6px66BrylVDE4esJlT
	 qV46lU8gq9rhUGeWqnKL3yEQhPs5rkqnG85TzZKgTE2mpcT5zcR5UaUYISXXuhMv07
	 WoNj0TAYsg6k2OMZnI5Qf8ZwIMqx6M+PUQjKKGD76fxuxgG/5rEiDZhTT98iHEPPfa
	 lZs01SJgzeajQ==
Message-ID: <e74d963c-8cf0-42ee-8b83-86e8c65dd0c7@kernel.org>
Date: Tue, 21 Jul 2026 17:29:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] treewide: Add a flag to detect the Apple T2 chip
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com>
 <20260721063412.11588-2-atharvatiwarilinuxdev@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260721063412.11588-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Jul-26 08:34, Atharva Tiwari wrote:
> Add a flag to detect Apple T2 chips on Intel Macs.
> Cache the result to avoid repeated checks. That will
> be used in upcoming patches.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  arch/x86/kernel/quirks.c                      | 105 ++++++++++++++++++
>  include/linux/platform_data/x86/apple.h       |   5 +
>  .../platform_certs/keyring_handler.h          |   8 --
>  security/integrity/platform_certs/load_uefi.c |  38 ++-----
>  4 files changed, 118 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index a92f18db9610..300d6436060d 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -664,8 +664,113 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
>  bool x86_apple_machine;
>  EXPORT_SYMBOL(x86_apple_machine);
>  
> +bool has_apple_t2_chip;
> +EXPORT_SYMBOL(has_apple_t2_chip);
> +
> +static const struct dmi_system_id apple_t2_devices[] __initconst = {
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

This takes quite a bit of storage, struct dmi_system_id is not
very efficient.

How about making this a NULL terminated array of strings:

const char *apple_t2_devices[] __initconst = {
	"MacBookPro15,1",
	...
	"iMacPro1,1",
	NULL
};

>  void __init early_platform_quirks(void)
>  {
>  	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
>  			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
> +
> +	has_apple_t2_chip = dmi_check_system(apple_t2_devices);

and then here:

	for (int i = 0; x86_apple_machine && apple_t2_devices[i]; i++)
		if (dmi_match(DMI_PRODUCT_NAME, apple_t2_devices[i])) {
			has_apple_t2_chip = true;
			break;
		}

This should save some space and IMHO just having a compact list of
product-names is more readable too.

Regards,

Hans


>  }
> diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
> index 079e816c3c21..47b27dceab18 100644
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
> +#define has_apple_t2_chip false
>  #endif
>  
>  #endif
> diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
> index f92895cc50f6..a355f4400179 100644
> --- a/security/integrity/platform_certs/keyring_handler.h
> +++ b/security/integrity/platform_certs/keyring_handler.h
> @@ -45,11 +45,3 @@ efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_ty
>  efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type);
>  
>  #endif
> -
> -#ifndef UEFI_QUIRK_SKIP_CERT
> -#define UEFI_QUIRK_SKIP_CERT(vendor, product) \
> -		 .matches = { \
> -			DMI_MATCH(DMI_BOARD_VENDOR, vendor), \
> -			DMI_MATCH(DMI_PRODUCT_NAME, product), \
> -		},
> -#endif
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

