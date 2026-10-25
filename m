Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792950656;
	b=WZ1ksc3SPE+U/UMpO9blURM2cYBXakoTyp2yN+wMnKKUV9uHBXnfkASDiLjFUfdUhNMO
	 xd/7YAN612p1edsFo4PO02aLmMLdXRpo6n5DUpYmXDD3CNVhCUAtlUuUGyfdhG0Mz8l7N
	 eIQueYEVmPTeaxONRXJFaxCaAvlluKsTqFesAZpnGM71tJY+Mzdqo724WgsMAPB9IB9AK
	 kLiGKbd4hRQcH762KLDJ8YBO4PGUqz3adEGkeOoCw93Y5LmJsQ+sQJWDP8uby6PoOBV1D
	 GnibY6fwtlN1sBjnnhDx6Ipxy/QqgetjHqZR/aBJZFQwdWLpAp5HAbQXDTtzNMhDC+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950656;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TA54rHY6teOSFaQOktJwbWdE9uD5IaMDmhSmda0ZLjs=;
	b=cnBOKNOvLs9myWwuPydzN7mNEH9dGMjrXpzfPZIwg748ykI8yAFtRUZPRmQaUPRcT83i
	 SLnATPJhczoj2B2XQbMX/Bbs1FPwv876/jW6VqHKrPIFormF9ov6trYkhChBssEL8ifiR
	 02lmY95Kz34GjO6U735Gbzdu1i6ypSTA7RIEfSrzABnsGc91ta2+O2Mc5xXQFom3A3EK1
	 KePQplkrHfY3qeBCzTxWuOSZR2MpriLEOWlrj/OR7Dj87oHuHeSCBqWiRsoc+7iDmDA7D
	 4unmSNhwBLPPIUVEXD+QJLMGybvznBi6+MHLIPm5UVLkz1pLGxN89FUDDejoZFrl1Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zytor.com;
	spf=pass smtp.mailfrom=zytor.com;
	dkim=pass header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=aBY905KZ;
	arc=none smtp.remote-ip=198.137.202.136
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAAE606A31A;
	Sun, 25 Oct 2026 17:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAAAE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=aBY905KZ
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69PHoYjb4052143
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 25 Oct 2026 10:50:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69PHoYjb4052143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792950635;
	bh=TA54rHY6teOSFaQOktJwbWdE9uD5IaMDmhSmda0ZLjs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=aBY905KZt3mZIxTLKMSLBnPJxCRSoDbW8HU2ypGBQFuIByLZyKivDl/zpKwR81hby
	 0xbHsk0hCBYea1vXqj0FUvIxaxbBy/CJq3N4kMszBnMB8ChdzaGUqmxZWHAqPrZTWo
	 7VzpmHbuwxHYgAvVoh+asSsxs6XkXJGV9OyorJ2El4QbDoJcJyFF3A+m/+r8IWoaJN
	 fMiq3/J4kVlQzFpdyEpk9Eb5WEuUDdcXGmVlOqaFeJQvigmSgzntfna+eh+NQ09TLg
	 2QEWxZxWDm0TIxHzCIrkIMn8zDima7pYJ0AcLUE6kLIN9AHIsUmJfFceIrVN5bC310
	 0vDeabyYb39mw==
Date: Sun, 25 Oct 2026 10:50:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, Thorsten Blum <blum@kernel.org>
CC: Dave Hansen <dave.hansen@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND_v2=5D_x86/early-quirks=3A_S?=
 =?US-ASCII?Q?can_all_functions_in_early=5Fpci=5Fscan=5Fbus=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.2610250743510.42255@angie.orcam.me.uk>
References: <20260916100206.92853-2-blum@kernel.org> <asDr0tWYBNC296EQ@kernel.org> <f9b1c1b6-03d9-44fb-bdc4-78342b05f2af@intel.com> <asLw3ZfDy-rDxwtv@kernel.org> <as0mu05UzFWBBRJ7@kernel.org> <alpine.DEB.2.21.2610250743510.42255@angie.orcam.me.uk>
Message-ID: <74A9835A-4B16-409E-B13A-4C34FAB5DC8E@zytor.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 25, 2026 1:07:28 AM PDT, "Maciej W=2E Rozycki" <macro@orcam=2Eme=
=2Euk> wrote:
>On Mon, 12 Oct 2026, Thorsten Blum wrote:
>
>> Is there anything else I can do to help get this queued?
>
> FWIW, it's not unusual even if not common for multifunction devices to=
=20
>have "holes" in functions, e=2Eg=2E:
>
>07:00=2E0 Parallel controller [0701]: Oxford Semiconductor Ltd OXPCIe952 =
Parallel Port [1415:c118]
>07:00=2E3 Serial controller [0700]: Oxford Semiconductor Ltd OXPCIe952 Na=
tive 950 UART [1415:c11b]
>
>which is a chip the functions of which (one or two native or legacy seria=
l=20
>ports, one parallel port, one GPIO interface) can be activated selectivel=
y=20
>with reset straps, however the resulting numeric 0-3 function assignments=
=20
>for individual interfaces are not necessarily contiguous, presumably to=
=20
>simplify internal decoding logic=2E
>
>  Maciej

Indeed, or there might be multiple versions of a chip with different featu=
re sets =E2=80=93 often the same physical chip in different packages, so so=
me features are fused or strapped off because they aren't pinned out=2E

The assumption that a multifunction service will have all its functions co=
ntiguous is absolutely false=2E

Acked-by: H=2E Peter Anvin (Rosaic) <hpa@zytor=2Ecom>
