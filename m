Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1412C21F0;
	Tue,  7 Jul 2026 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397961; cv=none; b=J3BpF9kddDVQtqu/2b/butvu3+dlqTSy/0p02MJtyNbfqAyQ6yZX8osEGTNMOyWOthb2h9fJToyl+LK5lm8WvX8ekcqS19sWtUAIWRko6PJM5NC6xICHRXaG11aIlpWgGiqemWcvuBpsjfsXWs4+aLAtUDVqUWnSrm8aDpB4i0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397961; c=relaxed/simple;
	bh=nyNGHTCJZ3iBbInaTzSh5iQ7keHFR7Nu2UenzjrWPG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrYgFaSHYw2Ts1H8MTGtLqHeFYNGpdsYKKmv/LVbkKGmI2oL9aZL8DA/iDeVnlG0YIXKNZ+qkY3TYc/54W/hzMZtyDqE7ab0XZvqdRhAO0ShymRedaYmknxuT4ZiF2mvM+MeRnZdz57Kiu1GXokumctflm5dsVV0DXRRQaqw3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZbFnmmMX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZbFnmmMX"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EBCD540E016E;
	Tue,  7 Jul 2026 04:19:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jIrOAHFI8u7W; Tue,  7 Jul 2026 04:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783397947; bh=MMOl3uLOwCecbqcr2z5pcvj+YLQiED1W4F9HM+J1R3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbFnmmMXkHvNHaiqhyCxG8VL4NggzTSpKquJOHs49aG4HOvDNJky1aFYt7Bs4s48g
	 LmqQPop1hg1WywqmXGTZnPM961A1DllKweJGHqjCjZOHIRbeTx/jDXakfNVki3aj1r
	 f2FmWgamnL07fmk1UVRT0/t5w7r0bvnrqfPnwOTyyuhpml9IuobyGTkmmg6tI8XBYn
	 qZMJO/stKgDQTkoO0/PI6IWG18IlFWamSFIZl3vCFYjSWzzUDWX0EQc/4ZHbjMpAJ1
	 1AGZIM8VEcCZ79tFSMJfSPOgWdSh+9Llr0xE5fnSv7o44T0bLbltcjnFRNDFmIF8wd
	 Ua0OxVXyKUrUfvCmOI+tXNrtX5cSQzmTAJVrmkVWpBCqTydOWVJUpyhpTCEoZlBefL
	 9cVCaclKSGBOpou460DvVv1CpGVGgD2wBpxdIBUO7VP6xrMi8oB3verb4KQqYJK2G6
	 EYwNyx/t44bE3uvqEg1EjqLmYUCGalvwoQvoo3UOkjN/VmJSjjdhl/han93/lfg6EZ
	 zchK+Qe75EphXxmm6NWbb4mL5ybW36WT0lS83xBakCl2aQYoP+n8GTzXamUjOAIVJt
	 zOso1ltNIqisoRTBINpWd2yITgS/IFJ7eLJKNMfxTAxoH8e21gWbStN62KVlrCVS+W
	 Plo0mEIOVROQ7eC4ruA7+pBU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5010640E00DC;
	Tue,  7 Jul 2026 04:18:56 +0000 (UTC)
Date: Mon, 6 Jul 2026 21:18:52 -0700
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
Message-ID: <20260707041852.GBakx-LFXxLiouBLwg@fat_crate.local>
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
 <CAJ6xRxWBtaPZZ=SVff2WVE+B2c+fMJ6vTTracHU4BqH16ROXeA@mail.gmail.com>
 <5ef1c84d-729e-4b9d-a3e4-dc20d8242982@amd.com>
 <a23f2003-4ceb-4307-a469-dc683e6eb0f0@amd.com>
 <20260707035645.GAakx4_XEpHpSFBYzn@fat_crate.local>
 <e002b48f-fda8-45b3-bff7-07f1318f2d67@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e002b48f-fda8-45b3-bff7-07f1318f2d67@kernel.org>

On Mon, Jul 06, 2026 at 11:02:04PM -0500, Mario Limonciello wrote:
> Those systems use the existing boot_vga sysfs file (which is unchanged).
> 
> Userspace recognizes both boot_vga for those systems and boot_display for
> modern systems depending upon the use.

You're "explaining" as if I were someone who actually knows anything about
display gunk. But you need to dumb it down for me so that I can actually
understand why we're fine here and we don't need to fallback to
vga_default_device() here, as the LLM has "inferred".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
