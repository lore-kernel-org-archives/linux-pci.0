Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3122BF3D7
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727821; cv=pass; b=ZRR8ilvu+LTFBpx62CnZqvudG3XjIM7LuWKMyM2gMlY/u9caPKyL0IFQzJP7L/A7/uZAHTqkApPeux3VAnOJDcAXAI4sJRVsAqegvdwLv1YJ+h4nFcLijQZig/0ijfrDIVttsNfALFlVr3L7HLjdv811+CsJGI8ARnWhTx4XuY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727821; c=relaxed/simple;
	bh=gvYRD/fbHclDb6BMPlUm/yjtLzzgXzWVzit+Q7QQgkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI41MyO8gMi39iDqmCRXr3LmM4ivLR6f/M+kgc2ZoBeQXg3Z/SA7MqPNX9gbhpOs1x+SO5YsJvIELVnROtnX12fBl4W0LuFAeCW9RZYTwRmyoP+QAPGnHsDKHbmZ2Rrot4nEmSYKPzNTkQBALEX0NryM0Amrn6XEbMf//3FoWGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NY+ukRVS; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NY+ukRVS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516d78ba1adso11581cf.1
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 09:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779727818; cv=none;
        d=google.com; s=arc-20240605;
        b=EhIQ93I9/wKl5Z8cMiqZYlqCgBzmwezKJiufMZdAjutzYgaWWArA+C5V0OWYqi7R8F
         pgEeqAiMfD4nvMz2LsrudN7kktLDK0Ek5DxHiqPR4jF0Um3Bz9cBpyXNEZMWeB2tH2cE
         CJ+PaVfcPe/Z1o07XUq3lsZXXMwBIIEogWO3UforuRNuxoL4/QlQgv7vpCx9ADIbCcsW
         h/fV8Ii1qa5aEgndj/xUzRTYXUm0+NZOEn/HJ54fr+N3tZ8ysbXxoInozcd22inMYn4h
         ZXYqWVodSFtWcR7PnBRF2TLMJlf1lw6MHzLGq/CM0WEhXydf81Y72zr7qZ7szggdQM73
         I1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JjUL2DNtzGEe4CPKkrL56TkQhquEmRXcDVg+YHzq9Q=;
        fh=I475EKV5n+RkPXbGmb2HUSuQCrGonTHRrlDLIXRvcYo=;
        b=hQaWlrfJWJCKfP1Cqvi9n8DqsO29FlhI8JQ5TWKl65ac2R0pfxEgM5ljcdN5QPphgB
         XQLRBqvBiGbIbmF+QP3l0NQzwZaRchrqH3x122O4LUbKmGml0HTN+scQa8yHezhFTE39
         FlVbzsEaMiV+nLTHz5FGuDd29EdmtAAwJMYiVcUKjv9diveXjk/Z0SDbLHGdVN5UBAPy
         cYi2QJzfvy2jGJQVnT4kU/n/ldcKajd5KNRzqXC5v57vAr4O9seXfI3zuIaDg5qbncBU
         pV/+3I0lANf7gNEyWi4AOlszw/zyIHeZwxFHOJLgpbql8I593AuYS9sZZ4RY96/90vwi
         xWXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779727818; x=1780332618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JjUL2DNtzGEe4CPKkrL56TkQhquEmRXcDVg+YHzq9Q=;
        b=NY+ukRVSYWIanc0nbdteQhMS8cCJcuxJ3xzjtWUkQ927cGk3sr/3HIQ1CQ8Bhis24I
         HEOTh43bh7St4yesyXNy3ZB1mPi8CIrH7GxP+jhk3oWqnEHkO/SI4tH6g986fAlTM/lm
         Ts2mMyWYRqeHvALjDWip4/R3LyDzgoXdvnBEMAfgaKpTuHV9IFbmDKvQOZDRKk87NElp
         lujYUBSUetBE3oqjh/d+yaiqzE60SuAoY7xrwiOT4vzxjzltIAdwtd2MVgiIs08YK7Mp
         ZOIQgOubxrhjejLpT07564+sKve+XjzkJbyfJOl44i7Yt8xVFvdh00ZbxlVA/Q+yzgDK
         XXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779727818; x=1780332618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JjUL2DNtzGEe4CPKkrL56TkQhquEmRXcDVg+YHzq9Q=;
        b=Lz7rIEvOwtPUJkj6brGzj+PnPXCSwUbWxDdoY3gOsMyO7YogI7meNeAaZyfWDuLET0
         5aZFW3lHjkQlW0M5ixChZkIgPpcGpJY8HauVg86969qdFd9/acTLyyXTQppClznM9tKY
         ctikYgnx/6WYa3HDs51MMc5zajzcVqm1vPZyvX3K0vPlIbvIxUYrzbVUrvPMBQgNXkf8
         zzQhKWQbrIUOsJyLXe8kglJi8rCvkes8Dpms3hztbUeQp8HRCxLteRbH72gaBxbhNvUh
         +PjY+zhFkezCQT3HYU7j1yJjZvqYBrUc/4z9ezT9PrsIDUwNjAWaDnddBDGKbdONrBUw
         Bq6A==
X-Forwarded-Encrypted: i=1; AFNElJ+pMhjgiukzHiOIfE/gn5lwLwO+dr4GxU6Wj5RY4z1Jqbi2s14OZNGI2VLwuhYkxw06P0EmxAdhgEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOavj9nSqwzAyfTq2FWd3E4zkdDKRn+DTDPmQDs9sXx4tc+M7H
	4eEcI6Sartn6nfjWOU9lo6VirAjQbht6cJcmUjDTVg7e5/3uV3tl+dIV31yfx7Hxo+TVSJ/g8X5
	LkQzL+oW4cZH77tUb+ZZu8UgXV6gq5ANkbg/jJUfqom/qODIJTuLuryxd
