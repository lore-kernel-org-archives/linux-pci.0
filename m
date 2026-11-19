Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048217;
	b=ptrQbHJgGgteQnjnKx2Ha7Ix216UkH0a6AH+/XaXciG5t+9ggzvebUvPW+kJfhtHmOZQ
	 /lE3F11f+wZm5x6JkD18etno/MtdfnRxT68jEKoIGrgQzUauaXZGTJuFb0aUraP+cuAwX
	 h9NKsGDpE4ivBUIWPmkAw/PLSRtdAdd8/zu4au7NwpyHKNFs6r47uXcyy5fXGMjeO8Jt8
	 m5H8wVa8gRo1IwHZHCAnRHysJeBYfh7QUR2o/+I/Yr/o1z4vwtSrrALxgH2Tzjw/kVf60
	 k0VrVyf8w987zseaTSkYm2Scvgz3nR3gKKgFJqu9MKxyUVo3us4+eHvaz7VF+Q5rbug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048217;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zlRhRe4x4C2GmS+jBT2E45nk92RFWRNTistccCNn1nY=;
	b=BvxL+O92vMIY5EpS84gsdXJPgaZrb6RoSi8KIv8qaCjfTSya5S4gyGlz9R80r/WTregL
	 s29HhCK/xZWSfQTSao/wpTz+AZK1zn7RgqHJARLx+ZCEslUq0s5Ima3dnkBKMAMlY7LXO
	 UJotWGWJ/3f6k8aToTjhKcxycefDzRPz7kUFXl2fVIq9VOEecxskLGlvXY7DKMAqVdnK0
	 ZujHwIXFsK9KS0T2XcBZ/uea8RLcbnP1UcGgDvEI86YbKqVyFHb4hGLQcntXR14HlkCDo
	 OwmIIrHbGmEx/aFlHOMEXA/LugOyK88ItrxOxWT3yNwCOLfyE9fEO1ywiCl6ujkQSdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xdih5uSp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0A60A2630;
	Thu, 19 Nov 2026 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xdih5uSp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA751F000CA;
	Thu, 19 Nov 2026 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795048217;
	bh=zlRhRe4x4C2GmS+jBT2E45nk92RFWRNTistccCNn1nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xdih5uSpGaoerosg1ND4JK+hXbCqKSnVoEkdp+XOaFUjHGloyFBTlDoI0V5MMB098
	 BT0koSnLKEagFz2rojOrKqIxo/mWBZDJKVBEv3LZsRwpdIXgO4uLSFCg5w25JA+V/M
	 KIMR8b9UU9yrFROvO55Sp+PRLh0EmKIosyycGCFPjDHeT5yeP69GMFYk8OYB2X48vt
	 tTWQW8FUXJTk5kAa6L5n+XSFeQgjsSW5MCRGuYj6h+zFYCDxB15bGyn9dka47Xr990
	 sO1cO9wJPIPQWh1bgndDnl4Y46VNDP3LPq41CWFxNI+hz9Hw6IIKZTlwyhCCMbFShc
	 gOKZ9r24Cepmg==
Date: Thu, 19 Nov 2026 01:30:11 +0100
From: Thorsten Blum <blum@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <av5DE5hlpItQzD8m@kernel.org>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
 <av4bS1QEZpniwlb3@kernel.org>
 <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>
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
In-Reply-To: <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>

On Wed, Nov 18, 2026 at 02:21:41PM -0800, Borislav Petkov wrote:
> On Wed, Nov 18, 2026 at 10:40:27PM +0100, Thorsten Blum wrote:
> > The patch has been reviewed and acked for quite some time. Bjorn offered
> > to take it via the PCI tree at the end of October, pending an ack from
> > one of the x86 maintainers, but there hasn't been any further feedback.
>
> [...]
> 
> It is also my objection to you not merging anything tip-maintained through
> your tree.

OK, I won't.

> It looks like you fail to adhere to the process everyone has agreed upon and
> you're simply bypassing maintainers.

My intention was to get this patch into linux-next for broader testing,
not to bypass the maintainers. Apologies if it came across that way.
