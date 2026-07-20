Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2CF3E8337
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589571; cv=pass; b=m2o6nX3VrG6elrJ9AzJuAaPUXxNInnfhz/SQ6qIKwbXJJB0ogAli9Jt9noynssp7hEXmMpAj17hfoSRxHHpBIcLZEWS/xNTcyTouoUcBw/gsCPrENGHsdMr5rwssGQAUe2ttSSow8fUh3ydAQOUOCi3IQ+BlI78mNJw8IW4yV/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589571; c=relaxed/simple;
	bh=VD3HIlbzEb7dewmVIFSfcvhuEGHcgLIWaCYKVXgS20o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2YwIsGgzVPIzcaPNFf0fakMLAKBqb5SFd/rMV4bKB0dXwgOZa5pw3s6IVQVWg6g8oGSeemKcIr8xxNAtXPM3B84zDDtti65bnl0Uu/sEQPRzlEaszV9Gf49h6Mh4DEOuN9UiSrr3mZfpUrfHe8i5RXUvww6qUCl03kqLib2e68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6vDnXlJ; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6vDnXlJ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso6711303a91.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 16:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784589568; cv=none;
        d=google.com; s=arc-20260327;
        b=IutyUowB5pXZXu7Fl5B0sIJM5DtnnyRZgrseTx8biHRxbdhhycohIR8g2Xvy536XV7
         gAzS92RC8oMl7Y4oASnRn7Gt1zqSSoBGSJifx4MHdFuBhhjoWoNCQFgSDJAwM/17sWmC
         67NlFHKADzESuwLqKltRIRcfi8zLZumt/pIxUlJj3s8BTPhYn5cNzmG+GUZ7pgfOIaUK
         TIbqQELmI/CMJ1udX0bQZpec32v+NYtXzcFfLMpFNC+1BOAp4329xXNfzvGrD71Zg+Mh
         Ngzga95fKO7cAFXM2PCzfNX5UmXlwWYvlmd7c8S8La5fiTRzuHbkOEg0Je3k/Ya2vrm1
         L7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYpxNurdbA4XJ/6Vuk5WIdVnSVbgksTgEkNwHBXbZV0=;
        fh=tMSkIgpZYKogwkO+7CzXgp9J+tDVBwvWbuJdNytCULQ=;
        b=g6xiPnFzXZDKMJuYUmagQad4LDKq0w+ea0LFNI5PnNLpcbNNhgVwjxXV9tr/ThRdcB
         XGfqhqX7yY7hipnF4+1CzY+AkRF8VJnZcaDoMvPM+SU9VYjThcXNsJI9hzmNs7lLzkD8
         fpXDwWEsR2MPtZQDZ17T/HGf9/3Y/gNb0+WoozR2G60hBQYcThxCFu++4nIAEC6xwQo+
         yLK65Ayg0CWTiiI1vdu7uDeiskpzYmE+S5uVcdrI+y+Hs7tc7oYEdGYbCBAfNdxolFhN
         xQDjq0PCc/pBWa6lR+zvcxtGseO8l/p6RcEWhZovbmf8C2UKub6nY4ax27fskB2aeJrS
         Hzjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784589568; x=1785194368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PYpxNurdbA4XJ/6Vuk5WIdVnSVbgksTgEkNwHBXbZV0=;
        b=s6vDnXlJ9z6NtpY49USEaFFyzDZGDp/vEPjToHrnv6bTvXKZ46obqIS+jfPx26/GB/
         fdHybSFsTRU/EBqaEZTJ1Q0SRXj6U+FG4F4efVXl+9woIAzVa7Nz3MBYSUVk6cEylAMt
         uFb8Gjxb6QpbfBWgcVWYMIpRALkPzuvfCcSRcUxLfCjzIfRpgv+nXJRbmxHdaGf4sjwX
         VPtDITY3b9/6bSdUyPBA9S1QuTvV23YrkJ2/lXP/0OHtIoiY6pdjZEw7Chf7KDFA9m+U
         0FL+c4alVP+/ag8KHbxkXAPn4JVv7ogGNkBtzbbXv8ZSaMj7EU63IdiTOcfRlaWoKX13
         odgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784589568; x=1785194368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PYpxNurdbA4XJ/6Vuk5WIdVnSVbgksTgEkNwHBXbZV0=;
        b=bOfs/QwfVP1fgMQbtFDCPWmZB6orKK8Es4/dKzQJPuHjMubiKAbywx1vs5SuBaL26y
         A+tluGaEuyriZJI9AJD7f6ubHp2PqJq31kY3PYgNBambS7mLem6PbEwhu4xVOS51OSak
         EnTgxFOr5wSjHhnFTKTxiGslFjIMXEVF40ZojctVY6ruKDtXzOt4Lng1PcnEbj2cjur3
         HainbW76wIXHBXUD/P+e/dNdCZ8nRDdp9+OdP+/NsVVhi7uG6szj4Y33vi1Jz0TZ/Ljl
         mKChspin9xLcIFIHJei4VOV3zZ6NJvxHF4aY2tO6BCSGRzx2qBrljWT240X1asV/ASvh
         /oIQ==
