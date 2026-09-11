Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77028477999
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130789; cv=none; b=fYM9Vg0HndFZ93N9R37akZnKDRS9hMYnStZSGbmTwIjmtku8G8FTYtGUAOS5kiw754Eds+8hnf3y3SsoU1m29zXZXQvi/DZg2Se1tSX2b4ogoHmzMEvRlDZrgwfsbdowBevlPa8ZPkr+ZgB4T3vf9PtEHPgJ6CD/CDRITqBYzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130789; c=relaxed/simple;
	bh=HzwzZdQFa12HhD4SKg25vV6pU/nQqNIqloGfd8AZnGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bmmX6P/Xm27rrJL9r9NYSsH3+dNsMlzy9NNEdvQm8KhS7eM/lyZyE8VYfZmzzSPYU2Ynq/+gMxD1UsWmQ233dx48HYsSyDnrovOcK3SSPLt+1ZnzUS4mhAZVbQbMhgXaXL6W13Zsm2q8rtxpIR78ULT95nAnScVAb9cJWIUm+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwpunHUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwpunHUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0961F0089D;
	Fri, 11 Sep 2026 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130786;
	bh=HzwzZdQFa12HhD4SKg25vV6pU/nQqNIqloGfd8AZnGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HwpunHUqDqGxLAQI9YtJn8PkuSUi6MGfCPXrUsVw84P8y1PnOQUJ8VRObLll0Ov5k
	 pTEj7aLs7ShK82cMLxr+o4sGb4YnpxNF/TZAlOKzbhcYZd9UCXImF2X54mniTWnkTp
	 EbooCJPcWAeVRKCk9ycOezngmOhZX4sOKQah/WvHj1btD7W+gd0953ub+bniMqtVqr
	 naK4J9SybrY2kuGm8up3z55whbCxo3dZxk68OONWKS0SOa/M787f415uGTguHcRK4r
	 ScR/tdTVa6RAdrxQA3rPEn52SZCU6/Yj7Vu37aJbNyuDo/2rPp6IO/6dS1ifdKBj8q
	 NFpjkEIGgt/+g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/8] PCI/IOV: Create virtfn buses up front in
 sriov_add_vfs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911122904.85386-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911122904.85386-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:46:25 +0000
Message-Id: <20260911124626.1D0961F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> virtfn_add_bus() is find-then-create and therefore assumes external
> serialization. Create every virtfn bus before adding any VF, taking the
> bus-create path out of the per-VF loop so a later commit can run the
> per-VF adds concurrently against a stable bus set. Bus numbers are
> already fixed before the loop, since pci_iov_set_numvfs() has latched
> offset and stride.
>=20
> The cleanup pass must remove only buses this enable created, because
> virtfn_remove_bus() checks that a bus is empty rather than who created
> it, so virtfn_add_bus() now reports whether it created the bus and
> sriov_add_vfs() records that per VF id in a bitmap. Return early for
> num_vfs =3D=3D 0: kvcalloc(0, ...) returns ZERO_SIZE_PTR and a later comm=
it
> dereferences buses[0] unconditionally.
>=20
> Several ids can share one bus number; only the creating id's bit is set.
>=20
> Assisted-by: LLM
> Signed-off-by: Pavol Sakac <sakacpav@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D2

