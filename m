Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040531;
	b=NQ1NY1UfUCp/UUyjqSeIIxHX2EnEkHIhTYij9Rx0IO2eeAFzDHDe8h4/Stpj6RtsMpvg
	 x36eFVopnrKEMtNjRKfwcmqKcsCDLmzR7+XN1w99fmikSILuXUyCzxewFaR7/cNe0duq1
	 LB8K58tCHI3yDhI5ie2lf1QBuGh6t4PdMr62Hydc7AcsOz47z3t43ng+lXZoCvl+Os97+
	 4r1mRYFND+AZMDcDr1UFQ/3Xy9L6O3QKIv/dEEPBcyc/32lNempTsw1EiPZDXMFSp3mVB
	 c0z3njoV1LvIg/itzS+enB6THTacTYxBEoRl42IK1a5ZxXfblIH51MhLr/l0GxYiaDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040531;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oBLl2ZgbtZzWgM6/8uoKipPcTWFuyccR49px6Ov+SrU=;
	b=z9FSJBW5cKfn44gyVRIUL2/42mmuTV48oa9ADDgItTikR26oFV+b/C4azh53mMU4PnSl
	 I6cgxhN3gqXwk6a328JGfObS1/NqRIvSub2B0PA/JCQJ+YHKDcS4nFUdnu1uTjR/pC6al
	 AzVCDrarzWBZlWUZGReECwUhmkJi/Yjkj4ncC5ixeuQe3j8KLn+0P9ClRVSDnciVaKIgL
	 9vbhzDpciSsYmNOGaB8iE0l6LnxVTwsEQXYn6K2aoae2caGxknNS+w7j0uAK4a+MOndGL
	 Ic2DXM6nmmobqWs0b2Y+IW8qvUdWQvjFFXivlNpgr0nR/Wi+1dRO6KaKGDX0e01BF1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=dW4SapPP;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC1606A331;
	Wed, 18 Nov 2026 22:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9FC1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=dW4SapPP
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE18440E01F4;
	Wed, 18 Nov 2026 22:22:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HV56oMIbxqM0; Wed, 18 Nov 2026 22:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795040518; bh=oBLl2ZgbtZzWgM6/8uoKipPcTWFuyccR49px6Ov+SrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW4SapPPPxF+o89PEAyD4rwh8D7DPju7lfrifSy54wursIa9i5qxCgjtyvz4Q/tQX
	 YRzyStNwN97KwmACncjco2C4+10akLH9dF1F1nP8pkP6ufZG/A6wA7X7VvWskWj4D5
	 KjASTIHZ4c9hPz1+q8n5b2O9HU1vVbNnQJPp2NkQ2ub3hL0yAJbYtZoYZXJSoN1YFD
	 N0Pxpu2ZKrAXM6qFmUXbHVaCdlPh6pUj9bXDF3p37CwfES/gimtCFQ6N8Mz7/l75hQ
	 hG3zmsxUCOT6bq/3pkI9Sjtj21mNEny0JREB6wZ/oqxS6idC60lu/mKD6b9ZQL2xVm
	 H+fM2hqu7SDMfks8Ft8fBMfziqfhnWmHZgJBUdtK3cmPF0tRSUqLWDgVqMNEkgrpiZ
	 UY4xJ9RCuvzZfTqUgaPeEBlOfjIbfXFi+NYSierikixvEMAXnZaP+Ds9udhVN+8N9/
	 5m8I3y1D4nR81H3xDYKecLnzeen019NSEfANrCh5uFHBobqIpx8sWt6o9/9TXZnl3w
	 uoQhU3QxqWfLkKicmjMrodzpNV0cp8PZgk3hRIaxaBDGgkc9tNWpion5lOlIE+L//P
	 2A2dPR1KAARPb524lD1rqXkBALYOtDTSGmwhb8KjTya9OSa5Am77ql3O8ms1R4NXCT
	 8hUo0eZaiG9tRMkBoIKGcmXI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE27A40E0184;
	Wed, 18 Nov 2026 22:21:44 +0000 (UTC)
Date: Wed, 18 Nov 2026 14:21:41 -0800
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <blum@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
 <av4bS1QEZpniwlb3@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <av4bS1QEZpniwlb3@kernel.org>

On Wed, Nov 18, 2026 at 10:40:27PM +0100, Thorsten Blum wrote:
> The patch has been reviewed and acked for quite some time. Bjorn offered
> to take it via the PCI tree at the end of October, pending an ack from
> one of the x86 maintainers, but there hasn't been any further feedback.

Why, because after sifting through all that gibberish in the commit message,
it is basically telling me that some mac laptops have trouble with Linux?

And because of this we need to stop the presses and take your patch
immediately?

> I'm not keen on sending it directly to Linus, but I'd like to get it
> into linux-next for testing and eventually merged.

So just from looking at the diff, that patch will definitely NOT go to stable
but needs to stay in tip for at least a cycle so that it is tested as widely
as possible.

Because if you break other systems with it, we will have to revert and fix up
after you.
 
> > Oh, and I guess this is an objection. Please don't send this specific
> > fix upstream.
> 
> Is your objection to the patch itself or to merging it via my tree?

It is also my objection to you not merging anything tip-maintained through
your tree.

It looks like you fail to adhere to the process everyone has agreed upon and
you're simply bypassing maintainers. No one does that and if you're planning
on working with other maintainers, bypassing them is the *LAST* thing you
should do. I never thought I would have to even write this on the mailing
list - it should be implicit.

I don't know whether you know that, maybe you should refresh on the
development process if you haven't done so:

https://docs.kernel.org/process/development-process.html

As to being familiar with your work which dhansen mentioned, I can give my
experience:

You are flooding us with what are mostly cleanup patches which are so-so and
not really urgent. Not really. Sure, perhaps some of them are nice to have but
meh, not important. Each time I have to ask, why do I need this patch?

However, your frequency of sending more and more of them is as if your patches
are the most important thing since sliced bread.

And because we cannot reply to them immediately, you resend and ping and
resend again. Instead of being patient. See, we're swamped with shit that is
orders of magnitude more important than your cleanups.

And I told you back then, if you really wanna help, you should REALLY HELP and
review some patches from other submitters, for a change. But you completely
ignored my hint - rather, you continued to shoot out your patches.

Sorry, buddy, but this is not how this works. We are not here to review only
your cleanups and deal only with your output when you're not reciprocating in
the least.

So what I would do if I were you, is to slow down, try to help out and be
patient. Think whether your fixlet or cleanup really needs to be resent
multiple times in the face of much more complex and important work we all
have.

And maybe, just maybe, you could perhaps start helping out with review. The
thing that we all sorely need and no one really wants to do.

Because it is only five of us against a gazillion of submitters who are even
faster with AI now and we have to go sift through all that flood, and make
sense of each pile.

So we're down there, neck deep in shit and all you're trying is to bypass us
- who cares what the maintainers think.

All this is telling me is that you basically have no clue how the process
works. And it makes me trust you even less than before. And this project works
on trust. So maybe you should step back and think twice: do you really want to
work in this community and have people trust you and you trust them or do you
wanna do your own shit?

Answering that would be very hepful for me to know what to do with your
submissions in the future.

Thx, but not really...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
