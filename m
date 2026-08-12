Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CF386426
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565829; cv=pass; b=QGzE/Y+g4dDncyDLM2oi2ydvBZmdRF8hnw7eNI6bmviUxZg8xn9eGmAmCYDFKCBawdibT0EFrnlweAZuL08RtAI2Lvhd9M98YTGNyyOjqzKCZu7FfHN8qcK/fqlOpfsQXWBQJ5uszi8rRAQODSa4F5NuKt+8yHb+1L/7x/uIucE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565829; c=relaxed/simple;
	bh=KL+OHjzBFXE0OJCd3X7E9DI/ljxcc/XAnO6jMWGQY8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSw44i+/LFUEsAHjDDEOA7IecvM69aoQ1yXzWFrvYB/ZE2dyxjLVOM6me0RdTf7yv6XT7aEIR/Rd2elnaYASmr80tmmwhi/vAuRIddHuRrzFedy/4zKdS97VTjOuAJnqSJ5HYx88DM1l+IL5b6NsIUjNf0dBneK0rsJndztDx/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0TyjbQ+; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0TyjbQ+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c08df8513so10330091cf.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 13:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786565827; cv=none;
        d=google.com; s=arc-20260327;
        b=MEpqvvhGaC3zIgFo9oIb11IRaZk9tkB1PdG5QvAcXw5V8OR2wyqR4jyoSmC+oLcpHG
         GPE2+oM0z4Hn5iO929wcVG8BLDxrhICH9kxVRpeGRhir+ua1pvauCiVy8EMeUwBQtwM4
         QIax/+yvMJ1cYcJs5R1R/woIjmCAXQGcBW0fsro5/tIm7gNXN5H4LtcGEpPTmwCuIssv
         iarPnDuxCHAA59cCuLwJ4W/NplFLFJcTi1Dc5m9z6FPGI8K3BWeuH8POzOcYvDAgcJDm
         eo92OinxxpOI9C45RbkGRg0cTfpSW4wPojl+o++GH40QyQnqol8cToO9DDFFAIuXrG5r
         jslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXYbgiSr9cbJ9dy0sMTDSdZsJv3hordTOuTBKGSojmU=;
        fh=TSgojNm3yhj6JXMvlmx3R5/9yqhex77GO/a2eE93lJo=;
        b=EFA9iNZYemc++UkwT4E3yTrO8f7MJltntu6Vg5wb1vApPIXxK+ZRLtT4LOmcvp1sVt
         0rJqlgY+TClhzdBbt/J0f5utN6g83UDqFKFOkC8cAa3NM6n8g6YuOnYC1SHGzaNibcxz
         qprJGSkgjOU//1ZDzdr7Kh1shRbHnXf4YaZ8nUmSgOjPzKsl5pCJzLaaboVlG88mJRBX
         hKA5JRla4J7ulm3qtlUQXiicn1xwERlxrBD7zcwbALF9WPGF9mJE7QHvSPd7cKc5Lnhf
         x6h+u2gmfLtni7wYG8LU4/kgg0muGg2w3eZd0dNZ4+KFOtpGw4ABViOxgbAsjCFYX3wH
         lEBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786565827; x=1787170627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cXYbgiSr9cbJ9dy0sMTDSdZsJv3hordTOuTBKGSojmU=;
        b=R0TyjbQ+5BrO5PlweA2ZrzNNZuS9oInUDk3NwoCbAt8onNIpWI55QfxrMWwQChXlvu
         /RHnjyM2HFRlredQxT7t1v5bOrFYB46PgD1NfVtKJBP4A6p/CBTME2t0JlpC4wfjLX2B
         BNktJxyG6RIVbrPyx06zT9i8vqQO4iKlSwiI8WJBaHJe7u39NUJAkVd2MybiINgIO8s5
         bQzFQlVco2WtIYbiZGK+9K4gnc36hnDo/JUZ2q6VsI85GdiXMIpMjj/MRKh0+BYdSmmt
         +sS4e07Vq7RvP4FfW2GZqoEnJMaovu8QLZKgI0KENjcWlw+045DjoVufCfVMD95zToC3
         /8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565827; x=1787170627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXYbgiSr9cbJ9dy0sMTDSdZsJv3hordTOuTBKGSojmU=;
        b=AuI9WB7ZCfokrSsetHMQ1r+GXhMZ0Jhnzfj9DAzCXWfDRUHmZKkBfFEhNcQVQVuVr+
         /Ixvf5pZ9C9XWRViuD0K12Jt3YbUzJX1Am1BtDzknF5/vrRy8gHXi9gldrCFemBy8osI
         JOC6lgRrp7zC8Wrigh7wX7X+qtVOxlPf9Lo59JhkdpwoHJrhBXxYph2GEat6J6Ax74/Y
         /q3yZ2VmEtF3Vewg5ZLXLrHAcJYcwqTT+XACrUYNJWqIns+NBBq4ivrsyvBAmhc3nld+
         WN1QgFeYpnaErDcUZQBbNBj15sdZ4LMFMw8PL//7h0GrXr5DeUWe4IYDI49Da7KE9QkZ
         6fjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWX8WbgrJo7YW9TjDonXWpugcu226Fpmom5bP3s4gTth96DRUQabqVY0eety0gVuZuk/FSykTS8MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVd9+rHG7dcMX3ZbXwgE8Hufgs1NsG087FTMPWGzi9Aa0Mp1V
	ZZO3GJlIdFKfbiB8w9xifrZSPxSMZn6r/TZFiHIeAtc1XBl29ViSlcGBb88qhGNZKeKpk5BgXHr
	2b5jGx4cttaoDWEMjLDW9jOdBnv7R9yo=
