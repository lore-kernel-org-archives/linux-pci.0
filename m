Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398F3C553B
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075561; cv=pass; b=YsVjU45oF0Yj98eVmQUIP2sJnHOb2uZhIdeyavdQBq/+r8tCpFtZoTXYD5/4Vnnmeqo3K4YNIuiab7C2r0h2S3kQqIdi1fkZsorE/b4Au0yG32P4cdh41tzOdnGayIh5RCPQadtMUHcDUrq5BsJ5huviYF1cjMvG2ZIPFfH5eYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075561; c=relaxed/simple;
	bh=7kTPqpLAh+L97oFkxfh+4rZx6U3XxL8GE5687Tp1CcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUO79LIPKgapES0qMkRy5sZM8oNcUcWRrwN+/wds1+BwxAif9SOzSongv2dJhDDiQ1o11zWT8lyhLrzFNvzCU8Zltk7tirZwH7eGNDeGZuvb3676/QkWe7w5sbi+3eZpwcZZCW+PBE1GDrDAmW20Yxg9jLSUH2qDmyTEvaP+NTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gi1KgUkO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8V8/SC1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi1KgUkO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8V8/SC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792075557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJMrs0BTYtg7WetIITx1Ab2b5lfsKukYxYHcdWEU7D8=;
	b=gi1KgUkOmHyjx4JuOptS9/41oc5AAtETdurVD2DBvNy72Dt2ijpF6kyG9Wslo/hN+VruOJ
	r2j6fN9x9lOwJoytwnLSBpJESYblbBhGnkyfAkqBAf+83jiubGwrsBddcnQu8JNbelHi6E
	3F2umo3KtG4ALprRVvK7EXga/V26cjM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-tIT0SdmlNNGs0PJlKvd_PA-1; Thu, 15 Oct 2026 14:45:56 +0000
X-MC-Unique: tIT0SdmlNNGs0PJlKvd_PA-1
X-Mimecast-MFC-AGG-ID: tIT0SdmlNNGs0PJlKvd_PA_1792075556
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4f4612a1a5cso81089b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 07:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792075556; cv=none;
        d=google.com; s=arc-20260327;
        b=g/1LuG7NPGs0+IIOYn+kOmcxTWYKY9cbL41+2Rgytas5TVQ1BLJJFiJyEjXYxVRNGQ
         4yA5t5imD+fuRdZLzdWqVy7osp+QKiqiSvipn+oaK27XycX0dK1OW/lk+giD+Sbx2uQo
         cYXpXdewVKpsQxvu100c+pCC81HIH5kk8NxOA3KpwRXncwKcX9RfJgWYlVpahD9UHiDZ
         cGDSUfCSLnzX9Mt7flBRl7vNXGn5ina6MtpVhhRwKxzGDASADMzrjKk9yt4GY8kK0OoZ
         +u8xuVG8cfINi+WvfZYWUjr5bTZkD7pzeP+KyNVCsrGX/O8o3ASIZvSBoNsUjNrKLnHv
         QdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJMrs0BTYtg7WetIITx1Ab2b5lfsKukYxYHcdWEU7D8=;
        fh=LJtStw9T80xQvLmdlHQ6f9qRUV4kG0Rnt41vu2oyvsk=;
        b=XkRTAO+a6Aop/mKgG//4MOROIy9AhgKSzCB0bajJma5J0OOiHgHwfBnAxAQ8FOiGo2
         c1D6nVdZCwlNZg9pKYjz3aJSwLKorfdJ6czokbTqjqKwZIEdZrH4I5poujTXZTtzHz34
         mzoAXhXnyCXUB+e7k8zjlaUXDqkP85eN/hRgmlXvSi6Kj94o5vb3+b1dXvn2WRDfDT2X
         163FYwd6lAqfgGMkuPg554LO+hOY9/pwKX28r8982cCt1Ng0SGgZy08l9M/ZlkuOx7nY
         8NQ6u1ItbAqPjax8bF8shf/0ZiPxrELZjo8oYdlE1d/6v1LVffRWHT2QJfJXPZ0z4ox+
         dKbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792075556; x=1792680356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kJMrs0BTYtg7WetIITx1Ab2b5lfsKukYxYHcdWEU7D8=;
        b=S8V8/SC1KORhzrxzC7R+m/vG29QzYYZGH9wev7JsB2jQEGBYDxeR/NQCRS20SZLAoD
         dDIFtVK0Ah7Ce34gAQA0RYZnLMKrSkFoGjPLhjxC3yaYAbmDiWPqs4E3wL8og8JhoBds
         sHGnu67q8AC7ZRJy56IpPpOq6FAfD40Oh+OVQrYwsqBJv/qO/TEdP9nqobURCjGF4Dyx
         EZyHxBlGg8yfy5SolW/5BeLMxIGcEYLEGXYxY86zD7XbWT8kyywvG6rw7S6w5Rt0ZzPT
         HsWBC4S1nYHj06DMyI6Gf5/YuRXF0LEgbYL/KRf8FdUzEt05w+tZHiD6tqVizfMejZRp
         6tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075556; x=1792680356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJMrs0BTYtg7WetIITx1Ab2b5lfsKukYxYHcdWEU7D8=;
        b=QwzUODP7pqta19SaHhN/cpZbb2bhXuTVXZUiJcxsV/Rm7kVoo//L7dj+A3l2I9CqVT
         5m0kmMLfw1NIERG15d8/zsKNM6km9aKMvqjOTcVvGjvDtmm0U1lhgt+GoaYzJJjLURmx
         /D5BVkj3yztYQ6Ry/SJB4WXii+N2S94mYsxRv9b0LzCQVd7zsEF7gVsSYmYfBegTn7Qv
         SPaTJIguZhwhfLxb/KDW4RSsw9iqVVYEQtD/K5b8UqmphCKBHGTpRlgMhdFXj1vluxQ1
         KtDrvdynYhkXhslLfa6CO9VHUOygB9ZcRGiY5qBbhgiGBdyDf+11M37WiCJalyuR0oms
         QrYA==
