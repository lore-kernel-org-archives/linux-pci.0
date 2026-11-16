Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794852205;
	b=uucMuudJ3H6bPkVDY9Y6g+4klfP03ctybx4foH7AJPR7islt4LeJjbAOonTIXnTpy88p
	 6/fKPUo/pSUqfebuIT/n4ukbAG1nEngW7k1zpOEfVaktUG+lj72p2WhUPCQ3T6fFFJWnZ
	 ujbEM2kRSkMbV5wFD6GqPZecAgthKlniSikFg1z6aAfGqDA1Q98PxYxd9bwl8t3x7TgLO
	 ORLIoye5QQoKWQ6+b69A61MOJy2Q3Og/ngc/7Col8N0afxL/IviWsY7ba2Tr1jmBcpIX4
	 piottLgk+lNqd6ChyFOPgzUuWjp9MnrC6PSO8uojC3ImZXmrWZdCykfR9lY1v77TfAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
	b=EOQ71cYp21HiWg8gDaLcrrCAldZryOXehFUT0YXpy0/mbgbd+jkaQcbLKllDrAl+bWlc
	 AatCGH0tyxVEkLTaL97jd8PdLiZPKpOOAu3fgnfGNWYTXZaLicAR0o6u+rm9PEOAu7AGJ
	 FeClnpIbKbuwSYa1ZX0gSSPYOfVVHPOcMHhtYozASYvk7urfIVO4ImOY4nJkaNxNz54vM
	 kCWGFWwGhE9P/XIq9eQnyXOJf54hfxZaY6wo6AhCUH6sNlPc99voUNjs8XfIUjsjr0X3h
	 ZTuTxQ4tVLBOLmraUtts8JajKIkrscWk7O6P7WTjHaFuNF6bJ7gAnzesL0XjUClw37w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I6mqVMTG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C35E606A32F
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 18:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C35E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I6mqVMTG
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d581da0aaso453781466b.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 10:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852204; cv=none;
        d=google.com; s=arc-20260327;
        b=kC5BRggTOVVbuT/in0+rXvD5q3GAtYmzzpHEUiGNqy6Jx0c/gEMF3mQ0fqbUNTa2p3
         SdceX2iYp+y5xrJ+0BunescmhEq/EyhQFz66iu5ADKluM7LIg8blpmeA/CkELftpTxR5
         8XqnYL9aBqGL5bj/bJw6A5nlPy3VE9dKchuAQ9fWFJpJ2+jDeXzx/pgS5Z2mZF76aQOQ
         EVq0JjdobXQtCM8C2kd60RpdZwEvWl6xl9Itg/Ibvjgf6ziy747IUEzR8pEenVHlM89L
         4QQEjiElVzZrkKbYrbhA7JqCpNvu6KvMkEQCxDUTyinQgp8Ev9IURv3cIdh5puIfTRLY
         qTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        fh=al0hGED32B8GNrKQeSjwmAOl4/0RFpHnTSsEMoiUN+E=;
        b=q/qLCfRXJ3NGyUlB7QAOsrqSK7gVCK/hFYCvztM6bKefYTaH0iyjBZnurq0SV9i5kK
         V6PvmQNPfKccmRhWfy5ub4G+kzhQm4yMSdRnL4MZnQR2Go7aHr1MR5HsWpZ+SZ96hLQt
         FeXyEDdgoIpNiVHlwA90NNXFAjz+okaBvMMzdYKWatutJ8oAHUEc6KKQFreda9S+pp2K
         LYF7Y9ZMGOzhM/crqq24kge1pb22MsrlchEazh9XnPK4LUBOINgXT0uQAauo17YrdETh
         IkB7md2/2QIs/R25NeqU7MwTetWDJFhleoSPcvd0Lpba8QvXcjdfM+uhSTydnyRke7en
         1LGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794852204; x=1795457004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        b=I6mqVMTG7TOW0QEwtuel8eM52dKEJwwHsF405R3hjerJsFHBrNmZbXj1231hyCM8t6
         lqbZTqy/W7RE6mA/aFf6Hg9AYwm6rN790YoLWLHRk8TLVbiDwMFzyhmLSGClLvIpmNF2
         Fd1UV/CIckE73CtjGGY+0jZ2X7dcdvGciqVfMht+mmpUzFUMO+dLUMlCFCQaKyMepbGG
         F8ohtkkUT7s7bFlbRNN/LGCQB4vCchBsVeQNAA3l8+Gj7s7oTeck1iQ/5Q79M9IA0TO1
         Zyy7QFC3lWeB7VhNxN8iUb0z+6DXNIMXIKoic7ZeJEN5l6GIoGek36/tcXyIzG7bt/kg
         1Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852204; x=1795457004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        b=v/NiVYKOC/R/NXqIeIRHtIXlUkVzJYbdb8OLVFuzQPgRnbFXMsORVqpVoodXf84v0q
         rovJUCm1BbJ+ID2++w3nZ9i9kT/kJBi4YpDaMpH4FCDSmkjat5/XQicTOyJnrSYRgO+j
         PK9ghmJvvGSH2PDMAQDDnjKgAfQmqY0ayVHdcaBq4vty+BANLZx+WIjpNxayjHCgNBoo
         5WQA6t1zO43UYYSEao7x22RNfc5EK4uXtCGjJYUCpttbFdbw8DJ0qZh/TDH7+6QryKn6
         Y2AU5bYh26HpPH5RDD953bxjWhwq4D138EIZ21Bo+owq9o6h1div1/RA8y/fvgS6t58j
         sDDg==
