Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505535208AB
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759720; cv=pass; b=W+3f5jPf1qF6/J8U8tnJnwcUrwJtxYWlBPb8cMv8diSFWP3OqQi3qQ8UZxWPiD+9IB9QbojAPdKog9lPPIWr+IMINWvoAEWdPWxNc05sqJTouPVp10TSCY6vhBLG9hDFy/+PF2z4qb+x+WaKElhujg2mGVJz5ghtrE1DnSkQTV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759720; c=relaxed/simple;
	bh=Pr9EeiZTbqiSt+KIaAIIUq+kKBnWHyvE8rHU/apYAjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF9BS0AzgKWwOdnzphi4asdlnClyjXjJN/o5xRtcX/1yniyo6PID0/9HfI7yQYcnTI32G7RDzqR7ocLUJ0VLipff3dTc00njf49M4p89FNZGwxBw8dbaay5Ptbs8Y6OgwqFL8oMcYkRRDjp7OJN9H1GSrAXkuYKmZEbw/jd/cAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wglF7trB; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wglF7trB"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so1529a12.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 12:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789759715; cv=none;
        d=google.com; s=arc-20260327;
        b=jaGHKZZEKPf5d4tW5jLmXKOLEWaUHRNosQje1VwDurHz/ZSUSUquYbspxhPNgRsToK
         yFvdyR0FSCdrcvV7LJOXs34fNNA+EvR1o93M7Wj0LxrjWvLNbRRXHdl2JXzA2tQF8ill
         OSDMaeWnO8La1bOC1vaTbOoGJxKNDPjgWbdFxq64b/i6qzxtmXy0uMzzPc+ZaMxymLnU
         KAnV2vmhRU6VULrJ1rKRQe20fYahF18FLp+pJOyoZZbmPdWdncdbPymuOmAzccLUIbM5
         frGnJmKey5ZtrNVbi3qq0vm1PEJFjRwIOgHiTiRQ0TyNnQZW0EQxO+YoyUvk7iqVCdC8
         8dBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EbHldw+OkWfGVFKKWtG3hDAcOnTKU4jITXx8lACI1lI=;
        fh=aq5DJ3DB35ztUGrXWn57jkC1X2GWQ6IO1y4dHlHTk6E=;
        b=lIBxTiYLXszqUteZdGWOPTeOzLuV3osqzrDTGZXtHpRayGV5WbNRU2EXGlZvii8iKn
         fCbwpDHHEqhTE3wRGauZx+4d0wcwZMNC4iK/s0fC5d7fFCgWGY27mdG0v1uZECOVnaCY
         KsbF9a3y2TCPwM/Ldz4Cpup6IAQ6xydvsRfB9t71SbsPXRteZ7WiI6Xfv7Uia9puJP9t
         6vfWFrI5M3VKtuk2Antl6iOBwmFDZpvxPvJsBpZMGH0NbKOWJZX/qt5MWGWgr/8wSjNf
         YZqvPeKWhdNDxrvJ69LXcvlFuPYklHhbPyt7yBqETCpIEmaOv9jIFdQ0y5r7kxg/fsop
         lmng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789759715; x=1790364515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EbHldw+OkWfGVFKKWtG3hDAcOnTKU4jITXx8lACI1lI=;
        b=wglF7trBk9fD3R+2h31qOtvE+5N9W26pGyXZas/kZ6tV5n7qDHlHfOkHaOeW/SpYPu
         VO2X2QmgAISHV+SiR4Kw+X/lDt2ttJ2cQTBEtQRk4E2E9nQ2RnuEBn3tTb9XzpgXVQQy
         pGvVKbIGLyA+2YkbnqL22fehYg6tkNyITbZAVD7Mi6Ae5xHHidz2zHmkL69qTojWwLTn
         CRyJ6AoqmzD2y6FUCVvJzMZAmxbf1OSIRu0dctl4YX5hdSX22gL20Fi1sTSVO8oAgIFY
         Veozg7+zId8NBjZ28FOzLGmS4LoY6nPtVrrQDBRum7aK+805lghjgXp4y8yBlw/6Fh+h
         xU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789759715; x=1790364515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EbHldw+OkWfGVFKKWtG3hDAcOnTKU4jITXx8lACI1lI=;
        b=j0B9uNO6kABtM7j7W8ymQYD4DraX7P7I7g9wWfWbduemctkoHV70Jm2BNCnu9rk4Ny
         UPaDP7IH15jgmy6uvBY2EldUEJWuwFInpig1PjeyTV4eUMN9YDE1ft8MqTQ1nCeDif1S
         EQLtR+96hPn/yvEQpo2iwYbDSZwc15IhD6flbDS3+KnfK+odOaU9f3iumnWnVeKYw4//
         d3sAk0lxbeB6MvfmTOHyVi5YRn3wEVFvgpiWUOCcAK0reCeMdxJcoWzGZoRSAm9VNK/g
         TDSaGnxE7EFRKwuLIb8n8RGUkLbKqWcTFHkW6FvW4P/qssfCnv+eDBU+yjZUOCYYTa+i
         uyFg==
