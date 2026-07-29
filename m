Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD184963B9
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332743; cv=pass; b=Iczg616g7HxJVciEOP9yX/WJqgOMq01eEyGsLtzCU6Wb24dphztiElNlMxQaPW0FbHpj76VBrigjqewEH88gpMVitciXahmgBlclux/TQjEl4grSryQe6WjOJdsUAE3Kyd8TywRToW5Qq06pGHZ3i7SPBgaPFBvLl6UchB5dkss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332743; c=relaxed/simple;
	bh=UZAhy5157NkSAMSWJcdNZefOEQdqg3ZnXPVybrWCqrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riswaOBp+KdYwWIjOrpx2tQj/3oSmp58PoMZP+wE82av+CVs3buzT+432ppl5JDHU1KRDHEsrGadda+I0r3PRnsjx69Oujl0uU00LMLxMngxVJoDTSG0dsfV/qRs4pXmjyYvoHj3O1b4JHMuCPuKpDtmrllNiSpqQgUc0IWH3f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chWEUca4; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chWEUca4"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dbcb505578so11528827b3.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 06:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332739; cv=none;
        d=google.com; s=arc-20260327;
        b=KA9q4mLUfTx8xrwV1b2NlTYrFy+DUZtVpbjXPJzc0/XIYQA1jsWcYBN6kDeclu/Utz
         F3WRGrYeaZ8BBQwx8cNBQ3Vohlmyfi+md7b1htteLQUCKY4k0VsacM3HAOr39pEB5NBA
         c/I/F6U6TX9YNwc8OTGf0wxaF9MTWBlRhyrHbevp/DVzhivLlN21FlFPEf5s/QwDJ28s
         cC+Qlw65oMN1/nwbqM7X2oVF6cEKe0Sy0Sqv7rjaJG3IZGO7Ilhz2/esgrreoWz4vACD
         MNI295wcNNMxq9LvS/I1F3WR3rbU/cJkV7YwQ2xRS+ZYS61ilEtQKOtalG+5A89mEYP4
         HjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHtZAPYn3Wc91D71uLVL563MpKOhtIJrqDFEQxe1/jE=;
        fh=P4bRhnFgOQ6kGVp/E+uclb5gA0IyOgiFq908tR4auXw=;
        b=ASx7pEQl3WCMNQfhl8jhyUgrh4U+6yqmEjjKWemzyhkQnzZ01KcpbKXreFKxAsG2kh
         Rup6NTdLJXf06ASQKoBiBtTGvjsCD+gib8yE+l1/rsRE7Qrcggpm1+B6iRy1hnZnHq2b
         haVH//eB4vN0n3fSKuY42rlpV6XRWXjnHHLkBEGTt1UhbIf5ROWeStflF3tvEKa9oSEW
         vOQm3JHTzGwm7pCzOq1Vb7PMiEz9KEeq7DWytB5RR8hjv76Zo3Ar4xSekvVr7dy3ByTN
         66mtRV7gcSUACMfIePZpC9xtlCM5tLg8EBX/Zu0SC0zecgMnFui0AT5tQhv2z8QiGWyf
         K2zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785332739; x=1785937539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHtZAPYn3Wc91D71uLVL563MpKOhtIJrqDFEQxe1/jE=;
        b=chWEUca4FTVNfCwKcW4Q9TaCtwloZxppT6AI+IxPPO7mjujJKlrQ+ARfITCLQVZFFK
         qjJMeVRGPT+bOLxeCufn+K+zaztiBTgPl6uW0JWN91pEyZtOhufrK4BBE8LR9FVsq15y
         NruhKJBnN7Z0dj7o0CklK2JgXUc5LZwcMce6XBhxNDkXhml0x3ujG0Dk7uYxHgb8Htqi
         S0iu2x61ih1nEDMOw0/tJgI1a6vmt7eKbXOCIPFBOESGdUT5OsFcTrBmxDQ0IzE9RJIX
         8HNpvtDOW9B79d0+pFgcqiKWF1cSilXj4HDYuFiJCLB/4TzSEUQy1oWE3ptmgSi6hlZ9
         rLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332739; x=1785937539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHtZAPYn3Wc91D71uLVL563MpKOhtIJrqDFEQxe1/jE=;
        b=hRvis5HUjUkTFPvgRXKb8UCTPIlx8Smg8HzMjhBvNLAjLAWZzJLmoVcbcwkTOuMWJt
         15nAi8GQq+HXH8JnUV+t9JTWjGx1+Oi0oqApYV2NQOhMl0QpGkk6EBDAeQzAYOErijby
         zIihjW+4r+m1HV9JAv0q0cMiPJUc7jobamzab6pTnhij3lgZ8TyTlfciBHdn4VGhGGaj
         1DnE5qeCNd6pTX5nPoym1pVCYCiZSW2Pu+ewFTmkNVzWhvBZWMfthXgEkFxLzVCFkQ9q
         Caw7ksPXI5bYfkSEyYC50Qm7U26xAE15+6uN2kSAdO8G2HFbGsvtwFcMgXKGLBOXU+Zm
         jXhg==
