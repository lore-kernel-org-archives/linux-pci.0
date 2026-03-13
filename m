Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0825393B
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381248; cv=pass; b=LHzxYcSm9kO4wZqw7VUed6L/lNckSQYlRm5eTYZDxa0sF59fJGTgxU2eYnXk7R1/C6sdiA4xpj6f/q6suKBR8NmutdMOTC+4IQC31YeOLGWP5TAlr6B3ew/HGL/2bK6XA/yhuM3qoujschvOwYQSGVQEReSpYGF3RrIrmFWAQLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381248; c=relaxed/simple;
	bh=1O5JC40mgWM5zVrjpeth08KNuSHWy6NaWB4eNtTtZrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCW21z9gyqEuOl+D0f78RGL2donSQZt6oClN57pqjb8IRu2FVGgsqv70JkWmAwivmP3TSrz5nei3vXxE/7EtuPkrWbLSds/7heeCu8T1AqrdWZvSNwFTo135m9xfK0rqaF8DvyB/grB+Qu2vmlrs7NywtmUSJNDG5GJtNZQtWeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c13GKxI9; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c13GKxI9"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be9ffbcf9aso72030eec.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 22:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773381246; cv=none;
        d=google.com; s=arc-20240605;
        b=ZW+AZTC9P+3kSy+3OwQ0fAWGUnlr/VyHf9SgUQLFTBqApaSbUnrEGhNmK4H/DUE1hY
         qw2U3saBazzzJY59ZjPMszzWoFlCeycpY8hR/W4PruYrQxVhyEP+xv9uyJxZZk9bXWSL
         T6hfW9HKxTkpCaI2dGaOf+pqljj5RICUsIPG9KEE+fdKFRsGeRbj9XVwoLMByN104YVM
         RMcbTEUuOntGE1VKMgDAZlvRjyQtL4uMGhehar/R5t67wBdnevctY9jgFWyZ0m8W0HBi
         EQe1e8qF7alOXkJFBAiRMovMcQYVKec5CN6AxgYWmQwm9NJvCP3YNA7Zb670+e0pC4+X
         bvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UE0N7OKJt0SzGyOmS75dVlvrQ3qOhY0fM26VXEgbq2M=;
        fh=RiPf0rY/p+iddCBgnoG/QTgR5eKQcLeAbTYmhnsq7m0=;
        b=OFdrMVTqpWOtI+sb0oYjCVdQSLNoO+vuWJ+WuiyWTFGRPNRtQLsZW3voF9zqTJ3xlA
         6yx+Ydyx3hSgKh4THLe/aIi1CpRdFQayZZoQE1CCKnUArADu70kxNZITeE48kJyDx3SM
         nUuZsXDBms6YZ+cq6bvLlZqL+cTDzjGGu24ZJJxtsN59+UauV73mPRQoKO6Vbo44+Wvn
         6MwU9Om/sKE1ydbWlAAPdRdVoSsYP2p8O1hIANmPGvvefht2fvB6dXkXZPv6y/syv2l8
         n2rHZ04OiaVs7liwaRS4s88RVjuBc4H5Csou/bb9RN8zdPGP/0xkPaBRvMp1GJbbstI/
         RMmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773381246; x=1773986046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE0N7OKJt0SzGyOmS75dVlvrQ3qOhY0fM26VXEgbq2M=;
        b=c13GKxI9GPhGx5f2mVq/NSsD4UsMECuJHYhsYMWJyvf9tXK+6P5WTH+LX7vgSUfrhU
         z9siGXsWcnssQ87b8x3fXJIyaXeUnGQCIo/w97wpxgmv/b4Y/8LrWvuW+nBB5hsqRDmt
         ysbUSe6tnaG0C8y39BmAhfyqESVKA+ljT4hM8ntmAXozeThCVIP0+M0pZHzYi2XBpEcK
         Cf8rUWfTofpfVC6JJj7x44TqYhJ7GgZ6f7yw/tAZz27j0gHOy5NjJPp2aG68/cinajb6
         ccQezf4OYcYXEKPKQtKjBon2IWiNcJan4dXXBGZlqTW9v6u+1An2SoR7GWzS8bRvAzSQ
         o/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381246; x=1773986046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UE0N7OKJt0SzGyOmS75dVlvrQ3qOhY0fM26VXEgbq2M=;
        b=WEc/SpGxbTXYnCModEw+X5+UgaEsC9/5J1VOIz3uhjJBm0e8mXTvhqMLO5jVPcjlvy
         GogoRqcon8gymhHEPAshzFGaKBeqkGK7uWug6+9I9Jxs2avR73lJcnzTFQT1KMUXCsXI
         xFn2jDhuE6kycvblFGYhg5pmvna0RtRjrxa1VXmLuLb9tYK+t3L3dkQz8D3NDECDGRyo
         GP6dDXh6l+uW+X+KoECK71RXqKNfWhhjFcgg+f/pzprg5USxuPxaMnmq/OIzzjJCh0N3
         HOwUgS46Bu7I/VkuwmzFFD3VKYUvNZteOgw2ruHPkC4JQP5Hp6DRY8I6zjhmSgASUKmQ
         0Vtw==
