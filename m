Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412941A4E7
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586632; cv=pass; b=KlsP2Xl0TijICx5FcWpBWAtw9CVKZtLerF9pT9nEgfi6fRHTMhR0Z6zyDbCsxBCRkKgwVDz862cFP3NEluw4YuD8s8CIvGfP0RwxXySAJcMJRl9rVVPiInkhwO0uMkoLlNv2etsvflW3zerUtlta7+D8Ocj7g90g9a+Ti/w3lJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586632; c=relaxed/simple;
	bh=P9Z7CVJt2RJqpCiLZsttpwmxblZO2voCKo8/zSNALRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duewAx3F5nXBRQFmM08OqKG7XVQusVJik3C8VnK7o2EfvaesDk6YXNO2Kaqup059A9XoQFeHvdztVWPM/H5sbJ9vehbO4jO4t0zLIZdduK8MIqyDgsm/GJyJHKsc8Hlz32xeM/AFrkgbMkepEGbjtUoG9A2SUp5RRQgu7LyPhb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbnRQZrY; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbnRQZrY"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a58so14399966b.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 12:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789586611; cv=none;
        d=google.com; s=arc-20260327;
        b=Qc93xus+3gqcLmQf96km1oj0GdYC013hPjtLlq9zSl5QTDst3UiTzBZ2fCuD04ReZd
         xJTwQ1ttkkgcoXlK526UbvCbABUGy3DZzxFCExq/SYEH9wwR+80RwSTO7kEcM89kEG5v
         iiaRtcRNUhPdQgQLNzHXsG5FB81avpYRYRsI5ngY8T7h4monTBIbDkIS67ScKDZvXh8m
         quslwhVHZYF86lTzdOo2ZKSV2feSW8ROZeFo/s03aVyoO+8l7hGVKIkSN2KX6FTlL1Zb
         bIdCk1NbNoRQeMJP0Ow+iR45PLETBJy3tEz6IiIdhLR3ZscUJ+3k9xBxBbAsGpk0NxyJ
         r5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1KLYZ+iH6BwF1ulRTppUoaxI/s8uMQmLIUDs0MP8toU=;
        fh=f7TFdXK6Hb8IF8hZSIMgKGp0fqB3M0hqS9EVXpq/+bU=;
        b=kGzV3OXhdj1F3Qp1mk7/PNMwMkTwpkfPDtm7dCvugfxRnqdEaMIqLSHh9R+Xi3Vz1S
         aeRr7VFbhnXI5IUms10SYyHLNXRH8yuWp/4k5dnn3jyIr9UneEAps73yfLRBErODlxrx
         aYhoQPjG64xbHFGTdyNOJiJ8O6Xemq423aklFrVUj+0YOFv7y5ALcLG8qsa5XcK78IWA
         hHlV2f/8C31zq+ec26WdQu0Tg9NTWKmQ/lAkcj6FbLBTHBcf45M8mfGQmTCdpUgsqQBt
         mG0EzMCwR09ZK7/1+ux3JViXvCbbNlACAMNeH7TwizkIaP7EbSyTmNG/iMzxi2M18Ugu
         lKNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789586611; x=1790191411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1KLYZ+iH6BwF1ulRTppUoaxI/s8uMQmLIUDs0MP8toU=;
        b=KbnRQZrYI+f7+ukAdQeM0O2nWxjlNFZw9frJO4Bmh5ACPxXQqIe9Q/xLHpcVbuOjp+
         hnfh7WJUUaNyZrkKTIQf6nnPhgM5c5zQyD5OEuMuRqQRWgDZMWLW1TZEp0jEjtmpyaEA
         7tg0xuGa4YYA4bO0IyAqjNkHcuo2KuCyN1yCnekn/awoJEz/TtTA/tU6AvXXcpJW6eRD
         l/+AjHFdG7d2EwIYSeBja6oY2TigI6cCcOOsBgCeVBlfx0gOZvwz5/VucPAjfgdRdChh
         b6qS6ReabjAIZtYmLtgFwX1R8WO+9TEsxTLCCjoReZNDFKEIesyFWFO86yx3H4yl/35U
         T8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586611; x=1790191411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KLYZ+iH6BwF1ulRTppUoaxI/s8uMQmLIUDs0MP8toU=;
        b=bU4Eb7y5ecJY/JJOpUO1aB12Mn1QOVm3aQFrQ9S8yVPoVr1Hwehkw4hpNuQAfNS3ny
         S/opTz/zVlHGhdSMqiafRkmXRH6ydevO9AfLUdw82ZPnr1kkdn1LMWINZK1sepGmgro7
         8BU+lV41dZPC0Ezg5bq/clnGRdfhZNGIwB6OmjzMwHAobuLtoIObTI7SVkRHVXo9putn
         TDc+4p0r7Ns918vkIU2jktuYsffLkYUtKwLRWEZbyurOmefV0wrZZMgHUtR8YJiRKmJy
         jZSPTzoFcQ06h1n2WIlkCT6ugnxIMnFOQKXI2EbqTGz+2GqmOyWIQJTshEKIlMOCWXlh
         9+Cw==
X-Forwarded-Encrypted: i=1; AKwUvBwRmS5fbyYC+gGz0/T/zBh39AfQnQioNwkkCp3ohD6w4wDBqslvM1SsZNIny09BbKcVUYrzLaF4FGU=@vger.kernel.org
X-Gm-Message-State: AFuF++lHp+ICgHr2ktJcJDdvrphK0OKBnoOhH0ldZHEJbK3nC3SOhqLX
	rXr0s1lvQOAW/dU3NIHrTDt1uGc05nP8TU3p9TS85f9NXm2S/COHuVSrPe3TafiqdMh8PmUMucu
	qQiLqn212opTj1e9X1uQOPwclZaJ1TAKeIFllVQYz
