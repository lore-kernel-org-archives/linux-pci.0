Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608694;
	b=KQMRBR//6pKdrpUhfD7xCdSHQVcX2uqwaVos1OAMe4lfaWVBvLKfpov2GIzEqRzf7PvL
	 A9Zo9+6q+2OapI6Tc1Y0ch0odZMUjFIIq02TM1OuYfHDXBg05ojHXSExzJO3ZX+brHcl7
	 9y80urciqBDNwBa3d3fIB/3lU2Ef9XmQeG2X2/Vctb1bMLX/5djbVUOdX4yTjVMRntirX
	 G/C/uYIwFbkpttMurDXgOxY0WY3n+Gkaaw0jSy9LASdG/mwjzFa86XcrU9fD5xjLcwgM3
	 S/x+Rqy6SYIKMHTmKcisZN+kOR4fCRSs2faQs44g38sSzZbUYoRKggaD/5NQ7u040JA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
	b=CFW0tlc+uRyZ9+1HcQoSYEDDiegNOsYL8R797PTnrJ8NUtHMej3ABbLppcFFaiFyo1q7
	 vlldz0OJJJdYdqIGujxu2KKYrZ61xeI7Okfsu/rOBZjkXwZcmjkdnPsCIO07YD71yGgHz
	 oG5vRv4c1gdecFbjixL2RnbmTfcdDTSgXWTVifI8V/g87l8l/mhvtccIKRYI8ate33abg
	 yGfRDDO2bgUkEgvatodzDBkowMGy57cZ0Ou2P1lg/TdXw/AjSbTpV/hUhC24NXZemZLOL
	 NSrkrG2L/G1EFHQVMXXm/A4slIIxyFe82nZYcPOksa40t1Ng3gKvHmRIJzxGFvNwVsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HlE8O8AN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2EF606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF2EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HlE8O8AN
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so1465388a12.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 11:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608692; cv=none;
        d=google.com; s=arc-20260327;
        b=VvSG4XMgP6x7whuL2S2AT5NNkeiSqNXFrdbsOXIrufJlmVR3/DJk0iDr9Q/kJnfuz7
         rkzyzdqIgWf+WKLAraN0VrbYwIMR+mBMtrMg9vy7WCIdHQ0RvJ8XII02me0/eGiCh8P+
         /JLDFoOt3R7u01QYfHnPuiTD4BsRC/TH/KVkohCXB+HiF24NtA9kSN6hA0MwWGtuqdyw
         3PNaNwJSLJZ0EnQ1R8FMHNxljfOiUYoBU5SdgM9Sr9moPK2dNYEuEshwL/EDeVSJX3Vx
         p/zpmZCtY2MBZ1LCZkFnfNlYVAR2XyOjMh7pedmw3tVqQM6mubSwLwRKW6JeIOttIjSL
         5dDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        fh=dePFsug+VMnU99LtpJTEIPmX6AC5f1A7Fq6Z+gEAyy0=;
        b=PIijezKy3Jiaa9sTjkZrSIsADz923D/qPHpBQsdzX4ZsDSIykjxZeP0EtfsnFqV1qx
         lFElmQWOi/sWRiB4Hc8afjtG7QI4hYIz/TOXwockreaH9ZMU5GuCHP1JDExGBw5bt/tA
         AtrSHkZreQxyOVvj6pfTHqfoQlWUuHDZ7+GZrlZOcQOCGReLkundtnETa2NeLDPRVkdS
         ImXADXNsUIDDWYA2w3V2M2Qhkvr8OcUuFeaegMdqtMDoUgd8UuuU2S6aClX4ecjMomg4
         61g67aQOFBqB5EikcSxEua+TJui1+sgzFy7UuR2693MRASGwl/4yDZ7lop5Y/DeV4dmP
         9p/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792608692; x=1793213492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=HlE8O8ANX0EKpSe16g+iBaKuq+PflNI/nF8nfZx6q4OaNXjnD3WcfTP3ZxUZ6C5yww
         AQBlVf8uKRAHdsAZlJ3nOI2KRDtgeKEzjh6KweWDxu1SToMmLpwutL5+Lhr+woZoPbMT
         N1VnHlS+CynNKAT7F1IUt5thcgbaiveM8ggBR3Nw16XMDjcQGNRcVcNo5SDcaGJ27VgC
         SQZcks2KlihqbrkzWQ6XLWFtJ/xz9Gpgi9JXe2qQ02aMC2CNEezI26fvbSwiRyYprEUe
         g6GxU5sGPGr92AGt2GfoO7lQG5xEts7k+b+8LB52OVC6Pn4O+EIbicTODb4yWZNAA2oj
         0ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608692; x=1793213492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=aX1dr5cTLGLdLBXjdFFRcWTnrIzPqXqybVlpqVHrDtxFB02k3AMmQ5EVutDrB0oNp7
         Oi8r+q94uSaXndkSgGpr7t1yMwWjJg1duXMYzku2wH9QL5fb5ndTTh+EwuLLkqw0x25D
         VGiU+dzgbyI3L0eWGReHhqZjpM0ziFro2tvAKK/c8cMZUTpKkgLqyEg52+30b+sp3gBX
         tK1OcO4jkwfBLFyYuYKrWb4rbDWyhmV19BBRf3q4g05xxQY/HmIm267fyIpxqucKIYR5
         ACKJ8wIzs+i/g48utRGSg4ozJquhTEsQm3Q6FNIfY77Xjg3Kto+FeRvsk4HVChPCBUgS
         VBOg==
