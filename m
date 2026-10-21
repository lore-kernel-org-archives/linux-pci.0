Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608448;
	b=VZySlwfVf5Rn/zGNQjMTJcZueHyzkccu1mpAQQABCPwan4PssrRppgz3KUWxZIm185PK
	 JJlGo46gz7Ndy95OEfVrKg4cMSP1fz6v72TdyEWNNeeMQnczzxnWnjqhCp4t1i+baKC6L
	 WTZapmeem16T1vzgb3iTAsEmyUKJQpqu+n6hIQP4+Fp6UHghP08q0ZWdAdCvzahwxxXOq
	 r+UZMi9bnKzHySZEzkmQXtZcVvKdLBcNLhtaTUXT9ftb8OOYyBhefOjHSA1sYT5krYfeA
	 sm31ch4U/m1N3fQchULb4ohqWXIVEQMA/xPBmVs/QsGUcV7LIOEaH16q7a8m/Fesbhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
	b=rHG8Lgl0Hxrwdc6AfzexFk8oqBYb3fiuJ1rG2pHCtTYzo9TCagLUua/EV1Ob9eRius0T
	 vLnY/TuGpUtApRUSsENi/SenzdetXn9j6rvXF7lNClQHM2s4EqXhAV7Z5+TlZ9uB+LfP6
	 ZDrDY/HM15MdQ5H8eUGGFLBCk/8xF/Owl3MYW2NcxJvxTAf8mgHOjoMQRViDMLtNq6Kmo
	 m2U2rPLkYFWIGRhvR+he1jkAqyxmMTQdzcbrz7ZHAtXPTzl4t0hpf1PyCKK4THGxs51HR
	 rYVm6G2lZwKzcjwj/nml4Fme6xVn1i926pkywWYdbVCC+jP3zvMTP0pB1zAO0PTPLvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DR2OOg7C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C7606A31E
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 18:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 374C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DR2OOg7C
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-188406bb948so595774c88.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 11:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608447; cv=none;
        d=google.com; s=arc-20260327;
        b=TmmRKcITPbB20USus5PAAAh7VfDtS0FiUp8/m09CQdiboYbRHM79UDQGNmKu+33nkl
         RNmsVGpdAq3lUnIb3n256GF7i6HTooklGBL388RmecruuAitzKv5Jz1vQz6pqcbDu/u1
         Z3JEs9PgQ/RcRrqm4LSjZTMXWu5B2C4RcjiZefyHcCKynVca6W1phdg6SuTJKUKdxqhJ
         LSJUuUtCEMjDk5P930oboA3gJR7yNRnmuP2I9QKjbkmWwNjGB1uRJqdTPDSj4kxmQ6cJ
         EvCRnw+3mOi2kIIICD0K/RzmEVnJpQLqb9xRxHUPcvxHKf2PebE1CXYySXc/wDjhhOTS
         uhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        fh=VEhzfc7IUSbZ8mAE+YKa+O7bjhi9Dm96Q5EHP0G+9h0=;
        b=GffVkb+XG5r+EHmAlDkKYqvK9g3cHMDHZ2nJzNH+JF+iBt/nmpS9I5/YA81ybZ7QKk
         bLJqxolieri1twFvqmdKg6RBWmhLHVo7NYImw4Po0CBoygdaVOd9nphkjCuZitwbB/5z
         dSRmlA39iO1jksXVHmYd3vsGw7Wc6oMSi233vxaIlkSIkcWCQYX5A3oa+vsn6aFG0Z5L
         XcaVIelbBCbZufFR7nHN4399G2xJeTwm02msoyvnvNB5DiSzGkrTyFiZ8xu9pDcXm0VX
         F+o64wDmmIycUTw34ofC6zi/pQ+jj37gIWtzqNCEB1emB8xeN0oHB4xKJEPxGh01bVcl
         pzzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792608447; x=1793213247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=DR2OOg7Cokd9wnC8bGWcf8lnE2DgANN4OCX47zntm6YeIxiIKdkNlSyMxGIzvsC8Yi
         +nu2MxLclS6ixH5D2q6uhakgMGBvLuPrRsev9q7rp0TNMBZWLaYyjH6GNRMU3+3bgYS+
         EChGinr+36jPwXttho3bWPBhPi/180HSIH22UBjN0HNhSsGeFnp3Zp3WBQ9ISO4qaWSE
         HVGLY8cSkGFARoh78a43yh3zx5g3O2U4glOPTARO9x5/Sker60qfPLmgksJmd3PLAlKk
         4Obt94H05egCn92XPZL1YpBXXtsyOexkNhnCmVkqiwNzUFxWUOBeJaGGzRVlc3miZe/8
         0meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608447; x=1793213247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=Z15Sa//tTdkxeVScBhi3OQIsInboTJXuuPvCCXw2X+IIEtPQrZ0p12oQEDJ1qOTibX
         U0ZMe7GO2L16VXxkUwuvuYKzBh5+KW1ZQL2kw/z1TDd04w8c8MrA7rVwqM//hRdUQH9J
         ojHd3djqXGSRoADBi56XAG/uGIP12wSRfhlveb+sntXcWM+ZAHGct/uzW2FZMz342yAS
         v/Dw8TDlsnjbY05ZRA4ZupwllcgyXo7VIuwk0S8krNL6hU7esfj1HxR4Hlv7DcCT2Jv6
         PcJgl+Zp5HKdytot6khzE7TZeYk1s7d6vExF3mZyEnBTZRffomYFCmZ2gwvq67FS8txW
         cWaQ==
