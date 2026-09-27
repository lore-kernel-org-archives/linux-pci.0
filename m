Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AA3C0A0E
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549235; cv=pass; b=gf7u55iUtksFQ7rckErRY+ZxpNIJV1yC1o2sXGNx/stYf1J32dldfSpnHG8iQeh64FMkSWwRGWMEL5zjnpN1PCUgLm+4tiyY+1qP315AA2mfSD0fWgsyslzrtUhsJk3P6SXxBpV59gs04NV18yEsNE/HYw3MgRRsLf1yAnnMwLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549235; c=relaxed/simple;
	bh=13e/yABJLuq5e3xhn1IcZZe5oBwPbnwbTkVGh4XSUbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By6dzoQCBhWSnmP+N503YcX9YZKqZ9+E5tYrYnpMp4bRsAcjtS+yYUSmznhBCrUgnvwYq5abLm+8ybLPt5gfPtdINNBhCwPGWqZuJucvc5LrykaFjjfF5WQE3SIMEq/mwtgEbu3eIS+5nbQzVVlTkSVH1ZOa/62qG/M5hZ9f63o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puL1Zdvz; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puL1Zdvz"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab4b93bbe9so2234930a12.2
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 15:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790549232; cv=none;
        d=google.com; s=arc-20260327;
        b=V/QuepZQIKuzUTGNvvkcxmKlJ5XJrUi6pPUxSZlYThQxKKD8+1ywGbfV3GIAF03iOu
         MHFoTVP3wWkIPttjHUdXCO8qSPTMJYxPhkBmXCJOpVg1ZVRke8ZniGoJg9Z2Gk/wJ1nz
         tCVIgGLEg22Y6xl6yTnfll5hsmDKk92WqlrVAgHWF7AEpn5BRm0ihvVmPjIhbIpvYrUj
         cO3+DAzL23vAiYuwfpvtrUhoCqmMvuMCt4H44+8gljac6+6OHrM1bbFU7IEoWFajMZQB
         Pr81dFC9qEq7pu0APTzeshk3EAtTVzHCLScY5f6CyVtPpzxRYbHvCaoBk0n5dFuxsMw6
         QrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QIJ+NAQNwQQ8hmxlSZFAjXknCZBUfMJn51nkt5PbrzA=;
        fh=A3jdoBo6RnmzgOjmH//1TIXVKU8ZqVJGv4ijofMnRck=;
        b=DP4HJGoe0t+nBkjggKGbg2Q5OVXYNC3opVpfE31f3CPFN0Wi7vIoSRzZJuv21MSOC0
         855uyRoDyT8Om5TB8qazJkSYxUF1SjVwGuPrR0H0l1bSLTztHQ1T6gkvUsQKrOf2zzDq
         0qIsk/iHp428YLPIqQiPlfD0NOXiuHwPelLYeEBNUJw43nRRfNfNqUxbpqlujZD117MT
         1qufEQLR0hI8kFB2Kf0LhRbP3nV3hNN3WybSaY0g0VYRf8kq+4koOEBNl09ny9A+JegK
         7N8K3lTeVL4nlRIKjzwHlG6Fqn/456virw75qYE0YNkcHHb8V7afVzxfbsXyyKXi57bd
         U1gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549232; x=1791154032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QIJ+NAQNwQQ8hmxlSZFAjXknCZBUfMJn51nkt5PbrzA=;
        b=puL1ZdvzDYmudKZIuFOaYnWzG342b+nzJQNuuZY82V8jaL+oJ1dKweO+f2avwCLxtL
         YA92OIzOPmYat7HWruZTV0XxaAsjtHCrnZkiFShFO5BpgrkWycNT7vhOYH8wbPuIz7/J
         vbk/Olp/IloFqZq1LIhdYI3dEg5sD+SaY7jb7W7X34GCWRpjOLBmIEW6zN7UxCHh3hJO
         0kDTNEhcBCUq5v3odU0s8+uyGA+kL7KA64fHltP1VCmUl8zrrDQLp1OrX6wP73Yrfry9
         SJBj7Qsl3HPLmf/GAECXK0fziXMq1nb4nEVC4/Bawv8V3FxA6hauMrzfWaWp0s0BeRS3
         TCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549232; x=1791154032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIJ+NAQNwQQ8hmxlSZFAjXknCZBUfMJn51nkt5PbrzA=;
        b=nVvxg7nnONDBziNzS7tqbDx+q/7k7jwHhcUDUUqAbhoWC0LRdPHPh0qHMqFyWkPr8v
         jXD/x2iA916+pNMvDFRNu+jtQMQ0TxGblaEDkQmKREFvGj2HNg69uxBG0DpAbm2zxX8E
         C+JIa8H47YV0zu0eKIpcxMytwaXwMGEbihiwh26bFhAcNhNpR4gmv1SNc8Rf6A3sYZUN
         tCZ5p8efjjrkQrJxh+tQnESstsJvdg77gTTE5Ah/01DV3pI9xOPgYglRaWt/Y+Iu1Tug
         Q8aKSw0DPYHBkhNqOwmcz9oLRNh7MG+dkf+l0YwlrM12abKGQOI8Vph6PbSM8UU+2jBN
         Jxtg==
X-Forwarded-Encrypted: i=1; AKwUvBwbp1dLtvI87/g0+REkncVh/kbZwjDMkFvsLgH7W2t3SNkTFfZGQ7gbRXKwS/NmV9ZfiJTXVj7YDhE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK0GsRlmaDvi01hsjZIz2zW1viSoiOtcyuwyxS/dz6Yhm7MAG4
	qnpIiwH0GoVTmpj56fyyW3RtsX4VFiiFpcqxWoYPIQWYQLpJL/4gNpsT5Y5sok+1+Tjhu5Gacpl
	UMWyj4f+4jpmh56CmWgsLQ1Uo4PC28MA=
