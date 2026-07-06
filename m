Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92A374E45
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342817; cv=none; b=t7VLAl4Ff7fwasq45SkdksL2q+PstqK70bAT3jrxDNxItN3jcywWQBQEDFsD/gNIcE8kYtPDY6pLcB6S/aB7Jr3o/57vt3Af50y+QLcBmNH65/l++9Kx3byA/KZe2NOvBM/8LIh7msaXRnzuFJitUQRCdTRNomU3b64lqOjf9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342817; c=relaxed/simple;
	bh=TjrQuxlr+lST6uIJUlZYxtFRA0Cu9iDe66YoZ4B14p4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OrbkLU0JpUE9GkyzZOYNIyjM47UFT0TVxQUPJfGTfw3lQgq2wIb9zl3APdnFL56pysJGtxlWTzxdFfCc94IIDKdn9uzaUD+laW11bn0Z5cvYYcUenVTKFwG7n0H17tE69UNJ524MXpHWyWiulVz8sLZAlKmI3oaUVYSyW8x+KSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJq+6w8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJq+6w8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6BE1F000E9;
	Mon,  6 Jul 2026 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342816;
	bh=TjrQuxlr+lST6uIJUlZYxtFRA0Cu9iDe66YoZ4B14p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJq+6w8lcbOducaYYxMDpYAw27YBuEqTHTybgNK/tBoWhVdtcdG+s1IN1uQ8BLxm6
	 4m37hGIKxWD9+wPE0Q3C9oBzHWrcnL6ESPbTsImIv1V/YClciTTymS2GyiA6rknS2E
	 HLAD41ia793gedRwz2Buk04xk8gaER5GmfyKzlymJSXSIjCL1/AZ+flBBUhqCzIerb
	 eNpwFgvFkqhKuoW79rw89uwBWMJkhw/ZtV2kxdEQUqsfB9UqJIz28HAFwa32zv49Zn
	 K0QdRvIsItgFgSBT2X30YagcjmsJ+zvNIrYLf2EBBpLn3g1oauwhgDwQXK8P6m5MUe
	 I2Q41nbDnDbcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:00:15 +0000
Message-Id: <20260706130015.9E6BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The current safety comment on `io_read`/`io_write` does not cover the top=
ic
> about alignment. Add it so it can be relied on by implementor of
> `IoCapable`.
>=20
> Expand the check performed by `Io` by taking `self.addr()` into
> consideration when checking if `offset` is aligned. For the compile-time
> `io_addr_assert` check, check using the known minimum alignment of
> `Io::Target` and the accessed type.
>=20
> While at it, fix the alignment check to use `align_of` instead of
> `size_of`. The values match for all primitives (including u64, given that
> we do not provide u64 accessor on 32-bit platforms), but are not
> necessarily true for custom types.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D2

