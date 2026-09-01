Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB935F5E4
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266550; cv=pass; b=i0mwDFxkk+Nz4NpcFEUCXkcs6zf9ZXe3cTKd+H+WKZUztp3GnJ/30R9Q4DZmAJs3gURIZ7BIgDvgaxXBbAaEMVf/JlNNfTrdc81U1cBpMzed7eGhrPFqdqXZtNYIJMU6JUP9UTH0fB1hSRDNInNcpwVIz/y8UdALT3HdOTituHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266550; c=relaxed/simple;
	bh=ZreO0EubD/Cpg2PFlTmnjBPWguJk/VPiiKkxH3gIp4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDwH+R9yCcMjhpIg9Wy6WKLz/6WkMDXL+9+SkrVjt/m3tDW8kBjpYkG9UT8d4n5Uguk19SyzDcfMquMDcjsgMWr2yAjIfPFZU1V6pw6AWrS2BN6X0r8I3R8UDHvbDupUQWnu2eVe6au/sCK7Vhr0jOM2fAddSQ6UQnO26FHst3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP8yHs1Z; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP8yHs1Z"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cecdc24b1cso4234295ad.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 05:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266548; cv=none;
        d=google.com; s=arc-20260327;
        b=qSJNVZ00UJz00u3MbfG9sMLFIrh21uijtS273jxwebCRtFzuNbFk/A9SUJfZnp2cZG
         WDphHTQxneUthqxvcX1EXvPCk69tRPHwYDNx6wDt+Ai/nJk0PUHou/2Ya0hF+BJi46KI
         z9jzhOgITilItAdugRdNrIUagExebs9XbDJLbyd+pFT3Ll8JXjyxAED43A8zt4qHiNSi
         FtUordutopE2kAtTVUsVoffmLnOvoTTssLxjE4HBXTclLFWxA8AC/5sWCQZZh/g7rYko
         KtJxQQcUbI6YzDSFevA29PyRrnl1lJ88ewwn6b7gklxz9H/h9bh1a5oVJSzBfsAIQH0p
         UPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZreO0EubD/Cpg2PFlTmnjBPWguJk/VPiiKkxH3gIp4M=;
        fh=nWftTStxa7+ErT99V77mrs8sqNSQPnXldZ3wlYDjsxI=;
        b=MFaMLRSAYVTpjM6H1glcddrsxB1tqkHodvtcro1AEdenmCsnCV+DW91ootABXx+EjH
         M/boBdtTgUP39m8uYklTbTMhD8eGQF8LPAkLxXheFC9w14sbZ/2gSG2ZF2FDIN9OHhDX
         Dgq9iaT0cPoq7EelEMNhRQwOiCgJnEIewZqNx+cWFJFjwbJ5rJoRNQY/p6YIMSqAJcvB
         9u2Dt+lCuKKbDNAN1vrhKXT8sW3aRblw6vNQTrdWX8Mr0Iq1N9igy7yMnzLJCsbQEzvo
         duFGvQkLsZO2zRXzwZL5I96tGWs3dP8pTrDf/xXLVcgNdGWOrNxFkDwKZD2AzRqfhhsQ
         RRSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266548; x=1788871348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZreO0EubD/Cpg2PFlTmnjBPWguJk/VPiiKkxH3gIp4M=;
        b=WP8yHs1ZJ6F3DqOFSZF7f5mLDLSaOZgOXE1egF2FqkzaHXQWbk0x5q2SYHqCjQ53c4
         sZfNN7Iq9M2UDDG94HJCHH22rF9OBz0U4PC13mEp9EBtu/VsDvq5t6jS4AW0Za4wn1N8
         PoafNmo+faCsCuTFMQlzyJI9uOC25vedAPHEXNM6bjXI380dDGMlFTxZkTj1H3Kh5p+s
         SiWYDT7q8gv2thXxpbcD89oA5ZC0fE3cTflvR90/MgxpUfgf0C82053cZGzrdl/0+zqm
         s1N5qxTYTptMCUI8n+dQTnV5pY7l+mObYIVlCwa+nXENPuA9N5cGeT3+eMAle0dBzwnr
         eBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266548; x=1788871348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZreO0EubD/Cpg2PFlTmnjBPWguJk/VPiiKkxH3gIp4M=;
        b=tKP2dITTDc4YG8lMKkLIEKv39mQoLYrT2rXoVxSYUqVwOmdz8gOTomEYBg3wyQ5nH+
         skoTanzujStn6M1AAOREjDpXPxDIXsjaOQjZcBXvjMnnhWD+UDxTZhOvKINGKGYCWGIq
         v8AqRbueW8ZNtYBeAdYbkwF9pY40xKRJ7rSj3QmLqkRvgIFZHUxVnyACScLJ2mC/G/5/
         jCTZ5TrFxy93WK0LbTrE8Zls/zHPsr9TLABKfZ2xCMQ2eTX2Gv1FSBnYpkBRFdVfgWm+
         fiIrlm68qjB7DJeeiJ/ZOcjZmMOC7OS645Z/fNnTWSyK2dOvMj8Y4oZ6acVnghPU7E3X
         q4Ng==
