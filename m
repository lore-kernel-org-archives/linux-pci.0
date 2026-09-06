Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6AD3368BD
	for <linux-pci@vger.kernel.org>; Sun,  6 Sep 2026 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788652911; cv=pass; b=HdlaE4CsM/nDI2PDkgh8C70JCBhup0RRocRaMZWsVYv+Rt5pQ4aYsP273aCzFQR4EWb5+aRzicM8H9AsLg+WsI5wDnKwt8b/RtK0h2R4un9Ni/FD296ZKhYacAx2p/t+U/irEi6N+lipFOF+gi1qHemT0zVrrpSi2Q1ZngB/8u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788652911; c=relaxed/simple;
	bh=2MqN60FsZvPdTZbJyxVZaz/7XO+slkluE367ZcdhXfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPqgvuBCvnExlp/L/nOXPC+PjVo3nHazDeHKAZ4FjR/W4SNsoZxlPlNnZtiRNNmRcGPV7MDCPLIiFisn7o6zIJjJv6IyD0dSA3lba1nSHjktgeI0tY6auvQxubjUOIHgt9Pi62jYb3ONx06vey8r6cu7Prmtf+tsMpO1J9Y1+dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO5g6y+O; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO5g6y+O"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396672b2569so161344a91.3
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 17:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788652909; cv=none;
        d=google.com; s=arc-20260327;
        b=Uxzr0u8ODBQwNnNERnVitgc6MSYPp+cqE2mIjtrK/MDDI+CtTtipDebwSZuj3PYhZD
         UgpoecqL7I6tE5ZKCM6htScIz9MxH8eg73dhDvnJyqXFbneQhKMaq+ax2Edxg/Judfe0
         BTOB4rNU37rp4o6dbAOst4KIw7FUKkFU3sMuX1xHtX8zMbw5oAJJzCg/EnSY5tHJKzz6
         PPL5stFF6FCmPmkcDDAN1G1lAFROiJgGDl4e0RiCD5Rw/xCL/waWGlPjDwmEq5TsNBfX
         t4cJJmxWOLqGifs5g4hb2allyYgiXKLgyWMBTRPG9mIC1L5f6R8Ps91yXSAU6b3kIB/h
         o5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2MqN60FsZvPdTZbJyxVZaz/7XO+slkluE367ZcdhXfk=;
        fh=1Zqu0oMQYQoZ4H/qSfb4DpIXlv4q2h+Lj37/nocBcNI=;
        b=EggkC7umNRjmqZp/Wur0wtsg3xdjTN7oZHQQfTweVrP8Cc10MEEUPanZegD7uWeNlz
         hv4eY6gfCrCf/kZIMzHrKI0YOL7jLKozQaVCW2fqn+KJCTwDBBavpQyFm5I+hGIH/0sx
         DGt/toMJ+x/MzEgFiOEwMlDZXCHAOeHxsLEcIiAGYdHz5bcPJMAQeE895Pt2rRbluFBM
         BuKE5F186TkMUYG4QnEYvbGf6UCgEucH5XztkHYmo2xpOdeIRejS5kqYGU2FnX3CAm/Q
         DNYtIZrO/fVmEFYscgw9jm59e/wrFDsRACfiFulsGTEuNojojvXqlx24yiT9VuxnovLY
         5O7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788652909; x=1789257709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2MqN60FsZvPdTZbJyxVZaz/7XO+slkluE367ZcdhXfk=;
        b=aO5g6y+O2I6KB0wKZYdrmuO7xdEIDcvgIg7DX2ejxj49oEMw/7Rj8Hcmej2IBC6qwa
         VDlvFG7+PF0JwCaGXi/6gE6u11/NmiwsPz1xFV/mV0MIwoHXpr+/T3y1REveqBv/xwNf
         ZGJdXaDXucuptYOO3fH3dU/bIRTXoP7munpqn2zy3GGixzYLwBUy4awoOuzaCVamG7VV
         PF6JfRrgpPgWYoC2G7PW/Q55A+nnu3+igXN2xLNh5xI1UIxXfcvv/+XBYEYFa1kve5L6
         xzJsY6/rLXwFAXmfyZHjJv0RPDODxdY/vLHvet86DzCNQuj9RB0guNdNuHNksSNNXrrz
         kkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788652909; x=1789257709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MqN60FsZvPdTZbJyxVZaz/7XO+slkluE367ZcdhXfk=;
        b=TXZ+iYVOTPkDl3J4y12yBj1VU6ChElDsxr/9R9OKTuv6Lp+PO1fbRBN8n9pA7g0p5Z
         IymLHcnf/hEm5BR1rVcRCmlKq7qKLs42yjNQBVyJpF8ImHuD1l4CbuDBOJTH0HjIxnGt
         Ia3bbLJgLH0ZEFYf8votA5HUQnlamEPEv0og9b0zLyB1gourEckYMbt7BdoOIpOGUy7v
         Hp3Yv5b0T4gla4uidi7pN6pqjiIGC40F5BsXU+n5qQ14sMYc6olEWvUHh4JYpdJdPjAA
         Zx9zZ/qLO4IcsElHUinBzOXQ8kdkpb+tcJoithkuwPGJBnURISYNFA7FJ7iWnohg48p7
         npwg==
