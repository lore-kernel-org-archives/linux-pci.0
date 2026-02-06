Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486291E991B
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407327; cv=none; b=tG9DuYO4+wtujUy2EiW4h3e37ZTN/tbA3csqsM4IluaV8L58QbvseU10AU9bgdI/dz52+wAgkg4ztN5u1DvmzELaJcE+QTTM0O3Nijyst8rF1DvmYjLPrUUb6nMuAf0EAwl1LHCxSqVwC5dZi5qiNZnDQniLdMeaWqzgQmI7ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407327; c=relaxed/simple;
	bh=gukHtlEF7NUa89Ae3ajjgjMGn+ERsvS2EyVcyWJkC2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paVvVoWZPPy59QkLYTCX/epqD5nV8fw/9l6UPLciK61TETubSphmilJMz5jh/syMqQVPoE7l8tNxRUjpL0F9Ue9Ea+mPnCbGr2LWlib+IbU4czcd8GaYyz+/MaNJSK3XWE8AXnUYXgafy0Q5ua3BPAwzFYA/naX67VisMbI93dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ki3s4ugk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p6ruhAPG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki3s4ugk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p6ruhAPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770407326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gukHtlEF7NUa89Ae3ajjgjMGn+ERsvS2EyVcyWJkC2U=;
	b=Ki3s4ugkq7wviW8ivC189Y3kRM2xQA0Z+s8ITe9MQWF930QJCye0SaS7aAtcYIEGqNfFPO
	xoOB0TC8oVMnbmuA40DyA9hOIDS/qgtOnC0d/MWPiQW8ple6gKMKGeNzvj1s1ztphwyl6T
	+qQc6WgEHD3LL8eMa+4/98NxtywoV60=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-_i2pWGCOOLCldOMe6yBHNg-1; Fri, 06 Feb 2026 14:48:45 -0500
X-MC-Unique: _i2pWGCOOLCldOMe6yBHNg-1
X-Mimecast-MFC-AGG-ID: _i2pWGCOOLCldOMe6yBHNg_1770407324
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50341b4f5e0so49621181cf.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770407324; x=1771012124; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gukHtlEF7NUa89Ae3ajjgjMGn+ERsvS2EyVcyWJkC2U=;
        b=p6ruhAPGmLgz9kppSiJn+5yETTVeMkdzKSFe+nA0cUCNQqg+oECsQQ/ItVBq+kRDwm
         qUaDmWRpz3HS3V60lZ5mROqGn9KsJcEzJNVaOxe7QnRTdWndXxBQWqm+iu7qBGHAYnNu
         SZMc1ldiJxlW4z0ThIkWM+e4ieQjN6RBg99wUZ8GkqMMYoIVYVVcJEOxXRUP2BsEdV1F
         zqK+Vp9xIq4Avi5x/eS83bBNPslReqYFzfgCn2NTyGROL4rnVuT94zHVbp1ROCFzH3u/
         ZHC4wcMadKIeuITTDaDr5Bas70xDoI+VJAFtvOYXo5Kh8enOv0pUxkjmm8HS8s7wmzEU
         GBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770407324; x=1771012124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gukHtlEF7NUa89Ae3ajjgjMGn+ERsvS2EyVcyWJkC2U=;
        b=WbuoseVqE57Dh1c+9rK3++IEqmc3Z823lDBGU+6WH5324+zQOk5LA+auOnce9UKCaX
         YmHDq/2gKfNoV/juLNqiaQSoTYXWjXsAZo5rNC1hGWoTCyVdfTtYwr561ehn2l+OLRq1
         LboGSJg1xZkEg/vOj96pA9np9qfZHae+OT4aiwqDaPaazZmPez09BrMQpw+5ajm1KEda
         Ku5i9WW7N7WJKQwpWLZTUGmhhrGlAm7wYo5HlB9g4o469yw036M6fTeTjCQjVqF5lPeF
         QZeb58j27dvxVnyWPWI/TP4G4TYhL8CPgi/wOFAoPbapDjU2EmJIEuOp/h/VDa4wgbkW
         lCoA==
X-Forwarded-Encrypted: i=1; AJvYcCW0ro8D/YeCCDHOtlciCBZCJL9y8O3nc+xNohl1h6aMdHry85ceQdnbTBsLemfd70m43Ruyi6XSptU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+iPd/exf1cTxBu7CUxdYkQFUHvjcsOygZgdQvdEJM1PJaHgl
	3nQywesbgd2eQ8Q4aRYZWvO/LLfFoqaN2SgztC+DxGasSb3LARnxUDlblMLESfm7JbdzxGtPjkf
	YT5uDNFsscv7s1tTZ46l1jAMaB4P03KR6LxmAGwiFLRdGLY8PMfjCF5RsPN+2fg==
X-Gm-Gg: AZuq6aL3noNwiT6GxhtDTjyW8Ge8zAwIwROLBwnAejHZR6WTfFaprdb8NdeUwWKgCi3
	WoNxMX1/lIFsYxNvASYakkKmtGPrXF1dyT70sNEk2gazqLgMBxqeJiQFg6Vfa10xmlaEwIznBcI
	VAEYFLP+P3+O7ut0HQbfNeRWuTTpCRzJsQXQ3ntdibtuV/GzpwG+CS8svBp53wJr47gvLBN8TCB
	ucM3fZ0YQD/cdggZJLRn7qsEiHVeedpK/DQsNKq0+e/f9GBxg/ChhbRVGb24QmDybhsmBEre0Ax
	zDJ0fKIt3hhhzY/NfeCMuoL/htqvQ0pVs0GxRTDtO1TobmXEs/No+t78tZie8C9QtkgG7WfCIyc
	4NDddYQ/i6X+MxZueOQ==
