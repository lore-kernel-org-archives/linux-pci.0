Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49566354AE2
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746623; cv=pass; b=BJOKV5+BBCsm97X947U+lKPwOrvSSKECI5/8mTXMPk+hY2jsLHfFe08Ton7v4IzhGdkXPSmJ9mgfxf4eSiyG2Ne/6r9i4avYiDiu6YvxwBiLPtvtFIDpFgH6TAOKxI0wSuSG4CnKuN1LKsE/L1Qx9yR2gnotO+a1+ju1znEWw14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746623; c=relaxed/simple;
	bh=g9xOLTV6kt3wSnT9BBZzDvN0YQ/XYrT1PlYrB1+Re7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1Skl8w52wo4ZvNi8cZSPHGy+PbikWZRhr73nZwcw2LbxtgB/fL0jQITdoSbvFEL+WLXygBc+RgCohLWp0OV+LM9h1Q8DEl4YAhcsCK4k9QB1bJP2bX/qSxCwGGSG807w8w2p34l7NO3aWntVf1LnjRNA1Ty+HO62esKWtalbWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eQGrKH1b; arc=pass smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eQGrKH1b"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56af73db66bso444420e0c.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 13:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772746621; x=1773351421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZNL5/DzZjIqCsjO6pWFKnguwFiagAq7ubBAyTm3tuo=;
        b=rBNHKSoK62Mo3TzYmFHKZFndMshIBNJ+liEgrazuBixrSCx8wNr8m/M1EoM1wlGtUU
         Q8MGb+FLSR1+739xz6xJXThoZqjDNHZ02F3CX5JN47zyjfg2BDFCJxQHjNP/5Y9Ddhlv
         JUBxrwLI7EHkT4/bgbvF8Sp2MXmvCwyLDbwy2QADgn2ztGxQjIS+OfSifSlg65jZtvnp
         SkWrhER8gld7oJdyt66pEtxV7k2P0c/AItcVFSgdDf59+hK+ZWNKWqqBVmNbEw7A2dne
         v6hEUxSOy1jrG74ujJMiBZSIyEJsEXtj8j44L4kHP5Z1A8ZoHGrH1+YcfblKkjdNUa7+
         L8RQ==
X-Gm-Message-State: AOJu0YzLfCxUHWYkZPUUvRahvVBElwijk34IOQHhQev4WDOc83030mfl
	iF9cLxcqQAmudEBg8GbgEdsdxxzvp/z9UHDmU7lqXV55nMaKovnsNQrHyYZPmoo2j0shZah30O6
	5MyB6eZNKvx/uz6oZIQyyaIlfvdBhxM5wHlzcMQJXdv3o5CRoZpXKYyNysRilzpl6aT0Tfv8sPx
	W1Bvx7fDxpGYVjFnkf7zygCZdrp4Nw2lemSzmXvj96XOM0eAWg9tTuRKh3jqLGyu51vmffEN2vC
	oGZ7i/HOH06OXCm
X-Gm-Gg: ATEYQzwrU6sOiebJuQ/90ZQ1IQUtD0Mo06+deiwcCYVdcHBnJ+Wg/DdNCXmklo9AsPz
	2rrbSzWj3QK6br4jkeofUAv/FA6ONAAfyTW4NHpPI+mUb7hX41L84WsvTZaqGiTuerZTiWrqUvF
	0Ed4NEg+UgnrcF5Dw9wuRYYsdJu5oFDo39SXQyAZSzewA4DoJhhqbtn+O9hQG598U9lCQc5TXqu
	0TEKLRG4ZjJBTv5EK2KGPCDkgM3WGM1IuafE21IVsP5MGzoXmtrdi1SjWqk/BMHlB0m73scBSpl
	uP1PKh6cTZxxMGr5O7QyI3KMKyHiGZ/Ib4/vULWFNUviNJb7sdpUZNE7kfLRUZ1xsoHkJZKfNWs
	YyXHiOY0nL/ue+SK2tfr6/STvlksDO/BbqdIP5ocUp7GHfkjyWI1fok7LMk56VKYT+ITajXyIhq
	FaK3vZuXV22HxTUebH1ii6gjStZxxIOqAbkeMHMIAHtjDMOPLtW7zLVF7RPg==
X-Received: by 2002:a05:6122:459a:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-56afff5bc88mr875721e0c.4.1772746620825;
        Thu, 05 Mar 2026 13:37:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56a916563fbsm3547337e0c.0.2026.03.05.13.37.00
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 13:37:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8fa57213c7so530439966b.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 13:37:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772746619; cv=none;
        d=google.com; s=arc-20240605;
        b=Ev4sF6IcKpIKdwr+EB0NXKAOt8mUBR3UCtnlz8jf4N9R3PlXln7bdaEqjf1PloRjgF
         u6eM41mNj23dERKEk4eGBIyi3ci73QmRW2IskNBx2PA75yi5mxpW6xhN6EIjYbY0itgU
         x7CyFFxu/pe42H/zN6VryuXbfvyeMZQ7DpBOtRMuf0LNrpmCByZ1rTqeDAH9L++eDpWp
         2u6RE+J+GCF6WtYd1yzHvN2lVgR5oSCBUiURwThqVpFTTc1bJvouFuDNR4sBiN+4gIG5
         cTSQIDiCbhvAqKmY6uSEoP39Jhw3PH0b4goNgtcs0zJr9zz94eSUv+6gRfZoDXKzlRTw
         J2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RZNL5/DzZjIqCsjO6pWFKnguwFiagAq7ubBAyTm3tuo=;
        fh=7IlF+BoJet//4Naqb67Be76JSxT1NAv44cZQAn3GAFc=;
        b=Uf4op7s/Moo6u36AU5Tx1AsZEY39pzh5nhzgEeHVgvkICaqewTzoFtPrAA/f7PTg2H
         1tjV03AZXIphMzlDWDU3Ap6jFFmukV73MTS7WIdj4k9zdAJCMnfsRY3QFpTWYliagG/t
         uXgGjzlUmKNdDccrzAEI3kUbr65v4H3hqThst12Tv4OaWeIGp3YB+fIsjybCkR5QMr0S
         XG9vGoRpZF2ZckYKW6CGPabO8Ki4yGFcmKg4WwTiMhPh8rRj7zQyZruv8GfbqJtor5JV
         8s6M8dcJk5kt4bckwe33SFsoZdzDp3FOlw6ai6Wlgvi2pqBllq/7OqlkuS3aGwBMQgHw
         ALoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772746619; x=1773351419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RZNL5/DzZjIqCsjO6pWFKnguwFiagAq7ubBAyTm3tuo=;
        b=eQGrKH1bFxlJZA7WnMMOR38b1Wc2Da/AhRRuFkTLBHXVsKCv1qE/B7RxABI7BpbQ5K
         hNT6O3BubSN2tjWFKzBC4O90dbI0fw/pOcoQHSM+1asNBSPoqTBXWWT+9LChMTjRb+LV
         Mbl5sJjXbcsfbiaT7SviSrTacCZ6AngSc3/SI=