X-Forwarded-Encrypted: i=1; AKwUvBx17XAO5iAmNVtlwKoURrA+J6pvZvfAOyuubb+2PR3WUTVmJ5msC5uiohDFbZtv9UnNQDvkf4y9T+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZoBqO35CM9yQ4hoUrcsPj6v+i1jG6B36OWRpR1wpB6wpdk/O1
	I22DNaTv/c1Bm6/Lip2dLGx1m7Y7RbRTQ8AYC/PusRs1B0LG55qU+LHQBA4cNqVt6jbOFGMpcKj
	wQEbaouEJUqjSlpL5Q6EBBRg7WX5tng73H0igAcTq
X-Gm-Gg: AYBFou1w7Aq8tiB4dJ1TtZnJE11mU4eUlyB8S+pNOXA/AKTggS3YcEP+vrcpG/BOE5J
	oewg5VO98IVoeLzkrLCQwRlVjaCpwd4YWFoKBobcslSG1xZwPqTr+pM+xTJ9Xs7ATLVoWMQKql5
	XWmVv0Lj/JAaji0BFL0OAfLaChHX4IemwCdovDzouJH8xvat/dXGHTzMTJ292fACuw5+bUn3v7L
	eqRj2jfSIR69nhKv3T1VAQcPzsRCBlin7NtbWE+HG21vVlyZqynm1PQzvd2nib8lNjA6OnAQsa7
	Zczm/hM0YYWVZhEPNKoJuZj/TA83MYKKEa/jtgJSwAAYSQ8TFXpwKpwOATez/Vv7JV+4IQ0d4Dp
	gvQYfuZOKKRzDwYtjFg7mjwf2hRb+twYlW/EoOPhuzG2qZHNSM6ts4/4TuN0=
X-Received: by 2002:a05:7022:2507:b0:14c:efa5:ee7 with SMTP id
 a92af1059eb24-190a4d18cc9mr4696437c88.14.1792608446024; Wed, 21 Oct 2026
 11:47:26 -0700 (PDT)
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
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <9huzecdi6go0.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzecdi6go0.fsf@tarunix.c.googlers.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 11:46:56 -0700
X-Gm-Features: AclHuK9GVWu4pH4tc-A36maNXu-EHT2uwChCmCT-hqS2EBFk28gxkLJBLwcVEzg
Message-ID: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, 
	arnd@arndb.de, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> >>
> >> LUO and its file handlers validate handed-over state with monolithic
> >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
> >> structure, even an optional additive one, must bump the string, which
> >> breaks live update between adjacent kernels. Replace the string in
> >> struct luo_ser with a feature header, so that the target kernel can
> >> accept or reject the source kernel state per feature.
> >>
> >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
>
> NOO, It is not. It is intended to avoid complex mess with unnecessary
> over-engineering.
>
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> If we will have dynamic extension of flags, Think about this.

To support dynamic extensions in a backward compatible way you want
something like this:

struct luo_feature_hdr {
   size
   flags
   extensions  // offset of first luo_feature_extensions (or 0)
}

struct luo_feature_extentions {
    flags
    extensions // offset of next luo_feature_extensions (or 0)
}

And then an example serialization struct would be:

struct foo_ser {
    struct luo_feature_hdr header;
    ... fields ...
    struct luo_feature_extension extensions1;
    ... fields ...
    struct luo_feature_extension extensions2;
}
