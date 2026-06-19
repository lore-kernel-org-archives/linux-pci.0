Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758A24B28
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861647; cv=none; b=myR4Bg1DqumjJUQiZejMMaTj9DNECSZ2V1aF1/aPDafL2QxlLuW21SrxwhVIfBmbr8hPDpb/u9SlyWvVEMPI3XYoNtmQ0feSdXoyAEWSOz1+hgmXlL8kiFP+TOlMLVGw6OadNq8w0ulPAlGVeVe4g8nn2JDpvV+xRnSM533xYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861647; c=relaxed/simple;
	bh=cyvSvhiaqTaMNYzue2fNLFFrGZcTCJ32AKSlK8y287o=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=tgKBQkR/7oOxIj1A7xIHOrD5k0b4bXS19RHmdE+G5Wf0UfKsD4A3GhBLf5OqLQt+5RoRkvqoJYrBmp+UfAWTy+euBwWj7jNTQk8kGJcg5lLzURHPVrhp1TxW+g2UsMshVPf/HSVqU7FN0ipWdh3YxgToAy2A4KfHRsfiiD/CtHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=makuru.org; spf=pass smtp.mailfrom=makuru.org; dkim=pass (2048-bit key) header.d=makuru.org header.i=@makuru.org header.b=hEYObVY+; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=makuru.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makuru.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=makuru.org header.i=@makuru.org header.b="hEYObVY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=makuru.org;
	s=protonmail2; t=1781861633; x=1782120833;
	bh=PuRKsREjeaFtFSF4V81B80R0zSoks2qeUOco5cBMa7A=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hEYObVY+nSoHoYNnWuyPXbOHtj0t0Qqs0AE42tk41rTvLSTsSlxkWPkeYAv3HfQ26
	 51SEHBnThqQVoESvMsWNK+240bTMoLz6Ao8jHvgHZNKZXGztbvLGt6/W9ibzfeR7bP
	 f5QYvc2KMz+yGyMlaHXYDSjRsduMLLKUVjw0ktbyEsA6mUpW4QBqrUCj+VAM/uL4Kk
	 /rq+2tGprhd757jtN6UX6PfgWz0Ix0uHpbERCtkcVwf6Ax8dzH6Gezu6ojALP8Awbz
	 5IZqyHBe6us4bem3xDUoWqBgpimG6RTgvCEizlMoCl5LYM8KHRzg2w+/MFGSo9Xs34
	 FY+G9tKTZfoIQ==
Date: Fri, 19 Jun 2026 09:33:50 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Makuru <makuru@makuru.org>
Subject: Faulty hardware, where PCIe SMBUS SDA and SCL is switched.
Message-ID: <U9GMZSNHpMAh-uiCxTqZk4-BgUTjtFoiSUUtu3e2v3TwWl0r4BoXsMvGJMISQ6Jqf-n10m95at5FCzGrIa9NzUYP6HzGJU3w7bt3zV_BmIw=@makuru.org>
Feedback-ID: 111662550:user:proton
X-Pm-Message-ID: d84e891bdf3c2dfb965918f493d20059cd4c84c9
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------499cd641e4bc532b7384712057c189c16ae2d45ed65e89018ada328d7e52e671"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------499cd641e4bc532b7384712057c189c16ae2d45ed65e89018ada328d7e52e671
Content-Type: multipart/mixed;boundary=---------------------5c326699d1c5df9522f7f2d2f8e1ddd8

-----------------------5c326699d1c5df9522f7f2d2f8e1ddd8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello, I am new to the LKML.

I have made a bit of an oops, I am developing a board and somehow screwed =
up the wiring of the I2C of the PCI Bus.
I tried fixing it with soldering, but that is extremely hard as there is o=
nly 4 mil or 0.1016 mm space and width between traces.

Here is the project of the "ad in card": https://github.com/makuru-org/FW1=
6-MCIO

TLDR: I see maybe two ways of fixing it with software and want to know if =
the LKML sees them as possible.
- 1.) Switch the I2C pins in software somehow (Don't know if possible).
- 2.) Initialize the hardware without a valid side channel and purely PCIe=
, RST and CLK connection.

Hardware:
  Laptop: Framework 16
  GPU: RX 9070 XT

Thanks,
Makuru.
-----------------------5c326699d1c5df9522f7f2d2f8e1ddd8--

--------499cd641e4bc532b7384712057c189c16ae2d45ed65e89018ada328d7e52e671
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmo1DOYJED/5yBcL/6qnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfep9b+C+JixV5u1c8pfzaeqGU8hlGWI43kLQrc
pOj7+hYhBHJs3yVDBUxfBwxa6z/5yBcL/6qnAACL9gEAgnQO4b4UZDRCyrI7
nFPOZ/AM5dzl+teSJ6u30vxoabgBANoowY3hxwEbnxec8cMta692uHKQg5Rl
T9uPogA6izgF
=cLEZ
-----END PGP SIGNATURE-----


--------499cd641e4bc532b7384712057c189c16ae2d45ed65e89018ada328d7e52e671--

