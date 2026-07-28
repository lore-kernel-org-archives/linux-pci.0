Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231325B086;
	Tue, 28 Jul 2026 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200385; cv=none; b=t/pOwBpjBPIHT066m6KrDJfVzwGHdwE9EjX/MYF8cqCCue32hTRMafC8b6MAX18z3QAqH4F/0NulcunNwhmtF5ayTy7WepmMdFp7z4PrmOG9AklAohoEjF31sATWpyrqRseA4ClOf4Z5MngzyOiUpWxIpNg4JzzShvtT54dDuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200385; c=relaxed/simple;
	bh=Cs+lhkcx4V+TqqoVLC1x5WpkdtMehp4i/XgGotMPyPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR68/pYzYGaGKlFdQ6rMkUTLIaxow4MGKFBKYMurMwMC6rNFUzsZKRcG9f9mjAg57AGuLT+D0Mqky5fwo2d1lI7yMMUBJcn7i/O5Hfhg0BWwKIXp4w/29V7CvCMdbquy1ke0xwMjgiwAg9wFMlrM8YlQXcItWMA4gDp0wQYS0uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QpeT7HFS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QpeT7HFS"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3016040E00E6;
	Tue, 28 Jul 2026 00:59:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9tTrzS08_f7E; Tue, 28 Jul 2026 00:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785200364; bh=9Pbkpsyn3LuxVwkQuJpW2Q4r277BvMJkMnI0QRRTiG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpeT7HFSVEUpD8isy8cgi+uAuDnpBv5k8tUswB8JcUi0yf3JUqKTQRIY6xSsdpO+C
	 tSzenpZgLXRXTw95sp0ZRAU1xsPDqjohWBswZjo4QT6xNyZMNeDBkB3MVibp3S/BTD
	 zw5PJxwBc5/D+KxwYxCzaRd3xB8IzAprq6Kdbqd/oAOF8xRTp5mWkapltNGT5vEOdN
	 zoo7uffYylNSVAvHPfePC1Ck0zOI0WUIAFKiVr+My2Tnca6dt5qjp+JB7kKdtkqzVQ
	 n6f2cmpO5KnjHdXEKDUqIDnxr67MTcj/SzPatjGosMYaY7oHCbm3VAHF9RqfM6gekz
	 hA23uR6Pa/k5U0rjYoTZAkm394Y0VyyVcB/cRdgLWv6xpfumR78tGG2i522vzmLpJx
	 407UtK/24FnSygTWoouOsIz8UGBp+Nsba43y6ogqn/1embEXhCp8CqNq5p5p38kWQx
	 RLZrKDf5ZBwFBS4KXv1LP9iFxjygFw1j/JHovqwj7m69Sj68H8EtQLpeItaWnk6CEL
	 yaKnDytPYYUQdbS8X8EKfm3714KMQlf2LinuarKBktj8tDVIysF8MgNOpUbjgTbRFX
	 j7pR+L1Tk/Zb7Y07YkcBwnB4DU5+y1KXJpzSMhooE2POqgYaxeDu1CAJStAyfUyqgV
	 um0y9GM4HUUMqOaBSvTsy+Oo=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 256CF40E00C3;
	Tue, 28 Jul 2026 00:58:51 +0000 (UTC)
Date: Mon, 27 Jul 2026 17:58:47 -0700
From: Borislav Petkov <bp@alien8.de>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Darren Hart <dvhart@infradead.org>, Lukas Wunner <lukas@wunner.de>,
	Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: Re: [PATCH v5 1/2] treewide: Add a flag to detect the Apple T2 chip
Message-ID: <20260728005847.GBamf-x27vgqj7WG7e@fat_crate.local>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
 <20260727211807.1223-2-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727211807.1223-2-atharvatiwarilinuxdev@gmail.com>

On Mon, Jul 27, 2026 at 05:18:02PM -0400, Atharva Tiwari wrote:
> Add a flag to detect Apple T2 chips on Intel Macs.
> Cache the result to avoid repeated checks. That will
> be used in upcoming patches.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  arch/x86/kernel/quirks.c                      | 37 ++++++++++++++++++
>  include/linux/platform_data/x86/apple.h       |  5 +++
>  .../platform_certs/keyring_handler.h          |  8 ----
>  security/integrity/platform_certs/load_uefi.c | 38 ++++---------------
>  4 files changed, 50 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index a92f18db9610..6651e5d4d106 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -664,8 +664,45 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
>  bool x86_apple_machine;
>  EXPORT_SYMBOL(x86_apple_machine);
>  
> +bool has_apple_t2_chip;
> +EXPORT_SYMBOL(has_apple_t2_chip);

I'm guessing this is parrotting the non-GPL export of x86_apple_machine from

  630b3aff8a51 ("treewide: Consolidate Apple DMI checks")

Lemme add those folks and ask why aren't those exports GPL only?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