X-Forwarded-Encrypted: i=1; AKwUvBx/Q5dTbLqv+SdOA2p1I9AcLP6/Ft4n314bJKuke8ZGZT8k1rAP/JUuE7RZrsAUMIJNcnSIr81Frn4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLf9JpbZs7HecVb+yV5AyyWFmCT940edz6CGJ7kV5CgGzK/BhzY
	+2ROMMWkPZzBWcj+mK9bJJ3EoKXm4JY2ZCiq2ZhPOg3s4LeN7lNnHzpY0dXlLqmhQP6pq2JsgHJ
	GPSsSij5FVv4VzQYTKO471yQcGhtEMQiGOk8czB4ffQ==
X-Gm-Gg: AYBFou2mhIZk9oh57ioiDuTHkOABcU6GKGKdNYJliKhhIU2DsVZrcmbT6imqlV4oPwn
	0Ra7+d0fnUMnFTt9+PAAr3/T8czHmqlYaZcBFy8HdmYs2D3wfjd0EpJ+46+LO7LCIUbjJjd5u4L
	LuLK65PQWczQZo/sKXFiyrdchcj9eG5GPFTXeFsGfYC0JanLB3okMgoSPjz+XluwwNoHAJ4MU0x
	xkhVTO+dCGf+B1KjzPdjvZN/WgHILoNiEBd74Ne7x/lyRdTbbX8r3VB243o7NHJAO4ZzUrJwB0D
	KkWoODeMC/R/7kdHw9nfWQxcQPMT6pf7yVQsUVy0r2xICWsj8MyaQqavzDTt7rA7/NzkRSjg1mA
	IBb+Tftn0hPgiDqOtvG3h5ayL2OszMy0KngbsJOqhiPM9kMOd3nqj3R5VJh+sKrUDQQQ=
X-Received: by 2002:a05:6402:241a:b0:6b4:1df2:244e with SMTP id
 4fb4d7f45d1cf-6b41df242e6mr53870a12.38.1792608691873; Wed, 21 Oct 2026
 11:51:31 -0700 (PDT)
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
In-Reply-To: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 14:50:54 -0400
X-Gm-Features: AclHuK9td__2XcAMViewCe_NhDoA_TjTC8gr4y8u3SANqGewpEKZoTgIKv6iXME
Message-ID: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
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

On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
> >
> > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> >
> > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google=
.com> wrote:
> > >>
> > >> LUO and its file handlers validate handed-over state with monolithic
> > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serial=
ized
> > >> structure, even an optional additive one, must bump the string, whic=
h
> > >> breaks live update between adjacent kernels. Replace the string in
> > >> struct luo_ser with a feature header, so that the target kernel can
> > >> accept or reject the source kernel state per feature.
> > >>
> > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > >
> > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > struct, we only need 8 bytes instead.
> >
> > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > over-engineering.

128-byte per serialized struct is not starter.

> >
> > >
> > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > bits of the flags indicate whether an extended flags field is present=
.
> > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > that yet another extended flags field follows.
> >
> > If we will have dynamic extension of flags, Think about this.
>
> To support dynamic extensions in a backward compatible way you want
> something like this:
>
> struct luo_feature_hdr {
>    size
>    flags

__u32 size
__u32 flags

>    extensions  // offset of first luo_feature_extensions (or 0)

__u64 extensions[0]  --> but the size should be specificed in
declaration macro that I showed in the next patch.

> }
>
> struct luo_feature_extentions {
>     flags
>     extensions // offset of next luo_feature_extensions (or 0)
> }
>
> And then an example serialization struct would be:
>
> struct foo_ser {
>     struct luo_feature_hdr header;
>     ... fields ...
>     struct luo_feature_extension extensions1;
>     ... fields ...
>     struct luo_feature_extension extensions2;
> }
