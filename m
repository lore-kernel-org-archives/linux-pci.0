Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118035;
	b=dKARnrj8BleDA7DmLK9jwZpIMZAn7+3Afa9HHKL3zxjo/39OehDxOZJ9u3bvxcNY8Les
	 ICe32bjxmPUQePjP/ZqQiL2qb6QbXFOl2uUzqflAxUVP52paCDUqRc7td9kzidzqMUWdD
	 KOnOl+SS0nKgQXCLpN+QcH5LIReyX1l/EA15GUYvytAO1oYllyZ8DK+3iTzBF9ckVymgt
	 /NDH/d1ZNK6FTvPpZFxln8CycM3M3f5z7zUDeB1h/7HCfsU5ljrJh7xACcxMZkWXP0kXo
	 olIrevpvHnWk+06H3MVVTsG6ZxevDMW0ZgUNUX+kaz7VYtH/Up5MFg4s0jgwpubhs9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qzH9q24tX7uN80N684oI7UbbW3QhQj/FHJ7OsO/kgNM=;
	b=3ub7J00U0xIkdOakMyxFOznAnlgmmHFqIY1J1tNw9c0wLbhSEJ+wSu5bqQImDhkkWJRO
	 R6lSXfBhW1/xA2qBeaX+EXZ2WU9oZk54OU1QNoCP4o4wWbbtGxMAfrPHf9KOeBEaEa7de
	 rL0qFG6FYh9oz9tBPWXGWPhtQuGohmIco9kgSEnyjIouDcH2pyx77051TOAectSjoH990
	 Rd0fggi8BwC9sfHW1GXjL+5F7GBVqNNrXp9QZwkoT0WfOVFS7uQ4ENC5ZzW/ngmjysmfe
	 vbzDprBrlHRqYbqe5G4iBT7fsKOANIovUkdwMk7eh1IFHKVp3twLTkLi+D4MyNqo1Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfKUwdTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2F606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfKUwdTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3161F01828;
	Tue, 27 Oct 2026 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118034;
	bh=qzH9q24tX7uN80N684oI7UbbW3QhQj/FHJ7OsO/kgNM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KfKUwdTe+e/KR/46HUoGwExCbmbdYpOHZom1mkGbDFipP3tqFmrrQPKJQ3Tka64n1
	 jivJ8uAn89TNxON6ILWncmUNSUeuKHQeeGB4B7CY0xkcut1UlJrDl4I/VEkO8uTrs1
	 2cf0wzEdHk9+RkDWd62yOAZ4ahks4lJSHo+fIdiDt6uBdsSYgIJfGqRYCwmT2SrkEr
	 +HpjMilcN9MdGXQEhdA2e5dJfMUH3ylD8aGXOGEMa552MbUTogjT+YZl/7+ZClgmtV
	 yJB3NsafrKB21vH30f9xa4hTuxcrtdi7OvLC5wbG9hS7dYBxr+HbyNE42yU4+WR+cf
	 Z0mdxsX2q6G0A==
Message-ID: <sashiko-outbox-186900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] ice: Use pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-12-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-12-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:20:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> ice_create_vf_entries() finds the VFs by walking PCI devices with the
> VF device ID and checking that they belong to the PF. Replace it with
> pci_iov_get_virtfn(), which looks up each VF directly by its VF ID.
>=20
> This also avoids leaking the reference held by pci_get_device() when VF
> entry allocation fails.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D11

