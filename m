Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FEC38A299
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485510; cv=pass; b=ihmPSIcao+U8j+cvO9YqrHv65AnMLBwCSzfNfauGiglWFzexb87myBmRL0m0F39mZxpBrUlWtP2r/+WY2nma7yWXsLWbLK02pLO+s7VPF9HxP5BgLOVMskEKaIGmSnS5ZpLQTD7CoDhhR8tLyxr57XrIcIsgEIm0fVXvS7OyzfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485510; c=relaxed/simple;
	bh=lhUCrdS8AzT6YiUpPvI6mNn4LsPzkSoFmcLVaCCgCIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7m6Tu/AT5kzXD+k7lnd7u+wtNUiDMlqVzL+aNgFUJLYevD5CH0LxLF9YmjwAvsJQLadc2iiF3jUHCRt5K7uJ1b4weegLgk6+XdUyJnmoRJYJBFo33Wil3oiX3K4p4l3jUwJ4xu8Ghoe51fsDKn31DSYJOEiAh7NBNiG6DWAOvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThDrrZ0R; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThDrrZ0R"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-135e7f4a295so2692309c88.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 14:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779485507; cv=none;
        d=google.com; s=arc-20240605;
        b=CwPd33ghMEWEZpQ2C9LFgegHA54GE1c0J5O2VqJoCpKApVxzU/Mrk9+nRce9/fcSZm
         0ieCB2f7XgBkDgcvnvXqGhwd7uiNHOh7Zp2JZTTcEtHET+xxoY7EJJS6vsshUbJy7bCp
         pl3cVjApPheerPU5xZ/EcpyuW6uKphd8HapGd3BbRntMLZ3wPTqPU8UNP3KZa+Dt6DzM
         5eJowlSI680B9+9np4wxMw44LeWgK6XWhlfTuho0hdgm1D/EvYOILlewKsAdayIjn3M5
         /y4vwfVsB9tgN7sYbnk5zH/4ptyuGYE8PF0apgFwhOfEZig2Se+ltCmg2ysekTaU+Ayh
         6oJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gH4ZOzGCp/1wUSJI9UajBWmDDn0DBrPYAfdLSalBmfg=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=D4FlLE4Cmj8rT7fWNLWEKUgUsM8o9E6lze2AFFIE8F9FltyijD6FMi6VL4zsyODqf+
         h6hmviSmLBXyaiPAB0GY7I1s/O/wdLUquOOD6sVKV/1+7NwmpEjSM1nJcPO2Sdd8L1Ta
         noUY4eCb2XIMrfCqi40w798gnq42xmnePT7gJrYowdZJ23K0UGxw7oBNBr7OmLZzglHE
         4AavYVj6gNdF3+pTzA8ORnpYOMefNT+hb7EORS1mEWnQ7oPKxPEq+Vr884Fsu9HeH710
         b9oQxEPjoEMGmKRtxkmppdIFenDKlx1reBaEk/Zk47fRFgP3vOO0AjbWSUQcLAnSkBLH
         YgsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779485507; x=1780090307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH4ZOzGCp/1wUSJI9UajBWmDDn0DBrPYAfdLSalBmfg=;
        b=ThDrrZ0Rwa4EOLgXCJZhzZJRLupJGEPSpT/JLk3SPlBsY17YMyYBoZvHTD+TlGjBBe
         hWlq6ic+L0WpHxB7tBOwvseTcDwXYN7cBnTJjgqpTd2EgRzgD7Un95z07/KxsS6D+h19
         5agb1mPxhKDUBcmVZ4RTl/yNYN2SGfv1i6XhERRveLj4i0xi1vhuD6/I0ju6J6pHjDS/
         FYLuHn3GQeCS8VgsshS5sgC+uFlt8jBzXMYG8MirpP8tqEu49XQ+M6ePxTtfb7f3PQvs
         mZuMwvagvkgJpL+N1mBVkyYJBErIStJnBBl9HQ+JPmVPmOUKinhsKNezGc704ATM8y3c
         1HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485507; x=1780090307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gH4ZOzGCp/1wUSJI9UajBWmDDn0DBrPYAfdLSalBmfg=;
        b=kiaHQgWF1Mu8U+pYVX7LM2qricJ1CoSM1Favpef5DKF8DgWTEhf5Cq18LX5AgvhJiH
         G3HwoosvnuI72z23IBDqk5VKefmv86US7o9MDo8R3h1W+NgSqcMgk+nlm3POhnRckc5m
         eJwMD79BxM7cvdCwv5kaXNno9SrLbDSTYrGavV1VnFHZLK8VhuK1vnaTcoeL7Ptvw+uu
         5kEhh3hvMq4CeeRju1ACS4M7Ea845kIZw5tqfqxjYvHIMnlNtKTr+KyQ+pEGyciZTlrP
         HXeD04B25LzZITSFqKgGQTX1ZeVbD2Fs1mQ0oEbjxwUn6X4SXl/HB096wsMFytptJhnz
         +ESg==
