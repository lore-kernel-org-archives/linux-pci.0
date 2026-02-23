Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103B3783CE
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882056; cv=pass; b=i4+I5mO+MzZOCdkVsa8OJ/olrb4SaNRUQuj6e8lpmR+CYf0oMiIb4PJz2gu9ko0QZUTQHRr+nOq+eHDDwNVHydnqQnXAWgB9WEs+bNJGw07tiiqbhNtX55CVEMZMSxNNcgYte0f3xXBXD5/FQKiR9TnpHdh7f+fJ9yD7/Zw9abw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882056; c=relaxed/simple;
	bh=didkkmMeA554Dxj/ZdCbtum+QUKQIqmhPv1W1r9HzYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9AUfmbrzNvBXka4iNIHG0siCDqpAv7Zd38LAL03/XWhkUQgp4ukG+DbKrkzowNsH/hqWlt4DfMY5bZLf0bWO/3w+YKygtHBsZj8oyl0nczv9kOh6Qx6az2Kg5CqaBXIDJXCPhD2cxxTwJM8ypg84QDcv1p7ptVHhA0itrvJ8+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZSyS0ri; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZSyS0ri"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4376de3f128so3439174f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 13:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771882053; cv=none;
        d=google.com; s=arc-20240605;
        b=AOKcKkIVU4EB1ionmegTEZh3Q1d5VVDrOtXPEC5sHPOeEnPF8TauoOe9US9zsRx/69
         MJGzlxpHizKI3J7MoXopI/+ZTulYRNZb7jacA8wu3ocPO6J9/TzZfI4n4hG7BnrVmHsc
         De6aTFxySJz117YexEYF4XMl4kUEDsutMFW3pg92x57kFxW4P+b9S8rAgHeaTbvWgdGq
         g3WkqResrgNkges08rsr1rd8joCsbttaCultQvDpmYxXClffc/2EeGm38erz1/+itgvC
         iNx473RAdZPgZ/ugZKXOC/AjtFLSCKUyWHPpFt6L0/+PjvBpG5NSk75pRrS9ofvjcmT1
         iNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3TLtkDhp5yvjNfBzirqBO5/FyIhc8TMr7bRoRTvtMt0=;
        fh=DtCqDRxre40P22EcCV+Sb0B+FPJn9Jv2gmLhqxKEbgc=;
        b=c4Nxp5Ccj2PyDMLqtakmbT7trv/cEcv+UhGGTVupzOHFNAnDsbo8Yyh9YIez1UP6O7
         tsDlUv+PDgAKkrNZN6cHSqy97eG39b1yAaooQRPDzGDIOi/w2E4KaPUIj9tjbqwcB8Jn
         YVxmC5ZNZr6ZvTI6ZSyn9By1+3de2kW4KaFom47tBsoPGtkGWQGvkG1s8f/Qvw6bYPFd
         ZzbQVMT9dSDhjq/fqCTaMfeBGUnaLC4iHeGJro9PoiMYG8bDAE437MwNqRIvTTPXyw/n
         /Md1/Oh6+zHCgqfvLoN6w8jfkWJZUgVh3MkMlQh/cYTilzA7Ot4iYzuCaYem9y1vlxLn
         s9KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771882053; x=1772486853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TLtkDhp5yvjNfBzirqBO5/FyIhc8TMr7bRoRTvtMt0=;
        b=DZSyS0riRLv6DfivVmna1TefOP8SBQFJcVmvfN2qZaiD21+nhCtRJxgr6DIoVKg7Fd
         nfynEr3YXUqQKAzAmZBB7vfSjrS6vkqRR4tzjHZaf26TgjYhimkEYamQ6do/vqUBUnBl
         I0gTPdDAqvP1Og7QhMhS/L7t8jQGg0yMBzy7hNC7ifXW06I7Ot8vYrB4b9WAb1aYArw4
         eGc0WG6uyjWoCS7c1TDXvR32ccsHAn0Ymzfq6WsYn7ZRBjEsPCoVhhewPh8BLn6+AA5Q
         mrhpgErqGXJ3avnvCpYerMFSIDJrOxiQeva9KtcV57GN455J+11Ws8DccSEMGS9ZGbq0
         3QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882053; x=1772486853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3TLtkDhp5yvjNfBzirqBO5/FyIhc8TMr7bRoRTvtMt0=;
        b=nsglpDGLN8/hzRsZThFFfJDKSctdKkipGvOqSgNpPjs0A5a+jEXr87zuBBSiabhDup
         Lhsz8qElUIIUg8u37oCoHBJbdaadmRXUERUYFBDMJKGQjvMYQRL6VDySHif6nKO7sRex
         jnJ2dWTI9b4NbPrztMjFOV9aXKCpeL8MSMcTuM2TGo8C2iIlRRJ3MrlQXnz6j2y1mNCY
         24pJkBlcJAEjcH+0qMSdSXdf/q7cRC037aljLANK2YenldwsoBuxVbdRtPNBmXE6uOjv
         z6PVHtLfh6wLFjD8xFS+bVYz8l8ajrZmR0WLq8d2CjSQXFHyQLJ8cYDWdiHWiUo5OhVF
         RLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXucgl5+uxjA1xzRlWR2JXQVbpBoWtCdYS+AEKFsCKI+68XZ8aDsap3OPCGCkhq6NlDowG4ZBRgkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6db0tYCR2KXvdg/rwEyyamzHIIItb3vQRz+RPPNWKR1/E9cK
	36pWovoyx6pkRWEPINj5qftYfawqig10QXkEOuFGTmaBCmNUQpbsacvNVpQH6ggVy5mP+Jqln0s
	7sReNazKBpI4oOcbaCw3pp4fb4W6SRJyAxAwoX2A2
