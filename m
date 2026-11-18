Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043885;
	b=UZy84mBuUDzE/rpJLfNwsI6l2j5JxfY32QpE5PaPKmJgNuyV00PM16rI3qaKuZ8dwRj/
	 SeN0r+SfT0X5dFozd1upS1LOc5aDndw5Jktij5PAM22y8520v1p547fAue8fe1fpvw7JZ
	 stL2yNyyEGGbM6wWE91Jblf83PcY1V5RIysfTMlOZAHVYHkxbfzkAxPcjmrEdXwDRx4/R
	 OcEjMeOcEtsQ/LHnlkf54nuxXcKj1IlFmUqi8GMj9I2/z/Gj28fk51an2MmUl7cLRWyLG
	 Xe3ftIcf4NUP1KLBYTP/EtfUMNxsBJubKZNBnLyXQr1DYWtmSIhjY2YOOGd/wNrYVuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=;
	b=AndGLVrap+EqRY1JA+T0HewdeLRoTIRc52vTye5tcDxnX3xH3zz/WgEqGjlbc1Kgbo4Q
	 q7EOxNd8xGoro934dQdT1llQS3KAmUmnjOsY1BfyCiqJmQgUETsWc12Uk/xUJglthVKCu
	 AgBJ0g/1U9HIHmy/0pWInwiompAgYEOPbJSSDimdIJ7nx6nD/50vIYtQtlfNDH5nmU8H0
	 TuJuX7WcKofoh0BAMtmFXS+DDIj34m/EgjlB6rCcohzubEgJ4kKq2onIUzbgpR2x9VI3k
	 zX6ymVbJUDV1ydPkRsjztVZqkEa0iLkhr+E5e3IsdwUUcFkUMfE8C+GPoWB1UVGAkEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gMqYmTxx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46927606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 23:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46927606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gMqYmTxx
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50933bdf4bso89884966b.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 15:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795043884; cv=none;
        d=google.com; s=arc-20260327;
        b=KqJDq6vLyCUK2FAC+c8rE2BKTvtq2H51XVWEhM+zlah277or/Hk7pZuTwqouNCq7mA
         R1nzEuK8TzQ7AMGt8QalnzUtlc+3scCZd+lT8MszrCyx3KyHYWrCZPontVlR72GbAZaE
         3kr44xicDTiBU7R+t1lkW/X2uJsB9h5bT+l0KYIYD/1VoXOOeUV7QwYpScnBPezQ0b36
         QVQLN5f9ekberIUcIoqEdDxpusmEmXxH/HuqcpjLcK6uKn2taf9TNZ5cCy4tkavKmPRT
         V3A/VOUFeESBHh6mtP5QOtZ3Lt/jE9FdQ558kaoHKGVL+mpiAiYcz6lEb7A93Vm48Goo
         95CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=;
        fh=eCpH3r/lLhOq1hc8nOS1eq5D++BN8ruvx61l70e0NTo=;
        b=rnhdyM3zq0Q7irn52vVnw9mV6BTEdGYemSb5rcD5nnWAS7O+Us5tCspQ7vOSVvJxr5
         V7AkLhOX1IkjCCu3Pz/UoSK4akyHXnefgzLSK3PIbb1Ucu0OVLvxnaggKHo+jcWq/Mn0
         ToRPjmnGm24g/mAwzN5WxGAIkMkHpdjMsuTPuR6SLQ6J6E9D78Dx9MM0Hz/9PUOITX+x
         PIjeni2Yo1WDYcnizBZI4Y4wHM6LNqCRRonARcjlhS9wtbsyO2kfj3wVP6TPEo1LMJO7
         E2Y6hZdeHWORTvRhnnjzHAfhY6o/R/TAC/l7BReN+Yy2rJYwgU5Hkm2a7zl8yc1Gw7qV
         +eIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795043884; x=1795648684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=;
        b=gMqYmTxxxzZ9HGz8ByNTixIytfLUOljdot+AsdWACnOc4M6nV+P2CuwwqQ+cFhNySD
         ijUZb8IlBLZwar+L2LfAd8K6Lc2JaG44BnYfdyrp0ZEw5i2YrtuT+y3Ga+iN5VsmqHtE
         qyoUk0lptnivIulrEftIYMo6ZiuXlYLkptY9ccthmYaTbCeBL7SkmfuaD6QjEr0ryUbt
         THS0hL0+MidksYMQZ6nowTIvqB5VQcrFDyAhpflVFZXq4KnuIP0ibiZW6l3HNh27vBxt
         ksMs9Nl88jZNneuABg8MrBigv+AOj/rUtxtFz1WxIbhdYar3e/9BQ41X/Hd0/41ozmMo
         xCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795043884; x=1795648684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=;
        b=Vb2qRn2wyJSaOyNgypl6YMOArIia4xaH/uv6hilA9maVIu/nAqQzd6UEege4y0bdMk
         YyHa34rlsxiLkg5CBQRLpcBoZPXJzeAKXLCnr5oSvc38FC7xFlBE+LloD2lS3+2CLMy0
         4YdAzbduz1HQVKjnXiQdCbRCgcoNMHWXVCnYOEuwLf+H0twn0kwL4yPmgTIbm/1IFk3i
         f7z66f9S/Xxt6kyO3gD006u9VExybzN/PPvTPACrOB8dwbT3mQs1PwfF+1wBrgQZmtR5
         jXmvyIZKtcnC3oN4ymkAXJmQA4epI4+l1FGsU2LuCrCId2k9hwrer5IaFWY0STDE4tp9
         FgAw==
