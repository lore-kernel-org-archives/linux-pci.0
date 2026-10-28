Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793208282;
	b=5oh4/DLOFFojto3ZqF/XI2ANOHkf7mqSAsiu1oFkYS0mJna4P/XxleDT2UQ0odsPhP1p
	 BgedEMlJ8nTBx+6A4De+7BkgSSK55L8tCNY8toNM9pjZ8kSMyg/c2Jbx//k/zHaa7tmLH
	 PqPX4uQy136aGnvah6YayKwyiHKpdqyb5I4KWhxL4vQ8lW4sifyEdCbD9AH5ru54ggLGL
	 2V4IlPVRXhH5v6KwckH/b2Zm3+MmWD9V8a8b0tD6uBXboiCoESss/FeNZ5pMkTGrmDSWM
	 APdyz4+8nVbpEyWN6YMhbjokVhv9aSyJREpZdVQ0nocbowx1mKgPSKiXHs1KWp59ABQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
	b=RQN5bPfYw1jy/2B0j8iXX6Ev5vZnh+eXSx0DR2uCgW/IkL1DBow9rqPI2RYVIWHPkUHV
	 jq1kpRlQ5BNkPYRkkBOBZOpJiZTxm4/PinULXdNLVKwidR4/eeoO0SvraQokYfbohhEdJ
	 nvVuEzCZ3XlmN0rEFuuzl8jISLUDxXpllsp7oEmwI7IHBjF2GQXbFHmGymEYtBW4DHEhF
	 oCnGJQMh7h/Yid+RIFQwm9RtKvQSdXWc4Sdw4qSvd+D9MIveXqgqMZsQHMeXjU3xur45j
	 CKqooeGqAotlw1UnXtojMPQVCYOkn4VvvywRZGlA1gFPbZYHpmjfWie1g/kKc7Q7/pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTEmwqKv;
	arc=fail smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D5606A320
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6D5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTEmwqKv
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1846bc43c28so1455408c88.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208282; cv=none;
        d=google.com; s=arc-20260327;
        b=A85mg7WJJOenGlXUD54Q67TDYYBphYPgByh+GI65cR0D/TlA5q6L3GTrOc3Qs3DH/J
         jgYg9MGyLqRtVFfs04FerKT8Ze31Jrd2FQrWo7ZD9QQSK5sIFmsCT+QrwdJ4LrfJ81+5
         tHFAOSFvNcgxdbtY7lpUxM9vUSwRvdD5wEG5KGJ3ZKXbw8uqqpEsXVePSVL0c3cBBxFe
         cywUbzhGjDiucAOeZRLb4RxDFu1Tq1K1ZvLYPHH6M9XtpmrwpuKllvtbyogACQW3pDlJ
         2SAWlEFDEqECvEnOxnKL/wQ9V5ieWIbcUAgxreeLh5apmt17FWVMhYnXvoJMx+ktr6K6
         yyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        fh=j2DHjccYIGFEmIzPh3eEBfn7RZ9SCC8olP7ai9/Dnck=;
        b=g81Oi9LLuyGc/OROnZv18e2nILvamtI1N5XD8MZEDEg25f+tWX+cfsgY+83bxkC5y3
         +/VVpVLgzKt1zZKGR0QGoJoKxs6JX0UzMcjTogBFFwm8NrFNhyrfAasWmTK9rfRaJQ0P
         amW0slI+ExGnnnV93fagBz1FqAB+nYm6mz3w050HyOFr8JKdK70ek7c7HBqHOfrOP6MR
         GD8oFgQoXvobGVmlP6JWyXqh5DKcTE+CSsjmmU4atDI4Kfnl8Jt8IeWfym3Dw4TaKhjk
         maiPxqR0iwdsDtxlUeaqJSlFKf1IFsGFDxytoSPeO6hNeH2geL6rap4uenGO7nvXAz1F
         GqBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793208282; x=1793813082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=YTEmwqKvUSdnC+hS4b0vibOxIpmGakM3GonBTipKjmgXAv02ptb1Vy8uP+4aUMBPns
         gZNosqX3uAXrNbcVQ8R9hdrBtd3oSu13hrmentv85sdRt33GEt/KoljlvKtg47NP/Gt6
         AhwUwVhxCmN0lKLj30d45Ypyo+T0SOx/hytd7VYgp+RromGQBh6bOr4sl1ec9H9aPPZd
         zNxKiJQ2yUaILf9HYEMWLXSrH3c8SJZ412vkomzSiqQiIESjeTooAznhU3TUiQlkczP8
         qFKV/bpX+B9T8G7m+G5/evMF641ACRS1xaFwPNKNFPNhiI/zMD6BE/r9ssZ5f6gTi54J
         0QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208282; x=1793813082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=UpAUj6Vgms6Zur7Lo7mheGBfxUDwfUdHitmTMxPTuYewKTYppUcXBT/mNk4+IiUVXy
         d/eOoVCMb35TtckU0raRmCEOl3kUp9Zty+ZQhA1+APPKAZkV6mfm5kJpRatauzhVmcDA
         Gqsp48QA9LwBUx1aXzquWSLE0VdhTETqPiHTlH/CpVipovEU61Y3HAasGKCS2L0c88HO
         QCyM1KoR7sJszG2XpGJeK3+hf71q6KxCICEI/ZhOxn7tJV0w+yaTafocgC/9IQb29P2j
         R4YYuxVlOa7b/ikFQ822voNrTecYt0WPncswTjcpn+8amBN7TJMHSGbK9s1Fner565d8
         fh7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwdNSrRBuo5cj8zeCT0NUL+0uBa1r4jekJHOsxxzTK9hN2SBUGbYTqnQYh3tF4GK7smk4euhpCi4Bc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGnaGrRYwDYeiGaMtYzmo++KRQFyteshGdGvyHYZhKhCXc7VEl
	AKt61h7o7tBDRRc9la8Xo4qBfqnesldieZfOMq5rWM/mAxV8fs1dnIB/p7exbM31q8DZNnohTq/
	G0zHrUKI1mH/396vdyAIA4DEImSFcy9hCx/xhr4cl
