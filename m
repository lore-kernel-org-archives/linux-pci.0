Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038034;
	b=xSxx4Ml+/1UubiT4t1x+4uXUvSoW/b0FCaH5VaLhqSk8xFNnXwpKC2iLT0ZZZMFqZz04
	 cW3Iavg93doq5CD5PLTuJFS5gcBDJE0yHK+3YaO55/Cbm4rBm64CcRK9CrImNiR2Lwr8W
	 gbB+BR735PvOeAE/lqzKpkiMFm4XVgOinlap5Z+PkdIIAs4y0tNF5qC/xWGzCR779m8ZH
	 jD5UpJIZs6mFZw5F8cUeqcy7NcnuRuLRGjRYVYjxwzaN7PQWeWOZcsSrEG+THKqbxlv5Y
	 2ZbESObzx2tEzBsnyEjVVbr96cejA8siA+x1zQreewXrfxGR2GPTsp0WuiZNAcvdO2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038034;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iuKNsFPRKwvcivKJujrThQj1zMMPbCoiOaIKHiRvbFo=;
	b=X9iybZTixn/Za2pHJqTKmLasGkSC0cvMsiL3WTKz2+qPJEMpXxEoSa/Wrp67tFiflb6Z
	 QcM3zYgc51mGz3vBT0cCI5XrNjZp74g3VXV0D8/DvHKkvh3P1LQQPgTLaAUAx/8MEb3+n
	 x/hBQUE3XJ5Rt80UoPBiwNJXDIsOtbuxPLuGX+2x0CKpTqLbEkddZOgMtL1wtdGUFwbkx
	 qznZj9R9Q+J9L6izU7QJj4dn3d2QEEeuF4kteoQ4NyqD32l9ULdxLFgxrwYrvTOKVXakq
	 1f+fy6nVX5yMms7drVhBwgK0Jnc896w8YTucPXp3ks9Sabsu27iFEuyvwl7Ilhx5cYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr+dmbxz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FA60A2601;
	Wed, 18 Nov 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr+dmbxz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBF31F000C5;
	Wed, 18 Nov 2026 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795038034;
	bh=iuKNsFPRKwvcivKJujrThQj1zMMPbCoiOaIKHiRvbFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pr+dmbxzIVAWKNADqW5UCHqyJoKcYVtCvxj6a6T2gniMoNbWNpknmhEXUSTae7YH/
	 AmP+qF84cFNrFsGUyu/y2f/0CGrKL+Rth1qEU+qB09RH3wf+XdhOJ6PtEvmPTeRRc+
	 cc9hVNBOoWSWz0fveLJ9qZ3Zu2ZOBlKH9K0NLCur1pg45kt+W7wATmOTmseFpaiVS/
	 xXt1Z1i8MmxDuyX56ERseI5r7rYYVkD3TeFY9h65toaz6smwB4AW2eU38imj+q/o4f
	 6PbjiRMLYmhqVSYyxYjsDXUTYqxHmTqVD24BOXNPGDcY7dfSdp0o1yS/o69ETbhRo7
	 Epr+O6eOh9r6w==
Date: Wed, 18 Nov 2026 22:40:27 +0100
From: Thorsten Blum <blum@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <av4bS1QEZpniwlb3@kernel.org>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>

On Wed, Nov 18, 2026 at 11:40:59AM -0800, Dave Hansen wrote:
> On 11/18/26 10:35, Thorsten Blum wrote:
> > Applied to blum/for-7.5 for linux-next testing.
> > 
> > [1/1] x86/early-quirks: Scan all functions in early_pci_scan_bus()
> >       https://git.kernel.org/blum/c/83e3892f2aadca0123a3b7d452e3f39e74cf5126
> > 
> > I plan to send it to Linus during the next merge window unless there are
> > objections or the x86/PCI maintainers would prefer to take it.
> 
> I'm confused why you would even consider sending this to Linus. I'm
> sorry but I'm not familiar with your work. Is this kind of thing you
> normally send to Linus?

The patch has been reviewed and acked for quite some time. Bjorn offered
to take it via the PCI tree at the end of October, pending an ack from
one of the x86 maintainers, but there hasn't been any further feedback.

I'm not keen on sending it directly to Linus, but I'd like to get it
into linux-next for testing and eventually merged.

> Oh, and I guess this is an objection. Please don't send this specific
> fix upstream.

Is your objection to the patch itself or to merging it via my tree?

Thanks,
Thorsten
