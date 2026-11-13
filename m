Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602082;
	b=O8bDptrzpWmpogMHh6xk8fUFIET/fDLEEfHkdMhXMEFqtVlRGM4jXmrDE9nHF1aJ/Ddo
	 6K+iFrBxVsEnWuZLGW/ha5rS7X4WNSU7e1s3gl2FJZKajQBUm32T7mkmpqsbc2XjTfx9m
	 Cwcx3ehDszhnNs2PjvxoAz4miYHEetPTeT9XHxpGcnm+3hVtgtQWhOVEE98McExOfGRrD
	 VAs47hWvaOkBvOiVP2a5qwthXOojulFjFGMw1h8CIgPI/nTDFY+HWxrPlUJPl8UE1trAS
	 J86hO0W37N79K0ADnXvlIrFi6VcsyLjlKeZiAoSHzO64lBd04g07EN6pu8JKSrizwAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602082;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xA/dHrB8DVHvhn8WCh7VdIDLIPRiACwfBEGFOII6u8o=;
	b=UcAGkG/VD2RXnr+mzs/bbOxykpTf8Lz7A3VKq3cI/zGzjqbggHrp5C3QD5b6HsXNQpZz
	 /9yH/Cvi5ubHF1sKm/28UF2+Hsq84li/L2wXqrM9RdlhEWAPTcVgWPf3DvPxqEjlVWm9u
	 2x8nOpRMze1Qv+OqYBcOh8hnYMQTeJEgFtq0v19UhC707n0rxqo8XsMoQ+QKej05C0VAY
	 HzfMAUA0QDyoJ76Ie94E2SBHwu7BaqZXkKpg6sPusiEH62EQy73Y7sZt/iCK5U2zIwkO2
	 eQZ+alOXL7Aa5Z7k95sApvLtvQfY832f4LbGn1K4qPb04A9h4YEhcS2oXEeg48AC76A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXJ334Be;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A201606A332
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXJ334Be
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF361F000D1
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602081;
	bh=xA/dHrB8DVHvhn8WCh7VdIDLIPRiACwfBEGFOII6u8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UXJ334BeQG9A4rnHdmpziDcI6Fz7SDEN+8UDcEhmHAFJsQgzKGcZD0ZTetqFjBe4e
	 wADAfgmSnQ84cxGqeiMAXVYXqYsFYDEGBiCzxfcJcdg+U+C//guia2icBTuFIuj6b1
	 kKUnvI/K4GG+2H1gWsVxVSf0RVvjz5aH3hvBI3b6TvZX5rowcTb6gza4Eqw2IyFbJk
	 8RGCJ6DY2EixL44Zr+kUf1LEcwXFPa3KPDW2EL0p1WdwUuy4hib1VZtVOHcux0hkdf
	 +VacrIuxzzzxXPrn+3r0csBmIWocnTYEAnYOadYbYXumFVSKsXZ25to4PvnvEaeqEr
	 d37VLfLkyrArQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ad5529ae64so18972771fa.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 12:34:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFC+EofRvA4K4kF2xz9lleH+voiSkW+s9/jp6D7Unwk4R32nrvt72AhaSgeo76+M2Uyn5CuO+cjHLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wvwyzA7SEVab+dF00tfdtj+AgciD1RW8kACOTBvI7VQk81ck8
	3hdXOJyz6BuIfDV2uqibnxs2rTO2aaEwYrF+p6iwEsqgjToQOtBiU1KBRNmpQe916+zd/o80adk
	XRocXsXQ7no5soUyPNIUPKoIugdLN+bc=
X-Received: by 2002:a2e:bea8:0:b0:3ae:25c9:f5d1 with SMTP id
 38308e7fff4ca-3ae2b4cb695mr13163291fa.11.1794602079970; Fri, 13 Nov 2026
 12:34:39 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794567577.git.ukleinek@kernel.org> <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>
 <avdryC3GOqVNVF8s@monoceros>
In-Reply-To: <avdryC3GOqVNVF8s@monoceros>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 21:34:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jxB4-R2K6iQEh5BVeF1pDXFGn81jkXFCTMJLBAXoL8rA@mail.gmail.com>
X-Gm-Features: AclHuK98RV8mUx3a_eF9a_B1pqyxZw7Jy48hGkbo4K83RPSBSBvPbkBZkEPiro0
Message-ID: <CAJZ5v0jxB4-R2K6iQEh5BVeF1pDXFGn81jkXFCTMJLBAXoL8rA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Ira Weiny <iweiny@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	Gergo Koteles <soyer@irl.hu>, Jakob Riemenschneider <riemenschneiderjakob@gmail.com>, 
	Yauhen Kharuzhy <jekhor@gmail.com>, Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nvdimm@lists.linux.dev, 
	linux-pci@vger.kernel.org, Kai-Heng Feng <kaihengf@nvidia.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Chu Guangqing <chuguangqing@inspur.com>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 9:04=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> On Fri, Nov 13, 2026 at 05:17:30PM +0100, Rafael J. Wysocki (Intel) wrote=
:
> > On Fri, Nov 13, 2026 at 12:14=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Cap=
able Hub)
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > From: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> > >
> > > Hello,
> > >
> > > this series is about preparing drivers/acpi for a change to struct
> > > acpi_device_id. The idea is to replace .driver_data by an anonymous
> > > union, see
> > > https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@bayl=
ibre.com/
> > > for more details. (The linked example is about platform_device_id, I
> > > intend to apply it acpi_device_id and several others, too.)
> > >
> > > Before this union can be added, all initializers must use named
> > > initializers (C99 calls them designated initializers), which IMHO is =
a
> > > nice cleanup that can stand for itself as it makes the code easier to
> > > read.
> > >
> > > Pawel sent a similar series earlier, find it at
> > > https://lore.kernel.org/all/20260727-acpi-refactor-v1-0-ff900aa326ee@=
thegoodpenguin.co.uk/.
> > > Compared to that the patch splitting is done differently and the base
> > > here is newer.
> > >
> > > I checked for the other *_device_id and for these there is nothing to=
 do
> > > below drivers/acpi because the few instances already use named
> > > initializers.
> > >
> > > The last patch in this series is just some cosmetic to align the codi=
ng
> > > style. If you consider it churn, just drop it.
> > >
> > > It would be great to get this series in soon, as keeping it up to dat=
e
> > > for a later resend is an annoying effort. Thanks for your cooperation=
.
> > >
> > > Best regards
> > > Uwe
> > >
> > > Uwe Kleine-K=C3=B6nig (The Capable Hub) (4):
> > >   ACPI: Unify acpi_device_id list terminators
> > >   ACPI: Drop unused .driver_data initializers in acpi_device_id array=
s
> > >   ACPI: Use named initializers for acpi_device_id arrays
> > >   ACPI: Unify *_device_id list terminators
> >
> > All patches applied as 7.5 material, thanks!
>
> That's great, thank you.
>
> I fatfingered my author address in patch 2, so if someone wails that the
> author S-o-b is missing and your tree isn't set in stone yet, something l=
ike:
>
>         git filter-branch -f --env-filter 'if test "$GIT_AUTHOR_NAME" =3D=
 "Uwe Kleine-K=C3=B6nig (The Capable Hub)"; then GIT_AUTHOR_EMAIL=3Du.klein=
e-koenig@baylibre.com; fi' next/master..
>
> should fix it. Sorry!

Thanks for the heads-up, I fixed it up.