X-Forwarded-Encrypted: i=1; AKwUvBwoec/KyC2hP15Va2dF0VFCBlM17AVIlpEkD+BuwdzJjuaM2svH0Ty9Twq/V9e++n2eTQLvREse8eI=@vger.kernel.org
X-Gm-Message-State: AFuF++mNLKsro3EJGJR+5P2wd7HIx6SbJYAR1SdOqMr4DS4PATfT4lC8
	PHdOJXb+XUgStcEt/kFJir5GiBxpfFa5UOnYZ1Ig3IlTb4g1RHSznN3JXkO+FgwzE1S1hKFfvre
	NpPB+gzRCG/iinjP8R1MGlipr4S0RfklUjJTikEns
X-Gm-Gg: AYBFou3hBw1mg9nDSFnuiyKUMuFgQ0ADML8TiDkgjjH4I2aVaBw2wFAUJhcCHeufvWL
	U1HicRI79LBTYa991FItYcvvoB4rR9DzKBK8bXBEVLxgOjv32dRAatpYUPdLhVARzvr0QS0j7yz
	2o83GZw1Nvuil9Pp7+EoTf/297YVE112B07VcGmGua7+6Kd+FqqKThkqVfgp5x81IChp4BQ60dt
	q/E6jUMHS1/mLb5B/Sw33eF5Z8Y4UWFoLVYPnTgmix94hZa1MYmdkW/PtPbvImlhElVRbFssboQ
	A/1vTFyH1pgwhdPkcYGtpKMP/kJ6rYfEajDaAOf0mJZmlJYSg1Brkx3ZemKr1/pRyei2Wpn5sfa
	SuCAEfz5itw==
X-Received: by 2002:a05:6402:223c:b0:6aa:1391:a4af with SMTP id
 4fb4d7f45d1cf-6aa684aa9afmr9099a12.3.1789759714549; Fri, 18 Sep 2026 12:28:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917230323.3701743-1-mclapinski@google.com> <aq1KWUXAqQ34ybRP@wunner.de>
In-Reply-To: <aq1KWUXAqQ34ybRP@wunner.de>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 18 Sep 2026 12:28:21 -0700
X-Gm-Features: AcwNN1XywJRMXvA7_I4z7yu2NHUmIFXps2ss-EHz_Q-ojRYqZb8DkY_9R4A6HQE
Message-ID: <CAAi7L5cjsUrLbcJtBg1DXo7frjdBY0m5x5tUeR8+btU70HP7tA@mail.gmail.com>
Subject: Re: [PATCH] PCI/DOE: Poll briefly for a response before sleeping
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 7:27=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Fri, Sep 18, 2026 at 01:03:23AM +0200, Michal Clapinski wrote:
> > doe_statemachine_work() waits for a response by sleeping
> > PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
> > which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Exchanges are served f=
rom
> > the device's local mailbox logic and typically complete within tens of
> > microseconds, so nearly all of that sleep is wasted. Every DOE-capable
> > endpoint pays it once per supported feature during enumeration.
> >
> > Poll with usleep_range(20, 50) for the first ~2 ms before falling back
> > to the jiffies-based wait. On an Intel Emerald Rapids system, time spen=
t
> > in pci_device_add() for a DOE-capable endpoint drops from 41.8 ms to
> > 14.0 ms.
>
> Polling is just a poor man's replacement for interrupts.  DOE supports
> interrupt-driven transfers but we're not taking advantage of it so far.
>
> Perhaps you could look into adding that?  It would seem more worthwhile
> than optimizing polling.

Thanks for the quick response.

This code runs during PCI device enumeration, before a driver is bound, so
the core doesn't really have an interrupt to work with: MSI/MSI-X vectors
belong to the driver, and enabling them in the core would collide with its
later pci_alloc_irq_vectors(); INTx isn't routed yet either, since dev->irq
only becomes valid via acpi_pci_irq_enable() at pci_enable_device() time.