X-Forwarded-Encrypted: i=1; AKwUvBwL0mLsBsZgLnfpwA2FNs36JsNNKAiYbDKcfWzhdfE/Klfmgi9DtlckhMHdcjTacd+MGU7ShFbvnlk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4axgKiAyDYoxjGrkiuw/axK2cukbIytPBcJd4SO9kVvvY5OO+
	GF+Kt0Z91pGhM90E0xsWYkA+N5iNCCxUsq4umX3vYBHgP9u4TpRBWDapvEjA8CJ9q4/huxvBvwt
	P7zwfudTrbCbiY8RrMUexWWm2oplpOqHaWzpoVydgUt8Grf4lnKApoutavcDOie26LSVtHFiC82
	YlxPH8C2fWj++P1RS+7YqGEghNdUXqcwdy7pax
X-Gm-Gg: AYBFou0SXUrlOl85Lc/Yy2+Jxh9FKNcRaSF3yuHUe1yXvZiEc0bWPDl96siCIMK4byU
	ChzH5ZJK1m3L3j/ZTr+BfmtZGYvxRIanMr4DrW7EuS6yrNn96monjT0KQuhtdDZeCWhWvS4mZqM
	g81iu8A0s3P1mIgzIuLW8swQkJpDTjLUmjnUaUm0MZdDcHerUuRd+95oSSM4Y0vs8WfQYY1nMvu
	zQ6O3KSEvpO+p6CWQ==
X-Received: by 2002:a05:6808:c227:b0:4ca:9850:4dd8 with SMTP id 5614622812f47-536fafdd8ccmr207182b6e.10.1792075555621;
        Thu, 15 Oct 2026 07:45:55 -0700 (PDT)
X-Received: by 2002:a05:6808:c227:b0:4ca:9850:4dd8 with SMTP id
 5614622812f47-536fafdd8ccmr207137b6e.10.1792075555012; Thu, 15 Oct 2026
 07:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015020811.1132314-1-keng-yu.lin@hpe.com> <CAJZ5v0iYieKPAQTDcr+g6o+JHz+kMRqYYmakeBsyn-BxtxQcvw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iYieKPAQTDcr+g6o+JHz+kMRqYYmakeBsyn-BxtxQcvw@mail.gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Thu, 15 Oct 2026 11:45:43 -0300
