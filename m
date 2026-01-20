Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94E426683
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912701; cv=none; b=lCSuQdfrO8cY0N5QRCp4mumbqIkxBSGQ+q3JNFMdOmowa6FsM7if2nj/5X+yag3L8oW/iq5ennMhQNLnPT2fXjPM1o4UC6T2J15pp83NZofJn22+V3WdZ7BiAaONwbv6SYABJimX6jLZPjEATG/tbfH8M4D+rLN4gxd3w7ssY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912701; c=relaxed/simple;
	bh=TXFVFSzZ/jVdUgcfun/l6Z+4x2xn58VmCP/XffLA3eo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBIGK31vBfJJ0hTiH8W5HXYArZMTTtboV0zy7p4CaHfhq1rlCeQaqk077LOLIsY/5adSnw2VNqlhtNFPLDio8opRJaE04V7xcHIPl9TIE8H+GL7mcWyMKxHudXWrxp4wr1tpPloDKjB6YNaMCDjR9uQvT/0010tSUoc6r2YoShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGoD4RTU; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGoD4RTU"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b83c3dd2092so822607866b.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 04:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768912698; x=1769517498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRu3uxT5l6ryH7K1x56GRVdKqVKTOQ0aBzImZoC0pQU=;
        b=aGoD4RTU+L6HsoAjns/mR9MWP+FQL8S/Whr5WksEviwbQBAa5TkcGZZHS4NcGbkqr6
         lQ3LAomAcLGsFfxVgjmMb/Sz+JmY1XFQIPNm2Wq9AvUTCveqyfUCBwz41l0bAOv92ekk
         9ZRBFjC0d6Sva8hLWWgmA2FW37PMQPdebfaHSrTJ8uwqM1FMVRrGbM/2vzw+Waxxcj9s
         sKGm0P6sSDz35WXRAhNnZtCsXdEsJuh7nnzY64UUyGludCt0ncq78kQV+2VmEzuMdVA0
         fGLcClZqZhbo+v8YfyF/dMp08qO8dkHIxjv2yVdkTFGkCXefZyL00p627piK5mAajwFk
         2oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912698; x=1769517498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRu3uxT5l6ryH7K1x56GRVdKqVKTOQ0aBzImZoC0pQU=;
        b=bpE5hgtIpBxDlg3wwkU1YPOlTWfz5jbca+pTMO3+8GLJGQcrT5kCzSzReJLxyh3UXb
         D/E9Pwf3PCec+l3THcAKURy+V/cSJhiZE/ZWBOlv29904XIMLmUPAKn8qX+uJiRllOuC
         d/7DlrxlmM8WinMOtRz1Vf4iuj8IyLmpBSTA9Ho7Dp17p624zTL7HwWy8NCmtmIXvaDD
         N4nHF9eFDb+u0J/+jxvvjOoUD4tnpLTeyS4aFdmnfdH6+v5R5w3MSDA3dGlk9xTfuPRK
         3/BMlDJQ27hygVM6QaNIFNUIbSa/zzexvEs0HKPjYKbLrYvz2WmW0skO1nS57MkeuEwq
         YwqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7m4+B5nquftwQPazMmet2FNjlRy2skJ8G4qDguGCi5FIgPg860mvu9FtFgzh7R/2So8Ltkr6sbyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LZrBpD6cI8P23bjb3L569VFsjPBIVw7pLJRfqGVe6yAP5PLC
	ql7JaU/kEdBf+39mFPzS2+Q9Oaud/surJw6DVI5a4Re3ZTETIS2pW/tFFVBqMqKlbAvHqrgEv0f
	HWOQAWOwC8Kqdc10FOA==
X-Received: from wmbgx18.prod.google.com ([2002:a05:600c:8592:b0:477:5a4b:d57f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4801e30a790mr205228475e9.8.1768912686463;
 Tue, 20 Jan 2026 04:38:06 -0800 (PST)
Date: Tue, 20 Jan 2026 12:38:05 +0000
In-Reply-To: <aW9mTHedRc32izbh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119202250.870588-1-zhiw@nvidia.com> <20260119202250.870588-3-zhiw@nvidia.com>
 <aW83HV4lVR5MQlDd@google.com> <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org> <aW9mTHedRc32izbh@google.com>
Message-ID: <aW93LS71i01F8FLA@google.com>
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

On Tue, Jan 20, 2026 at 11:26:04AM +0000, Alice Ryhl wrote:
> On Tue, Jan 20, 2026 at 11:12:18AM +0100, Danilo Krummrich wrote:
> > On Tue Jan 20, 2026 at 9:04 AM CET, Alice Ryhl wrote:
> > > On Mon, Jan 19, 2026 at 10:22:44PM +0200, Zhi Wang wrote:
> > > Overall looks good to me. Some comments below:
> > >
> > > I still think it would make sense to have `IoCapable<T>: IoTryCapable<T>`,
> > > but it's not a big deal.
> > 
> > I think with this approach it's not necessary to have this requirement. In
> > practice, most impls will have both, but I think it's a good thing that we don't
> > have to have an impl even if not used by any driver, i.e. it helps avoiding dead
> > code.
> > 
> > >> +    /// Infallible 64-bit read with compile-time bounds check.
> > >> +    #[cfg(CONFIG_64BIT)]
> > >> +    fn read64(&self, offset: usize) -> u64
> > >> +    #[cfg(CONFIG_64BIT)]
> > >> +    fn try_read64(&self, offset: usize) -> Result<u64>
> > >
> > > These don't really need cfg(CONFIG_64BIT). You can place that cfg on
> > > impl blocks of IoCapable<u64>.
> > 
> > If you agree with the above, I can fix this up when applying the series.
> 
> Ok with me.

with cfg(CONFIG_64BIT) adjusted:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