X-Forwarded-Encrypted: i=1; AHgh+RpDRYHBDAG91OlAFD1gSRQDFOnTVgoglp+cz1tZ5vQyOiHvHIi33gGQ4Nh+mwzbc6+lzL43YZYJxmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xqvu8hCokOnB5l2JZh2YTTRZE84MARagm5VSM2LQ9e6tjKPy
	i93iKooz1bJz7oaTvQkEA1cao65jCAwvZr9GgFKc4TyZ9pTOpkXdld0fGRTENoG0q281b4SOX+b
	dpqfHE51QuZmKpaIzG7hFCTgqvWzO34E=
X-Gm-Gg: AR+sD13FISVUrpeXGBFwedkG5tzJMmENwAS7dyvLXAH8knMNLC3I/j8pzRmscrbt6Wh
	pKh2r2Sc1mgBGY5DvJTEED4zfRzZ1vJxy8PF8XhWSxDmoqC5HRiu47lfWgrloBHFqqgnxCVXPaK
	Y5i0bLO429aWcfFxS3IIn9faFblOiSnkRT6Y//FeyTh2zZp9xXutV9vZ21YlQHQOu9y369qVjjd
	tpd/uRpnaw85ZNCW2hwBorDsfP95SJ3wrcG/NzPfI6YauO7qiVKJ3V+iZD69yyasaUMjjV7u05D
	FQWPqQs2nBBPl7J8s2M0bKhtMGZTzVU/B1ypnpID9sk=
X-Received: by 2002:a05:690c:6c01:b0:81e:1437:5763 with SMTP id
 00721157ae682-81f99247c84mr32859177b3.62.1785332739192; Wed, 29 Jul 2026
 06:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716230411.2767394-1-tarunsahu@google.com>
 <20260716230411.2767394-4-tarunsahu@google.com> <20260717024938.128D91F000E9@smtp.kernel.org>
In-Reply-To: <20260717024938.128D91F000E9@smtp.kernel.org>
From: David Jeffery <dhjeffery@gmail.com>
Date: Wed, 29 Jul 2026 09:45:27 -0400
X-Gm-Features: AUfX_myRPaVDt58yJr6A2eZEJEygxGVewYG3ucJaoFeFR_lLDJKTrjk92Ni0vOU
Message-ID: <CANghDUVJNULztJ+-8G=PD9eXjdBF=QuHyXhYszzZO5rtzyj5ag@mail.gmail.com>
Subject: Re: [PATCH v19 3/7] driver core: separate function to shutdown one device
To: sashiko-reviews@lists.linux.dev
Cc: Tarun Sahu <tarunsahu@google.com>, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 10:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The refactored `device_shutdown` discards the parent device poin=
ter returned by `get_device(dev->parent)` and re-reads `dev->parent` inside=
 `shutdown_one_device()`, creating a TOCTOU race condition that can lead to=
 reference leaks and use-after-free.

This gets cleaned up in the next patch, but I'll rework it so that
this patch has no functional code changes and is only a code move into
a separate function.

> --
>
> --- Patch [3]: [PATCH v19 3/7] driver core: separate function to shutdown=
 one device ---
> commit c3cdb15ac9b6efba6077cade25c652c124eaa9c7
> Author: David Jeffery <djeffery@redhat.com>
>
> driver core: separate function to shutdown one device
>
> This commit refactors device_shutdown() by extracting the shutdown logic =
for a
> single device into a new separate function, shutdown_one_device(). This c=
hange
> is intended as a preparatory step for supporting asynchronous device shut=
down.
>
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 78b90326addb6..82a7af1f3ba2e 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -4898,12 +4898,48 @@ int device_change_owner(struct device *dev, kui=
d_t kuid, kgid_t kgid)
> >       return error;
> >  }
> >
> > +static void shutdown_one_device(struct device *dev)
> > +{
> > +     struct device *parent =3D dev->parent;
>
> [Severity: High]
> Does this lockless read of dev->parent introduce a race condition?
>
> In the old code, the parent device pointer was captured and pinned in
> device_shutdown() using parent =3D get_device(dev->parent).
>
> With this refactoring, dev->parent is re-read here. If the parent changes
> concurrently (for example, via device_move()), could we end up operating =
on a
> parent device that we do not hold a reference to?
>
> > +
> > +     /* hold lock to avoid race with probe/release */
> > +     if (parent)
> > +             device_lock(parent);
>
> [ ... ]
>
> > @@ -4925,7 +4961,7 @@ void device_shutdown(void)
> >                * prevent it from being freed because parent's
> >                * lock is to be held
> >                */
> > -             parent =3D get_device(dev->parent);
> > +             get_device(dev->parent);
>
> [Severity: High]
> Is there a reference leak here since the return value of get_device() is =
now
> discarded?
>
> If dev->parent changes right after this call, the original parent's refer=
ence
> will be leaked. Later, shutdown_one_device() will lock and drop a referen=
ce
> to the new parent instead, potentially leading to unbalanced reference co=
unts
> and use-after-free.
>
> Should we pass the pinned parent device pointer into shutdown_one_device(=
)
> as an argument to ensure we lock and release the exact same device we too=
k a
> reference to?
>
> >               get_device(dev);
> >               /*
> >                * Make sure the device is off the kset list, in the
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716230411.27=
67394-1-tarunsahu@google.com?part=3D3
>
