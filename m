Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3834AAE3
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928254; cv=pass; b=HDgWzxpuNjJYcQEpsVWw9Zrlpa6LLU7G2/swl95X2W9blJEJCrTvJCg/bO+6pIZL541RXe5xXZXqkDb2e7XM1QaYNL5uFXqxNz04DaoLxUMYdAzFYHyQKRZcFdJXs4mPXeV/GrCFHsZ+lR2Oadm0Clu85zeHKyqf0Q5MICJRvfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928254; c=relaxed/simple;
	bh=wNe3zTjWXKubLpElCH4k7FK3v+Z2gPor4/nONBZYQbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzWQizm8DhtyCXjLZjEKDTz83BhuKZ/tmq6SS9N4dhZE2RbPWcYdRF8Lw+44hF6v8QekLnZBUj8bCMLAgzBAWDVrXpXuITwX9bHIUtYXnDd1rF2n2SamTmD8Nww7l7pFLyM8SbKlFc/5cvS4/isQYXA2kO73XMEU19Kzbet5frE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gmq0jwAt; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gmq0jwAt"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CE1273FBBC
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773928250;
	bh=L/j+PNZ0FI8K56+I6MmSwOePj2ibMpgOJ+algsLEe2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gmq0jwAt/mcKk1TTVsJ31xwI3GStLHOX6XKM1NhCw3fbXD7RUCY7ktp7anEym3YHS
	 afH0F3SIziUJaMFfA9N/7LByM8W3L4es0f0ft6HAIQMZEOikTrTEiE/TKruaCrItwL
	 bKQFTv+HhJCKQdjKhbAuXzTj880E6drtgHTXPVlPsFUgYEd2hprJkufXqoSPaqU20K
	 wQiz/kAhMoaO0AaGAWcwSe7q1AEOg2Z7FQCJsEazf0EZvptc51HhAnO4d9y7NBP38Y
	 3U6SEQD9B0Ww7x10DtW5HXUsqhC/Gnh22ZqR67/LdVcE+41c3XTItwUpgjfZJnAPZq
	 FEK1oj3YW0qsTVl4ozNLQgiTJl22L84nETSzSODi1xrkUgUCp/nEIl4U+Jxzh5dQTv
	 vcZJSzUL7RJes8xDaHnauwYrM11sR3zxv+ieCyseXw93nhmJBi2zdP4LJUgWpFkbiv
	 XDF/zuGWzBmr3h3U3JJJUjohiCL1sofw7Ea7ei/BarKUVSaNZAhtaya0y9Hdyb6bG4
	 Pr1XhaAnfhaC/vIGbxhgKeAI7AjJwBbDuJx2zzWvtmOW0d+Zag3PJ2D0zuH64bo9wu
	 0aPjTg5l3JXPTBI0xWiCfTUqGPjRSh4VAVN8RKWz4fauV6GAB0wuM3nIQBVQ863qkI
	 fS5R7g6cE5IbqWl+FXfRlkzs=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b9360e9f43bso114755666b.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 06:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773928250; cv=none;
        d=google.com; s=arc-20240605;
        b=Pi954+BC+AaUWlV+4EXG4YxXO70/bBzXcARnDQdzpjtpI/DtSB7cgXMQixghppIlyp
         L8qKfi1Wjs+z5xX1r2Z0fJ6xqyQecDu/sY0WsIiD1FqROlYlk/8JwyolGSh050liBflZ
         T+05iPijRp1V5XDc+u+LU2DiTEz+PB12ylfyXJmnKsposMVW60fwlqXTVMX72qkWpQ0L
         5c/mwBrJpi+QdpsIvkmNhEtMTpdq/Q+hv0uAH4MI+M6KNW/hnQUEcHaMuYgZ2+Emr47u
         +vn9+oY7wmUic+huxF6UAMit1oj9O5y2UzeKM4caA44bHAbW6T1u90R88WfSjGAaIlaK
         iN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=L/j+PNZ0FI8K56+I6MmSwOePj2ibMpgOJ+algsLEe2o=;
        fh=LqvU0Bj8khdXhODL4xnzeBRlnjgfI1XiqbWmkSNQb6s=;
        b=Kp3urOj9BDBt7WydPs5r5eFUNbigWGShltdhEmVJntOb5t0OucM4EnGUec3rlFgaVI
         GNO/loaiJ9uIIv4kDY3jc+3nHlT7a+iprq+RDHWIc9dzlxIaPi36AJGCQlx3+PcqlrW8
         xYkQj1pnP1yVGvLhxbq6T5wGgQLfcfaYoQ9kkMIIQpv37VDINEDQW4kLxQfv+T5b9XEo
         KuDEPWdTu5bRNu4Mt+j8u9dO7EOlWdd7fHOmW7DZaWaejzB3JM8VRAmzVXMkyST2Of65
         8AnnzIKPD5E2ZLV/VT+YoxbVldqOjJ0Aa0Ji3/5L+7PGuAThrXJeehare7S3sbid1O1h
         5YIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773928250; x=1774533050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/j+PNZ0FI8K56+I6MmSwOePj2ibMpgOJ+algsLEe2o=;
        b=SFOSQG1R4o8VBZsDFoQYK9QnYKU1lJk9OqBKCbbG1pNsuei7Ep5fnDpmVrFmxxGRBU
         1Tp8NEgTkf3T//jwE5ATj+X0nXk2fKS2pkXM87aWXL8FhTpIfq1UKjvSyPSzSXUon/yi
         5HxeasZ3/n4ue6nf+MpUBKcZURlVz31HU4QBqENs9DHXacrf+ZbmGNwKVEHbyInF+NpM
         rES4NonIGXEfIimoOWCxSRlBj/pe2EyTHAlRh6hK/0QeSDFZo8lSvAy/Ohb1lvtrlUDi
         3tPqcueJ6NlD5fY4GXUJLXNX9zE4EGbInoFlV7UWFE8B5iq6fin77+OKjBoKfxuU/F7K
         omNg==
