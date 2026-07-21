Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84246D2A3;
	Tue, 21 Jul 2026 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651320; cv=none; b=fac2T6VPoR90KGK/YebgqnwL69rpMpUCX8dfZzf8jXfyefjI4yxm/VpvHtUlRcWmSrZJP3xiuT7Gm0tti9abTxMNgdA2uwmz+YZT3YfYBkpZuCHHBRb2di2n4PQBjp6JwbFtD1Mo9Khpic/Wa3EwvF01oLM2HLTQ14OsVYlRUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651320; c=relaxed/simple;
	bh=34qBoBP8doqy5VO9Kefd06F5E2wV+r8m292nvAGiph8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJVUc4GJ+i5qhYzCKXaIOR4qV2nmCkIcjIyoJCE2Ks7dGvAw3jl4Yz2XUDfpRKzLkYiU4ypXiEf4tL9KiSgE+f2MsvrV1Z+EqhRIfogWDecXnvYWQIvwIe/6snDO20tf10IXUCqyV7TinBEAPDaoufvbtdhSA2YGIknUZgBZsDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOmO9/Lp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOmO9/Lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84641F000E9;
	Tue, 21 Jul 2026 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651319;
	bh=34qBoBP8doqy5VO9Kefd06F5E2wV+r8m292nvAGiph8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOmO9/Lp04gQdPzTO4jOKorJ9t3n2c5MvbF3b+oPxi7lYKN75cV0FG44njNtRfjuR
	 si/23DPCn8HBJ0spsh3wJjXGjxNtM8jbzSxdF4p2PzK1UUl3TuITDKlcHm7fvCZ2hl
	 mPRef6ai1YRV8wJumV8MxLnABH9h4R/XeBaK1HoGbzLMB89UYaPZ2R6v9SfqW5H+HI
	 xvMIxeXUYXKzWTyX9OJdwDfaUJ2JXRFjhy8qOgAYnPi2qZPwUxT8Fm2HJKihgrIqX8
	 thxOmQ/jM8Hb0VkT5/87+zVf3r41oOlGKjLz+R3pyPTgsld1mgQdf1T3qvGT5eM6h5
	 vt1kwnJcR614Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] dmaengine: ioat: use sysfs_emit() in
 per-channel sysfs show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260721155739.62120-11-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:28:38 +0000
Message-Id: <20260721162838.D84641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert the sprintf() calls in the per-channel sysfs attribute show()
> functions to sysfs_emit().
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D10

