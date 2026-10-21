Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605391;
	b=t+4I8ias/pNWgOn1INxzbjHxON7CBfk+vCKXzndr1DDCqCVUJZEMV1j2WM+CTwNt1/hK
	 aM/Y7gr6ijJrEeUgKgYbNVyPWPhlOPQFTCVOK/SxSdE4xkoRR+bG6M/szWvMD/F/FBLh4
	 hRQgGrho/AtBYrtLxJJNFkbacW3wcHMUWDOx9EI2RcpZ+Ye1AUopIvZp1x113236sa65I
	 jJDiZxIxPDtVwWLnHKnAizwZixS1n58iJ48ntCsNi3qKFpDsWLUzv+lXp3zVdDIjBDTIU
	 WpKpjMNJkYcQalYaFiM7DZ1NVw/gBFX9x9Pr1/YSKQ7qo1s1S/pkS4Y7vBtkf/LsAyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
	b=j6vUf/uVpTcF7C11VadisDDCpo7+EfjjacOrhkWvHA2G5ZOGBo2yqv8bOwt4HdHo1N9y
	 Ckj280PSzdIsQ7z45tqEKkTVruNclPrhuEPOvlWPIVg0c56RGrpoULcu3Y+or9Aw6EIhL
	 l3lzTh5ioWW7+g+gh9J/441O3jVCnGO1tcMgt2Rw+hkIAwcoM0pLBZ+5xWRwa7j4jbtAI
	 ZxlQqtf6Dzp1DKwEd8jomCdu2Ga87OuHHaJXwtEnLo1aC5OkMqPY+At0DS6kXvuMP/xFf
	 M+XM0n1zgDxZwuAyGbQuWRYcxsCZnvUENwtK/QuuAA6iWbMB7KGbJT+Td5MCd9X0GDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CsnNkHId;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C1C606A31E
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C1C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CsnNkHId
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1709155a12.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605389; cv=none;
        d=google.com; s=arc-20260327;
        b=AnBJedpLgSrKjggCtjj9mrzRbkXSHM7JSFV+BnI9046bhn6jLRACMxRKhmnbHao/o7
         BNQ3SHZ5s5KS/LXQuks7OdFcpPzzWAj8QJT0oB7P6I9bxhAuF2KKSBUYPCHSdq/AHE4l
         FmOLGhrk0vup4tAf0xEb9VHy+YUtjRV6tK/61d1oNSoZ+htHaFBb2U+fXWeVRtKOC+Yg
         WOYazEr1ECfVgiyFkpZd057OheZGoALfZumCAaM0zh/6F5LLNGHbU5+CLJ2d6TlpULBy
         plzTQheJikLCj308RER60O1670BmL7tZnSHMb2kdKwZAWcnni8ilchXhqtFFeDLIh3L2
         xl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        fh=Gj5IhsKeji8hXZ0mrhsX1RNqGCcp+xriXSC0hXeQN9w=;
        b=j0gkSNM7skQit/MRu+Wug5leoVNkbDq9X9XDv6sTwU/PaLmk1R7L4VuSey7zVCy5A4
         MpnrvMc5g8wMMwAuCI/bXtdO6HOLMePqq++r8U+y0e2sbqR2smWtFFknN4ZthgFq2LMn
         FF26MGf/GAuAxLAbkpZicHOadqMC8Bdl/wWvxgzu5qpAtckTistfMkvV0ZP42Aw0+MkH
         wJrYtmDY91TLINSWY5UbW+7eSOFlIsAl+EmQBXz7TVdca/wylOK1emMQSjWCjIAt4a1C
         stwKklycGX3e539zf2UKiR5GHcpaCzPZ3AtEljp16UxIK/u8UhkO77pwF/6kf84KTkgP
         cb6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792605389; x=1793210189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=CsnNkHId/2HmaPxBHjb/0jR2Ogy9CW+152Se+WQyag2dh21j8P/RHssb1Z44QC5yWC
         C4QlKQrH5IzSaG/OPVbhWVM3PA/cIm1fOy/fqHgVzQMXB+wzQ3KobKxzNHWIF4yHaCSD
         txHLa8F1uvqOKW0HUcSBT/UKnibnqOmjYCzuBGkNyTsfn4IHOirM/RQrbSf1aiLT2X7E
         TgvGTfdyJp6KjZJ9KdiumiVokiBpI9M4awk2Pc8IDRALgaKADIzg57iXw0Hqhfl8ts2G
         zkyDtGt7WXsJ0Qmo6uDo8E2S2BXyQ30jWJlFRuBusxShLi3wKYksnzRG7ma3ngGkK7xJ
         oUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605389; x=1793210189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=d/CUGUOJqz6H1gfp1JpHghzT7r/XSUZxObXQVgI66UYnpSFHr/Pn/m9x7lvIrRO0/u
         4kQzUBmk3Ujq5kD/ZyEdIr6KlJY5YviuKIOAGZsvZN1U5GOzA40HsSCI+b/s1+zTAx4u
         dJ2MBGTlXQqV6uT9s16NCGia2feksIIyvJUJYhqEWYtpnJeV+A31VB92XSlTuNtywpe+
         6mX3jQNptyvFShpcUbg7vnrbVSqE6Pg0ToMlVCjRxR941+62uTpuAmTq0y0KQrWd4SfO
         1Dq9ioq+sNrdAnUrD1vnGLICsLSkRm1RFcBBj7XU6IRTnSG5Jir51Ox1DgShITc2SFbt
         mRYw==
