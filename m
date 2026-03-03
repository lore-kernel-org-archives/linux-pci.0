Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051A381AFE
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561261; cv=pass; b=UGb1hpg5OKXyciYztpVq+rKxjA7tGeH4KHiocun7VwBSBxXY0zstJCASB82LlEdb6rEKzhh5Y9zHo862H9sXw43dl+zdLry2uZPhZGMAbPc8w2dTdCgmLH+j3iH1z/Zs/q4kgySMFgA/4NYVl/xeIwJt7wSbHJPZeUXIobXwulI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561261; c=relaxed/simple;
	bh=HUHgj2ElBuPGmubcslyfUuFNZEOEJOjv22IyfxcfieI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlnwW0m1VmDeMnXpICtK7CihEMwFKTi/rFPBpWZqGa1KGXHLyer5VGicmdZ0MAO+eJXO6gMgYGR5jG5KJrSBRiKbxZtA8im1ljw6oKbQHh6PYdaqrp31t71hPRTF8xeBrpQadItOmxEvmPg/OOdOWuPgukMt8+1KcYU3xLIfrdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGapfEar; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGapfEar"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bda3b4318dso543023eec.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 10:07:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772561260; cv=none;
        d=google.com; s=arc-20240605;
        b=llCNd3zvZTJcr0+kSy0SHSLg9bBLUl/rBf2Hdj9mB1p0xHxNjJy01jDfJ7XwavRBF7
         rf0/DvwJdUlla5l/hINOgll1YDlzTdoulQrfg/40sKWqADYj1jaDvyK5tPJNZM6oiC1a
         1vONWqlfLymeL4WLo3z44+9kvNup3IxlWb0jROS1x5XjlnlCUbDibnhZyBwBFcAMy1yK
         hjcIPzeZ/8JMpPePBiFhrAktBkTs3jRMlzyTqxpiEbsBv/qz+SMqFVlhtVddHap/anNs
         kNqptFqwULm9NinuV3aCh7w6kD5cHWgQp+IpWLQHVf6yM4taFJgzfGiYzYSMhU8nodGz
         mDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R+q0jN+aH2U740XZAx90ODP1AU2BrSp5EsLhQpO8EjQ=;
        fh=cp6d1tl38FTEvzrlKOqleiefN3MZ8zUXGnuNfp1lBZA=;
        b=FmkYpkGkeEC0wLWomOparGsU7yesfMwNAT74nZchnPviP5aJxe7vM5AVrVR7dMAeRk
         a1fhimeqfqbd0VGBIxLE9ShLCL9rwQATN7nTFfuHIM0fEAHph+06UQ0mQmJKi5lX31//
         y/fdJ2VGwTJHYw3ief+IO9XeQIlynOyxq0TNA7w+Tr1GxasMeHTmSHGvj/fKIu8p2fBc
         RCobUsPsDN1P4OqnS7xJjih1WOhWy4uAVBpIoHFpCRLQuWXx7lnw/Hu3gSVqGZqNcRCY
         3ODy2+PnIewqdX5KdK1+N6LtdLzdOB3gePDV+PtqOBAuzXXV6eDklD52C+m1wqON7tiq
         u4zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772561260; x=1773166060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+q0jN+aH2U740XZAx90ODP1AU2BrSp5EsLhQpO8EjQ=;
        b=XGapfEary2QvfkhT2A03zHWPyyNJ6Iao5dpwc6qoSW9t7U0bZEFgeqdUWFHiQx0oZt
         PMLO+YoBvftY2bV44jNW3TwFTtG4+y+HvpwCZzdquagngv7grRMS793RBb3gGOrxwQRh
         E+PmR57RDenuPd2sT4bp9qvEo7O0dtyqmqUziSLy77o3fNg0n4FGzzCCtazjecQmuc8l
         dZf2ZoDEqsp7iR5H+H2dKfgw6JlLEfrz5Ncya6As4PgHqhx+nA9oWgm8LS6SgA4Ko0AV
         JbiY+EHuU8qjRGYkzNbMAvD2NsVOQBJUH/75SaxLlqMriheKko1HccaKIHW3FGGn/Ig8
         WpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561260; x=1773166060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+q0jN+aH2U740XZAx90ODP1AU2BrSp5EsLhQpO8EjQ=;
        b=lIYar8msNNOOzpx3AVX/zjjdveTpndxpSPZ01t1PqcVb2PTqcZaUCW+wjOf/MLKzGq
         pPRXvyK5me0NDwHuY1JDjGPWOZ6wF9K4nzosbdMP/7DNMWDbPVZnVQ6qLRYyWsPRtDKA
         0Ln1TbZK88UFhUrO0ikGsQKfpYwbHR/73JYaUfUCO5GW9+Cr+jP5WsF04+OwH8xmQL88
         r4oWNfL7gcwg4vpT7HGeBBy3aasZ60WCesqAtf0WEaoLm3Q+KOSCjRIDiAXmYG/bu+ve
         DPneo3iIldNwcULWs+FwqT6267r6cpqcP5RiwujIW9Fu9UvZcLwPA0EbMIMe/Fnl8ieL
         diOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZpAnvPdFu7QCXXz4xMuUkmUEAKwpOnrVOe4eB9PR/Ga+9dBw4aug+h7wZ9cZ6r2sFdZteSur4v1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzocFH2ixzW7yh8aIDWErnJBPga3I/qXE1/x4hgSKR62siEKjLB
	LWOeF+pIqqq81jqYJujAaOfvZtlI93IjZozP0ooik1EXASgTys4r1Il1uGrAPa9vBiP139eTWpV
	N2Gc5N2mOJLDYfy/yhqQTCDGN/ChC79s=
