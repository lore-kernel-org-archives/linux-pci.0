Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830424;
	b=hNVHiZN80S31s58Q4c+c1NqWxitjn+l0EdWHim4/cGAsJleHeiMzOUPqZpL+svyYPuJo
	 WJYkROeHnu/pmSZxzIJHcV6iBuDfhW50djClQxkdzuC2Sob2EHj2ZAW4JZW9SEcwxSJU1
	 Paxie7tc2xh3ABqiDl5UM+uDH+qPzh3plKdUgc7pUo7GiJIl8p/sGqNrbFr7ev7mTSpt2
	 m/vNLuRPpisCPZZI57Bt7mDazjyHen2g8KC8pMU/sE91iFALtY9lLDsPOP1yMF7S3Mi2a
	 M4PLO1CXMsvD8P6PycAzsM8ab1XAzto2Zl3v12WTLsTPjQexTX0JwOWY/uLlU7A/75Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830424;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7goVgkpwYKmj8484XOYewoBUT5Y28TtB/xzaeGJiua0=;
	b=ozBrYzwxlrNB+lzx68dHbdYJhkhxmQpgtSoalFu4z+H6H9wuwWnvYJfT8vg45I8JmX2a
	 WfJTPqqA+6HqCI6ryUQfXYYYfW5ymz9YakSDXpcr6zudo4sbrWyXPkbz6K87HYA5YNuV3
	 4IX8mH9AVn+2yuBrid0gg6KY0k2HmNWHx+pJxRfJrpjXSCZ6Af3zZKQQIyhaMhfnlWFH0
	 8SV3bF7cOCis9J7yXBHNnZwHqMHCRLI2ScrmMqbagc71eTRxobHujDEG8AMpj6LZYqHiZ
	 B0kxI3CNH2E82Xi+p3diU5sLrTeb7Zn7KkoXp8wnIAmgbeWyc+mLzAPVb8rXMV5CDNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQcLI6Zr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA060A260E
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQcLI6Zr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4289D1F000C8
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794830424;
	bh=7goVgkpwYKmj8484XOYewoBUT5Y28TtB/xzaeGJiua0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RQcLI6ZrMq6dV82dw5oYMjwM1Qqk9yku14O9eRoQnFZOMZ6NB+O+ri0AYaxZo+6YV
	 zi0cxGicR4oaHrgiFM8AAawitT667yr3cLmV+BFEHEd0FKc1cXlyVFH3q7km5pPeKC
	 /jPnQHjeScl0KH8wjtJL35NiZaqtn+zju1p8OgVoqnsR2dMGW7hnxgoZ8afbE+Rvtb
	 tHxKhZtXpCqxLwLcUk2C++p+5GqpUlSju+4TGGq3FnjoSjyl9L+ywWjHcNpxIpwOZM
	 Ql9t6qM8jPGgohBZ+ruvLRnIgHyGdFUfjAl8cK5PCpK3xYCOjDyIBZWWunQshNPDF6
	 IY1UIoFqqdE6A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c1479be604so2812360e87.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 04:00:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFGfEoQcxLMCbJCqA2AHMCwYPGLASzdxeyny8a9p8gtxsD4//BMELGG+YYQOYo9n4YFOkF7e6/W3gU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8D5o83sYk7MloLDGlCFxiCnhQKsMOEBBrbTcjHHSS3Pu1hbNMg
	ps3aExJZT/xvswwFvQWNJU9dPEc6yKRxrURLXjnGmcnU7M55wTkcMwl8tX00cj7OtXF+Qr+vLSX
	zYyctXPRT7D5ZDB2jttIfIwzOxL153sU=
X-Received: by 2002:a05:6512:33cb:b0:5c1:5a83:4285 with SMTP id
 2adb3069b0e04-5c1709dbe47mr3567729e87.60.1794830422511; Mon, 16 Nov 2026
 04:00:22 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115091221.2217-1-lirongqing@baidu.com> <CAJZ5v0hBVwOksptV2ThK9iCpHbSZDh0Z+R3dtojCtkze4_0eQg@mail.gmail.com>
 <0b5ce94eb1bf496781dd89c12295d229@baidu.com>
In-Reply-To: <0b5ce94eb1bf496781dd89c12295d229@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 16 Nov 2026 13:00:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iEBtR3npi9nG9C6gX9yERmNfMT898G4yW-WEK5AQyrRg@mail.gmail.com>
X-Gm-Features: AclHuK_nKEEaz8R2XMkBiWNICEsQXg3qgnHzMgyulq4CuqWWBjmI7y2CipbF3Mo
Message-ID: <CAJZ5v0iEBtR3npi9nG9C6gX9yERmNfMT898G4yW-WEK5AQyrRg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0ggdjJdIFBDSS9BQ1BJOiBDaGVjayB0aA==?=
	=?UTF-8?B?ZSBmb3VuZCBoYW5kbGUgaW4gYWNwaV9nZXRfcmNfcmVzb3VyY2VzKCk=?=
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 4:05=E2=80=AFAM Li,Rongqing <lirongqing@baidu.com> =
wrote:
>
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > acpi_get_devices() returns AE_OK even when the namespace walk finishe=
s
> > > without a match, in which case the return_value argument is not writt=
en.
> > > The caller passes an uninitialized acpi_handle and hands it to
> > > acpi_fetch_acpi_dev(), which dereferences it as an ACPI node.
> > >
> > > Initialize the handle and reject a missing match.
> > >
> > > Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for
> > > ARM64 platform")
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > > Diff with v1: add fixes tag
> > >
> > >  drivers/pci/pci-acpi.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > > e260089..e90e749 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -82,7 +82,7 @@ int acpi_get_rc_resources(struct device *dev, const
> > > char *hid, u16 segment,  {
> > >         struct acpi_device *adev;
> > >         acpi_status status;
> > > -       acpi_handle handle;
> > > +       acpi_handle handle =3D NULL;
> > >         int ret;
> > >
> > >         status =3D acpi_get_devices(hid, acpi_match_rc, &segment,
> > > &handle); @@ -92,6 +92,9 @@ int acpi_get_rc_resources(struct device
> > *dev, const char *hid, u16 segment,
> > >                 return -ENODEV;
> > >         }
> > >
> > > +       if (!handle)
> > > +               return -ENODEV;
> >
> > acpi_fetch_acpi_dev() will return NULL if handle is NULL, won't it?
> >
>
> Agreed that acpi_fetch_acpi_dev(NULL) is safe today =E2=80=94 acpi_get_da=
ta_full() rejects NULL up front. But that safety is incidental, not contrac=
tual: the handle layer doesn't uniformly reject NULL (acpi_ns_validate_hand=
le() even maps it to the root node), so relying on it makes the fix fragile=
 to future changes. The explicit check states the "no match =E2=87=92 -ENOD=
EV" intent directly and costs 3 lines. If you prefer the minimal diff, I ca=
n drop it =E2=80=94 the initialization alone is also correct.

Yes, please!
