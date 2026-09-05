Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50CF34BA33
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636275; cv=pass; b=dUR4JVlUcd8icvqssrs1CeV64wR27y4QUhZYpKjiuuHUvFk241DSpJmSfXs5nWkehGte2ls7KbitDuGT7bdU0OwfLUdEhZCNUQ6T6HqH54dq/bNDQz8Uohp0zm+teUSSd8WY0scvcEX3/Z6oc0PWrdWNTZg3l0Z1eNG0F7iCbog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636275; c=relaxed/simple;
	bh=qlpeqXScrDkE5nbP6tp8g5wa9e/y0HMZle6PR6w1uuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMsA17wvC1NdnS+Mae/H1K/dBfyELVXTdAgZfIsZILgk5XDwwXVormaPzTUFS1XyhcnhtjpI2+PBHe5aurecWTZ9hlNWzUZP0f4oGbKHWKmaK+eTCInlfV/cz44dPNSemHvfUgQRIwWIJLtaE6HNmbZYWy0DGDu/c3HMfY4T6VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E01k6EvM; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E01k6EvM"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad861b1so208909a91.1
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 12:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788636272; cv=none;
        d=google.com; s=arc-20260327;
        b=M8viY01XNEWSQeXm+Xm6shFcb+S2YXGknphY+raKYrXnFQZhbS6Tp6tLQnfph7GEic
         1oetgdiRK6yT/fNva2kU5xxb0+UudNDT9PsX0cs/KlZJXUY0lul+VPvgl8dEg+MDnYrp
         W1tM+KJKKok7hDoPZFAjatw9Ahu6/LSv5SRXkMe056E8zFQZ05HJcV4TSUF7Bt/uEi8p
         VsBzEkL0RFj4rh5SoFVzmdI8j4w0UYjFBprTH4da8/jNauzlxH8y5dgUaOm47NpTHHBj
         RPu2e5vi/OBMbJKNnKqwITtXmTcUG7QzDtg5Rj+OuXDJrbnuJDIEPowGq2A/t4+QE0ce
         fN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qlpeqXScrDkE5nbP6tp8g5wa9e/y0HMZle6PR6w1uuw=;
        fh=PIxcMJBJgjDedO21MmKwYX84oijGlOHlyfjwj5sQMEk=;
        b=H9PyHMVmACv0tSBjidOCM9lgQxR44UPzxgbircg7i9GT73xbVbacq2F9EWgRnLPGb9
         bi+wkDm/Uk01hATQjcNiQBLsDqiLj4jjzP5Zck5jTspcm1YECB39pqWZ6omV9BsMkTMG
         JJngGg4E/pTz+5xYresB6VfQdKE1ZONmOKPN6Kx/7sCvMzNyotsNcSoG1NredjAVdI+g
         BJ9V+IMNUTWOtcjFys2f3MYXXVoiexj+YAQ/zquMWwjCZGAez48y5Cwbt0VOofk45Cpx
         oG45/Bpfn82dOBteaEZZg3/zwcHAF+7bWtuqOVCecL/J2wfloG3SgNr1y7P1GjZyI2G7
         tQog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636272; x=1789241072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qlpeqXScrDkE5nbP6tp8g5wa9e/y0HMZle6PR6w1uuw=;
        b=E01k6EvMRCFlA72sItVAczr26BLEIdBhQ+4S7l9a9aoMpN4eHz834G1Frh49K6U39i
         P25Cc2UfV/I4XiAE0p5SqR3/CfWPC1wi9WTR20af6Qiqqtd11crr/2ZQSsOJ0DkSQNBT
         BmPhI6D36DGYJDm8SiwaD4BAkUKyEM1jppVyRkVJPKCir3j5o605evKGFaSrIVuGeMrY
         8aPgOsQKePUSw84U7ZeP6fx1lEIpCMp/xgAtYbGq0BJB+6pAeTLQpux1n1XevSKlA2c3
         rswB+w9JunYrXxbHlR2VzjM9Nt+d9hYB7sYqMfNt7DmB7tDyb5kNSYTD1nvNWR0Y6HUu
         GRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636272; x=1789241072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qlpeqXScrDkE5nbP6tp8g5wa9e/y0HMZle6PR6w1uuw=;
        b=G9okfq4gnz7ekD//xrlW9GaegTbgYOxPKyK3JKMVJv/HHq/JFJoxoE+I7bmmTvOhVO
         Ohmv/LsVtnR9w85NhPa1TuLnT0beY0yaxND4DDnMYdCnrxR6NS7QK/6HcIuOAyYn4g9/
         UrVSVCd1eOgOWXoHYALPMvnq2p3JA9FB8CMWJzFLQLSeOEMNjxUwlet237BLMHE8BRjw
         wSInEznuuR3ZLgRUvhYwOKGNBBUpWBQio+AMSHEgZ4GsjiBHLhxg2jApc58hkwnaNvXj
         +3RDLaidVRXyxuBCaKC1vgGIdK0xYhQxUnJy1grNy0QHJtIHGrIqJbFt7IcqN0EE+6GQ
         GBdg==