X-Forwarded-Encrypted: i=1; AL+hErEWxbqkSCsnKMLUkEnA+dd1dBCQp2EPorc2qH4goPD2n5IgMbzF1W5Fr8YfXDyFO+edbL4f88vXUQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZDxKspwwWUJ8w/ST5GHynwLOcMgmhxtt6SJo7IrUiZ7zPOp4C
	/WYs0+gdTsHruXD8C8RUj7H0WG26GqvZdl1/dUkN7uwCOpAhKYuGcvXRgaVuJ7cCYdd+m2EhSAV
	FDvcBm6LlbEJM4X5sJQR5ZZnDjbyE9DfmzC1RUkxV
X-Gm-Gg: AYBFou36rjYd3CIc11TCXF4zoa2YvkqF/nG44uj69DLG1iWqGe01gFPvolVma9MGttv
	j5NrCXv1eYP0JpMLozfoblaQdWDbmPkuNnuLkuvtb8GuLgvojXeuZum7sQvKT7bZE8p3JjzimV2
	ch1jIXCBIOX7tkCg+2xUKB6SidUVTGy133wLuGuZYWE5NQjexQy4gFfBkTfd4+2goXoPulLfJs/
	nI7uqM4eAYA6kgbwlnHXMbVJqWJX2+LUfkbGmox4kuAlIhBcP2sqY687BNsrBZNBHoTzn7fJynK
	jopn1EqtMXf3FAHO+WMgZkJM9CQpYpRrnF+Z8Qgj7U4npVIb4IntYaVOFeqE/WvBQPHZqerihvO
	krySJSidBDREGOtoYpNKFnXt0HFY9Rd7U03wR/06sqI0AfY1I/b4FnMV9gu0=
X-Received: by 2002:a17:907:ea92:b0:c49:cdc8:10cf with SMTP id
 a640c23a62f3a-c50963df2ccmr868161066b.40.1794852203026; Mon, 16 Nov 2026
 10:03:23 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com> <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com> <20261115231946.GB1239159@nvidia.com>
In-Reply-To: <20261115231946.GB1239159@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Nov 2026 10:02:56 -0800
X-Gm-Features: AclHuK98Rk-099iLtslJwrWtAxHkQR-ncmpykOH17KTcOCuNGBfykDUUL8uCEbE
Message-ID: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Mastro <amastro@fb.com>, dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:19=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> > > Hey David,
> > >
> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> > >
> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expec=
ted
> > >>     uAPI behavior?
>
> Yes. Even if we wanted to the locking is doesn't allow trying to do it
> automatically.
>
> > The way I designed the P2P selftest support requires 2 things:
> >
> >  (A) initiator: A device that has a VFIO selftests driver.
> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_=
bar()).
> >
> > So far I haven't found a single device that can do both. But you are
> > right that theoretically a single device could satisfy both
> > requirements.
>
> mlx5 can do both

Looks like GPUs and NVMe can do both as well.

How would we implement vfio_pci_find_mem_bar() for mlx5? BTW for the
target device, by "a memory BAR" I meant "a region of a memory BAR
that behaves like normal RAM". Sorry that was not clear.
