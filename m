Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15C8248B
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777857813; cv=pass; b=jRqmoCQFE+kfihC0Swd4jX4e5QiU6mnNT3SaGswphY2hdxvHATg3XS58D/tAMVXnD8uiDA3i1kTX4eJLSbNGyKVp3vNBwIrmGVpCw3trgxLQGsU/dJV7WeiSl2bF6LnaKoW9GZM9ffcCeXSqhzXWmrdMoQWMpr4MPwnFnz/iX1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777857813; c=relaxed/simple;
	bh=8sdI02B/mV8t0/D1hNqUUuDuSgv5DnBU3ptBK27Rk1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzJTZJnuqUPdnes/IRTPIkYaX9+UuJvi2furglbn8X1WEQ2HcRQVtPMelOYLHv03yuRLQYY9KeWQmiH62xIw7vGXZ4rq6zDE1iJeFSoQT5JZzQ/oqrU3Uk5gQG2pPXr7k6/A01I2UIcSGvZSm5MDW8FuX0f4sDfm/nIw411bPyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py3hqYbY; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py3hqYbY"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a7109f568so38977157b3.1
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 18:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777857811; cv=none;
        d=google.com; s=arc-20240605;
        b=DKfp1dXGWsHnmQD/Tfxf3UnQuvIlLkg6ux92bxdoAJ/Gozy6Hw6RLK+5ZSVkz0Sbdk
         kL/7jcxf7EX76v80wy9lBRsEJKzZ4geSsBlxrJQAnkS7kmTiSSi/QLd4OGtGx96CfK7Z
         QGgtbzq44M34w9IUb/eiJbHWhpftk6dkHQgutlu+zmhHbuGkyortTHyhm5Vru6z1PUQ/
         NgqnWsgkzWnwJWbM5ZqcahmXje3AQFDKw1ntieyiIwshyaEXMM7IrKV60PwgfiCCOoAX
         eKMYgK1VSff166S+8ZCxSoRZVc+9blglEjcy2hm3vjtQUCoGybt+/DVkx5j0a0gcd/cn
         g78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnnjZJnxpC114lgHTXq4H9DIaCx9qFlYg4tgp/jUJVQ=;
        fh=99/qQXvzscAM7yzbIbgYcELHOp+r/6xWiQuPGB9MxbA=;
        b=azIlFCCOCJ3KZOgncNueIrBz2SdhsWlRIEWRaL9IB5NKprDPe2jSD3MxKJos/iF1qD
         pi4KCO5hjeI5sSjWjGxAJ8iddFdrgHmmIqk+cM46aMRakDfdLGIJe0PZSJ5xYR2KZsFr
         /qmNUdEmLPFWQdiCy4x4Jyj7GQdvX5LYgoGjZG2C4x2RIjy74aVymC9W5vjM0ecNFWCY
         MTR2hu/2QmYE0uizuMwXobVaay3y33SsEPNxSbu5d9OJxNVnkacPXZHQFTGZyVKKPqOu
         ZUGTmfwhoPQ5u7owZE5rAjaeNeiEzU/GELzumDGyvI6TNTFnDOXLqMOTno/oqcv4ZhpZ
         UXJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777857811; x=1778462611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnnjZJnxpC114lgHTXq4H9DIaCx9qFlYg4tgp/jUJVQ=;
        b=Py3hqYbYtD8Ot3eb5yo03KWIeBc0BH2JQJs55rr7VF6beAZb007z215kO6wAjjGy4y
         8AG5EXT+iMlLBgrBeuYmvmnTFuG2SiMEsrK7UgW6YCc24/9WIcvx1alfuIYv4W/pJ2m5
         D3xy22QyMQyUHI7QtUmAf1GzllTr/SWI/eKEgoTgpFSXDjgBe6O0321eAs8J2eXRJWpg
         /KM64BW+Zi8Ei30dTTnQH8l3uQELMwsoxJRPFU4czruYfMnthzKeJcGSaxzFe2fnIc2a
         Qts2faR5jF97SOiKUG/8BKUVtJeNSvsKnCFrxHlpReptUjAzOUpP/tQusWolk8bdXR/R
         YnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777857811; x=1778462611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GnnjZJnxpC114lgHTXq4H9DIaCx9qFlYg4tgp/jUJVQ=;
        b=jHZPIRR3Owqe2tKD1M0yZUhYjVS5lMm6ZYZccWPohEtB8Pr7byPYRUWy5/FXXtSMxX
         1p8Woua43pZzwqsXFiaKrSh7EEWpMJ8SJjbVmnfSWZWmXx478Y+DbPaJUITIYb9lGuDm
         lX8j2Wkg2/9errHn8Dy1pW5QhD7yDFSiL4PoYOaKLzkr6tAJkYoIckq2+iQCBH1U2QOl
         F2o7RWlTLkdHcPpISJiGbsb3CKzuRAQ5XsSnKLK2yt7fGu3iAS9LjUGDK4vFFVvGNQJI
         oA7dRwoZCAhgQeeT1CBIH636fY/ErS7pQr7E7ntkreK0teiF+iLag24K/xz/Az2qwOBy
         tHvw==
