Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946B1DF261
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726776; cv=pass; b=tqPSLC/jGVv4wTft9oA/cyJFxgA4ciwPDJCA0/Rz9cLvJJASWJv9juH49nzI+4mfS4pQLgVDcVVfO3xuAjMN7194566AAh0ckU/Hbe+4o19dwhTrkImZTKRYspQJEOxYYVeIiUmw1zN7fOBZTo/Gl4XTDekJrdKTEhCKUkuFVuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726776; c=relaxed/simple;
	bh=vEqK5Hy38R0aBF0xDioSmauYbfGzJhfLK1133ora4Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCGKFffQ4T1ucF6p7yk66nZrvRCkZZ63BpQJ1h43WvaPn2B0fuN89VT22qXh8G7qfdXlArEK7tVEC4Q0xnDAfMGrr6mYcxpqYZjdD2VmABURCCZgZrJX4K1zN1Jzkb2OdmpZZzgFWWPR8pYK9gVIIPuHGRWbiXMSB8D8rNy5508=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPpYlFjQ; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPpYlFjQ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd0fc4c336eso697837466b.3
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 19:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778726773; cv=none;
        d=google.com; s=arc-20240605;
        b=inN5jHNIEeRCKKVXp0xlylMQ5zS0AaE6B76tpmq48bHMigrFFJnZgoUY3RR3xbiT8l
         pMpSg2NUmTf/Gh50TxASz8jBCPFZYUEqw1AYsm1K6oWWVoyRcZtk5nL2uTFutfJ70ir1
         P8jsAjkwRkK3xbiwSF0CiJDa80JglL7bTceTMO09KNHmWRKPUjxeJYZwtm24zFBt4Xm+
         SF+Zt5fWyWWoHPGg+HTPfLf72d5wQSZNYLFxe/YjpZPmF9pyvnqzuQziTyaOv82XJ1cO
         1VrzUcgDHJbTYKi5uayTDA3Ztf0lu9PLzKNjOon77whMlJqpJbPHWVmBw2nbln63eNem
         J+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lVm1TB5o7eAEP1mADABDsAQv+jVr6i4TChiDBgIAcNI=;
        fh=AseaZWsDpekdaZguk4NN/nm8sHLnqRXA9U+fxTXFvNQ=;
        b=WW5CI4b5QexWFOH1q7LxJGSON9WkRpMkoH2DLIFZymuuK5pWQnWh6v+N2bvyJS+Wn3
         x5TO3dqDrd7J9M/gIQYmknoIkOBVFDvEwrRLEA5T+uN1FuqTEpJayKRUm8QEoLVu8/AE
         u+FjOwcscxEBmb3oXoyLIVM9393XneqQ/9izMFREDZAONOFE3fA8/m/5Nm0EdmFCkbru
         paPlX+0Jxm29rmxH7+sVOAx2/7GV80uo6beOGeliIkbEUylcdz4d/ei6xADjtfCfdbey
         2DrzQcGfMPQ7b2QddeHXqtqQ/Jli3wr2Fl7OEyuJ+Rp0n5m7K3lIm8Nhov40KYHpxNV8
         C8cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778726773; x=1779331573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVm1TB5o7eAEP1mADABDsAQv+jVr6i4TChiDBgIAcNI=;
        b=gPpYlFjQ+PeqObMqTLcJFOqLaJLTxyvpNqbVyiVizYUNm/rJurMzqmUxI6OpctnoCK
         ByO3J8Vh0KsZOvPpNSFWHovE3nqNOVFGNDSci/JyS9okqQLNN9WqBNDQT0p47EJMW9l2
         8SPsYoQOKqLxom/4MxkV79A6qYaQAHn31pEiDAHl+M62iStu8LhE00ysVNWafO50IFvU
         yvrJo7Ph7xFmCpQb8WTVuCC0ClJ57uBcMeOp+WcwmyCenn2qdoAJ5rdhk/d5Ccs4l0Pb
         eRD8ZxAoCnHbOhTQg8r93VlJC8afCOawgd155HzUUsHEBWpvfi+Efbr9wt8jq0nQQHLc
         1+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778726773; x=1779331573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVm1TB5o7eAEP1mADABDsAQv+jVr6i4TChiDBgIAcNI=;
        b=kFa5+y16VZ3y90pu8PpEQNqv1E2tiKF11rtxjxzlw0t4O86+vk5zZ/GqE1vHb57+Ps
         wTngypt5mXgRwrXgCgyubF9M4jrpdfA0y0SWDUWdwNNb0g7jQa27XssesU2Vc8U8YMzH
         E57R0NSPszOCKVJDcD18aspi48txJ4D8khdLreOjkH4sNyDTPLn4m2iw/OZifIdgvC8t
         kiruiTqkAFZ59u957E+NXUDDxIhuL4I8ZAbOQwo1U2s25l0bmmF15icCstDHnihPCOeD
         bYAanB89rXfMZ1YGO0QWF5aycnQZmvBbYGuQfDNwU6IKsLK1bcJQbaXz4/aBY0sOhGVD
         7N0w==
