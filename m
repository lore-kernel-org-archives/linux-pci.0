Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43F79CD;
	Mon,  5 Oct 2026 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791160548; cv=none; b=P6wqvFXaPFHZKCR5chOiPTG3E9c+A8Abaf3DpvboQNkl8FQuR87kkR9+6SF+zstWF4nNjlK8LOb3VYOTQ3P9blszLWlCplpd1uGIGsg4mkso6/1Ect58pyziOVinF2lslYhA2IumxQXG9ADjZi8AodaP4RI68baCQ4py5BG73t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791160548; c=relaxed/simple;
	bh=qQAb5M3Ldh3VAKcPKRRUntBg0VKcfBruUwKRe4B9Jpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8l2a748pqleWwoxiPkcAm6uDfz6WkfwZYzFn6vHSlZsd3hjAZaoJgECGiOf4+e0d7zTj1jPCq0gGz3aU2p9Y9gELW1AEupvvcCRJIJ3Xbw9lSuK2LQA7Hb+DCgGi3ryZII2dJlV+9hBu3NYDaB9mRo6KisoiO7W7bVU4Yz8Ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8TWGauj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8TWGauj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C00F1F000FF;
	Mon,  5 Oct 2026 00:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791160547;
	bh=c1QA4sWbnl2OZROjImqdrz4B2MciVP+03FyQwz6jKpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U8TWGauju8zdK71GYRS9ptewoONg8b3X8M664SwbJw+a4JqhlcKEz1PaXHylp2bkv
	 J7Y5JHBANBsdiordGw7egjY/tmqTSOM2jK68ph7tkCKwgsFd5sWacrD70y5jj06F3M
	 GYCu7bBlZXYSRho42Zdqa/WwpCsJxqGDkSm6IUxKF+S9Oqjm4EkLRtYZAx3NaoVDtN
	 8bg4FyyjrIKkMIsYxfTCublYRgOqCh0Iv+hzL1F7M8PrHuJgQJ3HC2c04puYOPTKHY
	 Xmmf8J2oNqm5TxH1pSuPPZucOZ4qwG5NHDsfYP9eu+ARZ4ubPyh40d1ShrvzTv7lkw
	 DaUrdQkaDt7gA==
Date: Mon, 5 Oct 2026 02:35:41 +0200
From: Thorsten Blum <blum@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <asLw3ZfDy-rDxwtv@kernel.org>
References: <20260916100206.92853-2-blum@kernel.org>
 <asDr0tWYBNC296EQ@kernel.org>
 <f9b1c1b6-03d9-44fb-bdc4-78342b05f2af@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b1c1b6-03d9-44fb-bdc4-78342b05f2af@intel.com>

On Sat, Oct 03, 2026 at 04:55:54AM -0700, Dave Hansen wrote:
> On 10/3/26 04:49, Thorsten Blum wrote:
> > Gentle ping. Is there anything you'd like to be changed here, or could
> > someone please pick this up? Thanks.
> 
> How has this patch been tested?

I tested it on an iMac13,1, and dmesg confirms the quirk is loaded, but
only when this patch is applied:

[    0.023863] Resetting Apple AirPort card (left enabled by EFI)

lspci also confirms the hole at 00:1c.1.