X-Forwarded-Encrypted: i=1; AFNElJ8vyN+s/E8SY/N8K1TYGzFpx5NbpKwFiXrfPyQlgwzsmx8BYuTWEZ0NKmVC+JlJN8pJYZOysScuolQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPsWrrCDgyywqW0VGtcgVJPl3dK6rQcjFC2nTa6va2DEPMvF4
	OwLgy6o1eO3tP1hkQwrXpJCYVdIsTKfTyuhpeKn09PfGHakKcCgc2robTSPDkvCbSOjO0UxClYV
	zXO7Zy0IlunlXTanRa+7CUQcDf79Mdcs=
X-Gm-Gg: AeBDies6dl/GesrQNtqsnanLOJkJtBTWLsC6+mvKmt4+OLMRnhJbeSvnMOT1anDwCG1
	4wsZqFq5u4nR3ELLtGzQ8bYpL/hOXtjqRyho3L8ws255JKwKg1UZWkAUQmQx3LDRFiTCaTJwZsU
	kxr7aGE8PtyiabvwyMx/f8zy2RB1LQn4tUMo7b6LUZNIEvRaSnPYbuUb0/rNgP5KJCEs+8ZbVVs
	Emt5DfbISWasscF/8+4Js1S/DIf7gcH0cuIakmnFqzP7G6XRjVHcR61UpUw1Vahn9hV2RFgWGvn
	83u6gAl8Ux0Te8UKJ82k+2Tp8IYsbDQX2bOewg2av316p36rlB0jaVaV974oS82ct4R0mRs4s3o
	VRz579u4=
X-Received: by 2002:a05:690c:e3eb:b0:7bd:998c:7397 with SMTP id
 00721157ae682-7bd998c78d8mr6708707b3.26.1777857811454; Sun, 03 May 2026
 18:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502011446.125268-1-kartikey406@gmail.com> <20260503154557.GA1455207@rocinante>
In-Reply-To: <20260503154557.GA1455207@rocinante>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 4 May 2026 06:53:19 +0530
X-Gm-Features: AVHnY4LAzKE65UAqCQJ1ussP5u7mZnf1aw8lE27SCzqOyzz8PbJSatHCvDc7s8M
Message-ID: <CADhLXY41kZbPT5EdkCRMqjvmw7iguLaTMcrGDf+-5JRW1xE7pg@mail.gmail.com>
Subject: Re: [PATCH] PCI/proc: check __get_user() return value in proc_bus_pci_write()
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 12:16=E2=80=AFAM Krzysztof Wilczy=C5=84ski <kw@linux=
.com> wrote:
>
> Hello,
>
> > Check __get_user() and return -EFAULT on failure.
> [...]
> > @@ -136,7 +136,10 @@ static ssize_t proc_bus_pci_write(struct file *fil=
e, const char __user *buf,
> >
> >       if ((pos & 1) && cnt) {
> >               unsigned char val;
> > -             __get_user(val, buf);
> > +             if (__get_user(val, buf)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out;
> > +             }
>
> We could move to get_user() here.  This would allow you to drop
> the access_ok(), too, as get_user() would return -EFAULT on error.
>
> So, something simple, like:
>
>   if (get_user(val, buf))
>         goto err;
>
> > +out:
>
> Use "err" for a single goto label for the error path.
>
> >       pci_config_pm_runtime_put(dev);
> > -
> >       *ppos =3D pos;
> > -     i_size_write(ino, dev->cfg_size);
> > -     return nbytes;
> > +     if (ret > 0)
> > +             i_size_write(ino, dev->cfg_size);
> > +     return ret;
>
> This can be kept simple:
>
>   err:
>         pci_config_pm_runtime_put(dev);
>         return -EFAULT;
>
> The i_size_write() is such an unfortunate band-aid, but unless we have a
> way to set the size before the procfs entry is created/made visible, then
> the problem that this aims to fix is here to stay for now, see:
>
>   ecb3908046ce ("pci: write file size to inode on proc bus file write")
>
> Having said all that, since you are looking at proc_bus_pci_write(),
> then perhaps an update to proc_bus_pci_read() to use put_user() would
> also be prudent.
>
> Thank you!
>
>         Krzysztof

Thanks for the detailed feedback. I will send patch v2 shortly.

Thanks

Deepanshu Kartikey
