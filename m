Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104341;
	b=d6d2WcE1TzIlPDORol+lU2LhbVPaVwAk7eumcpTxwVMBfqsfGaxrk7lSPnHe5Lw6xw0R
	 IxcrybON1VZCgg+8nuQgzZYNJSj46F1ZEJf6NSpj0N3K2fUpSMdv3n0JzGzha3AI2QesF
	 SeAl7mfTnsPifxqbf4upFl+Zy540eRYAiPzxX4xZjpMwPqxxz2rC+XRPpDWdra6RZvV1h
	 W6GIMhXd/YUE8ienTfg9GfwDHz5J/e0Tt1NWJfjhTSo0B+2iEkeIk2qUiyMot6fKTs7jC
	 wORdsxwbxGR2nLii2WWJUZD2c5vw+xkDLS8Oi7vXzsgpKOWxulCjqYZJi7wezaG0lNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104341;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JK5s6myLIwPYAlPueXJihWxjLQnJKLEVf2UgxMnIwJs=;
	b=CI51AnsBmLdZpzD28rLbuLNdZvFP/gqv+gMDm9VtBsCf0YpB6ixK0kbvSV/Sc0yC5y1p
	 2sU/+sjqsM1Dcjx4xngVYS9wk5iqMG5E714n7seLbeNEk2kva3NRnEh2RJI9m1db8Xykq
	 fhEDxlMG+ykK5vejXmEkFjmGST7E1xCXaULPDOVMAQvlxIcgvFj+aLvjyrVtOdvrC/j/o
	 NYYOtku7zBWryhrsOcUO86eD4z48Hl2uub4C/oncikXgXooUecRFS6ycttWXvOj8ukGZ2
	 vp8FQ6Z2RRBmc04tBneQaXcIYvAG4YcQhrjLC3HOGHFL+D6qw1jpwBgFEdCjkLb9cUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbUCM96z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877E606B256
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbUCM96z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A870A1F031E2;
	Tue, 27 Oct 2026 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104340;
	bh=JK5s6myLIwPYAlPueXJihWxjLQnJKLEVf2UgxMnIwJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbUCM96zYAnbVaiSCDLOEcrLk4ZVP/UhPho28oVVkIvUFbw3nrydygrM8DyzJl0p3
	 Lup3c5/Lgw3t0B0+tF9fjye2a6iTFjV426P/vwYkyt3kCsQSIMWVYJG5oZM36mebpu
	 s/PIHHZilvirVlPzLQS11/TYZf/yqz9kqOFV7g+PGnz1dAA5Hay496n6axff+aBFVN
	 iu21efh9BVe44jqClI5Wf+RYobfJttGOhLC7U2OCxApanKZnxbUVJFthUcmw69jB4T
	 3zGMZ3NLtp6VFJ2OyRgk/VhWf+cr4QX4sxl760u8x1lcDJBTmY31yHIfZNz9DALLeS
	 F+GxQy4aZdGnw==
Message-ID: <sashiko-outbox-186553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/16] PCI: dwc: spacemit-k1: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-14-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-14-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:32:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> k1_pcie_disable_aspm_l1() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap().
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D13

