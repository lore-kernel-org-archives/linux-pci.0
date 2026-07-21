Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1646EF84
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662553; cv=none; b=F6mQvLaqRUNJYZ9PJK923yHA1qmMaKRnmwXHZv56asUaYRyUDPT6mLaecoTlHbbF3MF9xTmDjy/6PdcMKRDbj39SNZsYifqceE3SsP1nnLGVJbFE8Q+GQ0axsop6EbjWY3GPSuAY8aqklz2UktpxCybvHNW+kit+ZIvNGgR761M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662553; c=relaxed/simple;
	bh=kKKZRVp8LuawR4dbZ+EnGWQDKHzKSIgE34iatLf4tUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g2aeU7I1dRzNTVE01J42KlOEZ59/9YGwN15lcuxwdAeXJPUaRZKCyIQSK+zlpknSZBJtVPr6mUZ4bj1rSAzRk7IXIBMj+0uKXiYrQUYP5y7TxCpXLvGft4WJpzd8huE+RVVhwpgGKrPOXxkIg3tper/Qic/QeG04qeNM7aE86uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0LU1Yp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0LU1Yp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8E21F00A3A;
	Tue, 21 Jul 2026 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662552;
	bh=ktXDkiEVasiBd225qc62EyChkJlJaMwgvRqWck2UpJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0LU1Yp29rU44yRLcdMlccTpQNnGljIGpolJYfFsnifA57a4C5VPRajNF8FDghf95
	 dyt5K/ejvc90ln4LbQvjs19ZLKENoiDIGEJO/gxydEHhaCVBp+u9G2drN3Nag9+niu
	 rQssdbHg63MADnRfjLGycd1KPJp4mw0FJoTNJXV5k0NzphmFlUCFpT9RCViApimSmV
	 6hTawoDwGDARxY/uOVM52vjXGO67pa+55ubdnjvqcnp8NQ21RfHDkd28GDZcecLmyE
	 Vm6Sm2lOUuQ+uUVOvaLAku/oLG24Rnf6w0Wyvi+4SVq4xec2PcK+uHYVIRDwOH/uWM
	 UeXsSiKRD2mHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/DOE: Add debug messages for transaction failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saverio Miroddi" <saverio.pub2@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721193310.1179300-1-saverio.pub2@gmail.com>
References: <20260721193310.1179300-1-saverio.pub2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:35:51 +0000
Message-Id: <20260721193552.1F8E21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> DOE feature discovery reports only -EIO when several distinct mailbox
> status and response-validation failures occur. The abort used to recover
> the mailbox can then clear the status before it is captured, leaving the
> existing failed-to-cache-features message insufficient to identify the
> failing phase.
>=20
> Add dynamic-debug messages immediately before the silent error returns.
> Log the transaction phase and raw status or response length, but do not
> change mailbox behavior or expose payload contents.
>=20
> On a WD_BLACK SN8100 NVMe device (15b7:5050, firmware 830ZRR0A), whose
> mailbox creation fails on every boot, these messages identified the
> failure: the device accepts the Discovery request but never presents a
> response, and the transaction times out with the Busy bit still set:
>=20
>   pci 0000:05:00.0: DOE: [500] response timeout, status: 0x00000001
>   pci 0000:05:00.0: DOE: [500] failed to cache features : -5
>   pci 0000:05:00.0: DOE: [500] failed to create mailbox: -5
>=20
> Signed-off-by: Saverio Miroddi <saverio.pub2@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721193310.1179=
300-1-saverio.pub2@gmail.com?part=3D1