X-Forwarded-Encrypted: i=1; AKwUvBxDVRviBmai0cL+beejF43O9PsTFhy6Pl/fp7fNYdgVUo7n4dFoEXr9hUCbv5kZIGHgitilcey9ngk=@vger.kernel.org
X-Gm-Message-State: AFuF++nTUbdnx52NGbHtZ3s32Bed2b7tZXxd/1gjgjhmJ7vpOr9nzBWm
	8dzrxozmUaiMNY78q1ogfpE77lOmFdXuZa9JA02hlESODyJaudsxmY5+bzyphiNDO3nIoJqcEOm
	Zp9sknxQuC6sEguw2pVD1Fi81RP7HfOc=
X-Gm-Gg: AYBFou3A5cPpEqbxYW8nlwgiLcTFVSXcFcWWj/iuUBsHvA3/YFZgmVtvM1h5mwkV4Co
	ANbnmag7JWK1EPsi/9DWYomSq7IID5ciLBuOc9OI8gmMHdumBsjCWuhlqir4pfqbzKaDdlVl/q6
	YRSPl7+4zCqjyIiP+5/1StxatXsMvGbuqVDBh4xxm1M9wySeeJUCZelO44f5qpEaemOmbiMWtFr
	s/NrkFFwG+3SG+aWoSeMNjPsvJIoDvGn4WNChYuOWShPLr8Iwm0YGVxun42eWcFKigOlSXIZ6xE
	D/vqebC2GNM4TgeeJSuo6GTxAdxl3bojhLojUnquId4LlnoyWDsyRxTxNLmO61HpHNf8Cx9evsW
	4NYlGYPV+37lwPtxztzciOV6BE+RvJdQ6X+RRppF4G04ksyahLuul5YsGceta
X-Received: by 2002:a17:90b:3907:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-39b3d8a3d1cmr7786501a91.6.1788652904655; Sat, 05 Sep 2026
 17:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-3-5552b1d59525@garyguo.net> <CANiq72nxtehkGdb9RZpd=MsjWzp9euoLw=MmCzvcqOgxxEwymg@mail.gmail.com>
 <DL7RX130417U.10PL9U4D6JU9L@garyguo.net>
In-Reply-To: <DL7RX130417U.10PL9U4D6JU9L@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 02:01:31 +0200
X-Gm-Features: AcwNN1XKuKFBV9qEAm_z4sB5Fo2qHcAE7av8dqRfbpy9oR-6X3rQ---1a2fINJY
Message-ID: <CANiq72n2B=7TXtmtQXEC-VZQNZ6NQTkPsxnnNCiWWYb=U4TyZQ@mail.gmail.com>
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

On Sun, Sep 6, 2026 at 1:32=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> I'm not sure why we'd want a self link.

It is to follow the guideline about using intra-doc links on things
that can be, which prevents mistakes and improves consistency, and in
this case, for huge traits, it may help readers of the trait
implementations section a bit.

Cheers,
Miguel
