Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834DD443AB3
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615461; cv=pass; b=RkXKZNjwuzydzxOqIWltbhT9NgADbov9QQHjIUecY/HetXa+uG7mMPEYLfJkq+Xj/By4gOQLnteuyJ7ADNXiLbRsjHS2NQjaZGkf8qBU5UDOHjA7TRJXW3G64xA8mpfE+b4Ib7b8vRSfBK0QyhxsLchMMtH0Ur+Ec3PNfzq32K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615461; c=relaxed/simple;
	bh=izncAFina5udvh82qhiR9A/Ymo2QgJMmGzIkcJM+wME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feKwuy2TrE1o2Pjb+ywy7yMUYN450x2mEBxxFfloWdVPiroAu+6FYAd4xf4Xj5cCNoKj3QS9mA//53tfVLDJOSWxITa8ONNh44WpTkHUd/1y65MLcd0qCFdqHuGMGQRY0cDYndpEg36ee+EE1u5jubxC5WGdLfsNF3M6W1w3gtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFHTrXRV; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFHTrXRV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf49dc28ccso3654015ad.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 03:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786615457; cv=none;
        d=google.com; s=arc-20260327;
        b=omkZB5o0UFvFyioFSD7bvv60XqMi31XFUZi/BI1BUvgu31wsL5totS1A0Tj7pgytcS
         nS9Luq3C6wmLpc56rT00UYcfAoEYCGuHk7Q0v7TU7tlj5JlImRFONYYxkFg8JPpJHqJF
         dGtCMGNglwKfNclk1GnW0k52PkWuDZt76rmLkDaoPzslmjfxwVDyMUdvRnezfKQW6j1Y
         IrqwMW/elSiSuMKEOrqzgx4tN9eRWLI3a6aqDFOKA2d4F0VHAMlgtiM77uLqzK2GY73D
         bH7jYUEvDlOsCaNOWfi+uctKkDCs40uOlL1q1zTStJ9ohhZKQiNQqZhq4gQ07x0bJEta
         GvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        fh=m+b9f70VdW17qUF1EvqR/wj1GLBaB4uCwh950kl/nJk=;
        b=hVZoEwrzNIVKRjpArZdUUBy34t4hlfnQjHP6RLFUMDtbVE03LUm/uoND4HKLayl6RT
         hNdKlCzeqMVQWlJ80+kN3tJBroz20TE/rUwzxng7cpWWjtEMc3lYq4GWVTz1J4COBpy/
         LPWpU10SrjGcVGh+2LINNwzADKR/b5iJGvHDfczONnEo4Ky5mhHpPfACpyEQcjoRTCkZ
         3qHIKGNVBoPECcvHYImPNe2L5lv1PxQNJ9cD22XnlY28rFPFToGAcRDz/OxNKeCzPfs5
         +67YqvnAzL4QFYh8e7n0nn0Sj/wAag8Weqth/ni71Tnr+EQl5FKkytl8C8TUXZXwOLDb
         1O5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786615457; x=1787220257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=NFHTrXRVpZQTifaiiAeRhSGvfW/dP05MC4U1EuRQWVJr10hfFTND65+3+8jb93NkKj
         pyVgNvfrsAHjJCQSlBnv74kIuyAGwTSHOr/dBTUV0FlXohKVfuehKEUbu+Xe3QIPOuZT
         xyYOmMs01ckolTS4zDf1GolYHoz54YaFz1+Jivey5iRPUdra7EMw9Z/AYpSZUXI96EKd
         3/FfoMhZEcw+UBCPoCbiwXXB7S4RQ9x13SiLR20aVLYVohDLsUPCpyg8prA+dVsmLDAw
         h9GzD11ijNfTClaEZMVLRNH9dpACZ2webaPItG2U1BR+OiDQwMwbfXeiDxCLD+bWtAte
         hzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615457; x=1787220257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=XA5+bhokRZGmy+siskmxdI7WKbsk9Zd/tw+QR2CxRVnZF3ss90HRppxFKyGh6xkEHM
         ZmFwOnwNuWfEUVg98PGD0DJ3rxGP09d28yh2W9P+4bdEianvwm+/9etHyuz1waR+vMr+
         KNp5kS1+NJj8zP3mpunmiZ55nDtymUeNImihWd9AQ2pKcuYBdUMvd3ujoX+GaHh3ku88
         1gjFyrbm49bYPmE843vO/1+E+5WSGLPJUDzC5C4psv92JlITSFJozLpL/EsDmsKd192W
         blug5TVfFvjucX9HttX84b9Y3kEI6krIEmNFUzApAZyKuouVQij3kPV9GBe9rMzNUfds
         5DKA==
X-Forwarded-Encrypted: i=1; AHgh+RrnYOl67/pc9+TU0WadVcvbppnryjKuRrEryAqk8tjSuBt+adGc+IvWyqHjx3KfHsk/oA98H9at8SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdErtDid01HRAXMSUNrU2wH8zScUuWUtIJIXR5qZpr3iMBp5JS
	moEm8NCxa0bL+VbyMUbpmVPx4B4XHai7S1oti423OZV+m0PQQ/cIarIS5cRhdhFd7TmtV8uifzb
	f7FZjg828EGjSJBMGDIKIE5DTnR2PF8U=
X-Gm-Gg: AR+sD10SLl49Og4a/9hFuv/0PkbhpmBuKEjg9XW0ZRUp7HH1OSTwO4CPS60ly/FFrZX
	Eg+jU3avZUextK61eOQCMmtQbbiL1qCqm/zGEcEECYhKHGWJz3gUGnQzakAQtqw/tSpoicinMkv
	1AFh3l7Fo7B+Vm2HRpGfB6VAz3nupUdJRREDXMDNtuGsJLlkgJSNo6R55//wUwn+vGeRUqB8TRV
	dPgj9jk7YE8U3R5rSZeMswaLtY3alFMKTNV1mQjLHwZbhSNo5pYkFQ6mCTAvqEmKD9buLyQzqQk
	cEaPfniSUFpdzlQqYMfOJo1kDuSo+Zn0FlBTeTwO+nWwJKvMyxhKA26NHSDWK4TvpiOJZoDp9xC
	E74xhAhpXPCSCaVaMYK2W+0a07UhmA7i675/Cpwi/qVdngZ1ekhM/A8bNNXv1
X-Received: by 2002:a17:903:19e6:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d389b61bdemr35547795ad.3.1786615457444; Thu, 13 Aug 2026
 03:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
 <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
In-Reply-To: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 12:04:04 +0200
X-Gm-Features: AUfX_mxe0Lg9da-FioFXEgvJltaWUVJqtXi0b-R5y4sq5pbip1KqobICrYsDddk
Message-ID: <CANiq72=Whd+u0cA88++KyeOQQrsBK+NqK-586jNX7L=_Ocixrw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, Alvin Sun <alvin.sun@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Ok, done -- Danilo, I took your diff and converted it into a proper
> commit, please double-check you are OK with the Signed-off-by:
>
>   ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
> `#[vtable]` `impl`s")

We also need an `allow(dead_code)` until we actually use it
unconditionally: a2595ed13816 instead.

Cheers,
Miguel
