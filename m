Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FE3EC6AE;
	Fri,  4 Sep 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500231; cv=none; b=ssm324hS1Lyu3QRHuC2r4hIPGNz6dEFznDjyEpEzBXx1G++POOLooijiFUZtkDPWD2r50TGVMZPvOlhC7ycsPTA1yydTkpAJZrlProglYCGI4PUU9IRAr+sgyOIAwtcfjgfxOHgqYBVasKJXtUhtdeuyYl08zN5JAlgr2jIeeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500231; c=relaxed/simple;
	bh=YamtZz9+eQOYPv+YW8vL3uLKsyhCQDtRxjSncZweHpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPdy7pGfnrsQ9aLDz0XEyb1rkx0i15s8V4swgnQ5QerNr8kwBguWTfyqCY8ETluzS/jmgS0fcDjRD9FyM9K+Or0Rbd51Qa1GLQY27nCi+EpnNIc1LyPnLqdmc0oTi9LxcQoODei4KaZbTExjtwgyq07pG6ot7M5NAnW6QRnOkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZDzvN7Y0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZDzvN7Y0"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A3B7040E027F;
	Fri,  4 Sep 2026 05:37:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pKegr_u4LegG; Fri,  4 Sep 2026 05:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788500216; bh=ftrzNRf6UL0Q9cjf7/RMWWmmexT6aW3INzb1nPqO/CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDzvN7Y0JVjScpzouOD1KJZ2MDv2FfI3ujcAAvt4JjwdaU4b9clCldd6kbyyMlwIY
	 JLhhIiNwzCrfhxABKHANxKgpgh+gXZrkP0VuXJIOVYO6mzd2IJSXlPvEawfATO8+e/
	 nkYVwH7DujZyT4xTHF6AS33MkkLobt65TnAzVxThu4oaEZ9+z9TOopgBfZl4y8ctN0
	 Z6y5UdFGVC+iwWAFVFXW+BoDazh1vL1P1gnmxusFJV8yaOlP2gy6Bfa2G980TNXSV6
	 MEpcAmbw937MjPE1xYijVgi0EkGVKaqWEWM9VwQ515Cs02awj39VEQfyieZnQV+sm1
	 F4qxipLYawjY4c+Ke4YqmgwVG7pJpCNzPnXJPVBEPGPCwsh7Ls8qTCULGPigP2Sjwv
	 g5cc7L9j0rtVg/0vAVPShLIjBwnU6KqZfOaaISEcdEcsFwqvmOBcrHN0iimJ1C3u/m
	 owRi/hp+wx5Tk1OqNF0fCNlHugoMnGuDRl5WZk34vIZHmej8s47f2QkwouOT94wklc
	 wFAIxAkVssPGZChuXjj6PZ0LGs3TZRRaKA4LOKGFIv3fkbSvkY8kwIYWlMDrioppFQ
	 ypHUvwnbeuAPpI6ILN0KRFT0O3EFfyJJCcpiQ7HAqRoUAwrzeO/qlCFfYp7FOfiRN4
	 EQL1LNuPEPxwuFGQjUX+TPsY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A6C940E00E6;
	Fri,  4 Sep 2026 05:36:44 +0000 (UTC)
Date: Thu, 3 Sep 2026 22:36:41 -0700
From: Borislav Petkov <bp@alien8.de>
To: Lin Wang <wanglin@open-hieco.net>
Cc: yazen.ghannam@amd.com, mario.limonciello@amd.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h
 models 0x04-0x08
Message-ID: <20260904053641.GDappY6bdy4hAwyxaK@fat_crate.local>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-5-wanglin@open-hieco.net>
 <20260902024833.GJapeOgRJ50RAZvI3e@fat_crate.local>
 <5c6ebbf5-3b3c-47e7-800d-adb4049cd636@open-hieco.net>
 <20260902151340.GAapg9JDQMt2WTkjLM@fat_crate.local>
 <20724518-2bf0-40ac-a5a9-1b2fe9df2b0c@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20724518-2bf0-40ac-a5a9-1b2fe9df2b0c@open-hieco.net>

On Thu, Sep 03, 2026 at 09:49:58AM +0800, Lin Wang wrote:
> 
> 
> On 9/2/2026 11:13 PM, Borislav Petkov wrote:
> > On Wed, Sep 02, 2026 at 02:22:13PM +0800, Lin Wang wrote:
> > > Please let me know how you would prefer this to be handled.
> > 
> > Well, X86_FEATURE_ZEN isn't Hygon apparently. Otherwise, we wouldn't be having
> > this conversation. And we wouldn't need ugly workarounds like that.
> > 
> > Which means, you cannot set it on Hygon. Instead, you should check vendor or
> > define your own X86_FEATURE_HYGON if you think it would be useful to denote
> > common set of features between all Hygon cores.
> > 
> > Reusing an AMD-specific flag but then having different hardware which needs
> > hacks and workarounds to the code is not what you do. Hygon is a different
> > vendor and it should be treated as such - not piggyback on AMD code.
> > 
> > Unless you wanna piggyback. But then you have to extract it properly and make
> > it generic so that it can be shared. I have been asking all people submitting
> > Hygon code to do that and you are starting to do it but then you need to stick
> > to it and do only that.
> > 
> 
> Hi Boris,
> 
> Thanks for clarifying the direction.
> 
> My proposed approach is to use explicit vendor checks to make
> init_amd_nbs() and amd_smn_init() AMD-only. Hygon node enumeration and
> SMN setup would remain in Hygon code.
> 
> Sashiko's concern with v3 was that the AMD initializers were restricted
> while Hygon call sites remained. However, as currently implemented, the
> AMD NB and SMN paths are based on AMD topology assumptions and cannot
> provide the Hygon node and SMN mappings.
> 
> I would first stop the affected Hygon call sites from entering those AMD
> paths, and then make the two initializers AMD-only in the same series.
> Later driver support would use the Hygon interfaces.
> 
> Would this ordering address the Sashiko concern?

This should address my concerns - we can then see what Sashiko complains
about and sanity-check it.

And I explained it already - you basically carve out/split/separate Hygon
paths from AMD paths and you basically forget X86_FEATURE_ZEN. I don't care if
Zen and Hygon systems are/were the same or almost the same.

Obviously they will start diverging so you can carve out Hygon-specific pieces
now and then keep adding new functionality to them. Just as if this is
a completely different x86 CPU.

This way, the code is untangled from the very beginning and there won't be any
ugly and unmaintainable

	if (vendor)

sprinkling all over the x86 AMD code where neither you nor we will be happy
about going forward.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