X-Forwarded-Encrypted: i=1; AKwUvBye/4mOwRWJ+cDpFKZIFRo6o22udrZWAlopZOq8Tlw3apJED90T/H2L0TUk8GzoksU9bSp2geqEQxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJb4aDAsQBINWszuEqWGTenVmAZv+boCwKaWKPq0flkNgqAC3S
	t4xjqQkbbftzUboe4/JVrITxg+JJtENbIDXQicIO1RlOrYB8Zn+cEnVh+AsetnjBBH1O4in+1/I
	3tn7huqlOBgH5Ot3u9GSCx3s28WsNURt0SSfqr0P0gQ==
X-Gm-Gg: AYBFou3amtX42CMTPwZWK7SR/tNloSTZAktkCSXY5rmQQ2kvrzjEOMQ63BKNDBEgSQx
	GOKscC3j79jioH8ktkxGohpsDJlfFLsOmT0XygIq8q7PzkeSHyA9WFBbB6CFt/7AtiDvoWzJKtB
	vDUTZiZGbuxWTN0jaVkpGwl/vpO8I/+5QVTnJ4uZBBxLuk2ZXRYehENSUGMyD6UnvAHBhA5zjvW
	axK0n1CM/KDLEXtJ3kGyVucm3yWKAMUK7G+XIx8LPOviAmijI+YYDYehHffxfetieBJtvFzoWTe
	KL6T0u6tZzJsfLKGEWzV1967vwq+B2zmNV+LJCHnrJzvcb8SzOUARvLjPjEIlf3JnLFG5KCYV8Z
	FEecEKI2I6dzdR131s+NhMLaVgBJ0e+EfzFiV+UL1FZUjTOHPdSb91xTtheeu50ZTgto=
X-Received: by 2002:a05:6402:458e:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6b408e9f045mr1964734a12.11.1792605389455; Wed, 21 Oct 2026
 10:56:29 -0700 (PDT)
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
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <20261021174006.GU3008132@nvidia.com>
In-Reply-To: <20261021174006.GU3008132@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:55:52 -0400
X-Gm-Features: AclHuK-Q6MQhxMIMUURzzci_OOwzGik9EFivN3YqqlGA_5OHu0xT6GsF67-BzDw
Message-ID: <CA+CK2bDJzo44K0X-+5F77E9g2dmqKdwZvrUf-1SkC7ewrgEgzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:40=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Oct 21, 2026 at 01:27:22PM -0400, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> > >
> > > LUO and its file handlers validate handed-over state with monolithic
> > > compatibility strings ("luo-v5", "memfd-v2"). Any change to a seriali=
zed
> > > structure, even an optional additive one, must bump the string, which
> > > breaks live update between adjacent kernels. Replace the string in
> > > struct luo_ser with a feature header, so that the target kernel can
> > > accept or reject the source kernel state per feature.
> > >
> > > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> I thought we agreed not to loose the string too, it was a tree
>  string -> feature flags -> individual values
>
> The string is the emergency if we really badly mess it up.

Yes, we'll still have the file-handlers/flbs compatibility strings.

>
> Jason