X-Forwarded-Encrypted: i=1; AKwUvBxz2AOVe7M4Rt/3WhUS8Jkg0rkDaP80LnykZkYJf7Yh2r0Zye37woQEmV/u/JhFAc5yapzCQpJqboY=@vger.kernel.org
X-Gm-Message-State: AFuF++mrJ3sTybiylLi5PJX5x61xXMqF4z5yXIu7MRXKeKcmPUoOutAI
	GcmoBe1IhTatalIbD2jjmZTyflrjrDD3EaYJEC++tReLmFUHwooT60lT0gDoCjG/RVR1xkYXlcZ
	O8B6G08XMWNSwWpDpc0GHScuAsa2mZ88=
X-Gm-Gg: AYBFou3067Z/suzZiyTtkCfYH3IqP1bed9vLXTHymhvMKf+xKvBdzb9w5pnZgUkoP8l
	GAKQ0gsgNEZzesgiygrxsDmXj7a6SKJcvBKV1nRjvfmBin1EERc1DSXQHKXja1sm0+K51uy495R
	Yssl4yO0Hh8d6bXuw2j3pl0lXJKKfE1+Cc9yFzrmE9wyQEP4/WjzDoAUxJUAEgxPkWmhGhBGAci
	7ObD9RY1g28kOetNuX391QYecKKko1MKkEhxhFjBeoJxvyqUzTlELSP4dbBib/mQmowO49KEA0B
	1KvKAEwCYrCRVQbI/cgo1uNxLU0sb/HAiLFOQdg06TlR0ukDVHy1z1wWoQgdhA2/A4A5MhnrkmG
	bxkUnb46ufKGvMKQCJeSaihslWe7J/hxPlkldugjYiP/UtsRpC86Q3xJO8zLt
X-Received: by 2002:a17:902:ce90:b0:2ca:ecf6:9115 with SMTP id
 d9443c01a7336-2db2776adbbmr63554785ad.2.1788636272311; Sat, 05 Sep 2026
 12:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260903192248.2248560-1-dakr@kernel.org> <DL5XG1N71CVV.TOAF6XQY0SW5@kernel.org>
In-Reply-To: <DL5XG1N71CVV.TOAF6XQY0SW5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 21:24:19 +0200
X-Gm-Features: AcwNN1VrVIX1rn-ymHE6KZVlOZK2RCfm_y-i_dbObCbOpleHp8K2ryo0MaspaGI
Message-ID: <CANiq72m1ZxFtQjm4fUAt6Y1MFE=ww6jx+dEg3F4Bqbki=ndO=g@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and
 remove relative registers
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Thu, Sep 3, 2026 at 9:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Miguel, Boqun: Please let me know if you are fine with the two
> rust/kernel/mem.rs patches.

I see you fixed a few nits -- I pointed a few others in a couple replies.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

It is nice to get a slice of the future of the standard library a bit soone=
r :)

Thanks!

Cheers,
Miguel