X-Forwarded-Encrypted: i=1; AJvYcCUGAW0HTqdIyrKX+ShMi04sEzhDyWfr/TfzbRPyNBGYrT4p4PPuR1Y8SMp7XICZfykcEtTm+zmWD7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YySb9SJys5H7wb7LK96p+cY9sO7D6O1vZ8W0GaYhJJ/OlPgJmZJ
	nRLJf4IdkAOZZO+VMQ0u4PCFc9s8Wz2/p0sWNd2W9o0Iy5k9hp454ZBBRAQh65Jx0zknyhki+gc
	p6UXKTxNdc/7bBfPvzxSuk2qAN+Ptu7vgrA3L+MfUbwaaL01F2buY0IB9dnUw3faCWYjqsDwJUE
	80XVrncn8UkKhGyzO2rguzkrcfp9FDlIiKkdrscJNbX7BhsyRYGm0g
X-Gm-Gg: ATEYQzxXat+cNYnXW8XglI1VGaDyzDn5M1DtP5jAvC+r4fAd/kHPv/AxexU3nl/iIOg
	xVF/mTigzxOZFcc0KoAk9KREBSwK5suoG9I+3GIkURP2A7aN8/yvaAPEqfW419uT2b8l6Cq/zlW
	FYZ/qVsG8k1YQyL2qx61T3pYk3Gyy2FuxglrYg5LasrBp4D8aJRaNocOsi7YXIQ1Pw/b6ejJZO+
	NirLMpNvS0SeVcycy6Rm37+qiOXfJV2+aHkDtw=
X-Received: by 2002:a17:906:1d01:b0:b97:6a2a:405b with SMTP id a640c23a62f3a-b97f498e062mr420853166b.37.1773928250218;
        Thu, 19 Mar 2026 06:50:50 -0700 (PDT)