X-Received: by 2002:a05:622a:1304:b0:4f4:c104:8e9f with SMTP id d75a77b69052e-506399c233dmr49042081cf.75.1770407324551;
        Fri, 06 Feb 2026 11:48:44 -0800 (PST)
X-Received: by 2002:a05:622a:1304:b0:4f4:c104:8e9f with SMTP id d75a77b69052e-506399c233dmr49041861cf.75.1770407324081;
        Fri, 06 Feb 2026 11:48:44 -0800 (PST)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506392902eesm22442391cf.21.2026.02.06.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:48:43 -0800 (PST)
Message-ID: <9a6adedbfd04eb4c6aa49891453de5bc5cd5bf16.camel@redhat.com>
Subject: Re: [PATCH v2 0/6] rust: io: turn IoCapable into a functional trait
From: lyude@redhat.com
To: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>,  Alice Ryhl <aliceryhl@google.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Miguel Ojeda	 <ojeda@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas	 <bhelgaas@google.com>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Zhi Wang
 <zhiw@nvidia.com>,  Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 06 Feb 2026 14:48:42 -0500
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

A thought that crossed my mind just now with this patch series while I
was working on converting iosys_map over to it: shouldn't we have some
unit tests for confirming runtime bounds checking works as well?

On Fri, 2026-02-06 at 15:00 +0900, Alexandre Courbot wrote:
> `IoCapable<T>` is currently used as a marker trait to signal that the
> methods of the `Io` trait corresponding to `T` have been overridden
> by
> the implementor (the default implementations triggering a build-time
> error).
>=20
> This goes against the DRY principle and separates the signaling of
> the
> capability from its implementation, making it possible to forget a
> step
> while implementing a new `Io`.
>=20
> Another undesirable side-effect is that it makes the implementation
> of
> I/O backends boilerplate-y and convoluted: currently this is done
> using
> two levels of imbricated macros that generate unsafe code.
>=20
> This patchset fixes these issues by turning `IoCapable` into a
> functional trait including the raw implementation of the I/O
> accessors for `T` using unsafe methods that work with an arbitrary
> address, and making the default methods of `Io` call into these
> implementations after checking the bounds.
>=20
> This makes overriding these accessors on all I/O backends unneeded,
> resulting in a net -90 LoCs while avoiding a violation of the DRY
> principle and reducing (and simplifying) the use of macros generating
> unsafe code.
>=20
> Patch 1 adds the `io_read` and `io_write` unsafe methods to
> `IoCapable`,
> provides the required implementations for `Mmio` and
> `pci::ConfigSpace`,
> and make the default I/O accessors of `Io` call into them instead of
> failing.
>=20
> Patches 2 to 4 get rid of the `_relaxed` variants we had in `Mmio`,
> since these are not usable in code generic against `Io` and makes use
> of
> the macros we want to remove. They are replaced by a `RelaxedMmio`
> wrapper type that implements the required `IoCapable`s and is thus
> usable in generic code.
>=20
> Patches 5 and 6 remove the overloaded implementations of the `Io`
> methods for `pci::ConfigSpace` and `Mmio`, respectively, while also
> deleting the macros that have become unused.
>=20
> There is more work coming on top of this patchset (notably the
> `register!` macro with proper I/O), but I wanted to send this work
> first
> as it stands on its own IMHO and is more digestible from a review
> perspective.
>=20
> The base for this patchset is `driver-core-testing`.
>=20
> Cc: Zhi Wang <zhiw@nvidia.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Eliot Courtney <ecourtney@nvidia.com>
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes in v2:
> - Turn `RelaxedMmio` into an actual wrapper type and make it
> available
> =C2=A0 through a `Mmio::relaxed()` method.
> - Link to v1:
> https://patch.msgid.link/20260202-io-v1-0-9bb2177d23be@nvidia.com
>=20
> ---
> Alexandre Courbot (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rust: io: turn IoCapable into a functional=
 trait
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rust: io: mem: use non-relaxed I/O ops in =
examples
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rust: io: provide Mmio relaxed ops through=
 a wrapper type
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rust: io: remove legacy relaxed accessors =
of Mmio
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rust: pci: io: remove overloaded Io method=
s of ConfigSpace
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rust: io: remove overloaded Io methods of =
Mmio
>=20
> =C2=A0rust/kernel/io.rs=C2=A0=C2=A0=C2=A0=C2=A0 | 435 +++++++++++++++++++=
+++------------------
> ----------
> =C2=A0rust/kernel/io/mem.rs |=C2=A0 10 +-
> =C2=A0rust/kernel/pci/io.rs |=C2=A0 99 ++++--------
> =C2=A03 files changed, 227 insertions(+), 317 deletions(-)
> ---
> base-commit: f55ae0bfa00e446ea751d09f468daeafc303e03f
> change-id: 20260202-io-81fd368f7565
>=20
> Best regards,