X-Gm-Gg: AYBFou2RsPrpV31FUfW3msvK7v6stZ6N0LH6GGIdviYhlPvRQrR+2v1mbkVBnoeoLgK
	VVbLAHdkrfFq4XW1WO+LW8mU5gn7zTWMuVVQHSH/1AxkS19cagMymxolFFAWov6lRkz8sTTTHVJ
	SXZG1lYt/bK8soFRgzMKP0rQTXLIGJMpoybozcMwN8p+O1cnvqWEpeF+VkdxC/68oWgLPQyg058
	DG9oSn6wG59gP3WmIhf2nfdfCtwz+n2bmTCvyZqLh1L19/tJQypgKcE9FkuQA5RTz5v3iHui05f
	e1w3rCMpzeK0hLp8iro1zRILC4bB/wKcF5YbXUTqk5o87nqjln3Nt6LAj+A2h0vQvZ6kaVrje2x
	z9l3MYPxLJw==
X-Received: by 2002:a05:6402:23d9:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6ac8dce626dmr16296a12.9.1790549231274; Sun, 27 Sep 2026
 15:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-18-alistair.francis@wdc.com> <20260901012040.554EE1F000E9@smtp.kernel.org>
 <20260909013616.13993627@jic23-huawei>
In-Reply-To: <20260909013616.13993627@jic23-huawei>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Sep 2026 08:46:45 +1000
X-Gm-Features: AclHuK80qnvQONQBTNAnvCROC7Xx41gEGXL0iR9jU1dQigho_4UbMx7DCECDSXU
Message-ID: <CAKmqyKN3ik5nHvRVEdAb96+CjXO8x53bFNsKMdOUWCWw-4Z2kA@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] lib: rspdm: Support SPDM get_digests
To: Jonathan Cameron <jic23@kernel.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
	linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:36=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 01 Sep 2026 01:20:39 +0000
> sashiko-bot@kernel.org wrote:
>
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> > - [High] Buffer under-allocation for SPDM 1.3+ GET_DIGESTS responses le=
ading to transport failure, transcript truncation, and EIO crashes.
> > - [Medium] The GET_DIGESTS implementation validates the payload length =
but completely discards the returned certificate digests.
> > - [Low] An undersized/truncated GET_DIGESTS response incorrectly logs a=
n 'Overflow' error.
> > --
> >
> > commit 7b16689f564246befd0f0c43fa0d4515876746e6
> > Author: Alistair Francis <alistair@alistair23.me>
> >
> > lib: rspdm: Support SPDM get_digests
> >
> > This commit adds support for the GET_DIGESTS SPDM command.
> >
> > > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > > index b78086c753702..131c22319b262 100644
> > > --- a/lib/rspdm/state.rs
> > > +++ b/lib/rspdm/state.rs
> > [ ... ]
> > > @@ -612,4 +630,64 @@ pub(crate) fn negotiate_algs(&mut self) -> Resul=
t<(), Error> {
> > >
> > >          Ok(())
> > >      }
> > > +
> > > +    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
> > > +        let mut request =3D GetDigestsReq::default();
> > > +        request.version =3D self.version;
> > > +
> > > +        let req_sz =3D core::mem::size_of::<GetDigestsReq>();
> > > +        let rsp_sz =3D core::mem::size_of::<GetDigestsRsp>() + SPDM_=
SLOTS * self.hash_len;
> >
> > [Severity: High]
> > Does this calculation fail to account for SPDM 1.3+ fields like KeyPair=
ID,
> > CertificateInfo, and KeyUsageMask?
> >
> > For SPDM 1.3+ compliant responders, up to 32 bytes of additional fields
> > can be returned. Because param2 is a bitmask of provisioned slots rathe=
r
> > than a count, any device using slots >=3D 4 will produce a response siz=
e far
> > larger than the allocated buffer, which could trigger an EIO crash.
> >
> > Even for lower slots, this calculation omits the 1.3 fields from the
> > transcript, which could cause a permanent signature verification failur=
e
> > in challenge authentication due to transcript desynchronization.
>
> Nope. Feature turned off by requester not asking for it (yet!)
>
> >
> > > +
> > > +        // SAFETY: `request` is repr(C) and packed, so we can conver=
t it to a slice
> > > +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request=
 as *mut _ as *mut u8, req_sz) };
> > > +
> > > +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_=
sz, GFP_KERNEL)?;
> > > +
> > > +        let len =3D self.spdm_exchange(request_buf, response_vec.as_=
mut_slice())? as usize;
> > > +
> > > +        // The transport must report a length within the buffer we p=
rovided.
> > > +        if len > response_vec.len() {
> > > +            pr_err!("Overflowed digests response\n");
> > > +            return Err(EIO);
> > > +        }
> > > +        response_vec.truncate(len);
> > > +
> > > +        let response: &GetDigestsRsp =3D Untrusted::new(response_vec=
.as_slice()).validate()?;
> >
> > [Severity: Medium]
> > Does this completely discard the returned certificate digests?
> >
> > The SPDM specification mandates that requesters compare the hash of the
> > certificate chain with the digest returned in get_digests. There doesn'=
t
> > seem to be any storage for these digests in SpdmState, meaning this
> > cryptographic binding between the get_digests response and the certific=
ate
> > chain downloaded in get_certificate might never be verified.
>
> This one is curious. I can't find a reference to the spec requiring that.
> Digests are a short cut, I think you can always ignore them and just use =
the certs
> themselves.  I couldn't find any text requiring the certs if we ignore th=
e digests
> but maybe it is hiding in there somewhere.

It's not in the spec, it's just a hallucination

Alistair
