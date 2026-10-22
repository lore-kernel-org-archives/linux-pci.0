Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792632406;
	b=pVcyOTxzaQ4SxMTrtNTam2qnIYAyzhPp7Z8ZO1BIH5UymDQHBYfMgGlD1eCTobcHNhiy
	 q8CCxInBU14jQSRs9smRFqnjDgtoryp9UDIJyZezREGns4l0AGJthBZrMl2HUMX1e5nVM
	 PUmQ2GW7hV6R8ppblBYhcCz3wE5rzR3Q54zInAVs8l3LnRMRcEHlgIXwWZzX5pO7Hg4u7
	 Bo2OuajsOP0blFvgJ8XqxexxmqWPGuVeHZeXg8ipCV7eMdJnSD+WFBTEE3sepD70F4Xh2
	 LiBNnJK7lFE9MlThkeRXyvlmfZbhVbLFJ1Z0azb/hJdJcR3plzrW93Lr6KDHbDQQaPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
	b=W+upFyOC1t6XHr/WiloaeHatZ8kHbEgmUoc/PhZu4jsZwGziHag+yiCEj5f7TYai+8Vg
	 gdfXWYnonCxwzNZjEVYovQ4uN023OIW/UaF3XD522Qr8G65CgzEh20P1BV09dvrfKDpKn
	 sXQh08rHLfbb1sUsnw/K4wCes+jj6H5NGJuMVtJj2v7+nCNGlboJmA6XiqrEquFRJsmmH
	 EljirTTxyO8XawlW1GqBqnGySrIcqqtq0Pu7JIPJmAkGhDmBwed5AFFVYw9VZWexyBzWx
	 uKvmuwksbt0HxNNHFnQ1XnHO2F+lPRr2tXxu7trcozARyGt0XmnQkb+L+/j80NrIGYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UjasCW3N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B51606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 01:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UjasCW3N
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso1997400a12.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 18:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632405; cv=none;
        d=google.com; s=arc-20260327;
        b=hZ3c4XiB8h95njKvwXtVIlp2E3opigzf/m1DNlUkZAiyg8Q8t78HOYZIAknecn/Fg2
         jYV35Xic+pQ2yef/dHPoPJ7YZWMc4gF/wnUeWqUJWdSj723EfvigvWpYP6FjmhaHjgyO
         bw9V7tR/bb9l0P9+Q4Xz+Pbngmoowxggjzvor80ilErxGCvaCvizTwxIX5FfaxcXQQx7
         P57gRer4Pbk1BDkw7VcfPpIOXoqwhITJ4q8xcNi0qen+Lon3gTBSOSMFO3YCgTD/+uJi
         TdVJL3wa4LWep2bQZnJ7chDzzf6caQk1FxtjHUX3G9lWy1yi/Cb+S/7x1Nr8U5Y9p8Z4
         bRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        fh=naAIcinsxQ5oAlyw1PIgg2tkzPxByhEjQDNGQBbiHrU=;
        b=oWJB7NJBL86nTX4fvUzjaPKYuBg6ioIkqJ86EEFW0UAZEdVNDMnGpX+hlkF5G+WwWP
         wGIsjoiLnxjQgbPMoB8qHq3bLYjqpXmMMEFDbhAqAOErCrmn5ThdW1xsQ+YBkytj5J5H
         mhC4YKMTCP+N8cmNNv69DCVhLFkN192mlz2ciW+PmgEXfpVokDLXUHNxbrnbV4lBOd5W
         YYHxO9/YZj0ypUbgKBACW7fEhxNPbbBCng8zPLXXkCCa0aC17A2dFqZQ0SEz2yPtZrOX
         RSzYMk7zBK1HfLWDeaq+L1Z2d4U60VwNhvt5sEGVBoIPMsTcrCYOD0Nj2XAhfST0zge7
         GzpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792632405; x=1793237205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=UjasCW3NpozzrrA3uptNAoyxN3DqKW8HmkXQNxzRnN/JTz/QnCPODSFsuQp+CU15iz
         1LkOjKGsHN11814MpjY+/WDEGC7whEmqGfcFHZilFU92hVZmd0P/jDJQsz1R1tiY1v22
         QEJjzFYaVhhlpS7AL3b9a9Eh15m7QtFtTO0PXMi0cpCfJWXwrmO20D3TU8B5QgOQt69/
         SNKIxNxzV23JLqHMuIqF+Rxhbp4ACGvPlVLutcB6tch3U6K8bn3cBIdJedvQXqJoWms3
         LTcsARGJuNIIBF49+wPKcY+NHi+T9ZqJmZfG7n2YznT0MSfnTRXZ9Wu7/w8UUAK2YMpN
         qYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632405; x=1793237205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=ffMyXfcM6TS6BGKmMB7KOh/sIRDraaEwLhJDMRSZjFkwK3J6y8rDZzdFdbX4lu0jIg
         UdHzBK3UvHLoW8WhOfoltZ6Pk+LBFQ5krUw+OKqJDJ6AyODYH4f6TDQAL635D6idAl+i
         dGtKyZXElmbrP5xtDl6hWK313YieAtBG31SZURLACa8jQ7+1qVaQxbT9VU9BavL9/SQ2
         7+VXTerVcY2tltfoRKeMYqF1EahU1JR48TN/xm83iHxiwuA3KTB3mN1zNx4XOJL/sMyw
         g6Fhds6oyNoVQVjIOL1nQJON7hoQ75ktaGB7LUoEWQPEHxIhsrWtDzGyk6q2rQNd+jLJ
         GUCg==
