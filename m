Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81C3A6B65
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267028; cv=pass; b=KD0y22b8l9De0Y/Oi4FP60uW/Waco/0uK24hcXRqzw9GK9CZFzjPqcfHun5ZZUgfEpiHwhydLXdr5D3nZ7TRBDfzaFWlcka2CUmPY4yuJDYNIiHWqUSRD57VKB1RdSGqV8o+k0c7pY1OuhekwVto6A0Zn8+9MyNBwzUfLDy1/QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267028; c=relaxed/simple;
	bh=OuZdxdtD2MuuyArmy960J2u4SzK0kRJyCn9E2H22tnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2b7J9VT9vRfHVj0RoaEAOYK6wMN5VR1gE5XBWg5aEmZepaG7ZtiyE7U5CbZWEwt8nr1TXLo+lQ5NDyDuD+Sw3LBevWtxGw+D8gtETDkKNs3J3ZqhFnuaQPXNmgYoTguuNRFHb25ORY6oN2JIcJ7E8vW9Kri8bXq3IcGLxIV/9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9M6iYc4; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9M6iYc4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7a269ca1so388395ad.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785267027; cv=none;
        d=google.com; s=arc-20260327;
        b=axanrDSwEMtWjD8r3SQA4laVnQn/U7LKM7+HGWC7eDG9SoYPjhnut78Z2AsHnsxajL
         nQyuBracOUCIdaIgLPtvuJsUU1IjvS54//HnVoxnIEQPARMWLiRCgeBk97QaX7J0HV/R
         quVcIjMcE7gyUN4njWlWQ3AtbvkJSPaIEc/Bz5yyAmrS+nABtT0psPt5RmgSEzS82l+u
         CdbBSOs20wCEYS9XX/NcpHSJkMC1s8Qffft+7uhFYI+7d41BmtdHV5zWK+WgXH1EZhvf
         XjORsqj5zoq7Eva5cYmuEDuFD8/jGvCGN25TNpmTugCEI7VcxJu+sC7G1JTGGYwnS7Ao
         sfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YOlnY10tnr4QkKaIlxFYxTs9Lp19ftPVrjCjqbroCWQ=;
        fh=ga5jDb50dZSuvF0R6IsEKuomVvB+BXMMetqDwBKVuOc=;
        b=F2Gd7EgBuxfnUs0NfSkO3GoH+bDAeGagjlAxR+2F8CxGN8HpOrGJBpKIWmfhzZuCFT
         KHFLFkb26DAHWhrLe8PQSY2gU/hLZCA1Dn3Z9xOMNHcVHIzLpvJWwz6k1JUmv2GeDGds
         n2ipHHxJXPCATSF6E7+1aHK54q+KjYBy2mppl/JdhA3zftnj7Q7+X+tLRmX0w88RZ1qP
         nexchSDz0xY8qEsdjOOcv7c0WHzA4CIi8ZP2xEHGnTj1vShIzPeStnsy/j5OD17Bb+DE
         vdRH0cAruf/8ougeqfvrQON4tDHo41lWp0k4MlPX7KDPV16whA0di7bSExxUfT0io91G
         1Wvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785267027; x=1785871827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YOlnY10tnr4QkKaIlxFYxTs9Lp19ftPVrjCjqbroCWQ=;
        b=e9M6iYc4ltG5uN3Rzl1KyierKU0sM9Aj4sXlKNMnqu3A6GEpTGZddBj+9F5TXFKOA3
         SQiWnl29Z6tJ+Qr4M7/SUzHx1H55LJFIz8fKo41Z89LpZZTqHs9nIvrAKp7JG3id5ro6
         gl6PlvBrG4BFvNAWA8JsQv4YxyhR88axdG4qKnrZiwT6aasDCZbM1O0V9M5TUiShuo+z
         vZRDp4r8LI6x3BmKQYJoix5sBYNO7FVJ/EXY4fuTy+TUykDmfp7+jEPxmWPDVbl9Ao+/
         qeZBeoxNk6QdXE4+ZdtqL1J1Bjrz6dGK5fUphOdysAGLQeB5UbfO3izhFm4jmYhY7FjV
         W1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785267027; x=1785871827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOlnY10tnr4QkKaIlxFYxTs9Lp19ftPVrjCjqbroCWQ=;
        b=lR5z6ciDa6YuFj2awrwKbwWkoVfw9vx4jTRrGxooTVSHuG//hq55uvNMUKvZcJ/k2W
         vWPX2+xHPwSC4yeKLZl7VFxFBY6BzT5MKJQSLzh6ezPGi5sfsxOOPXWZe3MU1/TxSXvL
         trQYt51GLdCotiAQ4YVHDaotnrZ3GDXkA7zpAxZclqW2cV568XSlSk6XcYnZa/2RlC8t
         wYfJWTSlso/GuNuooQsBP2L4xEWAXCh3nsf2oYKnfucBlXTKJl4srme6J8YtWoqQ5HGe
         ifEJidYbt2UIKozKRzcVwhXuRSkigqVTFaQre88eTW4F3/0jO5tuKLK+1SO6JsEE2luA
         xVrQ==