X-Gm-Gg: AYBFou0HdlUTCXdTBBzR0d4C+iQ8Xjd/ngyD2dBWMSy+fsspQcZ6xDondDhzKWEjNL6
	QlvDewVHnASmbCRMLdmiImK85Ga7JgBSA4UAWA3Qm24AxUhibSO1vuv0kK+h9IzYkaNCimj0dcN
	wnXd8ER6xsw+CMO1/InarKm86FkvBOa9zSKgKrdU7cxT9Xiw3GUTWkTy6i0VacHrU5918P4dt7b
	2f6OZjqHl9NpB0oUoNFMUFI5qHWB2SgYhnjT3iUz3Pww8b22H9daqaxQJVkqGShYZFQPGvxlnI2
	i7fdPDCrnfq+8HEdo1WughQ8FomuzBHlZ+5GxQRsLJPldiEA/KwSY1zWU8Z3ZwPXol3+aVIK91l
	CIRiKh4TL1N0=
X-Received: by 2002:a17:907:3cd4:b0:c29:3711:626f with SMTP id
 a640c23a62f3a-c29e52c97cemr277311666b.24.1789586610730; Wed, 16 Sep 2026
 12:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-4-dmatlack@google.com>
 <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev> <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
 <2vxzcxud6ol3.fsf@kernel.org> <CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
 <2vxz5x056n1b.fsf@kernel.org>
In-Reply-To: <2vxz5x056n1b.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 12:23:03 -0700
X-Gm-Features: AcwNN1XBA5tWfpFye7fMRURIMgABlK_FSM1i3xHnxeEQBrBN_oHQDGfs58Y6KSU
Message-ID: <CALzav=e3_m_53PHTpMbwj0kFwVQdjx=MU8iHKwGcSa13V0R5cg@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:58=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Wed, Sep 16 2026, David Matlack wrote:
>
> > On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Pratyush Yadav <pratyush@kerne=
l.org> wrote:
> >>
> >> On Wed, Sep 16 2026, David Matlack wrote:
> >>
> >> > On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux=
.dev> wrote:
> >> >> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
> >> >
> >> >> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so t=
hat the
> >> >> > domain and bdf can be guaranteed to fit in an unsigned long and b=
e used
> >> >> > as the xarray key.
> >> >
> >> >> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >> >> > index 3781e2b5f095..8af20f558086 100644
> >> >> > --- a/drivers/pci/Kconfig
> >> >> > +++ b/drivers/pci/Kconfig
> >> >> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
> >> >> >
> >> >> >   config PCI_LIVEUPDATE
> >> >> >       bool "PCI Live Update Support"
> >> >> > -     depends on PCI && LIVEUPDATE
> >> >> > +     depends on PCI && LIVEUPDATE && 64BIT
> >> >>
> >> >> One question about adding 64BIT to the dependency:
> >> >>
> >> >> As I understand it, enabling CONFIG_64BIT essentially means that we=
 are
> >> >> building a 64-bit kernel, and a 32-bit architecture cannot normally
> >> >> enable CONFIG_64BIT.
> >> >>
> >> >> If that is the case, would depends on 64BIT be necessary here? Or i=
s PCI
> >> >> Live Update already inherently restricted to 64-bit architectures b=
y the
> >> >> existing LIVEUPDATE/architecture configuration, so that this depend=
ency
> >> >> would be redundant?
> >> >>
> >> >> If this problem has already discussed, I am very sorry about this.
> >> >
> >> > The necessity is that the PCI core needs to store more than 32-bits =
in
> >> > the unsigned long xarray key (see the snippet above). The dependency
> >> > on CONFIG_64BIT ensures that unsigned long is big enough. We could
> >> > probably remove the dependency but I would rather wait until someone
> >> > with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
> >> > before putting any effort into it.
> >>
> >> KHO or live update themselves don't support 32-bit platforms and there
> >> are no plans to do so either. So I don't think you even need to have a
> >> dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures defin=
e
> >> ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
> >> inherit the dependency.
> >>
> >> If you'd like to be extra safe, then probably you should add a
> >> dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that ca=
n
> >> be a separate patch independent from this series.
> >
> > It should be in both places then. PCI_LIVEUPDATE explicitly requires
> > 64BIT for its own use of unsigned long, so it should have an explicit
> > dependency. If KEXEC_HANDOVER requires 64-bit for its own specific
> > purposes, then it should have an explicit Kconfig dependency as well.
> > That way if and when someone wants to add 32-bit support we know
> > exactly which configs need to add support.
>
> Well, I don't think we are ever adding 32-bit support. Most 32-bit
> support in the kernel is being deprecated or removed, so I really don't
> think it makes much sense to extend KHO/live update to 32-bit
> architectures.
>
> But anyway, if you'd like to explicitly mark PCI as needing 64-bit, that
> sounds fine too in the very very unlikely event we do add 32-bit
> support.

Agree we will probably never add support for 32-bit to KEXEC_HANDOVER
and PCI_LIVEUPDATE. But I do prefer explicitly documenting the
dependency. It costs nothing and makes the 64-bit requirement crystal
clear, just in case someone tries to do something crazy :)
