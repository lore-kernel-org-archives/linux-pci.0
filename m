Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CF48663E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334142; cv=pass; b=ho/Ew/BvGy0YmR3LtqtF1gi5oWPltYTTsmtyEeKjlyTNoehWyI2sFBkZky1addRR4uL336lIhhetVh+fA/0n6mnKsdCVT884B9uDfNbL6tU/0708eX6oh+x1EsmwNjyzPFMCOLHPaAhvWi/y35SxKqyaK7bwSqRi6bMq48UeZzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334142; c=relaxed/simple;
	bh=C9xtxbuUwTl2/4FiNCbCnz92H6bjM6ISYPijuuaBP7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8VamAoRiDZfOr7wTynp58VnhZgoThYDQW6QLXPSuJmzBcqLbQ4UdswUQx8YNn6tQUZIp5XEYe+vmW3AT6V0XAVCm8omGYcoHVdWO3Y6przGE8tGPP1kLMaVpXF2Djt9V9t0oF2G4klv5HdisUWoZPsYRhBFrq0rMiJ6JFKUU2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjpXqR0Y; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjpXqR0Y"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81ed2a06b9eso10863037b3.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334136; cv=none;
        d=google.com; s=arc-20260327;
        b=dRQm0VJ1MV5KYbWwM82QQUxVriN6yiNVefoRH30DP8b4EvXO3VQLFp7KSCOnZK5dsT
         8a9o1J3+bhOebS+29V5eI9rCPHUg0bbRsvrZf0OpT22hujkTxGWUfkNq3Cby7+tmY9vH
         apnCQHtmLAYz9LOEZL1uePh5C3YwZs+btDae0UBiw8dexeUPP90l688YmLa0ZH6LI6Yu
         A3w5ypyjeLvYHJdtJZfgvA+rfvJOEzyXRRmbBf7mH42zZalx7DIpo2+zzLVGt1AkjIt+
         YV+nYOc1Rd2Qmh3kHwI3q1D66vcOBNWEaKam78Kf8r8RRFodMVIuG/FkbH8rPddQ7uHI
         jrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ILQW7wTx7MCavtjYKz64KhhUuc2hqgjwomjCvbjS/JA=;
        fh=V8DifFPxYRxJ9Jt00V9USkncMS3vxQl1442FY0B70t8=;
        b=dnBJhSsUJCwPD55ekm86BEH+jBi4TYWHWuCe9Z7ECO8UhsfU529phjD/LN4DOcMQFC
         LUEI8j0AnBdnJScOf8TCOGDMsY4lYk3wd8QmNomHNzQaxCtG0l6vL2Cgz43qxyKhW5yU
         IP2TsZDyoAqr5gJVW1Zvb0Ocr1fwYQHrzognbDF9dp2eIEIlrvGhZe6lIiDTTc8Xi8zr
         sUWCoS7rnKgOnQ+Bs9rHZ4NcN5OJczChX3oKBkzrqbrBZRSCCuEdTGBrJ8Q85RivFWuy
         WI6ljzwUjKFXcMB7S1oLRrIluhoc9vsXwb9BZidWuKDLAXLS0Q3PX+SzLt3O9Ja59IMl
         eIhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334136; x=1785938936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ILQW7wTx7MCavtjYKz64KhhUuc2hqgjwomjCvbjS/JA=;
        b=jjpXqR0YFf6ekhWMsG4jve3XQGUZMPCvLbVCKpbrL9Aw5uxkbvKrZP+89Q9vwa5xpW
         QL+kEpUErsvgomW2e88CJwqZHNz7sLXne1mrM778ANvcvtRCqov4JuQsZqD0caudPRPL
         nGVENNSpLFCIzZe5oQMXm3M4JvetsH2GCuTJXNgYyulRq0EZOHg9uCgvkMUFEnfEbI4a
         8oEYPjfjas+byx4RqOqqAnK3DUIiZETPwMDZO7uVAezcKSecI7cZIK2/WrASqnirreDG
         8+92KUEWgzYHgLn1I28HwQK+LE4CsJe01F8E0huUbjs/fS70Jqlh0J+3jBnivc67zM9V
         cv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334136; x=1785938936;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILQW7wTx7MCavtjYKz64KhhUuc2hqgjwomjCvbjS/JA=;
        b=WdL0YjEwIOghTZKU4YQFjvj4PeMxp/0bAI9D5yin76KiABdzNmYurEu9R+IE3VGvOG
         QRtcT6zRTXY/LNLZbshAflIli50E8gaQ5uYTNJqbratta1XdVgMIfxIM0TIkLf7sOGcF
         nZG7MzrBdW2FY4rqYlxw9uHUqTwgDEj7cKbFvYkpIiDO+cVFbF49dbez7PKytJza4NQK
         i38dOOP/RhlbAc0vhoyX0aS9b+9G/GMGS4Yb9U6WHJQ31qCYuVDTLc49h80Ux2Ev13xe
         guV/t6RfKmaRge9rKYiWIGFONpHoDy+swpKo8/eqSh1mW1gtgZedYcInRjeaTQtG6SKv
         I/Tw==