X-Gm-Features: AclHuK_vz2mggd0RcuByATED0GopB3zO_jGEVLBVHom48STilEFyTjbRWniIMTY
Message-ID: <CACaw+ey8pZb=Vg+FDaK+K=iyho634sgs=G7nm60mooCD=PuVFg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/PM: Restore BARs after powering up during enumeration
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Keng-Yu Lin <keng-yu.lin@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Matthew Ruffell <matthew.ruffell@canonical.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com, 
	s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com, 
	zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com, acelan.kao@canonical.com, 
	michael.reed@canonical.com, dlee@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Desnes Nunes <desnesn@redhat.com>


Desnes Nunes


On Thu, Oct 15, 2026 at 11:15=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Oct 15, 2026 at 4:08=E2=80=AFAM Keng-Yu Lin <keng-yu.lin@hpe.com>=
 wrote:
> >
> > Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> > initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init(=
).
> > The helper ignores pci_power_up()'s return value indicating that BARs
> > need restoring. Its resume callers restore saved configuration
> > afterwards; pci_pm_init() does not.
> >
> > D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1=
).
> > After enumeration powers it up, pci_enable_device() reads D0 and skips
> > the full power-up path. Previously, a device still in D3hot at enable
> > time took that path, including BAR restoration.
> >
> > On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
> > D3hot with No_Soft_Reset clear before kdump. Diagnostic reads on
> > v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
> >
> >                                    PMCSR      BAR0
> >   before the platform power call   0003       f4100004
> >   after the platform power call    0003       f4100004
> >   after native D0 power-up         0000       00000004
> >
> > The upper BAR DWORD stays zero. pci_power_up() returns 1, but the BAR
> > address remains zero while dev->resource[0] still contains 0xf4100000.
> > Without BAR restoration, the crash kernel hangs during boot. The
> > last console output includes:
> >
> >   pci 0000:01:00.4: enabling device (0000 -> 0002)
> >
> > Restoring both controllers' BARs gives matching readbacks and allows
> > kdump to save a vmcore and reboot. An AMD Turin xHCI [1022:1557] shows
> > the same BAR loss; restoring its BAR also allows kdump to complete.
> >
> > Read the initial power state first. Otherwise, pci_power_up() may
> > request a BAR restore based on a cached PCI_UNKNOWN state, even
> > when the device is already in D0.
> >
> > For devices already in D0, only synchronize the platform state so
> > that ACPI calls such as _REG still run. For other states, use
> > pci_set_full_power_state() to power up the device and restore BARs
> > when needed.
> >
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> > Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initiali=
zing")
> > Link: https://lore.kernel.org/r/CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=3DWWO=
QjDAPmSepSAQPg@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> > ---
> >
> > Changes in v3:
> > - Use Rafael's sequence: sync only the platform state for devices
> >   already in D0, and use pci_set_full_power_state() otherwise.
> > - The D0 path no longer runs the full helper's ASPM update.
> >
> > Tested with diagnostic prints on AMD Venice SP7 and Turin. Normal
> > boots made no BAR writes from this path. The crash kernels restored
> > only the cleared xHCI BARs (two on Venice, one on Turin), with matching
> > readbacks. Both systems saved a vmcore and rebooted.
> >
> > v2: https://lore.kernel.org/r/20261012104645.975190-1-keng-yu.lin@hpe.c=
om/
> >
> >  drivers/pci/pci.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8cc6a89130b5..895969fe4520 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3255,7 +3255,15 @@ void pci_pm_init(struct pci_dev *dev)
> >         }
> >
> >  poweron:
> > -       pci_pm_power_up_and_verify_state(dev);
> > +       pci_update_current_state(dev, PCI_UNKNOWN);
> > +       if (dev->current_state =3D=3D PCI_D0) {
> > +               /* No need to do a full power-up, just sync-up the plat=
form state. */
> > +               platform_pci_set_power_state(dev, PCI_D0);
> > +       } else {
> > +               /* Power up the device and restore BARs if necessary. *=
/
> > +               pci_set_full_power_state(dev, false);
> > +       }
> > +       pci_update_current_state(dev, PCI_D0);
> >         pm_runtime_forbid(&dev->dev);
> >
> >         /*
> >
> > base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> > --
> > 2.43.0
>

