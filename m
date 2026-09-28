Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B7280325
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599161; cv=none; b=jAiWmFOxZw4VEO2lmUThg3/KDok76adYViJFSR8hfnKe12Qa02DkDOOj2sW1pHkDhh0Lel/25ltRNarCzz7axz1S6nifrkL5sgxW5sm2b8XJjuFVYLgRtbGBteyuYioCey9V3P22yCUkTh0xVcyWlWlgR0cfYbnPit0lBoVojl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599161; c=relaxed/simple;
	bh=a/g2yGiDpOr8yd/bhG3PtChfDDjk124uV5fHGSbLRnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JtotO8baLyEY5E5vr0D4tqlZ39zDgshTfDssVHkjteWeZwATPDotMwyxCC44dYb+8uxnAs/5eb8QO0g/9zU2Jyp1nTnH8tyyKikBjEF6Omdmt5Rl0dz6JiEQgvxuNP3NCtDECgzeHDQWd4U/Ms6+deTALCxfajn9DbJ2Ercl4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV6CrOPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV6CrOPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC141F00899;
	Mon, 28 Sep 2026 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790599160;
	bh=a/g2yGiDpOr8yd/bhG3PtChfDDjk124uV5fHGSbLRnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mV6CrOPaGD3fUTxM80JoGg8l2sIFUd4DAhaOm2Qp93kidBJq2XLwIxd87NjkHOvW2
	 +KuEqha6y8l6JnoPeeb0KU6QSrrPcHe8N3tiUfEOsd63ZhIRVsy8Ga1hzXZXJcMNou
	 P/Jo3fsVUi99Dc6u5CpvDJmHtu/8W3zbK+r4RiaJ8eEj4rVG9KWn0AQXpTH1PljRwK
	 K1fQr4sop+xfw8cQPSS3fQAfjvO0v/eN3PuMWOAAMNpPG9e9hZhUX9g0EBrlsnjWn6
	 /2JoUvwuFtFJz+hQU9RKbljl8eXS6uWg2usvTCFefPV28piYBuVD0gVOrUZ1K2B7IX
	 A+uzlwkIKybYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: sysfs: Reject unaligned resource I/O port
 accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260928123036.7902-1-kartikey406@gmail.com>
References: <20260928123036.7902-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 12:39:19 +0000
Message-Id: <20260928123920.2CC141F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_resource_io() validates that the requested port lies within the
> BAR but never checks that it is aligned to the access size. A
> pwrite64()/pread64() on a resourceN file with an odd offset and
> count=3D2 or count=3D4 reaches outw()/outl() with a misaligned address.
> On arm64 this becomes a store/load to a Device-memory mapping
> (PCI_IOBASE + port), which architecturally requires natural
> alignment, causing an alignment fault and kernel oops.
>=20
> Reject misaligned 2- and 4-byte accesses before they reach the
> low-level accessor. With natural alignment enforced, an access that
> starts inside the BAR cannot extend past its end, so drop the
> port + count - 1 range check.
>=20
> Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7134530b25073b4ef373
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928123036.7902=
-1-kartikey406@gmail.com?part=3D1

