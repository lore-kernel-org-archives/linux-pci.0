Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A243B840E
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215742; cv=none; b=sfbKe7bhanFCltXO7qbM9EEFCOmmqfJ/v1eVEq3qCF9OT7/8l8D7IGPgeQ7uZGZe5IqBxckY3SVrPqKn8v/hVwFqRq+ch9inuXVkjoY6RNrYoS9Jmmk2fosXcl/RFWccRqw5HvGW6vP5YFxHn0Pk59fu87zkcKIAc7bML/P2luE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215742; c=relaxed/simple;
	bh=6annBgpDe5mXjTb5KKjZkTbcuEH/UguvdVMXW/hWnFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X2eVIma/SSavGHxbjtiWslMb76/MEf+BfDAhA8ihj4Jrff35d/AjyQpEJT2j49QymNta61alyW+AwjZ/zyCO7EKdhI8FshT4C8qA9EJkU7Lp+kKZi816MfJPklnOShUirvtMbJRR71WLXkr5rtxpyty7ZdZs7IKCSe5ZyF9MBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt2pcgJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt2pcgJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61E01F000FF;
	Thu, 24 Sep 2026 02:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215740;
	bh=6annBgpDe5mXjTb5KKjZkTbcuEH/UguvdVMXW/hWnFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nt2pcgJLVwyRingjroSmBi2F8OIWnld4Bx051CrziTG1U6EL0nyj9Z59nncmwUGwt
	 kQWYpvg0o2rkUmLQkXcpkr5T8poCHbWpb2xbRwlPk5mZao+Hwem7QKe/pQdi3YxIGy
	 BjICrH9YEoLbU8177LUbfE7+zDeJybJgSn0ZviVQ/9x4oU2m1Bz2zw/eM65g/2owf3
	 dzSHt1xvtMtU8crObojQD3NmYiFcBgXk8JQAjKzYWzOIuDdJu7uKHnBgKzBsC6lZc4
	 4TFqwpt7Kk/63YTL7Ku6XCnATERYXX3r80G1LZaI+uLMht0/ZiuFzeZqpHbbZFFQhJ
	 pacAWc7Rz0dZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: spacemit: Ignore link partner PERST on K1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Encrow Thorne" <encrow.thorne@linux.spacemit.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com>
References: <20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 02:08:59 +0000
Message-Id: <20260924020859.E61E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The K1 PCIe controller and PHY are affected by the PERST signal from
> the link partner during initialization. With some devices connected,
> this can prevent host initialization from progressing and cause the
> system to hang while probing the PCIe controller.
>=20
> Set PCIE_IGNORE_PERSTN before accessing the DBI registers. When set,
> this bit makes both the PCIe controller and PHY ignore the PERST
> signal from the link partner.
>=20
> This allows host initialization to complete without being affected by
> the link partner's PERST state.
>=20
> Signed-off-by: Encrow Thorne <encrow.thorne@linux.spacemit.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-spacemit-k=
1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com?part=3D1

