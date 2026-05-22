Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE438A299
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485877; cv=pass; b=pPSJoH0XJ8ZjNbLqNOhgV0AwcFQzWaR2j1sTvmEWjOPZBitW7TBzJuylZTVuGTgNbJxqt6Qdorri4VKi7t3GUsQ7VwJqEWZk7DEH4bX5kdDfTyfPmp1tqJspv4AeZLgadHPQfCNDzo5qhovbHsGFi0NRX1TJ0dG8OHmEh2zyvdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485877; c=relaxed/simple;
	bh=1TyT37xR7LChang2oHJC0H7cE1jVc5Im3FbgnD3myWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJUP9jRVW3uXfl9KkaT+1CHa0EN6izgGawYWxBuy+YVBtzLhu/xIBtk65+u0A2bodYLGTy9sSt9eX+n7lH+nEOPquYf1H0EwyjMCNFnFCKN43W1YCAOBc7+Aa0kjz6DqUJGNjFXxaBeSeZYvsKTp3tq8mtssTpTE9wmCuIDE5aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhLyV6B1; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhLyV6B1"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-132d1b2519eso230127c88.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 14:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779485875; cv=none;
        d=google.com; s=arc-20240605;
        b=A5I1cB5AG6o7wr3fn+4S1vazuBi9iKxbSQalnwe9n5Seo8ruYneQZi5A4Wm3/Q92j/
         1/2MdrG8sM0FmaqjIvSvp7xnQAaFxCeK2wj0vXe+bD2hvOqx7TGZ9yh568/MKh3jcqM+
         w74LaJBhN04aJlhGoq8mU8tdmDQ1QN5wPO3yH8Bp9/GZYmCI3NkxX/s94F78l8jsPDwa
         CRPdnGOW8j8jwhc6Y7s0iQ74PtPvQzQ+2k/qxIUbxKFBn9W/siKLwz56hVOfFTYzodiz
         SoIoWenx2jYN65qtJjfUiGm3TffmKy7plvG5q3LqspuziBXEUJaWztvj8mcWupYZp8wW
         hZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zSm7l63uLGYvmvNDjzx7U0ucFLWNLmiIMJFYAIeXl4s=;
        fh=kcRmEvKuUr56T29pmcj1pltt3w0eGbocMmUdu3r/3OM=;
        b=M8tE6sX9DDYGRyI6ns3d5VrX+T7oqJEfgtMhaaSgJ/FJy4zvAok1IxIYoTsvwhfUee
         Sfh7YHOMZXva3sjOg8c6LDsh5cZWda1HT9LkzY/L7xnDS3UOPLB0Z7YoBfc+9KPaSvRP
         cw1jAEA6uCF++0kzWyWB89x36h1NA5jF5SFy7Ww1PDnHmTnG4PZd5rheiVG08OnrSEgf
         Wr8VwtJFDLogxNb5vbDDBrOEXZWdYZHJvxXt/0XjNbM/9OnShjt5UN/fOmzYWnJuC6iD
         mBKFU3NqA+9St8XBY4Tz8iHF3qAV60YVld8lWBCWWMUKnKehGfW2zd9j7TkYNc2haqIv
         LUyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779485875; x=1780090675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSm7l63uLGYvmvNDjzx7U0ucFLWNLmiIMJFYAIeXl4s=;
        b=jhLyV6B1j/Ih6tGrIy3GMKEp1l4Rnzr9eIEFYAQjK4ALoT5tNOFqiTKLt++TKUhQHR
         axpfblo5tbIZp5L/xnoFzyw1y+Q1D+nI/PYUSxwiiwNqLsfUlLsPCUDU/p3Xqs4MxLcw
         CvWvTQtAMdGrb8SZ2tSpFYVqhJouDA9kU8jRfqMpl9E4SNHNQ5QII7wCuQQgxqzQ9sXg
         7tERSV4oE12rrFbMhTRfnKMxMWQLHyu+BlQKyn6xO/L1bdtfeXNLSX6ln9LkebNSSMLB
         O5ikuU/wihx0F8nOwQfZJmLxxeeLNA66bT4UhODaKXod+h1THilzn6qF4YTyhfZjp4Ho
         efOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485875; x=1780090675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSm7l63uLGYvmvNDjzx7U0ucFLWNLmiIMJFYAIeXl4s=;
        b=NvsEZvq/HtNp945RGBvql7PBU0HB71wdlNAGWpdMkmtWMK7UNqBR6Wzjkv/Z1gZobK
         ypHpa897V4Xn0cS93B7ComgfGuKhEAKb/ujaGGtdZUKCVV7GgQT1pv5qmJ0fez6I0GlR
         MyIceuDcla8O9MNbCZTZvxApRTFaZt0oyddJNY8q79WHtjPSVIkVEboiiNJ9tnnYmFW5
         2TDjCEU57UoVOrfTSNeSYkhsyhBw77Db+EmXu52ovhEok96gT9fDIWIYCnd5woM8prqD
         t2WcwBUcJ9vao6A0I9PjJ22dnnd9lVPSBUSZSqg9rTUBtgd8RblANMPCa4XXdBCrGKze
         sG4A==
