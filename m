Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D94DA9DB
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158955; cv=none; b=EVECT92oZt/r9hyxvJF1G81gsv7AhCLkTgJ+Gws2waNPHksCTkv4vO+M6mSYCqxNa039AjDjguVSfy59N0jIBtllmnXKdKY0lG7683lL/3HSu7oH6FO/VTtQpAbEXpAkUNOGAhtBBikq6N9exLPnGuuSkRnjsllcjz9g9eHd3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158955; c=relaxed/simple;
	bh=/bkDCu5h2XLX3ibwAD13714kJqdylICd29ANwrfmR/s=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=CtJRnN2OqCwYheC1u70CvwRTFFBxKAcIRp3NtyrODRRGDDcTdr8wtTd2gQ56E+bcagnhxbZMo8qtvLuxiedRNEYuZbtdZY5Kx0rbzdGWqsm6Pz0PwG3ceK1ER1+X3/UdZII64trM2xQkDpp0dmBVwxaeQ4Ux5PSQxNs7wUnVn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idALAy1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idALAy1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB631F000C4;
	Fri, 16 Oct 2026 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792158953;
	bh=Ia8coliKhJ/V4AoLa640OXs53kUDD2/dNMLRecI8WsA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=idALAy1q8XyUfSSQSQczs+dPlMTNlLtopTX0p2jomAhrHmyHHf7oaoYLQO3ZurHJc
	 ui0CsAGAA+d7ev1hBfYWaoLQaENvkJPUtYrkfzfIXYCCQJ5vK7RRGmVBCHHDDadaw7
	 tcCQ+wyIR7wq0fyw3E/Ex5NXK0oLCELzU8yI811S2n7e0H/LkrZK+foDbsT3PXwZPJ
	 QvLHFD6GqtqFykHRG75DkSBNDaAPdo0VVoAppN4xe1QuMUohm+8FSvCqwhaElIqHQU
	 hQtoCPs6EOE4peRGXQslcucATwUpfjF2u8RNm37lfLKVytZ+hZqwATcX8mXafskCW5
	 6Ww7B+BPEQtrw==
Message-ID: <sashiko-outbox-174417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Disable async suspend for AMD rev 0x62 ACP and HD
 Audio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Sousa" <diogogsousa@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261016135042.44914-1-diogogsousa@gmail.com>
References: <20261016135042.44914-1-diogogsousa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 13:55:52 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On AMD platforms with a revision 0x62 ACP, such as Dragon Range and Fire
> Range laptops, the HD Audio controller usually stops responding after
> resume from suspend:
>=20
>   snd_hda_intel 0000:69:00.6: CORB reset timeout#2, CORBRP =3D 65535
>=20
> Audio playback then stalls.
>=20
> The ACP (function 5) and the HD Audio controller (function 6) share an
> audio block whose power is gated by the firmware.  In the AMD CPMACPV4
> SSDT, the _PS0 method of each function marks the function as present
> and then calls a common method that powers the block up only if exactly
> one function is present:
>=20
>   Method (_PS0, 0, NotSerialized)  // ACP; AZAL sets M279 instead
> [ ... ]
>=20
> Fixes: df4148a5a3cf ("ASoC: Add DMIC support for the AMD RPL platform")
> Link: https://github.com/CachyOS/linux-cachyos/issues/950
> Assisted-by: LLM
> Signed-off-by: Diogo Sousa <diogogsousa@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016135042.4491=
4-1-diogogsousa@gmail.com?part=3D1