X-Forwarded-Encrypted: i=1; AHgh+Rpxc5zrPa6N4e7CVU17+n4FJpQ7tVy5JkeCFr1Imi8i7j+TDGOxiCcfdogowm9PWni8tyqFp4l9sA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LKZmekdMVpxVZkSzBGOlW/edhGQeZd1Ijckg8yhyuQy6Op7k
	uMzCVZmIxRHMJZ7uCFDyCS88KDAgcSKQ84FSKBlO14xAxdeG0KJqzFR4eQXwpOI3CCaGWMQcqlY
	0gsJRIqt84ecNb+frEsmDyYi6EqFfDEA=
X-Gm-Gg: AR+sD12mi1cDG3Tk/kY5VxdJ0cd1+z6JTgy+plN3Y95UFbIPgykxwCSbBZHfjNrCnYx
	8ePd2wkqEmh5Gdtf3i4FREnscQrTr0XF/W6HR8a50q84y1/WbJfxKpwKwUxi1+YZoK3j6u8sa+o
	VuvCMt4hUQvGp7plCGNcfMYrTeLydzl6Tn8CYNTZxTnty3yPnOtfaRAtMavIsuW6gfL1D0T4TkL
	iRZzzlCnZZXH3ap3hgt8sA9ItlO7Hqsl4PVkJLqU0KmbYx6Ck8vlCAPE2V55oOryE4xwl2zlN/B
	SJoWHIIZ6H3qT2aIX+3iZTeS2cP4xnkaLUZaonh9FcfT9xjteDzm0Q==
X-Received: by 2002:a05:690c:f0a:b0:80c:85e5:8741 with SMTP id
 00721157ae682-81f993df989mr36253797b3.63.1785334134768; Wed, 29 Jul 2026
 07:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716230411.2767394-1-tarunsahu@google.com>
 <20260716230411.2767394-5-tarunsahu@google.com> <20260717025913.067B41F000E9@smtp.kernel.org>
In-Reply-To: <20260717025913.067B41F000E9@smtp.kernel.org>
From: David Jeffery <dhjeffery@gmail.com>
Date: Wed, 29 Jul 2026 10:08:43 -0400
X-Gm-Features: AUfX_my5xPWn2PPlT7ZWQqD-dmkDU18YDfPkQgQ3vbI39xQlspjH-YQORqbG6Us
Message-ID: <CANghDUUFrGN3CiJmRhQS0jtDwNnoWbKv490E=UxDXGgKsy6m7A@mail.gmail.com>
Subject: Re: [PATCH v19 4/7] driver core: do not always lock parent in shutdown
To: sashiko-reviews@lists.linux.dev
Cc: Tarun Sahu <tarunsahu@google.com>, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 10:59=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Unprotected read of dev->parent introduces a Use-After-Free race=
 with device_move() during reference acquisition.