X-Received: by 2002:a17:906:1d01:b0:b97:6a2a:405b with SMTP id
 a640c23a62f3a-b97f498e062mr420848366b.37.1773928249601; Thu, 19 Mar 2026
 06:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313094618.1361418-1-ziyue.zhang@oss.qualcomm.com>
 <20260313164542.GA1405513@bhelgaas> <en5a7jrgpbn4bsmw5qwprugb2qmjkqw2x5eey6jxxu63634duz@b43rhcsqkj3o>
 <abdviJbrluDn2Vrx@baldur> <kqpgjzcxnazjohiop27exget6qrv37wn3csmixt5nmc6d5dkbg@n7qjo6flaabn>
 <abtgaXSv-zRysJqO@baldur> <4byysnjodmlphwcevw5gb2asxbwwwlf526mtpwpkfi6crjxoqb@vyuktezfu2wu>
In-Reply-To: <4byysnjodmlphwcevw5gb2asxbwwwlf526mtpwpkfi6crjxoqb@vyuktezfu2wu>
From: Tobias Heider <tobias.heider@canonical.com>
Date: Thu, 19 Mar 2026 14:50:37 +0100
X-Gm-Features: AaiRm53OOBmjYF3wt3fYYuOja2T2t90m9EZO7Pd32ZcMTQGM6FDTvHdOzk-54EU
Message-ID: <CAARv3RSag8n0=ut9KGm0yALRPVTiyQ+bBBbT+3Vf1sNOCBLbGA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: hamoa: Move PCIe PERST and Wake
 GPIOs to port nodes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending because the previous mail ended up being HTML (sorry)

On Thu, Mar 19, 2026 at 6:39=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Mar 18, 2026 at 09:42:56PM -0500, Bjorn Andersson wrote:
> > On Mon, Mar 16, 2026 at 08:50:12AM +0530, Manivannan Sadhasivam wrote:
> > > On Sun, Mar 15, 2026 at 09:53:33PM -0500, Bjorn Andersson wrote:
> > > > On Sat, Mar 14, 2026 at 07:50:50PM +0530, Manivannan Sadhasivam wro=
te:
> > > > > On Fri, Mar 13, 2026 at 11:45:42AM -0500, Bjorn Helgaas wrote:
> > > > > > On Fri, Mar 13, 2026 at 05:46:18PM +0800, Ziyue Zhang wrote:
> > > > > > > Commit 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERS=
T, and Wake
> > > > > > > GPIOs to PCIe port nodes and add port Nodes for all PCIe port=
s") did not
> > > > > > > convert all Hamoa=E2=80=91based platforms to the new method o=
f defining PERST and
> > > > > > > Wake GPIOs in the PCIe root port nodes.
> > > > > > >
> > > > > > > Without the change PCIe probe will fail. The probe failure ha=
ppens because
> > > > > > > the PHY stays in the controller node while the PERST/Wake GPI=
Os were moved
> > > > > > > to the port nodes.
> > > > > > >
> > > > > > > This fixes probe failures seen on the following platforms:
> > > > > > >  - x1-hp-omnibook-x14
> > > > > > >  - x1-microsoft-denali
> > > > > > >  - x1e80100-lenovo-yoga-slim7x
> > > > > > >  - x1e80100-medion-sprchrgd-14-s1
> > > > > > >  - x1p42100-lenovo-thinkbook-16
> > > > > > >  - x1-asus-zenbook-a14
> > > > > > >  - x1-crd
> > > > > > >  - x1-dell-thena
> > > > > > >
> > > > > > > Fixes: 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERS=
T, and Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe ports"=
)
> > > > > >
> > > > > > Are you saying that DTs in the field broke because of some kern=
el
> > > > > > change?  That's not supposed to happen.  Even though PHY, PERST=
, and
> > > > > > Wake GPIOs should be described in Root Port nodes instead of th=
e Root
> > > > > > Complex node in *future* DTs, the kernel is still supposed to a=
ccept
> > > > > > the old style with them described in the Root Complex node.
> > > > > >
> > > > >
> > > > > This is not related to the driver change. The driver correctly pa=
rses all Root
> > > > > Port properties either in the Root Complex node (old binding) or =
Root Port node
> > > > > (new binding). But commit 960609b22be5, left converting mentioned=
 board DTS to