X-Gm-Gg: AR+sD117FoTAK/+TioY7NAlfsAvzxADwYeqYVokdTMr4t31dfMihXwyTFtb4ahcb775
	5djhHbEF2Wb1LEC9i83RarG91rU53Bg7IXYxQQL9G7e7A61CJmV2EFdOvIJZsZiVByIR5PECka3
	/+DCk6xQ9Nm4f+XPIj0TTpKl0xQKPJCk1CqzGvjYKg6vNpDQtO5dgUolZAsLzXD+rBZOZOrnYON
	RzgsKBUyxO01lrX5pZCJb9ceFoByyHGupo3b7GA6tn6Wf3HgfAvjXgUCOL3PBqOjUwpFOUy6B0W
	UQNJxm6SLDVLzg5fl4du9+3OZE5Aybwt2AVX7hc254bq
X-Received: by 2002:a05:622a:1925:b0:51c:164b:b241 with SMTP id
 d75a77b69052e-52d73c4f679mr9449211cf.13.1786565826589; Wed, 12 Aug 2026
 13:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de> <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de> <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
 <angci4oGyGFtvbSQ@wunner.de> <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>
 <anqw0M6cQLEA0J6d@wunner.de> <any5ciFCjh-0cGkB@wunner.de>
In-Reply-To: <any5ciFCjh-0cGkB@wunner.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Wed, 12 Aug 2026 13:16:56 -0700
X-Gm-Features: AUfX_mwuXA85TtTPsyIxkUMHFxX7zrfzMP4sKUZ_77XvYBtORgz7Tu98Z2JnHKE
Message-ID: <CAFqHKTnPHuJ7VFqpLzNDJOOQm=-4TC84y2Z+a9pFgB_qXNpPEw@mail.gmail.com>
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:20=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Tue, Aug 11, 2026 at 07:19:12AM +0200, Lukas Wunner wrote:
> > On Mon, Aug 10, 2026 at 01:57:58PM -0700, Derek John Clark wrote:
> > > I suppose that is true, but in that case we still wouldn't be able to
> > > use it as the root fs since it gets removed/re-added during a suspend=
.
> > > Would the quirk I submitted not have this compromise?
> >
> > Okay I wasn't sure that using the MMC card as root filesystem
> > is even possible on this product.  If that's a potential use case,
> > it needs a separate fix.  I'll come up with a proposal for that one
> > as well.
>
> Here's my proposal for allowing root on an MMC card.
>
> Both this and the other patch I just sent (or something like it)
> need to be submitted upstream.  The other one is necessary so others
> don't see a lockup when disconnecting e.g. a Thunderbolt-attached
> card reader during system sleep.
>
> But either one of the patches should make the issue go away on the
> MSI Claw, so each patch needs to be tested by itself, without applying
> the other one as well.  Thanks!
>
> -- >8 --

This also works independently of the previous fix.

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

- Derek

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df75..9da7ae0b2437 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1080,4 +1080,20 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev=
)
>         }
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
> +
> +/*
> + * MSI Claw A8 firmware initializes the onboard Realtek RTS525A cardread=
er
> + * with an MSI-specific Subsystem Vendor and Device ID on boot, but negl=
ects
> + * to re-initialize it on resume.  Avoid hot-removal of the cardreader d=
ue to
> + * the spurious ID change.
> + */
> +static void quirk_msi_claw_cardreader(struct pci_dev *pdev)
> +{
> +       if (pdev->subsystem_vendor =3D=3D 0x1462 &&
> +           pdev->subsystem_device =3D=3D 0x14af) {
> +               pdev->subsystem_vendor =3D pdev->vendor;
> +               pdev->subsystem_device =3D pdev->device;
> +       }
> +}
> +DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_REALTEK, 0x525a, quirk_msi_=
claw_cardreader);
>  #endif /* CONFIG_SUSPEND */