X-Forwarded-Encrypted: i=1; AHgh+RosgGbe70Td0h5DV/ooS2RyS8/W3JkDrxlhDdncxjBysoSbBu3oVdxWUUldyXDGWSITB5YY4Bpz47A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RAnzoDWs4TZWnKSca/nLB5ET2tKW6+h4rZH7IKdP6uawsum5
	awz/7QKhBXKkP830Tlhzp5b/gwfWbr7gZ5L83XBEjbhvY2dEnavemQLuI5K5NeZ5gigOpfp1vp4
	k7uzU2rzcJ040HZdfs81sX3YkYSgZ8mQ=
X-Gm-Gg: AR+sD13q2OKeaBl0GZPUAFPQl2eNSiK+s0LmrCxibrRSmjoyVghUn4NL0TVvbfqj9ah
	Ny53IqumJ8mWTKXoOEgZDrO6vf8w3S2QIjePQmEhNMli7GBV84jQhvCJPlRSj0D5nsAnxd4XJMx
	cte8nIircQiwiYFQ5qszic9IY+AfRWj3lh2X5BXEJefM3q2pjKdzSAbYWhdAtuZJFrofu5m4f+M
	IBLgPXu5qps+q6xHq5ABF8cndKRt3XxYlRlBpqWMImtDQwkFvt7dqLfUQqseKcxE1FoTNaIeC+J
	yk5ApEQmRYJnLxG+OJe6XCMT6kh2yf12K6R74pZyxQHseE1IzU8xMVVcDlL5E+WiwVpB5z8PyQw
	3OT++YWNQG16XyIavpgDL8eZx34RVM6HWwmfszTkN8PtWy9w+d6DAFut3im8s
X-Received: by 2002:a17:902:e88c:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d0157877cfmr34510465ad.0.1785267026639; Tue, 28 Jul 2026
 12:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net> <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net> <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org> <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
 <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org> <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>
In-Reply-To: <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Jul 2026 21:30:14 +0200
X-Gm-Features: AUfX_my7ge7MYUh2zUi3Gt3zgCDTbiWd0Gi_L5P50g4KhlbsBg8SdJA5xeWd3II
Message-ID: <CANiq72kqRh=ucvE8ibPmesyrWdLnwbOwcsmTx2A0iD34DdUsVA@mail.gmail.com>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:03=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> It'd be a compiler bug if const folding is expected to happen, the whole
> BUILD_BUG_ON depends on it working.
>
> `build_assert!` is a useful tool that I'm not giving up. If there is a ne=
ed to
> use it, then I'd use it compared to having two variants to do the same th=
ing
> with different syntax.

Yeah, and on this topic, the overall concept is being discussed in the
C standard committee due to paper:

  N3846 2026/03/10 Grant, compile_assert =E2=80=93 optimization-enforced
conditions at compile time
  https://www.open-std.org/jtc1/sc22/WG14/www/docs/n3846.pdf

I gave the author some feedback on the prior art in Linux (at least
since 2002, originally using the linker approach) and GCC (adding the
compiler attribute in 2007 from what I could see), including our Rust
macro too, starting in 2022.

Hopefully the discussion will continue -- the thread was active up to
a few days ago.

Cheers,
Miguel