X-Gm-Gg: ATEYQzzPaAQLGoppkDIxLPZx+q9kOQsOdFq8EV9G3TGtLvVUUWN91yUfuHF7rXNR5Rz
	cLALJ32j81I5qO2gQHmVztuXNB+lTdskUMCV0ur1baTthLFo+ealVidTw/t5D8CEbAEijGqUEEx
	m93bWok5ghycG4zvYlVYJPN3/A5cm3osWijF9lvlPXgn3P3ij3kdQH1xRnYUtkgAgOQKYYRbCeq
	mfF90yY+Usg8vYKvPWpxaV27wXG6ePejLUsaJwuVCiSieEdE5SFm0GSJTGnb6LQLjCGKw3csQ/C
	lAfGuEgWmoyOgzeBJ+tf//nJ5KsucDq5p9oDdVNkBryggI4eMLEpSJc2G6cmVfRZv+eQUw6gE0O
	zTJgkkx4X1VwdU92Dg11GLZgh
X-Received: by 2002:a05:7301:128f:b0:2be:1946:8576 with SMTP id
 5a478bee46e88-2be19468a7cmr1189062eec.4.1772561259708; Tue, 03 Mar 2026
 10:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-14-alistair.francis@wdc.com> <20260303120901.00004f09@huawei.com>
In-Reply-To: <20260303120901.00004f09@huawei.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Mar 2026 19:07:25 +0100
X-Gm-Features: AaiRm50kQCG3rWYXRXgEs_41HrhB68jbew2wmRd5fS8L-moVcgSEic_0M728KX8
Message-ID: <CANiq72nU-0Da1R3K6eHeJU1jkhnu7arVP5NOykdvQEpoHSgHbg@mail.gmail.com>
Subject: Re: [RFC v3 13/27] lib: rspdm: Support SPDM get_capabilities
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: alistair23@gmail.com, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 1:09=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> Can we use bit_u32() or similar here?
> We've tried to move to BIT() for similar defines in the C code, so I'm
> looking for something along those lines. Provides a form of documentation
> that they are single bit fields.

We have these so far:

  https://rust.docs.kernel.org/kernel/bits/

Out-of-tree long ago we had also a `bit<T>` generic const function
(https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/types.rs#L31=
7-L349).
I think we also discussed a `bit!` macro at some point.

> This is why I was getting bit grumpy in previous about long lines.
> Fair enough if this is only option, but it's not nice for a review proces=
s
> that relies on patches!

This should be using the kernel imports style, which should make a
case like this more readable:

  https://docs.kernel.org/rust/coding-guidelines.html#imports

I hope that helps!

Cheers,
Miguel
