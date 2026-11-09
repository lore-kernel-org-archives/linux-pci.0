Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259069;
	b=NHxb1UkOSUdXUlrpNSBKbtwl/RXBNAnZebl9aHyCgdeYujkpZlOYD2ZR+tQLHWknmrFV
	 38FT6vojfbicJblJYZzvjfor6ecJSDqxZbQGTB1gVHxz9lGKrPt3Noks7HhDjn4wS3KG4
	 9fU3uj+6G7IepXYshn+oR110CSnvWxPDI2r2CwR0ns0T0anmZnhi8zCaUN5lAdZmvL0aI
	 SiO75rL8+7I2LAlYN8nPNjBJ79yWJ4CJsXivKhlXm+HyI3QrwPOjsxKf3K/Bwxm0cyqaS
	 Ec+VXhXqY769L0t2Bqq300QwdKvRJSMwxDF2XkQRlOx0OouN8R3wslI94BRazgBuJwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259069;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AR4+XLd6P60pVRRnfwDEYY6wDpGQsQihesXJJzGJHIc=;
	b=GrYuYarl39H1WO3gwjtj/duBPKCyFHH52W5pOc10DdY9fBEaPRp7iH6/F5ul3CSiles9
	 FVf2YnHZm0BxFATxWQumCc8xzuPCzV35A0ocFyfphzQiWUQ8G635y78XDpy5OcGGOGqqQ
	 Oi/Mqvtu41HfrsCPh6OFHFtyO9yv3SYik2ghiKgq1zf/B+r+AqFyuv1wK+0cBIGa+Ce7A
	 XqQtKSwhsLp/ToeVHob/XNv4kqA8M+akwxl/ZpKq6eehYMArMWncCMjR4dwbuyFdEKARc
	 hKNbD/pozpJ+w0IzCZKZdlsgYsA+ShW5Hz3n8YZEuOjxlkzH2bw2kuzMs4GtjLDEbmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCRW3yYN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C44606A321
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCRW3yYN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F90B1F008A1;
	Mon,  9 Nov 2026 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259068;
	bh=AR4+XLd6P60pVRRnfwDEYY6wDpGQsQihesXJJzGJHIc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bCRW3yYNv9kfXNnMMOGdVDvEEtnNPruuckXtfuwA1pqYk6U5Hh1alFyYvRT7I6x/3
	 Bc1X02rNJwh7l+aJVQsAubhrXK4mFwSIYUusm7tH4VBNeXuwOX7SKZ3MymFiA7GDQM
	 yq+9dk5Y3b5VRrAUl+eYGLjTtzpCUyS1nzhikVuDVXg34KHBujEWh6KG7thSgv2woH
	 hKgJyUgrmsjnk1BXR1q3BJdtBFAI7ZWoHRlJbCDzDxvjNcpyN5T6B3Wm7LFNJWN4VC
	 bVefhb73eWg4xxI3vr3isKGeG8fuE1BJNqHdOc9e3e3wZj9m1CjVgsvXg5hpeoCnwI
	 jzbJ6etJYZZjg==
Message-ID: <sashiko-outbox-205659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] PCI: Move pci_read_bases() wrapper with
 BUILD_BUG_ON() to pci.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-6-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:17:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_read_bases() is static in probe.c. An upcoming change moves CardBus
> device setup into setup-cardbus.c, which needs to read the CardBus
> BAR from outside probe.c.
>=20
> Move the body of pci_read_bases() into __pci_read_bases() and keep the
> BUILD_BUG_ON() check in an __always_inline pci_read_bases() wrapper in
> pci.h so all callers retain the check.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D5