X-Gm-Message-State: AOJu0Yz1SYCpkuPwLjdP04YBiJGNj9UFOkLPkjyArVoDMK0CbGFQGKs0
	z6UOgz5jqdvB9xF4j3Ht7w7bavuXx6423lC22NrtTLwKb7wjnw2hak92VovPSrPhhsPoF7TtV1b
	7TkAWWCv57EAgmflzLifZzLg/+jIB6KHHSiBrmr/C
X-Gm-Gg: Acq92OEk+gZZrHX1pfGcHXWYvtvymB+J+RNFPyjUjBlr6cJIQkTsgqOA/Vpo27FFJSY
	TYbJ8sax/yfSj3bZw/2tsT5/03QJyYzMcSKOreaMmwNYbnTnMUGRTfWoVj5F7qOxarnzlcThC/t
	TFyMnnXIkRoqRy25zwkw9d6loWjeFBCjMumva1N2u66H3C3yxklE47VKz1hdOVh87z8x/XiFImG
	qHWvSi67yhLht2hitq/PIJtLGZv3ynOjPXgs08xTVTrBLaPQUj84LrKxF8tMeNCNWAzfshn3QPm
	9r3Owd8EMdA5q7Rdog==
X-Received: by 2002:a05:7022:613:b0:134:feba:3fd with SMTP id
 a92af1059eb24-1365fd7ccb7mr2727225c88.37.1779485874567; Fri, 22 May 2026
 14:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-2-dmatlack@google.com> <20260522204400.4C7E51F000E9@smtp.kernel.org>
In-Reply-To: <20260522204400.4C7E51F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 22 May 2026 14:37:28 -0700
X-Gm-Features: AVHnY4IjqQqs870qR0-ohQ72DF2PWotw1xJ6wHuzXsXUHRQz5rQ4D18AzHyAyvs
Message-ID: <CALzav=cZsFx5dpbELx1cMHUa1+4+uv7cYEWAWAtZkXeB2d9mMw@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI core
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <prty@google.com>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 1:44=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Missing `kho_is_enabled()` check before calling KHO preservati=
on APIs in PCI Live Update FLB operations.
> --
>
> commit b0cb2fb154fba1aa85d63570fe0186e243353fb7
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Set up FLB handler for the PCI core
>
> This commit sets up a File-Lifecycle-Bound (FLB) handler for the PCI core
> to participate in the preservation of PCI devices across Live Update. It
> allocates and preserves a pci_ser structure using KHO when the first PCI
> device file is preserved.
>
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/drivers/pci/liveupdate.c
>
> [ ... ]
>
> > +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> > +{
> > +     struct pci_dev *dev =3D NULL;
> > +     u32 max_nr_devices =3D 0;
> > +     struct pci_ser *ser;
> > +     unsigned long size;
> > +
> > +     /*
> > +      * Allocate enough space to preserve all devices that are current=
ly
> > +      * present on the system. Extra padding can be added to this in t=
he
> > +      * future to increase the chances that there is enough room to pr=
eserve
> > +      * devices that are not yet present on the system (e.g. VFs, hot-=
plugged
> > +      * devices).
> > +      */
> > +     for_each_pci_dev(dev)
> > +             max_nr_devices++;
> > +
> > +     size =3D struct_size_t(struct pci_ser, devices, max_nr_devices);
> > +
> > +     ser =3D kho_alloc_preserve(size);
>
> [Severity: Medium]
> Should this code verify kho_is_enabled() before calling kho_alloc_preserv=
e()?
>
> The commit message states:
> "Note: There is no reason to check for kho_is_enabled() since it can be
> assumed to return true. If KHO was not enabled then Live Update would
> not be enabled and these routines would never run."
>
> Does this assumption conflict with the Kexec Handover subsystem guideline=
s?
>
> The guidelines mandate that all callers of serialization APIs must explic=
itly
> gate their usage with kho_is_enabled().
>
> Calling preservation APIs like kho_alloc_preserve() without the check can
> silently add tracking state that will never be used if the subsystem is
> unexpectedly inactive.

Sashiko keeps leaving this comment. It seems like a false positive to
me. KHO maintainers, perhaps the KHO documentation needs adjustment?