X-Forwarded-Encrypted: i=1; AKwUvByz4Oivzitd3kalGOLYGCcokTpJYXycOfChugYOgn2QvWaS+DZcejgnf39aTTTxbrLno9S0qKkq/SU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9y6e6bK1aXEIFpB/b/x5ZNMvdioWYVC8Roa/jMX8u8kUi/QLQ
	ttqTkRCpApTG7sV/mDoUersI7QBZ1rp1skmTNJJiSyOtmX1p8kTJMY9VIjqJqGQMJ4IxSY7acS7
	WAMM3JKhybNLeagNehgRNCJI49iTOFYdG7N60nWq1Ng==
X-Gm-Gg: AYBFou36sF4XU1PxOnj7PjkAKzjoZQu5QXuuiVOC2J77bhklDxthxhdd9mTIX5D/umK
	d4b351GVBZ8B5mZqLRr+nsjQ2xm+2tjhHlDUWekwQf85inNUDM685zjveGJ5O5qWAakTNMSsQkc
	8tkN5kQRxyUE0pvGk9IGe24GG2gVQyQCqyGbxFv0qxsSKkqA742gaDZUP9RpbgSJxIAhZPodBTg
	1ASldqqeRCNtPCy1oHXyWiSABEKRPt/9fMQZyIN2NiqlIPPBbjniYn0zV0dYH1fO5IC7KGRZMu7
	A2ZQf3SWBKbChxayCexP2XdDIIgNSEf0+7PpifVBzKVXgaWOlfbYQeDdRqdaVNSeOnEut1AXCvG
	UfBAxwXo9B4+gFqF8WIn3Hqn3wwnrgy7ZR8BIT+au1FkFUe8oymc+aqmYNICzR/RkiBU=
X-Received: by 2002:a05:6402:2801:b0:6b3:a1ad:ef6d with SMTP id
 4fb4d7f45d1cf-6b408dcce19mr2969744a12.6.1792632404378; Wed, 21 Oct 2026
 18:26:44 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com> <atlKsD-aJB3mJr2j@google.com>
In-Reply-To: <atlKsD-aJB3mJr2j@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 21:26:06 -0400
X-Gm-Features: AclHuK8Appp8OBdUFGLxu0V1hBTCm-a-9f142JZiexa4wOQOsDrRrU21F_J0R34
Message-ID: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote=
:
> > > >
> > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > >
> > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@go=
ogle.com> wrote:
> > > > >>
> > > > >> LUO and its file handlers validate handed-over state with monoli=
thic
> > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a se=
rialized
> > > > >> structure, even an optional additive one, must bump the string, =
which
> > > > >> breaks live update between adjacent kernels. Replace the string =
in
> > > > >> struct luo_ser with a feature header, so that the target kernel =
can
> > > > >> accept or reject the source kernel state per feature.
> > > > >>
> > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialize=
d
> > > > >
> > > > > This patch is all wrong; 128 bytes is far too large. For every _s=
er
> > > > > struct, we only need 8 bytes instead.
> > > >
> > > > NOO, It is not. It is intended to avoid complex mess with unnecessa=
ry
> > > > over-engineering.
> >
> > 128-byte per serialized struct is not starter.
> >
> > > >
> > > > >
> > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i=
.e.,
> > > > > 30 feature flags + 2 reserved bits for flags extension). The last=
 two
> > > > > bits of the flags indicate whether an extended flags field is pre=
sent.
> > > > > Each extended flags field is 8 bytes, and its last two bits indic=
ate
> > > > > that yet another extended flags field follows.
> > > >
> > > > If we will have dynamic extension of flags, Think about this.
> > >
> > > To support dynamic extensions in a backward compatible way you want
> > > something like this:
> > >
> > > struct luo_feature_hdr {
> > >    size
> > >    flags
> >
> > __u32 size
> > __u32 flags
> >
> > >    extensions  // offset of first luo_feature_extensions (or 0)
> >
> > __u64 extensions[0]  --> but the size should be specificed in
> > declaration macro that I showed in the next patch.
>
> I think you may have misunderstood what I meant. In my proposal,
> extensions is an offset to the first extension, not an array of
> extensions that immediately follow the header.
>
> If the extensions immediately follow the header, then the number of
> extensions is baked into the struct layout. Every field after them sits
> at an offset that depends on how many extensions there are. If we ever
> need one more extension, all the fields shift and old and new kernels
> can no longer read each other's struct. That is the problem Tarun

We can structure it cleanly by nesting the payload: something like
struct { struct header {...}h; struct serialize_data { ... }p; };
That way, the header can expand dynamically at the front, while all
fields inside `serialize_data` stay at fixed offsets relative to the
start
of the payload.

Since the header size is self-describing via continuation bits (e.g.,
the last two bits indicating whether another flag word follows), LUO
can
easily compute where the payload begins in the incoming blob. This
keeps the implementation simple, avoids linked lists of offsets.