X-Forwarded-Encrypted: i=1; AL+hErF9PW93zVmt4liCPPU4xgRZ0PlZw91bPMGID+42IBj/40ezVMAOmOn0BSkYFTVr/7p8eZzsakqsri4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ytc+V58g1tn+Tq0P3s9mbYYMz/vQMFHU5e5H+vIGMoayxCFr9
	2dU/bYFS6xPwE6dtRVzvLVV+u5qLB1hTu7Y37r3VgfjdhQqvMzSR8Fdpsqn3MsjbciUpRvEB2qj
	bUJ5ecwtEkm9vgr4rNdiZOUBifzui3wKw1lfuyvRq
X-Gm-Gg: AYBFou0RUvDMRNrrXdvEWy3/LNFLDeBPEMZnXXD9wOG09B3065TwzVxXBJFYIThqRuP
	PHlzkSCOzlBHCcp5Ri2k4Ws4t7RlfVaAcpuw6bdTlzyt5tN87I46pfmxjeaXl3cOz1Wdb9qvw8c
	jrX2n7mrlhg5SLCSimEWAN+1HCo2j2z2oMB4FpO95rRMx5MfE9AiwNW1LGn2LUuVhJPaDXZ8ZIe
	7AgEmFV8PTdIUe0LFQj2lypcdGA0tSKvZp0+NwM7ZQVTlmG/B3GFyCat8uhLsEnbF0rXmW1mVOm
	e7qtvO8/3n9fjYAAO6dE0o0i/gRAvwVMIwkDnp0k3+jFeTWhmcxw14Zl7ZNj9BZFPlt4AAgE95G
	K6mryXMftzyI9kStfJeavtb/FCXrKaSxg1MJ8OQ==
X-Received: by 2002:a17:906:f58f:b0:c51:2e3:f426 with SMTP id
 a640c23a62f3a-c512b79e2demr9058066b.18.1795043883126; Wed, 18 Nov 2026
 15:18:03 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com> <autxCZPJ9yiE2ucq@google.com>
 <aut0H65XKAHUqPR9@google.com> <CALzav=dp8HvdK=9cAkGfbsJAeckyU3_y7rCRM22R7+AmTTtxMQ@mail.gmail.com>
In-Reply-To: <CALzav=dp8HvdK=9cAkGfbsJAeckyU3_y7rCRM22R7+AmTTtxMQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 18 Nov 2026 15:17:35 -0800
X-Gm-Features: AclHuK_BmYZZLmsTICieOxQ9QtDw0U6EdYtEs__fOCufTHy2p7TcHAXRToh2pGA
Message-ID: <CALzav=cj3GuYU3wmW5GPSy8Rp+4xYjm3vonDBdi8TTyWSgxPCw@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 8:45=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Nov 4, 2026 at 10:06=E2=80=AFAM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On 2026-11-04 01:00 PM, Pasha Tatashin wrote:
> > > On 10-13 16:25, David Matlack wrote:
> > > > v10:
> > > >  - Save and restore the ACS Egress Control Vector along with the AC=
S
> > > >    Control register, sizing the save buffer from the HwInit Egress
> > > >    Control Vector Size field (Alex) and drop Bjorn's R-b tag
> > > >  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
> > > >    rather than adding the dependency later in the series (Pratyush,
> > > >    Mike)
> > > >  - Reword kernel-doc comments to read better in the HTML docs and
> > > >    spell out "reference count" (Mike)
> > > >  - Replace the version number at the start of struct pci_ser with
> > > >    required_flags and optional_flags, and record the size of struct
> > > >    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)
> > >
> > > Hi Bjorn,
> > >
> > > I am planning to target this series for the 7.5 merge window through =
the
> > > liveupdate tree, as we previously agreed. However, there are still 6
> > > patches that lack an Acked-by from you. I believe you might have
> > > reviewed some of them before, but the tags were lost during subsequen=
t
> > > refactoring. Could you please take another look at the following to m=
ake
> > > sure everything is in order for us to merge the series:
> > >
> > > PCI: liveupdate: Set up FLB handler for the PCI core
> > > PCI: liveupdate: Track incoming preserved PCI devices
> > > PCI: liveupdate: Document driver binding responsibilities
> > > PCI: liveupdate: Auto-preserve upstream bridges across Live Update
> > > PCI: Save and restore the ACS Control register and Egress Control Vec=
tor
> > > PCI: liveupdate: Adopt ACS controls in incoming preserved devices
> >
> > Thanks Pasha. One more for Bjorn's list:
> >
> >   [06/13] PCI: liveupdate: Preserve bus numbers during Live Update
> >           https://lore.kernel.org/linux-pci/20261013162529.1928093-7-dm=
atlack@google.com/
> >
> > Bjorn's Reviewed-by on it was dropped in v9 when it changed materially
> > (albeit based on his feedback).
> >
> > Alex, could you also take a look at the two ACS patches? 08 includes th=
e
> > Egress Control Vector save/restore you asked for in v9.
> >
> >   [08/13] PCI: Save and restore the ACS Control register and Egress Con=
trol Vector
> >           https://lore.kernel.org/linux-pci/20261013162529.1928093-9-dm=
atlack@google.com/
> >   [09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved dev=
ices
> >           https://lore.kernel.org/linux-pci/20261013162529.1928093-10-d=
matlack@google.com/
>
> Bjorn and Alex, these 2 patches still need your R-b or A-b tags, and
> then this series will be all ready for 7.5.

Thanks for the reviews on v10, Alex. I've pushed v11 addressing your
feedback. Patch 09 on v11 is now the last commit that needs a tag.

  https://lore.kernel.org/linux-pci/20261118223704.3286085-10-dmatlack@goog=
le.com/
