Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613672;
	b=Q8DwR/on7AnqoX+ennHBhNKECWH3G/YMzQRySUkeHgGBB8S7F54O1cbAWAC+3JS5Q6/o
	 2PwORv3UkAD2lToFx11GvZnOomjo2cY1ZJ+PdTuVSYWR0ANGE/TMu1z3/FQZMB6Xik3Ol
	 hKzcSLgt0vpr50sfkJqp35DgLGMWeRIxsmj3BoubFJtlqACurtQvxBP6gSOsBhMwiCA/u
	 h+gYVKAqddEiNept3ZcYenTHPp2yqh/4nkCpahxjHYeOoKYs6kXbWun7rKpIloIxJMr5C
	 iRO/Sqi6TLrQBIlLvFNvcECcPhgXTySbdk7g6Xclq0/9cqsl4ACDFhBfVEgaY3kIFig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613672;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+QxvqoRWAdTvGHzN9pmero8HVg+ufb9PCPakJyTvPbk=;
	b=sT/uoYB93mHQle2iBxWDESuYOvajPLr7boIpBTnJHR8QnZUxel379u06I7tvqfGvks2u
	 esX+nx72HyCv9ZaZS82KtokqzMBQ/F7+vUZna9iuwBZwvsbszTNznTD0XE128Js9LszHO
	 7UzBNLLPzxHnrZoCAxqvKg+pK0fq2C5nEMQeqDLIQ3gYwrQGc/Weg5Q/Yok+GcnWKzaMY
	 aRjC79vT886+ZS+Um0EP5ZfOrlZ7zvpJc6os0lO6jtz2/cVuDZ51XTTarzDN6cdhjFsfw
	 tNz1mckiqHSF3SV7Fs9h8e7hN/GCmZVjyp4DNIr/NWbUubtXtnMJ59npClRbd+Ldllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOMSRAFo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6E606A31E;
	Wed, 25 Nov 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOMSRAFo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909E11F000D0;
	Wed, 25 Nov 2026 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613672;
	bh=+QxvqoRWAdTvGHzN9pmero8HVg+ufb9PCPakJyTvPbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOMSRAFooc/HXqX2SGYIBjoNPbn5apQ8Q/8BHms4W4i47xj8BMApTVPSl8/e/lMC2
	 9ALDXEqT/tPLd4WGqO/oLdNHIHXCByQFWBqTqoTojZN+KiwMAciLs18LnEzb+1xvFg
	 zzbEJIbqrrW8LlI3k/xAROR9sW4onAmf1+4PXKjvBGnXVMNSwve3ztjgI2wvo4VUJV
	 reNgEZDGL93l8VPs8IgIXLodQ45X7NCt5cnf3bpUXlZ+K4NoU4VQHpJ6qeiQeL02cF
	 x9sxAXGVaQ280EyG6dYQL20wJUa7SJ1jfdvp5P7pqP5O3a17pl71IKnuLykqgUOGZU
	 zYwr2NwhPFEAQ==
Date: Wed, 25 Nov 2026 14:34:25 +0100
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
Message-ID: <awbj4V167BPw0Er-@kernel.org>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
 <av4bS1QEZpniwlb3@kernel.org>
 <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>
 <awJLsDWI0OgdWhph@kernel.org>
 <20261122191512.GAawM_QHC5IxcZywvs@fat_crate.local>
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
In-Reply-To: <20261122191512.GAawM_QHC5IxcZywvs@fat_crate.local>

On Sun, Nov 22, 2026 at 11:15:12AM -0800, Borislav Petkov wrote:
> On Sun, Nov 22, 2026 at 02:56:00AM +0100, Thorsten Blum wrote:
> > I never suggested the patch had to be taken immediately. And 3+ months
> > doesn't seem particularly immediate to me for a bug either.
> 
> Did you not read my mail?
> 
> "So just from looking at the diff, that patch will definitely NOT go to stable
> but needs to stay in tip for at least a cycle so that it is tested as widely
> as possible.
> 
> Because if you break other systems with it, we will have to revert and fix up
> after you."

I never suggested an immediate stable backport either.

And I agree that the patch needs wider testing before it can be
backported to stable or merged upstream. That's precisely why I'd like
to see it in tip and linux-next.

Please let me know if there's anything I can do to help get it there.