X-Forwarded-Encrypted: i=1; AKwUvBxZOFwzLyNb/V9kx6HGS+fw6NyEL3/mQXrGa84hNKd/X3udh37k4pTHoc9xs12+9K2oNL8q7ArB2Kc=@vger.kernel.org
X-Gm-Message-State: AFuF++mTFJxFq87CQme2PMGbbSevrALMShFai5mCfKl0Xt819icPDJEU
	FSedj7vdsXe1nT2bFBiY4845sbwUWj6EtTYKX5h/yruobHTfX2a5AlQ8JZoanqXLEDfgvdib0xQ
	gCsPaiUKKLtAix/FU5niPz64CB3Ha7Kc=
X-Gm-Gg: AYBFou2B6WTkIzPn4fixjtRRm25Aj8kEzYqbvUmlgLZhlw0krQMV7UZKcOm6Ivx/yPy
	Su1IE1bj8RgxtPle3ZSRNXg/Xzex0KhaNZMRPhcf8SSNSI+kO0Tz/IVvs7wS8224HTcOVOuiLtq
	n+9RmCw2wHkRa/mQkmbHkKKI+FeT3asjY6xsjlCCfFxxYLb1WOPFTTCtXm3VCLdGYB2ayHRodRa
	kngCy7mJWcdH/xiTFaD1JZfgb96dLvIDT5KTuwEV4ngC3ZozKOHPXEq+3jtVyoosvY0DeNm98sd
	sy73s34+jzP79rdg9pZhgg5MYSj7+BA+MAgGk93O7tscLJoQKn5a8h6KFxdzjzkuS79rsEO1lVf
	ktuX5ie8DHGNkClC+OvXYaUzuQyro7FM5EntQaKaeoZhnTz5nqVQuI5ZQHTDY
X-Received: by 2002:a17:902:d2d0:b0:2c7:ef84:c58e with SMTP id
 d9443c01a7336-2d74dc08a13mr304207985ad.1.1788266547835; Tue, 01 Sep 2026
 05:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
 <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>
In-Reply-To: <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 14:42:14 +0200
X-Gm-Features: AcwNN1VnWRWOYROIxu4T-i2jI1d1fjW-RoGFUjjuLdYxZ3xRyTDBVBEFMSpQ8Bo
Message-ID: <CANiq72=GvH3KwsdTMtRq8jJcTWAh83uj5L3qD8vHbyntgCgoNg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Sophon Zhang via B4 Relay <devnull+aiqubits.hotmail.com@kernel.org>, aiqubits@hotmail.com, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 12:58=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> That makes me wonder, shouldn't we make `index` take a `u32` directly?
> If that's what the C API expects, it does make sense to align to it
> instead of forcing users to make a potential unneeded conversion if they
> already have a u32.

In general, Rust users shouldn't be dealing with C APIs, so if they
have a `u32` then it usually is because we exposed it from somewhere
else (e.g. we returned it to them) or because that is generally the
right underlying type, in which case it may make sense to align
everything.

But even in those cases, it may have made sense to define a Rust
newtype or similar instead.

So other than exceptional cases, the types that C APIs use shouldn't
drive the decisions on the Rust signatures, since they shouldn't be
seen by the Rust users to begin with.

That definitely introduces some friction on our side, but it does give
us a lot of freedom defining APIs the best way we can, which is a
major advantage, i.e. since we have to provide these abstractions, it
is a good time to be able to clean old decisions and improve on them
using whatever tools Rust give us.

Otherwise, one could also argue we should be passing the underlying
types in general, e.g. even pointers.

(Of course, you know this, I am just elaborating; and obviously there
may be cases it may make sense to just use the underlying type since
it is something that has never changed or is fixed due to some
"standard" etc.).

Cheers,
Miguel