X-Gm-Gg: ATEYQzxG4vHnANcImaARcR9YiSbK+TclMtmwCrUhdmvWcN70hUZrvORIx4kWkYlOdyl
	jGS/WiJoH4+q3Bs1TMKXEW9CWUzoyyRq0XzQAh0uu4AupHvQQ4EnhLoHKpuCnzFT9Joy6lID7w7
	ji6eXGOreSV4RLLqQsGTJbycnYW8B6xhB9silUXDOzQSYfgLTQdHLFf1S6oLESgmjNuwalLLHad
	I4ARjbVu4WgI6J1gR/bJaJCmIDivTqCmLXoaFwvXbhv2heJxnxKx1iY7KCaSzD6YTw80WgGaEtJ
	UqrEX6/D19f0iTOS2EIPV+k9XAvOpWlkDLpUog==
X-Received: by 2002:a05:6000:26c2:b0:435:a8e7:62de with SMTP id
 ffacd0b85a97d-4396f18f942mr16385137f8f.58.1771882053091; Mon, 23 Feb 2026
 13:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216131534.65008-1-dakr@kernel.org> <aZMaFhvZWiknu8UK@google.com>
 <DGGF97AAA3HF.3DSNMFJTCNI9Z@kernel.org>
In-Reply-To: <DGGF97AAA3HF.3DSNMFJTCNI9Z@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Feb 2026 22:27:21 +0100
X-Gm-Features: AaiRm51eKGoP_MuYqn_kp-y0-YSen_uHZo47Hlce9OFpI8_rE8a7FBFjXKSXZpk
Message-ID: <CAH5fLgh6MvjN3AHCVUROeYFWr+0CPxoYcgFfa99wu1EaNJAn-g@mail.gmail.com>
Subject: Re: [PATCH] rust: io: macro_export io_define_read!() and io_define_write!()
To: Danilo Krummrich <dakr@kernel.org>
Cc: daniel.almeida@collabora.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	ojeda@kernel.org, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, zhiw@nvidia.com, acourbot@nvidia.com, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 2:31=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Feb 16, 2026 at 2:22 PM CET, Alice Ryhl wrote:
> > You should keep these re-exports (as full `pub`) so that they can be
> > accessed from kernel::io. Exposing all macros from crate root via
> > #[macro_export] is legacy approach.
>
> Good catch!
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 58f464cf5efd..e5fba6bf6db0 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -249,6 +249,7 @@ macro_rules! io_define_read {
>          }
>      };
>  }
> +pub use io_define_read;
>
>  /// Generates an accessor method for writing to an I/O backend.
>  ///
> @@ -305,6 +306,7 @@ macro_rules! io_define_write {
>          }
>      };
>  }
> +pub use io_define_write;
>
>  /// Checks whether an access of type `U` at the given `offset`
>  /// is valid within this region.
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 2c8d7d00e54d..fb6edab2aea7 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -8,14 +8,14 @@
>      device,
>      devres::Devres,
>      io::{
> +        io_define_read,
> +        io_define_write,
>          Io,
>          IoCapable,
>          IoKnownSize,
>          Mmio,
>          MmioRaw, //
>      },
> -    io_define_read,
> -    io_define_write,
>      prelude::*,
>      sync::aref::ARef, //
>  };
>
>
> (I'd still keep the `io_` prefix though.)

With the above change: RB