>
> Pre-existing issues:
> - [High] Dropping and re-acquiring device_lock(dev) allows dev->parent to=
 change, resulting in locking an obsolete parent.

We could add additional locking around device_move to exclude moves
during these times to quiet both the AI tool's concerns. However, both
these concerns are already not possible in reality. The only user of
need_parent_lock in the kernel which will use this code path is usb
devices, and none of the rare devices which use device_move will move
a usb device which has need_parent_lock set. Thus, there is no actual
device_move which can cause these conditions the AI tool complains
about.

The AI tool is finding a non-existent issue by applying a very
specific special state as a general condition. If really wanted, I
could add a patch which locks out moves during these times as a form
of future-proofing, but from my view of the code all it would be doing
is creating additional code and complexity to the driver core while
currently fixing nothing.

> --
>
> --- Patch [4]: [PATCH v19 4/7] driver core: do not always lock parent in =
shutdown ---
> commit 6be56e5bea0fe214a5199c9f806c49e62e60127f
> Author: David Jeffery <djeffery@redhat.com>
>
> driver core: do not always lock parent in shutdown
>
> This patch modifies the device shutdown process to only lock a parent dev=
ice
> if it is strictly needed, rather than unconditionally. It also defers
> acquiring a reference to the parent device until the point where the pare=
nt
> needs to be locked.
>
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 82a7af1f3ba2e..31f95e86856e0 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
>
> [ ... ]
>
> > @@ -4925,12 +4921,32 @@ static void shutdown_one_device(struct device *=
dev)
> >  static void shutdown_one_device(struct device *dev)
> >  {
> > +     struct device *parent;
> > +
> > +     device_lock(dev);
> > +
> > +     /* use parent lock if needed to avoid race with probe/release */
> > +     if (dev->bus && dev->bus->need_parent_lock && dev->p && !dev->p->=
dead &&
> > +         (parent =3D get_device(dev->parent))) {
>
> [Severity: High]
> Does moving the parent reference acquisition out of the list_lock critica=
l
> section introduce a race condition where the parent could be freed?
>
> In device_shutdown(), get_device(dev->parent) was previously called while
> holding devices_kset->list_lock. Now that it is evaluated locklessly in
> shutdown_one_device():
>
> CPU1
> shutdown_one_device()
>     evaluates dev->parent, but is preempted before get_device() is called
>
> CPU2
> device_move()
>     changes dev->parent and calls put_device(old_parent)
>     dropping the last reference and freeing the memory
>
> When CPU1 resumes, could it pass the freed pointer into get_device() and
> dereference it?
>
> > +             /* the parent lock needs to be acquired first, so re-lock=
 */
> > +             device_unlock(dev);
> > +
> > +             device_lock(parent);
> > +             device_lock(dev);
> > +
> > +             __shutdown_one_device(dev);
>
> [Severity: High]
> This is a pre-existing issue, but does dropping and re-acquiring the devi=
ce
> lock here allow the topology to change?
>
> If a concurrent device_move() reparents the device while device_lock(dev)
> is dropped, it appears we might lock the obsolete parent. When we re-lock
> dev and call __shutdown_one_device(), we haven't verified that dev->paren=
t
> still matches the locked parent.
>
> Could this defeat the need_parent_lock synchronization and allow a
> concurrent probe or release on the new parent to race with the shutdown?
>
> > +             device_unlock(dev);
> >               device_unlock(parent);
> > +             put_device(parent);
> > +     } else {
> > +             __shutdown_one_device(dev);
> > +             device_unlock(dev);
> > +     }
> >
> >       put_device(dev);
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716230411.27=
67394-1-tarunsahu@google.com?part=3D4
>