X-Gm-Gg: Acq92OGzUhN06DPhSkzpCrSx6WjQ8S6P+JDml+ID0nbxxbAgG6+y0PjAefj1tm34CW3
	Km1n/w23AxWbu3j3M701j//Vy2/C5gnPnRtRRS4+vIn/H7pWzLX6f9bCMsP52kUEQR9g5NutHK1
	t0TF6fQAwSz7nPk1kESKm+e2g/mL/4KlqL69ik7qpMpf2t4eP5NKFVVKXq/ligDFliQkFLcKRJp
	AOXux7VRR1v0z58hRvHXw7+t3Y2G/nfBvohIt6iyW7dnII22WaXBP83JX2XiPy2bqUnrPHlShZi
	UQE3ah7PZPcdtORsPy5RMrPcwiz/g4O7TghwWkG7JbrX8YD/
X-Received: by 2002:a05:622a:5806:b0:514:b17e:86f3 with SMTP id
 d75a77b69052e-516e0dba205mr23195971cf.12.1779727818143; Mon, 25 May 2026
 09:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-2-dmatlack@google.com> <20260522204400.4C7E51F000E9@smtp.kernel.org>
 <CALzav=cZsFx5dpbELx1cMHUa1+4+uv7cYEWAWAtZkXeB2d9mMw@mail.gmail.com> <ahGMrrU0wCUdWgsN@kernel.org>
In-Reply-To: <ahGMrrU0wCUdWgsN@kernel.org>
From: Pratyush Yadav <prty@google.com>
Date: Mon, 25 May 2026 18:50:06 +0200
X-Gm-Features: AVHnY4Lb1xmQZl0kSTzbbqWnI26kjuiXlfW8kdi8Ev0RksUckJgTRut1sW7eqVc
Message-ID: <CA+Yg5gQ_6jwFJpDupMoPz7Q2pMB7PNMHpLdv6ikFxfchz0zGCA@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI core
To: Mike Rapoport <rppt@kernel.org>
Cc: David Matlack <dmatlack@google.com>, sashiko-reviews@lists.linux.dev, 
	linux-pci@vger.kernel.org, Pasha Tatashin <tatashin@google.com>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 1:17=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, May 22, 2026 at 02:37:28PM -0700, David Matlack wrote:
> > On Fri, May 22, 2026 at 1:44=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Medium] Missing `kho_is_enabled()` check before calling KHO preser=
vation APIs in PCI Live Update FLB operations.
> > > --
> > >
> > > commit b0cb2fb154fba1aa85d63570fe0186e243353fb7
> > > Author: David Matlack <dmatlack@google.com>
> > >
> > > PCI: liveupdate: Set up FLB handler for the PCI core
> > >
> > > This commit sets up a File-Lifecycle-Bound (FLB) handler for the PCI =
core
> > > to participate in the preservation of PCI devices across Live Update.=
 It
> > > allocates and preserves a pci_ser structure using KHO when the first =
PCI
> > > device file is preserved.
> > >
> > > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > > new file mode 100644
> > > > --- /dev/null
> > > > +++ b/drivers/pci/liveupdate.c
> > >
> > > [ ... ]
> > >
> > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> > > > +{
> > > > +     struct pci_dev *dev =3D NULL;
> > > > +     u32 max_nr_devices =3D 0;
> > > > +     struct pci_ser *ser;
> > > > +     unsigned long size;
> > > > +
> > > > +     /*
> > > > +      * Allocate enough space to preserve all devices that are cur=
rently
> > > > +      * present on the system. Extra padding can be added to this =
in the
> > > > +      * future to increase the chances that there is enough room t=
o preserve
> > > > +      * devices that are not yet present on the system (e.g. VFs, =
hot-plugged
> > > > +      * devices).
> > > > +      */
> > > > +     for_each_pci_dev(dev)
> > > > +             max_nr_devices++;
> > > > +
> > > > +     size =3D struct_size_t(struct pci_ser, devices, max_nr_device=
s);
> > > > +
> > > > +     ser =3D kho_alloc_preserve(size);
> > >
> > > [Severity: Medium]
> > > Should this code verify kho_is_enabled() before calling kho_alloc_pre=
serve()?
> > >
> > > The commit message states:
> > > "Note: There is no reason to check for kho_is_enabled() since it can =
be
> > > assumed to return true. If KHO was not enabled then Live Update would
> > > not be enabled and these routines would never run."
> > >
> > > Does this assumption conflict with the Kexec Handover subsystem guide=
lines?
> > >
> > > The guidelines mandate that all callers of serialization APIs must ex=
plicitly
> > > gate their usage with kho_is_enabled().
> > >
> > > Calling preservation APIs like kho_alloc_preserve() without the check=
 can
> > > silently add tracking state that will never be used if the subsystem =
is
> > > unexpectedly inactive.
> >
> > Sashiko keeps leaving this comment. It seems like a false positive to
> > me. KHO maintainers, perhaps the KHO documentation needs adjustment?
>
> TBH, I don't remember such guidelines, but patches are welcome ;-)

Yeah, on a quick scan of KHO documentation I see nothing of the sort.
So possibly the bot is hallucinating?

But perhaps it would help if we update the subsystem prompts for
Sashiko about this?