X-Gm-Message-State: AOJu0Yz/bDMO/Un/oPvAc06MvsmL8BtIryRsORjy245jK+q3QXOxoKgc
	uBLcOx5jf955hu1FplKootTPy4Sl6NlxybPavgfngnkbrWRxK6YnlcSvhTpqClt01xM6IA8SPlj
	DJFst1CkAwSHb341bQ72oY07FYqWH3eR6KqDIupCB
X-Gm-Gg: Acq92OE6jmkhn1mw6GyZ4b8nckwsEIztkuDYab8PU8pyzSO8bVrpPOws/WmlDGj6fmv
	IKny8q6SbbsZJ2ohBzXS8XCLJNHTiC+4eB9rShm4GjfoM40aJOU+MnSvVl1T0Vr9bEWfo1cv3cv
	fUuDnJQ6Cu4OLhEoluZRgsiuA+5o0sixkF/8hm8yNZtxIiORrcihukd4QGKdTBC8pAdr7nC4F7M
	4fvX55ZQy30gKP9X/FeIqffPn+fZVxci6yg6wwPI1BV8/78AtR8UGtFMN2xPxE65tnoEgb3bZwo
	8e51qD3KzN4faut9+w==
X-Received: by 2002:a05:7022:61a3:b0:136:8b76:14eb with SMTP id
 a92af1059eb24-1368b761676mr393791c88.14.1779485506467; Fri, 22 May 2026
 14:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-6-dmatlack@google.com> <20260522210848.6E4071F000E9@smtp.kernel.org>
In-Reply-To: <20260522210848.6E4071F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 22 May 2026 14:31:19 -0700
X-Gm-Features: AVHnY4KtUaRLVMOD-NXvStODJghFVTqbdFSmxbdst0oS_AQ4Epk4q_B3c0DtFks
Message-ID: <CALzav=dzAa9nxQ4ucGe1Y+Vo16qaJgN54vhyMtgzutXKp_s80w@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:08=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Mixing goto-based control flow with scope-based cleanup helpers (=
`scoped_guard`) in the function `pci_liveupdate_scan_bridge_begin`.
> --
>
> commit 12ae1f010eb68b0654e38ce2800545f03bf1b835
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Keep bus numbers constant during Live Update
>
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology. To keep bus numbers constant, this patch makes the PCI core
> inherit the secondary and subordinate bus numbers assigned to bridges
> during scanning if any PCI devices are being preserved.
>
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> [ ... ]
> > +bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_=
dev *dev,
> > +                                   int pass)
> > +{
> > +     struct pci_dev *parent =3D bus->self;
> > +
> > +     /*
> > +      * On the second pass, reuse the value that was set on the first =
pass
> > +      * so that the passes are consistent with one another.
> > +      */
> > +     if (pass)
> > +             return dev->liveupdate.inherit_buses;
> > +
> > +     /*
> > +      * If the parent bridge is being forced to inherit its bus number=
s
> > +      * during this scan then this bridge must as well, otherwise the =
PCI
> > +      * core could expand this bridge's reservation beyond its parent =
(which
> > +      * cannot expand).
> > +      */
> > +     if (parent && parent->liveupdate.inherit_buses) {
> > +             dev->liveupdate.inherit_buses =3D true;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Otherwise, if there are any incoming preserved devices, force =
the
> > +      * bus numbers to be inherited to avoid changing the bus numbers
> > +      * assigned to those devices during enumeration.
> > +      *
> > +      * To keep things simple, inherit bus numbers on all bridges if a=
ny PCI
> > +      * devices are incoming, to ensure that no bridge's reservation i=
s
> > +      * expanded to overlap with a preserved device downstream of a di=
fferent
> > +      * bridge.
> > +      */
> > +     scoped_guard(rwsem_read, &pci_liveupdate.rwsem) {
> > +             struct pci_flb_incoming *incoming;
> > +
> > +             incoming =3D pci_liveupdate_flb_get_incoming();
> > +             if (!incoming) {
> > +                     dev->liveupdate.inherit_buses =3D false;
> > +                     goto out;
>
> [Severity: Low]
> Does this mix goto-based control flow with scope-based cleanup helpers?
>
> According to the cleanup subsystem guidelines, functions should either us=
e
> scope-based cleanups or goto-based cleanups, but never both in the same
> function.
>
> Could these goto statements be replaced by directly returning the boolean
> value instead?

That seems reasonable enough, will fix in v7..
