Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1735CB91
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636166; cv=pass; b=FdF8PLUBjjYmA99DNZmSCtDcfHJ7vfwtRoUGVE9vlgwOu/xCX9QY3UyQtKgnN1BuJszdy2lRKdqItVUN8VbH7YRZiu6fTYIXlS9tSCvG4Oyo4Oyewtyl+JbS3cG6grLvVSjpNw8UohtpQxKkn2OZ6GXC4Lg2l3x5YJdRObWFdN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636166; c=relaxed/simple;
	bh=yF37/Nza90qpovsTyPIotV3GHJX8YLw3YQa4ToPG68s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUAUQ7VBf45wNBrIVnvT7hSxkBDYGjChVGGFDTX6G1mH7e+c1cblV8fa7wyAF7ZCM77ls0INb3CN2KRgkRMOiHHqfVrwkZ22j+qMexbjaPsjDs+Cni9w1KAYBcO0CzKHmfmNFNnLuiWNPPFok2ZFNp75zzndjGNpJnQIeQirOoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMvQbhU1; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMvQbhU1"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39931869b4aso108804a91.1
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 12:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788636163; cv=none;
        d=google.com; s=arc-20260327;
        b=VEDFZStP0vdW1x6ggTcHB2hn3WC2NIP64x4Jju/VuqTM1yo7yu6N8CFtIgvjMmxQ44
         +s3Lx+99aiLgBbBSVbRepl+KnR1vECgCzO5RhU4OFwVyQlN0AWNXLUYipcheFjX+f3HJ
         sCfiXH/P/EXpg9hs8Eu9vDpdsD//389RRN9tdxfuI5J9tX6/Bf3i2RafB2mCoeU1HzGu
         EvxxWZx+4yA9mJcNCLonIuINqlegiLCVXgVEYBQr8gUNru2q0LTneuOVcuHz00LOciFD
         SdBoe4UvBaIi6VsA/6W6xf+dImdGc4ItaVbgODKCQjL2eCMgKuF9fAnww3uW0pcOFmZi
         upGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F0hp8ol4MVmew9w5JiuEvACCnB101tW8NVpWQVhjcY4=;
        fh=f16SqpebPxqvGRuqO0DjQ/uc2sglcJal4CkwWXTqQzc=;
        b=EqGfPmkuB3NA/IhNNE4ce5ijLsk0ovhYSD6h4Wh3Oy8MlgwrSicnKkikyeyEW20KQA
         fNJ0Lqd5MqFrSvLrVfQiUYxAnP7mgX1uPztajMrWSUuTOS7itb2ovopDkse+nDuFql3g
         018y6axM2so4oS1FvAMwannMy5mlG8SDuWp8n75gVn+wNt1MjWEUeq8Fdv1ViIBdD58t
         to+MxwkEE49JafmA4kbfWhjAitB7PrgSscXWW/clsFZiUFQoJ8czvGNG2Mqyv7zGGTrj
         hRIDhpcOeluPgehyI0gI4EW4yXRL74WMO4bO1P8ySElHzly8KVYWbdj52RK0CoZJdNPX
         iM3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636163; x=1789240963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F0hp8ol4MVmew9w5JiuEvACCnB101tW8NVpWQVhjcY4=;
        b=HMvQbhU1ti0n9lhueEGhNyQx907yj3lOqhfVzjDLGcQSZrylyPwIksCdVGBnS5fjxQ
         Ky+QL1eYy/+KvbGivmYxs92NSxDf3EEStVYzb7zE4zp+54VGWoqw19mW1jBOXN1sexJM
         GPrUyn1uxTXEXgjiwJtQrJakwF8o8XDRf3UoeMqS4UDqyuLWERRvFvN4r3BJrzXXJ3BH
         W5aFM4TZmP3BJc3S6P4faRBpMptLTHIeX7wjRgWS7QWy1btJkXqW6bwhvmsz2dobFn80
         OzV6OPAcu8CUB8IKymu3MBqbLuegon5ZKiE0IArK+2TeE4PjNxVaHEBpCB7YdKQMby4d
         bB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636163; x=1789240963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0hp8ol4MVmew9w5JiuEvACCnB101tW8NVpWQVhjcY4=;
        b=BV/cbj/NBMHw5CblrLOQPcW3lU3qnLtH2/tRiemCiubpVsjN3fZ/KGZzjPdFReDS+u
         NTt2yAk1nkszpOLxxudWHfgNZVcQn7MtjMHMQvEODBjk1E/82HSn87czYzKjh9JgJ43l
         KOtkhMxQhxn9iLZlE09YDzRH2mThC+XNjJB28QCVIBdZpv7kWUrq/qn9pjuCzeUGjbaZ
         Uq1TvP7iEWzusKFv/ehX3oxqhneakH19lAaQSlEEPgYVzpxy8MIXkwWrkUCGMUXfqpS4
         yCDNko6DF6EcF0kxaKN2p70rw3SUUP93BRWuuVIj5j9YM4hvzlTkxytQYUpVq44LedD7
         a/lw==
