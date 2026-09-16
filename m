Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF94A2E2E
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572079; cv=none; b=KtE+GGmQIXafVClyglNLQXb5YCBtWQQjAoTrWSmLwFLpasBfGelhKogbvjgeSek1HB+0grIHyeKSCD86kg6ykqAVci8ctuq6EgBsW1t6jYDI2zpm/0FetpM08Tze+eTc/Mp+1ClP12WuSYgyWkWipEI/weewpCMQ1O1dCMAjNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572079; c=relaxed/simple;
	bh=Yc5flAwzPthSa5OPV6yHyZ+TUhCs7vJ7+HfS+tNbQQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYDREhSwoDNR8LLJrfyfzkbIM51EgiMvubm+/FNTmDO1HAV4Wz3qaytSzVsk6rwHgtqyMmQgLXwr3QuBEeSvnbL2oWErak/NqQtnXDHuJAZw7UAex/NzxYxMHmpZCTh/4BWmkdA41kQEJOo4MQFkXEM2z0+7ko+y+zq81Gk6mNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U0bZDH6F; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U0bZDH6F"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6711bc23524so370008d50.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 08:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572069; x=1790176869;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5G+dHxrlobytaqyGvS22WsK5/UePrURjvKq1vmyfTvY=;
        b=fFg/zh1SVWqxm9JWFjDKOYveCH7aZXgdZ0JzF3oZMw7A/NuCYkNaQREbUbIonJYw+5
         ozQYMuTWqJ/AdQZ//exez6KmfARtbBzOzpo1b5MWuyOB87Z34RSdmSOSZ/syA/N/2dX2
         WEUMxOhsoKZgQFVt2tGknhjwyLTkk0bsqD1eRec+hFZVjhmcOisz8xnO/fi/ak1z+e5T
         y9pK5IyJ476icMjgUBj9LVNn5juv4Y8HAhPUP8ce2yGCv2DC6Ag+XINvGyVDp754yZ+e
         k4s4XCw9dY1E9hPXeq1dq6dOz4GMqLLAw5DTNcTdnU7cRnMUymDEKjX+QEUEGHP0jyln
         Lidg==
X-Gm-Message-State: AFuF++l4JMkjE4owhJR1yO9N2Gy5ofTtGcyn/Be1qA/F9ITqhSsXrI1E
	qawflQW3sCaZ/YF1wuzZVbeU1Y467FkFK1qThNr31GoxiGn2Q9THZFxFKHZQsaIjBqJOgHWV+La
	7QifOQbadM4+t2SZzW+qV6e/lm9fY95tFz1nxtat/i8INVx14GWm231pr9XfIDDOuvnljF7lRAo
	US0UoUu4V7FCKN7zCE4wFjlEE8Gnkru8gInrXY/WZX768FpQoBOyNw7h4VQweVPi3zao8VrgpBJ
	SYxBkJo4aKpGONz
X-Gm-Gg: AYBFou03XROGe7lB4i06vRenJAKK7xwzi0XDwiWCHTZ8Eaug+5xuC1tYNvn7cEEONc6
	WcDsTyuVScO1xv+4lLQ5LuUk4vI1icds7nuEIIurPbVTFOX8a0phWX0TS6ZYrOFO+mGJygusFfI
	FZTsHWlVX7uNZxkWdu7SK8TayzZfHlC3NjqwailuPCjIXzzWksPfFrmNvCgBK7zGDzZvBzunCk7
	vSpGz6yM5qQUxhw5Byk5dPTtGtiVbLo9dKTRj1xlo4oc08s95xCd7GeG/EfHZVgt7wjYrH+MY1F
	AfXV1h808IPFawH1eJgKPFgNG8HXqWApHlDrQ8c5eoR+JGTfH6dKqFuKkykFc8Sh/FHkyVGcX5Q
	iLZTxQKQYP19MFLrsqzz57av4iAhMzoEuINfvkyJBUKz5mTGc8lb5+iwPjGAJJugCD2sgiCe4a7
	8ssyBxPKM/jrLC1gKKgrpRVGrMQbpPln2TPnOi
X-Received: by 2002:a05:690e:488d:10b0:671:2d6e:b7eb with SMTP id 956f58d0204a3-671632dc048mr749355d50.66.1789572068703;
        Wed, 16 Sep 2026 08:21:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6715fd9987bsm154489d50.27.2026.09.16.08.21.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 08:21:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c293743f5cdso630881466b.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789572067; x=1790176867; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5G+dHxrlobytaqyGvS22WsK5/UePrURjvKq1vmyfTvY=;
        b=U0bZDH6FlLOZjQg8c0DpS0c5JvwgQMrLxQgEqToVwNlgPAYoOZ/SyYAa8yMfkoaVKZ
         GHSxH04lAjkzxOO7lK87Oae4ZUkvp9FwtWOTZ2gXaYm1MtXcwmS8CXZAMH2Lv+YCtEQr
         kQhnClPGF2fCZDGBC1luGLHMPTC550uCVhKLc=