X-Gm-Gg: AYBFou11A9+BZYG9cGor5qBlFnaixH8roNOKNQ4tWZf04XH56YmJsrhZH3GSwowhNWy
	Nt/AqhO5kXGL+uep2NHuXwyhWv+vXC2Vs5xhRLaOJ61O8mbQM6ZAspckKwfsw1Lan+BHRemM5fB
	s9WfT/tBlBnTDKflPdapEwbklfLelFVDEJ96nMBnldL8GooDO9071pMmsYcLIf6qQVf6KcXi828
	Co5DcvOrRd1xXN6F3thgIWsZKinNvkNX1YgQK9/9NnUy0hFWQAzsj3iRdrI9N04+bWo9i32bONF
	CS1g1IPvCpyqw/QvsZl36qei+MAEjyNcXMjNXn2+w8t5BlmcZ/eFwi7If2DjmXW9BFW4jXmT9pI
	eYygsZLJ6K4Uk5OfGQocz29LxJFrsVbQ8XRULVw==
X-Received: by 2002:a05:701b:2813:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1a6cd3a1575mr3454907c88.13.1793208280541; Wed, 28 Oct 2026
 10:24:40 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com> <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com> <2vxz8q3hoicx.fsf@kernel.org>
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 28 Oct 2026 10:24:10 -0700
X-Gm-Features: AclHuK8mtDBrFSk6j3m-QjfmBC0Hg3WdAbJ_jeR4OTytlWOkEsZuDbAniPHpdm0
Message-ID: <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, jgg@nvidia.com, 
	robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, 
	pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:17=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Mon, Oct 26 2026, David Matlack wrote:
>
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google=
.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
>
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

+1000

KHO block should track the entry size automatically and not rely on
the caller. Otherwise every caller is going to have to store the entry
size in the struct that owns the KHO block, like I had to do in the
PCI v10 series :(

> Anyway, not a problem this series needs to solve, but something we
> should eventually do.
