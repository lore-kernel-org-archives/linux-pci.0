Received: from mail-yx1-f104.google.com (mail-yx1-f104.google.com [74.125.224.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043CB28CF6F
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236362; cv=pass; b=qiXOSOyOA6v3sWRorqICZ7JfLR7ih/PZ9ZaoxbBWfKjnzexdknDbVdKYft8EkC5G303XFm0d3zagb2QKmI0pSsd0a7Y5qVkLuAkUhyOaTZaMm/7zzpsnDKri41/tQMfnAMlgjsPzEykjgE54EhIksC4JseeiBbVq69rG+mXlDHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236362; c=relaxed/simple;
	bh=jFubAEdZCZclsZnDnIhRLggwaux+zxsuEGUztzc7rnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnkVG0Ei3qf19JowTuWudLGyL+V+MfcuuOIY2w9rwQLL+URNkFLwgSALaoeIBNCAfKxRarQyRx1cQDNyBGFOexwp1qtNrR5THlPiBkJX1tkU/PoBjixk+yUHdvkWt2PB42BJhncF3XCqXIEsTEof5KMJzbXC3fmpzxxZ11lg6AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=crwlwzQq; arc=pass smtp.client-ip=74.125.224.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="crwlwzQq"
Received: by mail-yx1-f104.google.com with SMTP id 956f58d0204a3-649278a69c5so2350794d50.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 15:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236360; x=1772841160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU9sm6x0KT8GUzZ8y84PhcqMYC35Nr3VhVAobUJuhjc=;
        b=oG1Y4QYve44RSbYGA5SDQpHAoHbp9V09Zh2Kk8UtnAkblaHEwNn3dXAGrWz+liEfcy
         m65wdtL9zbxCJDFeUTLfldEWY+WXfaqF3OcnRNNc8CKq2x3ZIJfhVQkDYoiP2Iu6tjL1
         ftJEkRQmsmLoczkNKploj2jvxZXqGv6Akvj9rIbswaTMaNNPm9nd5/9y2JmKZjbTO8lI
         SMwhjsZNstgp8ARXbubpo5qiEv/hOIdNACRKGLVr73QgzByGd/ZuqIKA78y3xy92k+t2
         ezhtHahBjUXLdc2IPq4Nu/yfF2sLdMKoXh83XmjNjBsZmIyIlgE4L8G7Jmuby1Bq43vQ
         qYHw==
X-Forwarded-Encrypted: i=2; AJvYcCWMu2b9q/X8mHXMgTpm18c2DM484hszGTLmUpf6Y8Bymn6vpM1nJsEqysnNFvMAKRwwfNKq+73k+tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKXSh5NET7ClRwRsLwYOXJyEycXPfviYSVp+ZxgjlfIUEMLJe
	3jXx0/XyJa6wqPE3IlYC/TLFYw6O1YTvH+/pYx59BBpAVGqQeZGVLsivo8kK7jvnMQNoT02ndhJ
	aMsYqZ73erpJDc3zei0fo7X/793+copRnoZvnOAWvMiSm0+4YddbmqzfcNJ+mU8G9Q46OfWqOZE
	GuXV9K0P6VSuCh+FfGW+T15c9lmaFPvSR1rnJL6YaVoayJRDRAXVee6jjEjMi+DzA2KyF29XpyM
	ckPs5i0mlZDJQkGjBE=
X-Gm-Gg: ATEYQzz41ELDO/POsORUcU56HI2/Q9seF9xMNHLH7CUg2Ipz1grbvEezCzvWfVLu7oE
	QcbTzlvPPHTOX6RI5HqLo6Znt7+MrUo+DVKgsFoBU8FLfelRQyocixrV7yRdgfEfoTeZGak5za9
	BYRu59N6Haa9LYn7y3qVeM9/0fxFLmWKFSHOeX3j/280+a46ESMvoOapiiSaRJDGHVuLpggg85C
	1q/Q3HSMokgxaem+iyRH6JVtLgK0CKF00fodmQhhg0NHW7+Ep/evoDm5g4lnQxNysLPyMftZOrY
	N1U5taNF5iPffOHnQHOmVyeQ2WRXOsm4ICQhQ4g7wNWeie6PCg4wcKH8IQ4cdt77rHYwo7yt26E
	oXSHHYe7awPGFRMJVjz2wnQtpH7I3LkCpakEb+7TIzv75O9k0kzH51pgHJJbht0R1zy9CeyKKF5
	HkO0aTmUaHvLXwSaRzoKrlSUnIY5RB7Uo1czgN71Zds8YjgDj/YmTsoE6ReSUS
X-Received: by 2002:a53:c652:0:b0:649:b31e:8f4e with SMTP id 956f58d0204a3-64cc22c2ac6mr2889579d50.70.1772236359680;
        Fri, 27 Feb 2026 15:52:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64cb75fe60asm617070d50.9.2026.02.27.15.52.39
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 15:52:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3871bd94811so19970101fa.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 15:52:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772236358; cv=none;
        d=google.com; s=arc-20240605;
        b=bIPLEAY1LkGoD0qTbtKWP79UXclRqrTbmSKw3FBETe8dK5qO+Pq8oqukqPophavXCA
         FLtYGCEiBs9uSwMdOkz1TAIo+86t9sEgkJf8QPIWvDyU+BUp7b69inBZEp21aUWciuFt
         EmGTz7HnPZexeCVALhOLKaUVrh9vMvDdPPFkWnudWEcMGmejQNYfJIoD3iONnHWMl4t8
         XpNQUjeLSy99qNR/3EAI0nxrVJy6n/xugGda9R6z5IUhCapV+0GPJx90GoVOmJ/h5/wF
         maNb00igVbpblabKc/18dgiwMtpN05Zzpmpg6JbSfCf9scfj/uEa1aJGOhFLAIKB0iAn
         KTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rU9sm6x0KT8GUzZ8y84PhcqMYC35Nr3VhVAobUJuhjc=;
        fh=h0l1TLfuMshmff+WRIQKFZNUqpFNmzwXgeDmVYZql3Y=;
        b=i/qmceUjGnnu1734YLKHJRATKnZzAP5sfVJBbexOc8SM5HalcP9W9q5mOgQLejY8MH
         Tjv9si5iI278KlOOeM/J88hDdXyzWN0Ytyb9jCsNVRE4YIqztq1cOOkw2evYGykjxkdm
         Pg1WEmY/sDIXBh3ESfRj1kebNwXLx9lf/HOMkLq/cjeZ/s3K7ECFH7lMSytxewDyNQhA
         Am92jVfGbiZOIDeOkQdnWyGdris1IntfFzECtPOBJWBv24MQ/zRZnxQxgzYArFM6lReG
         87RXjNGJYsJWKxr3SofhCZzW6MDZZpZF5M9QZEL2gGWI+BjMr+9yu9+E1xyPwrgvXWNm
         Hcbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772236358; x=1772841158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rU9sm6x0KT8GUzZ8y84PhcqMYC35Nr3VhVAobUJuhjc=;
        b=crwlwzQqy7WhV2r8qEOxzlqn9V1Y90VlgVNvRih8L1uzBBkPwXYtf48k6lpEdNKare
         p4Hq8r6sDj1r2TpOc3BDcHNCxOe/NJdWIHZW9nPrnv+6TOiG9JnI1fwyb/O2r6sFyAIc
         R4/GsHkl77YNQivVKAyWt4z1BZSzyjpqqMHPk=
X-Forwarded-Encrypted: i=1; AJvYcCXhBgC+FezieKjuTdwp3iHeOi56pm3G8j7H+qX1DmMbhyTZu4u4b5j1yzFhlXcXrermFDQczm6d+u4=@vger.kernel.org
X-Received: by 2002:a05:651c:30ca:b0:380:a1c:7045 with SMTP id 38308e7fff4ca-389ff105688mr28751841fa.8.1772236357856;
        Fri, 27 Feb 2026 15:52:37 -0800 (PST)
X-Received: by 2002:a05:651c:30ca:b0:380:a1c:7045 with SMTP id
 38308e7fff4ca-389ff105688mr28751711fa.8.1772236357336; Fri, 27 Feb 2026
 15:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200928194651.5393-2-james.quinlan@broadcom.com>
 <20260220221106.GA3552425@bhelgaas> <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>
 <aZ731NM0TgqvwOlo@ryzen>
In-Reply-To: <aZ731NM0TgqvwOlo@ryzen>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 27 Feb 2026 18:52:25 -0500
X-Gm-Features: AaiRm5339ubbkYR_U31qTji6EZOgKPfannORuqNblCmANAvrqF7kAFzwbjOmBzA
Message-ID: <CA+-6iNwjn1PKufe-Ot0oefnKfkPxYsYoCk-RwuPxk117t=joww@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build time
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Bjorn Helgaas <bhelgaas@google.com>, 
	open list <linux-kernel@vger.kernel.org>, Hans Zhang <18255117159@163.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000097b7cf064bd6ee9c"

--00000000000097b7cf064bd6ee9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:23=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
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
>
> Hello Jim,
>
> Could you perhaps test this series:
> https://lore.kernel.org/linux-pci/20251127170908.14850-1-18255117159@163.=
com/
>
>
> Since the series above only defaults by setting MPS to MPSS for the
> Root Port (and no other devices), for kernels with PCIE_BUS_SAFE=3Dy
> pcie_bus_configure_settings() will still be called for each downstream
> device, so it should not affect your CM product.
>
> But, it would be nice if you could test the series anyway, just to
> verify.

Hello Niklas,

Unfortunately I do not have the specific board that required us to use
the PCIE_BUS_SAFE setting, so I really cannot do a proper test of your
series.  I typically only test things on our STB boards using non-Brcm
devices that have stock upstream drivers.

Sorry & regards,
Jim Quinlan
Broadcom CM/STB

>
>
> Kind regards,
> Niklas

--00000000000097b7cf064bd6ee9c
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
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAwz
l7kW7u7ej4it/jNhKN9G+q3NVG14Ug06lDFqVMKJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDIyNzIzNTIzOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKtrivNOAifHom2IqaB5/MMIJXCa4R034UxuA8uh
7MCurfTOeN3407pKukIGES14gYEmoYJ9605yx522ZLr0kb4MW9gexAy8QYj+17rYMu3Yg2362Wh0
MzSCVULiIN+q5n/l/tDcetc1aLU6/+E7v9KzThcPFXD/LpZxV5IyTTN1GMLKmrvZ0Y0KdmYxp5oo
wnBMYwF+4WKTKpNXQ3qIBTAFhRm5qPzelGWxwysHFs52bHw6XSmd61FweCNQssowSH0Z4dWEFdnf
J0kJCrjURlAcFkY+SauId1+N7XIwNzCM9uZIZbuKuJOFETwq/DsQfSK5EcWO5y2OeOQW4AO9xKs=
--00000000000097b7cf064bd6ee9c--