X-Received: by 2002:a17:907:6091:b0:b88:46c5:eebd with SMTP id a640c23a62f3a-b93f148b367mr447134866b.53.1772746619199;
        Thu, 05 Mar 2026 13:36:59 -0800 (PST)
X-Received: by 2002:a17:907:6091:b0:b88:46c5:eebd with SMTP id
 a640c23a62f3a-b93f148b367mr447133166b.53.1772746618677; Thu, 05 Mar 2026
 13:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>
 <20260303000337.GA4038046@bhelgaas>
In-Reply-To: <20260303000337.GA4038046@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 5 Mar 2026 16:36:47 -0500
X-Gm-Features: AaiRm51sA_OwxVRWUjCZ-SLpeJ4njnNyBmyGdKA59jzGL8AJDmAnAJ6N85dmqK4
Message-ID: <CA+-6iNzd0RJO0L021qz8CKrSviSst6QehY-QtJxz_-EVY0Hj0Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build time
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>, 
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008a3aed064c4dbc3c"

--0000000000008a3aed064c4dbc3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 7:03=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, Feb 24, 2026 at 04:10:17PM -0500, Jim Quinlan wrote:
> > On Fri, Feb 20, 2026 at 5:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > > > The Kconfig is modified so that the pcie_bus_config setting can be =
done at
> > > > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  =
The
> > > > pci_bus_config setting may still be overridden by the bootline para=
m.
> > > >
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > >
> > > We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRR=
S
> > > strategy"), which appeared in v5.10.
> > >
> > > In retrospect, I think this might have been a mistake because it
> > > forces a build-time configuration for something that may not be known
> > > at build time and can be set via command-line parameter.
> > ...
>
> > > But I can't find any discussion about it.  Did you have a use case
> > > where command line parameters weren't usable?
> >
> > Yes.  We have a Cable Modem (CM) customer who can update their Linux
> > version but cannot update their boot loader or its default bootline.
> > FWIW, they only want the option to set pcie_bus_config to
> > PCIE_BUS_SAFE via the .config.
> > ...
>
> > It's a CM product which uses a particular Wifi chip.  Recognizing this
> > scenario would have the RC trying to grab the EP's vendor-id (and
> > possibly more info), and that seems awkward at best.
>
> This is actually kind of weird.  I don't know why a particular device
> would have any special MPS or MRRS requirements.
>
> Do you have any more details about this?  Does the WiFi chip actually
> not *work* with other MPS settings?  Or is this a performance thing
> where other settings don't give acceptable performance?

Hi Bjorn,
I looked up the original request mail thread on this -- it appears
that the device defaulted to an MPS value of 128, and that value is
what it was assigned. Unfortunately, this device has an occasional  HW
bug when MPS=3D128.  Rather than fix the HW bug, they wanted a SW change
in Linux,  and somehow that request morphed into a request for
PCIE_BUS_XXX config settings.  So the reason for the original
submission is weak and we should have done something different, but
here we are.

>
> I assume there's no hotplug in this setup, so we don't't have to worry
> about adding new devices at runtime.  Do you know if there's any
> P2PDMA usage?

No hotplug, no P2P.

Regards,
Jim Quinlan
Broadcom STB/CM

--0000000000008a3aed064c4dbc3c
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
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGux
64iMmmmTWgN/I/iDla+N42hiRsuzS1Y9ap5GioWVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDMwNTIxMzY1OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAD/gylY5VCGKxI38WgrXbKL6YRCh+tTinUTB1ky4
sxBonHlNRY5AOigGpa4auYhs1y9DMUYJ/0c/jf4x/9UI3TYRpzzSqoUhvd8VQ5jhI416VPXuHPpJ
v+4To6hdV1LCm1JKUXd28H/ahV+otdxlPKGFTzicsr+0rZHk/hZR2rnLyv4ZuVylxrLQHIj9j8X7
OrIM1jDAv8QqMrtb9+EdeSicYJGRCmnBNtkaUHSlPAShom9ymc01L16NRHLPvddZ8POrc50PPqdx
wtw5q7ArhmKggLQwsNdjwALtA1vU+nFbXC5OZhlkFNoIKvFgfy0qruUyFrkMUW9ZwcKN+CmKz6c=
--0000000000008a3aed064c4dbc3c--