X-Forwarded-Encrypted: i=1; AKwUvBwgI3rYvrD7dMDCw8hze7IV9yYGUpsYjIct/OH50ZLrku9oRvNMc4Pkxhwym2/pBYfH5DtgRZISd2U=@vger.kernel.org
X-Gm-Message-State: AFuF++n+W+xvWzGXi5d7I+4CqAJEFg+X/BAVIruEWq867n7XxD0goV/l
	VX/ve/2Le6i4I+yj+AIvCvTEo6ZoAcLwxCU8LVlOac4qpR6cbp3XWhccw4oUocsE4L9EiwAo7UK
	TAIEjcMicq+Pu/T8pLmECofv76hoQFAs=
X-Gm-Gg: AYBFou1EgBjeb9rX/Z5eQ30F4JTyaZa1RbsISXt4Ihfhrat67iwoYEc+cI9EhE3j0IR
	4weC4DBSVQJNZWzypIym3U0VunY6TRNCo1Di6cF7ldnWWbskMsUDV7h+3Cbv/ee0gMpJST4WPg9
	FAiqAxrv9kS4Uy6NwEoXePOI0m/5XGJePI8NfXgRyU9JaSoCZvWfjuFVsilx2sVGOvbVERbBwnZ
	wzLzZiykYlp7d8CTup2CsnRfxf5zI3rIT5kblDDFTde3ngXLOSPXIiWylZOzPls0C6HgSCC2dHz
	D4AwZ8HeFcd+/LPBIIAPbLG6gJ0mVjeEkP8MmtdOmDusoxkBcy8/Z4KEKhSyf1/vZRzwvkPMwLB
	r0jewAQ2fSEA5mocDxkl1VmXXvIcIdx1nM970ufmeiHkHhaEKMWF1QG+RaiwZ
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr7470429a91.6.1788636163260; Sat, 05 Sep 2026
 12:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net> <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 21:22:30 +0200
X-Gm-Features: AcwNN1XYNGZeZdAbyqW_MpHHmRnUCoTfhvfgQ1L93n760L7NneO9Fvtxk2YGC7Q
Message-ID: <CANiq72nxtehkGdb9RZpd=MsjWzp9euoLw=MmCzvcqOgxxEwymg@mail.gmail.com>
Subject: Re: [PATCH v4 03/16] rust: mem: add `AsRepr` and `AsReprMut`
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 6:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +    /// Convert from `Self` to [`Self::Repr`].

I think [`Self`] etc. work too.

> +/// - [`Self`] must be [transmutable] from [`Self::Repr`].

We say "can" in the `AsRepr` one -- we should be consistent.

> +// SAFETY: `bool` has the same size and alignment as `u8`, and Rust guar=
antees that `bool` has
> +// only two valid bit patterns: 0 (false) and 1 (true). Thus `bool` can =
be transmuted to `u8`.

`false`, `true`

> +        // SAFETY: $unsigned has the same size and alignment with itself=
, and is transmutable to

`$unsigned` (a few below).

Cheers,
Miguel