X-Gm-Message-State: AOJu0YzfbZudjDugu27KM+Xrv2QCa9FpyfKsieUSTEufq4sUwiRtZ4jA
	oJvXyLn5Jh4cBX5C6ft5Fs67dwpl0tSM1kGH325WQmQwZ04LmSDS1Ts08uYZJGOg9hlTg7ypcqy
	YGlX8RNrjfbdvB7n2MhSPq3BmMRxfPstidMFq
X-Gm-Gg: Acq92OGGsX3b58fZjHJOVMOLHWwycoYo57HZhrSNffBE494b+Kd2w3AziZ5nRaa+CM+
	Lhv80K2VsfzSWxCacocaSaK112nTy15pxyZrj8wbV1zgidIrSAzWrGXuEq/iVTZgt58enmkf8fS
	I6bB7PW/PSccZLdkJdR/Zd2k6hT6eNz4lYBinKbw1JD+fu8Zg41+3ujyYm6La0sle+IRaIsOvdO
	PopE7eh5iIKLaJtonSyJITQtr8dsf5LpvKFRUEyfhHUCHgmUnDsFnhZtjYmkB0j9XGomE4b/RLK
	9PDnzg8OYW6cLjOAChIPgRcwmBuCWWIYlXbxhw==
X-Received: by 2002:a17:906:4786:b0:bcf:b634:67fa with SMTP id
 a640c23a62f3a-bd3bfea141cmr377448966b.18.1778726773231; Wed, 13 May 2026
 19:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508031710.514574-11-alistair.francis@wdc.com> <20260508035806.0EE8DC2BCB0@smtp.kernel.org>
In-Reply-To: <20260508035806.0EE8DC2BCB0@smtp.kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 May 2026 12:45:46 +1000
X-Gm-Features: AVHnY4KzlzSD3tbsDp26GjVQh6A9MwE7bGWJC4sJ1PHj5GhXuZKhZjNfvrsHaos
Message-ID: <CAKmqyKMti4wxuU-uRcLXLnXpXTHGajHkx=7zt54FDLUry+mP6Q@mail.gmail.com>
Subject: Re: [PATCH 10/18] PCI/CMA: Validate Subject Alternative Name in certificates
To: sashiko@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 6 potential issu=
e(s) to consider:
> - [High] Valid devices with a DSN of 0 are incorrectly rejected
> - [High] SSVID and SSID fields are incorrectly omitted for PCIe bridges
> - [High] Torn read of device identity prevents reauthentication after run=
time mutations
> - [High] Kbuild linkage failure when compiled as a loadable module
> - [Medium] Chaining `snprintf` without length checks risks logic errors a=
nd out-of-bounds stack reads
> - [Medium] Strict case-sensitive comparison of the Subject Alternative Na=
me risks rejecting valid certificates
> --

+ Lukas

>
> commit 72435325efe665bb825f47731ca5c0081b7acc14
> Author: Lukas Wunner <lukas@wunner.de>
> Subject: PCI/CMA: Validate Subject Alternative Name in certificates
>
> This commit introduces functionality to validate the Subject Alternative =
Name
> (SAN) in PCIe Leaf Certificates. It parses the SAN using an ASN.1 decoder
> and verifies that the identity encoded in the certificate matches the
> device's identity in Config Space.
>
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 16abfd0e17e19..15512512fce7d 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> [ ... ]
> > -obj-$(CONFIG_PCI_CMA)                +=3D cma.o
> > +obj-$(CONFIG_PCI_CMA)                +=3D cma.o cma.asn1.o
> > +$(obj)/cma.o:                        $(obj)/cma.asn1.h
> > +$(obj)/cma.asn1.o:           $(obj)/cma.asn1.c $(obj)/cma.asn1.h
>
> If CONFIG_PCI_CMA is configured as a loadable module, will Kbuild compile
> two separate modules (cma.ko and cma.asn1.ko)?
>
> Because the ASN.1 compiler does not export the cma_decoder symbol, would
> the cma.ko module fail to link during modpost with an undefined symbol
> error?
>
> Should these objects be bundled into a composite object instead? For
> example:
>
> cma_module-y :=3D cma.o cma.asn1.o
> obj-$(CONFIG_PCI_CMA) +=3D cma_module.o

