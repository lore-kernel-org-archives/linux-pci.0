Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A603B6370
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208753; cv=none; b=atS5Oub2vzKwbCFxVoYLGyxnYtqecrFo3Pce7bmfPt9O/uVG2/4BGC+G7k2pXasQ+TE1WH2KqXsDruFMreS7RGCNW8JvHSugirlUSYeuU/RYH5wfVFI/h5e72CI1qvSzceEUBHVbX1IhhYXjNNQU0Jtv3jotRgJXRe1dJBiY+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208753; c=relaxed/simple;
	bh=jc7dxDCyUvOGX9J9Rq7iRNQprzCbX+Q2LfMFqUm2uic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ihcYxp7MFJgWv/uM5QI1rj4Ep5S1jUzBrGbM4PTH990FqnH9lMEzqrsqjyHaQOodBWpHUSedTp6UN3quEIFn/elpT9c5DSIYieg6H4D/x48MfHc1Tek/Bo4aKHLaFLHHAOZBPsg2JdAr7kS7VGlhA4VdVR3H9XwJhQTpHl6geQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KViKMYBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KViKMYBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07911F000E9;
	Thu, 20 Aug 2026 06:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787208751;
	bh=jc7dxDCyUvOGX9J9Rq7iRNQprzCbX+Q2LfMFqUm2uic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KViKMYBaGLFNt1ZmGXTP2xL2fd/I/7h1Onh48W/xaD7ZWSX7jw5frM1UNClmXzHc7
	 he4f9B2Tg89J6PxBQFIx2Pr2C+TYefZpIu0PrXO4uvExRS4vd/ozv9nMdmsW4eoH44
	 SsQgNHky7sI0rWSFHoQAGHGlM9zNn5O4PgV8ZtFUhlN0bUi3+JXpiaYG07U7GL67Zf
	 Odp+AsJRk3RPQNAs/D2hk6n5C/QiuRr45ExYqMOi0VVyfuwHmX0U+/ADs33NDaXtDN
	 dndCzMnXPrYMe46cP2WdF7n1Q3f/Aqc6NwJJPFuT3E7nvr/r3EfwsyhYtnw4Xbophk
	 fSoMt+MsBlE5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
References: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 06:52:31 +0000
Message-Id: <20260820065231.B07911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> After a PCIe link goes down, software may still access the BAR (MMIO)
> space or configuration space of devices behind that link before recovery
> has run. As the link is down, these accesses never complete, resulting in
> a storm of Completion Timeout AERs.
>=20
> Use the controller's ECAM blocker to drop these accesses to the PCIe
> address space as soon as the link-down interrupt fires, so that Completion
> Timeout AERs are reduced. The blocked range covers the entire address
> space (base 0x0, all-ones limit), since the Root Port's own DBI/iATU
> register space remains accessible regardless.
>=20
> The range is programmed once in the host init path, since the range
> registers are wiped by BCR reset. This leaves only the ECAM_BLOCKER_EN
> bit to be flipped from the link-down IRQ handler, so the blocker can be
> armed with a single fast register write for immediate effect.
> [ ... ]
> with a Root Port reset triggered independently through AER, which
> reprograms PARF_SYS_CTRL as part of reinitializing the controller.
> Serialize these with a per-controller mutex.
>=20
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-ecam_block=
er-v2-1-e7a8fdc1c5cb@oss.qualcomm.com?part=3D1

