Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275E35898;
	Tue,  7 Jul 2026 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400493; cv=none; b=KMLcaa2SLcTnZcnvwQEoTTgqEmLoWVCD9VHP+iS3/zwy9D+va8yHN0MlWkawDSLR8WH3D/mZhzQV0ROgxQjyB6EdgkS72siD/zVf0pMqHbunjt3zSrWeb7OJIRP/spcyL/1u39OkS6mhuBgIbPGRzFYCy3WTmRr8Yd5sJtl5b6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400493; c=relaxed/simple;
	bh=mxytIN/UFgCA0tvBfOVeqmq6MfS3mnFBdlfExS/ORi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnkXCyp5pcQkm1sMRmqMgp6a5FJnKHQLi28PsfWscXwgYvcRpAJfsKk/u/dUrpW4BQDgyZ3m4sborSFcuyDnLytV12dSEXxrkn99Vv6yTho0mfUf7aV9BW72bsXbk4JODjcsV+4MeoySNtoMocXoXIqzUO/bRuGSWBi/L1Q0Rc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q/5j5tq8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q/5j5tq8"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 02E2E40E00DC;
	Tue,  7 Jul 2026 05:01:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e4YWmARrWxwQ; Tue,  7 Jul 2026 05:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783400480; bh=lf4G1Hvt3a3wr7cV52/ElcWQzEi1uqBet5MCciNxKME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/5j5tq8zAyh94A1ZqrGdDrE4PsgRxWQsOw2msvC20cjgog1XBiCvRCgmzDq5Bavi
	 zaMIosRNkrwUfiFK6mngQ7O16Beqd1riMeBYCQ+YGA0NXulX3UrH+rWEEmUDZgXQqc
	 CazAxHxIUZfqDqlDIrWvKVmuzaIKQZkwASfDws4HfwUBCj7/m3bCe5rjvzhsMLh7Ar
	 HisTvKDywg+D3J12ZI9YFDPhSQd8B2ino9TMv6fBtbrH34XpoUlqBxjkZ69jP3m6Eh
	 1btKlBUCdzHCdObhzym8JK3lA/8gfgelDljZIuXA1Qo8CQAQxA7jI8WtY7MBdVx+Rf
	 kDexJhjCfJsXPdXekLEihjK9+ZrTYMyhmCoZF+RK5yIFJahGjuZk9rW7nstkcGmXhU
	 vKXqGp4OtRGxjqbGSY/DCmPU4ZemWmH6fOzsHZvASO1Utcm5CBzgln9etozcZ8pTf2
	 4KoOF8BzXCw6PhuItACRxGoR8CLH40QXa0tstUEoh+6uvZdMb9WwXxGiBxFG8gULHQ
	 1dwyZBNKLTzqWjshBqxE6GgeW8gFlXfYMau2hzu6p0y2QssgAvP0rzFcnXL6JGOnO1
	 O2uRHuM2NMaaUmuzDjZEaTYp/vNEmb7Tzpjd92UTejn06og9rH6dTe4s3k0o3LSMZw
	 EVF50bJ6fy4tRRFXgZGCAA60=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5818140E0163;
	Tue,  7 Jul 2026 05:01:08 +0000 (UTC)
Date: Mon, 6 Jul 2026 22:01:04 -0700
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
Message-ID: <20260707050104.GCakyIEMSp5SXvf52F@fat_crate.local>
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
 <CAJ6xRxWBtaPZZ=SVff2WVE+B2c+fMJ6vTTracHU4BqH16ROXeA@mail.gmail.com>
 <5ef1c84d-729e-4b9d-a3e4-dc20d8242982@amd.com>
 <a23f2003-4ceb-4307-a469-dc683e6eb0f0@amd.com>
 <20260707035645.GAakx4_XEpHpSFBYzn@fat_crate.local>
 <e002b48f-fda8-45b3-bff7-07f1318f2d67@kernel.org>
 <20260707041852.GBakx-LFXxLiouBLwg@fat_crate.local>
 <f87df9b4-fd6e-45c3-aea7-e76a7995c050@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f87df9b4-fd6e-45c3-aea7-e76a7995c050@kernel.org>

On Mon, Jul 06, 2026 at 11:47:48PM -0500, Mario Limonciello wrote:
> So my point here is that even if boot_display fails to be populated on
> anything in your system (such as reasons the LLM called out) you will still
> have boot_vga, and userspace still uses boot_vga.

Aha, ok. Thanks for taking the time - that does make more sense.

So looking at Fixes: I presume you want me to send this to Linus now so that
it goes to stable too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
