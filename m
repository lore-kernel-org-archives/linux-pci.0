Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28057320CD3;
	Tue, 23 Jun 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190890; cv=none; b=jDWQ57BeLX7nhjYpQPhnD06VUIKX8RKT5Rz6igY04LDpgQOLoxoCqGDVkLnP1T4niUw1IyDoqGNimwqnohFW08xxK8+85SULSVzLV0YiKT7RNEcPYx/lECjXp/dHAgp95EJMhxAUaxfkxa3jhXfld7iZHjfEx1atzcxb3vTOgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190890; c=relaxed/simple;
	bh=jrHtQG/7+2MwqVifmvn/LKv244iQj0w3abg+Ql4lIaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtGZIirCfbVRGo/l8g713ciHzxCXLxqRS2vhAfVZogaol9uaus7rxuOF/7c5HbwIpLaolbo5MRMLojQ1twORsP1ZPZqdaKyK+SA6TlmpMsojoAm9wnuC57WXcWmV0pOf1pmBfSWYi+obwlP0bu5pYIfUOigrYkfEXI8mgpYVC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ9HsT7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ9HsT7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ED71F000E9;
	Tue, 23 Jun 2026 05:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782190888;
	bh=jrHtQG/7+2MwqVifmvn/LKv244iQj0w3abg+Ql4lIaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RJ9HsT7j95+qMBWnrMy/LIAdrC+3+qm2h0h9ELujBCuT9o/i4Ryyw+A839Eay1KeZ
	 dP+JDfvh4A9nH1p9nVZsivE5vw97c5PMSO87G3oUe3f7wjkWaWHsVymfv2Rbe1ddV7
	 C/pKqEX7N84WJPuFfBML4mN+qX3dVJc2GY594ZhB2YARQM/lbq4ml0rKCa++yVmmI/
	 oYjTEO+rm0PUjTTZ6k1ZIzvCnQLv3tySIyPoLufcJc4+qxGBk8P/gmMH7Mc0cO7y4+
	 qJNhkIYeXam5N1R062SAGxbr1uC/CcO3i7E5Fiuxj/fZtiaHDvnYYvzsjToj5ZanvQ
	 a9pNOAXXuDzFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/21] rust: error: impl From<FromBytesWithNulError>
 for Kernel Error
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-9-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-9-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:01:28 +0000
Message-Id: <20260623050128.89ED71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Implement From<FromBytesWithNulError> for the Kernel Error type as we
> will use it in a future patch.
>=20
> As this is now generally available we can remove it from the test case
> as well.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D8