> > > > > the new binding, leaving those affected platforms in a half baked=
 state i.e.,
> > > > > some properties in RC node and some in Root Port node. Driver can=
not parse such
> > > > > combinations, so it fails correctly so.
> > > > >
> > > >
> > > > Are you saying that above listed machines has broken PCIe support i=
n
> > > > v7.0-rc?
> > > >
> > >
> > > I haven't verified it, but I'm pretty sure PCIe is broken on these pl=
atforms.
> > >
> >
> > In line with Bjorn's request, we shouldn't have to guess.
> >
> > > > It seems this is a (partial) revert of 960609b22be5, is this actual=
ly
> > > > fixing that change, or is it only applicable once some other change=
s are
> > > > applied?
> > > >
> > >
> > > This change is fixing the issue in the respective board DTS and is a =
standalone
> > > fix on top of v7.0-rc1.
> > >
> >
> > So 960609b22be5 was broken when I merged it?
> >
>
> Broken on the machines mentioned in the commit message, not for all Hamoa
> platforms.
>
> > The commit message says that the commit was incomplete, in that it
> > didn't fully convert from the old to the new style, so it sounds like
> > the offending commit was incomplete - but I believe the offending commi=
t
> > was a workaround for the new solution not being in place and this commi=
t
> > mostly reverts the changes in the offending commit.
> >
>
> So 960609b22be5 was supposed to move all the platforms from old PCIe bind=
ing to
> new for greater good, but it apparently decided to do so only for a subse=
t of
> the platforms for some reason which  don't know. But the problem arises d=
ue to
> 960609b22be5 changing the hamoa.dtsi to the new binding which also warran=
ts the
> platform DTS to also be changed to the new binding. If we only have eithe=
r dtsi
> or dts converted and not both to the new binding, the driver will get con=
fused
> and fail. And this is what exactly happended for below machines:
>
>  - x1-hp-omnibook-x14
>  - x1-microsoft-denali
>  - x1e80100-lenovo-yoga-slim7x
>  - x1e80100-medion-sprchrgd-14-s1
>  - x1p42100-lenovo-thinkbook-16
>  - x1-asus-zenbook-a14
>  - x1-crd
>  - x1-dell-thena

I can confirm the breakage for (some of) the listed devices on Ubuntu.
We are experimenting with 7.0-rcs ahead of our 26.04 release.

I'll try to collect some test feedback for the fix.
I'd certainly appreciate this being included as an rc fix since
currently half of
the x1 laptop devices are broken.

>
> > In other words, it's not clear to me, from the commit message, why this
> > change is a -rc fix. Perhaps the author of the offending commit tricked
> > me to merge that one, and that's what's being fixed?
> >
>
> I wouldn't say that the author has tricked, but he was unaware of the fac=
t that
> changing SoC dtsi warrants change in all platforms, not a subset. I wante=
d to
> catch these kind of issues with DT binding validation, so I sent out a se=
ries
> earlier [1], but it got stuck. I'll push it forward.
>
> [1] https://lore.kernel.org/linux-pci/20251106-pci-binding-v2-0-bebe9345f=
c4b@oss.qualcomm.com
>
> > Also, is the lack of Tested-by telling us that nobody has tested any of
> > the v7.0-rc on the 8 listed Hamoa devices?
> >
>
> Exactly. Otherwise, they would've seen the failure so obviously.
>
> >
> >
> > If it's actually needed, can we please have the commit message improved
> > so that we can merge it into -rc?
> >
>
> Sure. I'll work with Ziyue to reword it properly.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
>
