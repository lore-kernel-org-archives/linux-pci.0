Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990823769FB
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785265; cv=none; b=NI4MHyH40AanReK2bwHT7iutZEfjudTQz2KbyAvb00WofiJuOKCZCBFXjaRsNZC0k+mwpxNfoJi/fjYkBb7hjY5lw8FxS9Vds0FkOFzS/fERUAp0Nblomq6KO8VvMb2t34NQWKAmY0QNJqBiFU4aZgJ8xZuu0fVn6Gnl+tVsrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785265; c=relaxed/simple;
	bh=o9alcJRd675ibCuCnIlhix7dvYsnmqi93+7QnX4yazQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=deMEKcaHb6XhuPaLKPg6Ryv8df2ZNeUpX23ZDhiZzd1iNBVpIirIyoDcokmujK/P2Mr5IlhSAoF1+HI3N7sjRYIsMnwDopo68KPLWcyO4jDL/p9KDkWaPC6DQED7kYwsh2Vo794WCgodKkln6sCHCJlzxHnUNvr3rJIyPtCX7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckbRScw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckbRScw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B941F00899;
	Wed, 30 Sep 2026 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790785261;
	bh=o9alcJRd675ibCuCnIlhix7dvYsnmqi93+7QnX4yazQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckbRScw6/Ug0QFytiGkW3Sed+wjtFu4kcxVsLTLGzHuXyQcISE5CHpl7hOUuhRNnB
	 XjRCo6ARb2HmCATTr9Xh3sSjDjEA4iICcHChPZ5eG4GeD6FGuv4CsY/mYk+Lj+LRsX
	 iumw+yruAyLEtPF657P58gzHquIDE/7+VcLLil99BA+cpgr1PnOeRiXibJDK0IaoMO
	 b8nx3rlu+qKXzNfWmvkN2u95e3fh0BT2sXZmZJgQ6DkqRWPni0vsgDLyqEhxc0sxuj
	 loMw0tz2sb5Vd/CTU9Ck4jlO3srvD11IY26OAnq8x66sGKtVpEGQngcdL5V0bh9SQA
	 iV4jYLdbW5klw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@flipper.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
References: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 16:21:01 +0000
Message-Id: <20260930162101.86B941F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> pwrseq-pcie-m2.c never did, leading to a memory leak.
>=20
> Add an explicit kfree() for the consumers array.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver =
for the PCIe M.2 connectors")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-m2-pwrseq-=
kfree-v1-1-82678b02c126@flipper.net?part=3D1

