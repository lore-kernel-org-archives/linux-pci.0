Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218233ED10D
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908369; cv=none; b=A7XJlG9lh015TqQgUYPMxpUzSm2iXQrnj7HMWhix6wUuQ4vQoEq1xn2b2BUjjYq20mDmSXC3Sq6RnL1lJsRtuBzp+F6Hc3EOYfKvFGxAb7DRRCuTMblJ4qx50IrpdvBRIMJbAwfiUXoUJmiagVZeUVgBfmOa365U18h0yZX39nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908369; c=relaxed/simple;
	bh=aFwAsFCueI3F8HL61Jos3nEXhnNrwT2HXWoXx/DQ/Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dOK4dufSEilETULteY3obVJD/zGKNtMBeQEjMn+yYVONvVsWR4I0uxoHamZcRF9nqufGe66NvoYK52JZod7X3VQb9SuqVoysGbkqvZfrSSqX3HcdrrBYwsy8FbxORvhSvSgS/cpVKkXzWEPpGx2GDdmaO8+g+Pd/5/XLgGLVJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17MEL82D; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17MEL82D"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47edfdc6c1aso43075785e9.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 03:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768908365; x=1769513165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldsCAiEe6YHG+kFSXFuiVLJqCic1Hklucfx2DJT9jNA=;
        b=17MEL82Dk5v/pZzeQe7BB7anax2M1Ffrnn3wwWs8mIrPgZG7LMLQeUIxdRbkfe1yIY
         FmdqeToC1kK+/bI+fDoa1G0Dqg/qQM2nzM81Sr7fO9jQc2morOWV18ePw/fND8h5QIls
         Be+pDVxyGITP3xUGXQ2c8HSQDVmYnP9V4vXWyWR42QKZC5O2LcJHE9Zzfq7LyhwKcw/u
         ppc0HHMy5MBbOUIALLmZ8AZnqTXxRkizSFdIIWU7gzmcYXV0uiyDId9b2+1If4smEupK
         Tls7erAwLJ54hQn9xhPw+2oPYpRo+uFiTai2DqXzkRZQHmVRf2k81jogq4WYxdaMblD8
         bRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768908365; x=1769513165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldsCAiEe6YHG+kFSXFuiVLJqCic1Hklucfx2DJT9jNA=;
        b=nkpMpf373BmFSJjFhHP+OGZDn5mawaG3zCNQXgbCzdVgo1rSWd/93SNZwNRnSgpuXe
         85AupVQWKp3YIT7EjXwA5IhpazqxoxTeNKo/EcIRscX3o/gGcc4S6y+/0047dmjsmf5K
         4NBAOHvBrh+kNKHPXkKlYtGFfk2Dq/GZYDmre50j11RMmLtly2hDCxtvgNW+lr9GpunG
         mg+btOVKP/Kob/hmW6pogMEqIosSs1jDxaGq2YVqvYlOrFb2viM/ZzPVaGVw4vSubUxw
         bBUSlKrTrcxxMNcD/JZmoERLoH0MVuLD2oaGgq1r9wmQ0OPziZSulXjRxEROOcYSvGY1
         DK6w==
X-Forwarded-Encrypted: i=1; AJvYcCXkYG45AVovKgQ2/68XNnZAihJi1DsiWU7D825HZh+k+Ck3YfD1ubi8MxS6lFNE7ASxHQ+uPZZ5GE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2PzuQJbmnrgdGFubPkEtkUpHkVthPYaa6hYkpt1q/rTIGYUH
	NJtmPkB26ZRxwUynXY9ygeXxeio3vaMs2KELxw7Frn1CsYWj/MLlH2BEMkvBp6+k48/rRdCEizS
	9SMWU/C49iWW1YoeipA==
X-Received: from wmco8.prod.google.com ([2002:a05:600c:a308:b0:47e:e4f5:36ca])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id 5b1f17b1804b1-4801eb0375amr171782955e9.19.1768908365167;
 Tue, 20 Jan 2026 03:26:05 -0800 (PST)
Date: Tue, 20 Jan 2026 11:26:04 +0000
In-Reply-To: <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119202250.870588-1-zhiw@nvidia.com> <20260119202250.870588-3-zhiw@nvidia.com>
 <aW83HV4lVR5MQlDd@google.com> <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
Message-ID: <aW9mTHedRc32izbh@google.com>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from MMIO implementation
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com, 
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="utf-8"

On Tue, Jan 20, 2026 at 11:12:18AM +0100, Danilo Krummrich wrote:
> On Tue Jan 20, 2026 at 9:04 AM CET, Alice Ryhl wrote:
> > On Mon, Jan 19, 2026 at 10:22:44PM +0200, Zhi Wang wrote:
> > Overall looks good to me. Some comments below:
> >
> > I still think it would make sense to have `IoCapable<T>: IoTryCapable<T>`,
> > but it's not a big deal.
> 
> I think with this approach it's not necessary to have this requirement. In
> practice, most impls will have both, but I think it's a good thing that we don't
> have to have an impl even if not used by any driver, i.e. it helps avoiding dead
> code.
> 
> >> +    /// Infallible 64-bit read with compile-time bounds check.
> >> +    #[cfg(CONFIG_64BIT)]
> >> +    fn read64(&self, offset: usize) -> u64
> >> +    #[cfg(CONFIG_64BIT)]
> >> +    fn try_read64(&self, offset: usize) -> Result<u64>
> >
> > These don't really need cfg(CONFIG_64BIT). You can place that cfg on
> > impl blocks of IoCapable<u64>.
> 
> If you agree with the above, I can fix this up when applying the series.

Ok with me.

Alice
