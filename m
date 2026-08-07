Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A4404BC8
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117236; cv=none; b=lhMDzntJ4CaDrxNfvQikqotqnRvzX1sq907DvyP05aeFFsNQLDGUkKe+W7B14hzQMf1TkMRVz4vVpHendg/cAnI7SC/y+Q3HjvFPI1dUy/no9e0ChyAJTeuX5nY2UMTN1WJSB7VNx30auyU1JWzk1nFCLveeSiIV4sRRddcbmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117236; c=relaxed/simple;
	bh=aFWzsoJRqmLexpfzHPbCkHpX2YjdJdScMlnqcX19Z4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uGDprof8nypMVz3XHL2Wwe4oY3fadH04If/YnpiP89IS3kUUSqu2GOslTMvoS/cI/Iv0bqN+j4kBNhqzM3ET4YHJS4xjU7QiQidVsGIHgh1LoOeGZ9z9IKxY9HWsnH94im5aJAgjTcmPqw/zDx27Ei3/RlYj4f8vYSzxR7yn6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiHirnDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiHirnDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BED1F000E9;
	Fri,  7 Aug 2026 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117234;
	bh=aFWzsoJRqmLexpfzHPbCkHpX2YjdJdScMlnqcX19Z4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EiHirnDe5LfkW9Nt4M81QqzXZy0BRLuu3gRzFrRzNZQ7+/CZCsC4+pVMToNCD1/8Q
	 5hMj1Wr1uJzwN5EooCabJhznNcySYFq5STrheUTGrbVVV98YPnNDfRBFK/EFg8pmp3
	 lM5+sbr4Zc6Zod6SGVWQKd5C945i7sv3QGdA+xlJvKwUmOGJ3jhMjtCO/bvoeVp/ze
	 idYQEt7TnRSp8Hl6h9tNTL49on37+sSLyT6P3zFtD+ZpOD4MqSxNkRUec+qP4OwrdJ
	 AhQhsERIhvLT4TnThWcddjcWo8nfj1EbxKOyujBgCp9GlB6oL09Wo052q8K8MjsV2b
	 6aQbIXkSHsM+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260807145638.168865-14-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-14-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:40:33 +0000
Message-Id: <20260807154034.87BED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
>=20
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
>=20
> The explanatory comment moves with the code, reworked as kernel-doc now
> that it documents a function rather than an inline block.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D13