X-Forwarded-Encrypted: i=1; AJvYcCUp4z+984CG0gUx/z8mKR3kIt5P/sP1b5X8g5rkK1U7Oo5K1ugLdMJgdxojMjZZwhkeSt5wiO1WNeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiygcWw5Wv35mqripFm+R87bFJanw2fX91g1U5mkRLIE9aQ6je
	nM27ApCaj94wjG4NgrbXnQgF0ztuEmoxLMFEEjVS8vphqjVgYe0IfzkHCu+V0aco5KMxXFl6oMJ
	75tsDDpgx1ZN+1QtkPFNLzZHeONyMtT4=
X-Gm-Gg: ATEYQzxz49BLjo3NiNlkS2NI8B8h//NokEYe1iYw1doQixGS1WKdbF5xhBP+yUnxmhs
	ZTDAX/7L/D5woVuz7rMUSAnMg1zWuFim1fYyQk5/947p5A4PeUFRdTr8xhvHjb3+XlhQ5mhdOAo
	mTpWIAsOyiogiP8aWZ1vR51fdm4CdR+nj0RmOjKIFY9+ESpMhY+8shD7I2/jRjCWQpivTbthiR5
	//EasxJvlg0r35VSsflwJWHVj54cpaF0avBAx3UMshxiktkhILSMVG+mJkRxSLlnIbj1RuNPP8U
	thwVie10RbEpOLfXXuVgUFCt6SHQam1EJSgEdUEKsUsdSePKLGcodiyuxPVUDG52n/gJng/RJhH
	lMFdHwAbuisYV0SdAd/nQgJbqSP5zmPA1Kg==
X-Received: by 2002:a05:693c:3008:b0:2be:a251:b3f2 with SMTP id
 5a478bee46e88-2bea553709bmr543412eec.4.1773381246439; Thu, 12 Mar 2026
 22:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-13-alistair.francis@wdc.com> <20260303113642.00005774@huawei.com>
 <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com>
In-Reply-To: <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Mar 2026 06:53:54 +0100
X-Gm-Features: AaiRm52U2RRbXymw9sLKGMHCSPSFMUzzPE02drckpBuanNBmfgA91wq9hM2e7sA
Message-ID: <CANiq72npg6Cp8EfvP4H_PKhSaenq=hhOvV2VyMesc+rR3hB0DQ@mail.gmail.com>
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
To: Alistair Francis <alistair23@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 6:36=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> This is a public function that matches the C implementation, hence the
> arguments being fixed in the previous patch.

Since you have it in a C header and in `bindings_helper.h`, then you
should be able to use `#[export]`, which will do a typecheck that the
signatures match (it also does the `no_mangle`, so you can replace
it):

  https://rust.docs.kernel.org/macros/attr.export.html

> This is just how the linter formats it when I run ` LLVM=3D1 make
> rustfmt`. I don't really want to be manually formatting things

Please use the "kernel vertical style" for imports (it is done
automatically by `rustfmt` too by adding the `//`):

  https://docs.kernel.org/rust/coding-guidelines.html#imports

We have `size_of`, `align_of` and so on in the prelude, so you can use
those directly:

  https://rust.docs.kernel.org/kernel/prelude/index.html

I hope that helps!

Cheers,
Miguel