X-Received: by 2002:a17:907:9414:b0:c29:448b:f5d4 with SMTP id a640c23a62f3a-c29e532cca8mr215806966b.35.1789572067077;
        Wed, 16 Sep 2026 08:21:07 -0700 (PDT)
X-Received: by 2002:a17:907:9414:b0:c29:448b:f5d4 with SMTP id
 a640c23a62f3a-c29e532cca8mr215803666b.35.1789572066469; Wed, 16 Sep 2026
 08:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-3-james.quinlan@broadcom.com> <20260911234703.B08F21F00893@smtp.kernel.org>
In-Reply-To: <20260911234703.B08F21F00893@smtp.kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 16 Sep 2026 11:20:54 -0400
X-Gm-Features: AcwNN1Xinvg8Z9NfEcyW1vfu5iWj6pGrSavA9-d62UdS4RnzB7jHJUC5vZ8azDk
Message-ID: <CA+-6iNyukaqVYFm1jVjDYL2DujmX2r1kZCM=Vq9eNp22wUee0A@mail.gmail.com>
Subject: Re: [PATCH 02/13] PCI: brcmstb: Use flags u32 instead of bools
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006048ff065b9b37b7"

--0000000000006048ff065b9b37b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 7:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] The newly introduced BFLAG macro lacks outer parentheses aroun=
d the bitwise AND expression, introducing a dangerous operator precedence p=
itfall.
>
> Pre-existing issues:
> - [High] Uninitialized spinlock `bridge_lock` is acquired during early pr=
obe before being initialized.
> --
>
> commit c6e2c757989753d5008cfee8a289e1111796b0bf
> Author: Jim Quinlan <james.quinlan@broadcom.com>
>
>     PCI: brcmstb: Use flags u32 instead of bools
>
>     This commit replaces separate boolean fields for SoC configurations w=
ith a
>     single u32 bitvector. It introduces the BFLAG macro to provide a unif=
orm
>     way to assign and check these flags.
>
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 89aaa19d508a7..47862569937eb 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -286,16 +286,24 @@ struct inbound_win {
> >   */
> >  #define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN              BIT(0)
> >
> > +/* FLAGS */
> > +#define BFLAG(pcie, flag)                    ((pcie)->cfg->flags & CFG=
_FLG_ ## flag)
>
> [Severity: Medium]
> Will this macro evaluate correctly if used in a logical NOT expression li=
ke
> !BFLAG(pcie, HAS_PHY)?
>
> Without outer parentheses around the bitwise AND expression, an expressio=
n
> like !BFLAG(...) expands to !(pcie)->cfg->flags & flag. This applies the
> logical NOT before the bitwise AND, which could lead to incorrect evaluat=
ion.
>
> Could outer parentheses be added to prevent operator precedence issues?

I believe Sashiko is wrong here -- the expression does have
surrounding parens.  Using the given example

     !BFLAG(pcie, HAS_PHY)

should expand to:

    !((pcie)->cfg->flags & CFG_FLG_HAS_PHY)

which looks okay to me.  Perhaps Sashiko gets confused with #defines
using the '##' operator?

>
> [ ... ]
>
> > @@ -356,14 +364,14 @@ static int brcm_pcie_bridge_sw_init_set(struct br=
cm_pcie *pcie, u32 val)
> >       unsigned long flags;
> >       int ret;
> >
> > -     if (pcie->cfg->has_err_report)
> > +     if (BFLAG(pcie, HAS_ERR_REPORT))
> >               spin_lock_irqsave(&pcie->bridge_lock, flags);
>
> [Severity: High]
> This is a pre-existing issue, but does this acquire an uninitialized spin=
lock
> during early probe?

ack, will fix with an additional commit.

Jim Quinlan
Broadcom CM/STB
>
> During device probe, brcm_pcie_probe() calls brcm_pcie_bridge_sw_init_set=
()
> early in the sequence:
>
> brcm_pcie_probe() {
>     ...
>     ret =3D brcm_pcie_bridge_sw_init_set(pcie, 0);
>     if (ret)
>         return dev_err_probe(&pdev->dev, ret,
>                              "could not de-assert bridge reset\n");
>     ...
> }
>
> If the SoC configuration has the HAS_ERR_REPORT flag set, this attempts t=
o
> acquire pcie->bridge_lock.
>
> However, the spinlock isn't initialized until much later in probe:
>
> [ ... ]
>
> > @@ -2179,7 +2186,7 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >               return ret;
> >       }
> >
> > -     if (pcie->cfg->has_err_report) {
> > +     if (BFLAG(pcie, HAS_ERR_REPORT)) {
> >               spin_lock_init(&pcie->bridge_lock);
> >               brcm_register_die_notifiers(pcie);
> >       }
>
> As shown here at the end of brcm_pcie_probe(), spin_lock_init() happens
> long after the first call to brcm_pcie_bridge_sw_init_set().
>
> Could this cause lockdep splats or kernel crashes when PREEMPT_RT or lock
> debugging is enabled?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.16=
50895-1-james.quinlan@broadcom.com?part=3D2

--0000000000006048ff065b9b37b7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P6nIShznyqOL2EoCa0IXujxvXUo0pANFYsDhrCVF5JOVPeEL3Y2m+4flRtOI+YlRQoepb+TEVdkY
/g1rlWG7GIYrtHxrFFRvn2/Iqqpv/x5kzJgoTYFOyTTGlXIqGkKTqCWFrN09kJWzhhmxhxtJprJs
KveDLF8yhHSbqmXfKTkT+CIrynXXDro+80qXEXC8CM9W9d+2lDDM+hWTlC6Pt/ikMYf/ZB4K2Nr8
VFruDYGZfAHhh9/lqK3SpS2Z/8cB88K62U+Eb1yNAgMBAAGjggHeMIIB2jAOBgNVHQ8BAf8EBAMC
BaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYB
BQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNV
HSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wQQYDVR0fBDowODA2oDSg
MoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCUGA1Ud
EQQeMByBGmphbWVzLnF1aW5sYW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQiuRLoBkhIaas+1j3yf23P
ffVFcjANBgkqhkiG9w0BAQsFAAOCAgEAp1y0fznw9Uo7UzExANVpYjj+OG1c3C7MhWOvAd7LvfPX
BSFisMaabop5Pyfc/sWzb/jCNfVkkDW5Ij2mzpUsUca2qpILoFhOUT9b0d+nc48MCZ4/Wj6vX5QJ
i9VdYeuv3DYASZsQdH8iYnV5X5YCYo1AO/pyW+M4gG022Nsji9+3A9zkx8JRPDIXkPaDLrzcGD9L
rEVIYnnSK9b/4VHzITVgEmSsUTAIzOD6M6TzgrSoJZFmKNMXlAqo+m1nlNyJkM4OyOvaDx5y+2hA
mp4tzD9gJNU9TzQpQRZFz53+c8BkCpzvcHqT8lMluRlCrIYWqaSOUDHX9HPYvzbtO4iYV+irMdGN
2PBz6Wtfaoi1xTfFSKK9ON1mvxACK+E4B5gycSoZcOBADTbGXLDMqiygl7Wz0oooAPqZpUnaD1nc
x/pX7N8Ff6YK+iN3vVah34vLkE1CMFyDQMtyTCzQPW+7XCTxCL9ML3LBAF+eNAtKpPOsrGIdRHy5
6oQr+2ZquSMvWj447q4v3sk1LHs7ata+sP8/kmcPKn3WPXQ/4xMevqFVyv2VIFrBK9ZnOZ//fz8R
7SjJ7t2kOITvbWcMkizMc33S9hfmYiXaVTjIi89NiO3EXCJouYShpptgGNG6mpYHcddnfdKiILOS
06KlKNuHO4IpRmaGrzcDjsUQQSn8amMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHwS
BjaYi//EOr4Ys4WWcElg9IBGK3TJkgnZN6tjqPQdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxNjE1MjEwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKIHc+HPV3B8/uTwtJLdFqVvQW3wdggTL/G8rMlH
rW/ZzKsECFvsUY42YMToRiTUBU+vtkEOBptXNgSdwzji/saqX6HWM7hyqVJL8vY9g5f3ZeM1q1CV
20rZkDc1tg6bEeYmD5Wcca4rkp5P/zVpZyVO4C3XTNgbdWCwENi3zD0ghKZeFX/0pmLN+CnnS7RB
N1wFOzcQ8Emq1uKKvwmCLVTW7lYCRUxJQrN6k5qQaDMDM5lTn+mqSaab9D72aEihl3xcxvcYHt0F
GeDh+M+faX1Gja9g2qA0U64QEkLUAHg/3i3jcS5V2sRZOb8YLBDqXRG4ipLn2dRgx58sJbMdD58=
--0000000000006048ff065b9b37b7--