This seems correct

>
> > diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> > index 998fde6366fb8..ee186f3619409 100644
> > --- a/drivers/pci/cma.c
> > +++ b/drivers/pci/cma.c
> [ ... ]
> > +int pci_cma_note_san(void *context, size_t hdrlen, unsigned char tag,
> > +                  const void *value, size_t vlen)
> > +{
> > +     struct pci_cma_x509_context *ctx =3D context;
> > +
> > +     /* These aren't the drOIDs we're looking for. */
> > +     if (ctx->last_oid !=3D OID_CMA)
> > +             return 0;
> > +
> > +     if (tag !=3D ASN1_UTF8STR ||
> > +         vlen !=3D ctx->expected_len ||
> > +         memcmp(value, ctx->expected_name, vlen) !=3D 0) {
>
> Does this perform a strict case-sensitive comparison of the Subject
> Alternative Name?
>
> If a device vendor provisions the certificate using uppercase hexadecimal
> letters (a common standard for hardware IDs), could this strict memcmp()
> erroneously reject a valid device?

This is incorrect though, as the case is specified in the PCI spec

>
> > +             pci_err(ctx->pdev, "Leaf certificate of slot %u "
> > +                     "has invalid Subject Alternative Name\n", ctx->sl=
ot);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ctx->found =3D true;
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned int pci_cma_construct_san(struct pci_dev *pdev, char *=
name)
> > +{
> > +     unsigned int len;
> > +     u64 serial;
> > +
> > +     len =3D snprintf(name, CMA_NAME_MAX,
> > +                    "Vendor=3D%04hx:Device=3D%04hx:CC=3D%06x:REV=3D%02=
hhx",
> > +                    pdev->vendor, pdev->device, pdev->class, pdev->rev=
ision);
>
> The commit message mentions handling devices that mutate their identity
> at runtime, but this string is constructed using cached software state
> from probe time (like pdev->vendor).

This I'm not clear on. Do we need to call pci_bus_read_dev_vendor_id()
to get updated values?

>
> Since pci_get_dsn() reads the live hardware state, could a mutated device
> result in an inconsistent string containing a stale vendor/device ID but
> a new DSN? Will reauthentication fail without a full PCI rescan?
>
> Additionally, snprintf() returns the number of characters that would have
> been written, not the actual bytes written.

This is true

>
> If the inputs ever exceed the 79-byte CMA_NAME_MAX buffer (for instance,
> if a quirk mutates pdev->class to exceed 6 hex characters), the string
> will be truncated but len will reflect the untruncated size.

That's true, but I don't see how the fixed length format string could
exceed the size.

So I don't think this is an actual issue, but...

>
> Could this cause the later memcmp() check in pci_cma_note_san() to read
> out of bounds of the ctx->expected_name stack buffer? Should scnprintf()
> be used here instead to track the actual length written?

scnprintf() should be used instead, just in case.

>
> > +
> > +     if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL)
> > +             len +=3D snprintf(name + len, CMA_NAME_MAX - len,
> > +                             ":SSVID=3D%04hx:SSID=3D%04hx",
> > +                             pdev->subsystem_vendor, pdev->subsystem_d=
evice);
>
> PCIe Type 1 devices (bridges) can also implement the Subsystem Vendor ID
> capability.
>
> If a Type 1 bridge implements this capability and includes these fields i=
n
> its certificate as required by the specification, will this condition
> unconditionally omit them and cause validation to fail?
>
> > +
> > +     serial =3D pci_get_dsn(pdev);
> > +     if (serial)
> > +             len +=3D snprintf(name + len, CMA_NAME_MAX - len,
> > +                             ":%016llx", serial);
> > +
> > +     return len;
> > +}
>
> Looking at pci_get_dsn(), it returns 0 both when the DSN capability is
> missing and when the device's legitimate serial number is 0.
>
> If a device implements the capability with a valid DSN of 0, will this
> check evaluate to false, omit the field, and reject a valid device?
>
> Would it be safer to explicitly check for the capability's presence via
> pci_find_ext_capability() instead?

I see your point, but I don't think so.

>
> Also, pci_get_dsn() performs two separate 32-bit reads without a lock:
>
> pci_read_config_dword(dev, pos, &dword);
> dsn =3D (u64)dword;
> pci_read_config_dword(dev, pos + 4, &dword);
> dsn |=3D ((u64)dword) << 32;
>
> Could a concurrent mutation of the device identity result in a torn
> 64-bit read during this check?

Really?

Alistair

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.51=
4574-1-alistair.francis@wdc.com?part=3D10