X-Forwarded-Encrypted: i=1; AHgh+RreJub+4qSV8OioXq193AtIXyg/0ZcRc9Taje5Ntui/qnFRSwIl0qqUFDnjBibTZbyYBsw6yJEQjMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfUXQ9Opkcd2hBmULEhrGeMX1QnMeWZ+KTTB63ra+pL9ixAcQ
	OYlwEh2y63aww3vEdiYtNQWsg4utZ5Wps8TNERfrZ7KPtnFLrAbK41512LZ9mdyHHSYpAKupt3x
	eS1SGhI/lWKQfELEIUjVjLL0NNVfoi1UsyKHGRb1w
X-Gm-Gg: AR+sD12x35PaSqrkUNgWOJuHrwe0FM6uQ/iTdQt2dN9T4uRdOZfDf1W0XuYJS3m9hpp
	DSWOoCJa3xuUpgvEcyPsLi6G4tgRoUNJI3D0jY/HH3Qc2YaRFq0VR1RJoka9VfMTED6+QF0jaXP
	jPyFn8YByeyH7re6EtuWVCcaFz/OIUw44KdsfaYooCjcFOnYC/RWg+7JKaW+GledKbvl4LLLMFK
	r/uuuIlrvn7fOzcvklJHpVtS/4V19xe68G38k7TMza0dlBcDoaTCg5qiOLKPQ==
X-Received: by 2002:a17:90b:5905:b0:381:23d5:693f with SMTP id
 98e67ed59e1d1-38e4b534bedmr15548062a91.28.1784589567330; Mon, 20 Jul 2026
 16:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-10-dmatlack@google.com>
 <178433098576.189683.2364970585754668266.b4-review@b4>
In-Reply-To: <178433098576.189683.2364970585754668266.b4-review@b4>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 16:19:00 -0700
X-Gm-Features: AUfX_mzMp9DAjORlO4Z9lJDkbL8nPaOLaXiKeGO1DzMTd_1FqdXSUAFnXR38zlo
Message-ID: <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 4:29=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> w=
rote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index a95bfe5eff77..74a11e520f0d 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
> >       return 0;
> >  }
> >
> > +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > +{
> > +     u16 val;
> > +
> > +     guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +     if (!dev->liveupdate.incoming)
> > +             return -EINVAL;
> > +
> > +     pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> > +     dev->ari_enabled =3D !!(val & PCI_EXP_DEVCTL2_ARI);
>
> unsigned int    ari_enabled:1;
>
> Sashiko asks a valid question, what protects other bits in this word
> during modication?  At a very list a comment is needed.

This was my reply to Sashiko, not sure if you saw it:

.  pci_liveupdate_configure_ari() is called from pci_configure_ari()
.  which also sets dev->ari_enabled=3D1 and is pre-existing code.
.
.  If writing to dev->ari_enabled in this path is indeed unsafe then that
.  is a pre-existing bug.

I figured that a comment wouldn't be needed for continuing an
established precedent (it's ok to write to ari_enabled during this
path).

>
> --
> Pasha Tatashin <pasha.tatashin@soleen.com>
