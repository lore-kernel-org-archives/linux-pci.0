Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094579;
	b=jK9V8Xlcp93u8p8vsBUOg/HzE/lpM7gfkmmRRvXWEaTRnYnNqzNAJtL9l0/l1jZc1QM3
	 IqmHBM+NLyht8CzHlGVVvgsI3LeQLvXNICfmR9J5rAxb6I3Bg1HKH5TikzHbzjMd0n1b4
	 fqZ/+euhz9qrpNKhL0ngjSL+Xp8YdVra7G/sKrhjlJjI5nViw7sx4JFP+WJewJiJ80HLh
	 rdGInLp19HM/R3uI7OymDKD6veoh7bgQPv3p6Mo3WQjvaoXWeqWj/hKmvyIYsC6W9Ulbv
	 nfA3dRQDSuK+QSY7wGuCK32H2DcJ6XJd4PlWaHxIykl74qqAbLSyeXGLl/O15da+FXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094579;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=byBuLwYLdGFgSyXoxtsRWpdvZoXnKhOAl/GtIC2I9go=;
	b=zfO/3Uj4bIi2Wk/7WkiG/VbTU6REMF+9acA7Ov9ShqSe7lvio3zTXcuMsqES1cweYrgi
	 ddrwDx2orMER+NHy9y1+CV3X4qZ0bTlMn8E2o2jkLqVvas7iGjyX5v0STR5MKQs9jDUCf
	 zmZRqqlNalD8YxWKKDs0MBxp249ZUhEL8DJ8u4I89pDJhyS8nIBCqyUOWDdD19b6Y3LJV
	 RyvhyYl2HpLVod890NzVgiapWywk42db+O35ZrCSHi1bHlXe6JARiiENNGJUrzjEIt5+F
	 Z3hdsfjJC785s8i0V5CB8HkI5WEpGsG3lYEMCifD/EP92HFLEOGB7ckQTQZgvI9cwOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0gMXzaH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FFC606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0gMXzaH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CE11F01825;
	Tue, 27 Oct 2026 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094578;
	bh=byBuLwYLdGFgSyXoxtsRWpdvZoXnKhOAl/GtIC2I9go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0gMXzaH4b9Q9O8tS7f3HZBi+sWhmCj5c0ZR+PvFLNAUmGnly1ditptt3lwTfw3vw
	 geMPdkzv42+TRi0oOtTFZ+TegtVo47yPetSzAFdVgfGVXtQ1n6ODRrhwcCIIn2lIac
	 7dkVQMpmxtnt7dSfG+bHQH3jPm7e8iUocxjLe2vh6xtxFajqu8czu2uK7Rvn8lXDJR
	 1von45XzLbw7J658rKXxSDiDWC7k9W3aWW06eUDUqtf4AKWIVropDuiQo1to33smmD
	 znzzRVfz1FG8MQ2hyy+oWE6XDavaWZeLL3ZLi/7cE4KMMWh78bus0X588VtLL+kXqS
	 A4h1VZTg+0Y7g==
Message-ID: <sashiko-outbox-186335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mobiveil: Fix device_node leak in
 ls_g4_pcie_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishal Satle" <vishalsatleit24@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027094427.143733-1-vishalsatleit24@gmail.com>
References: <20261027094427.143733-1-vishalsatleit24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 09:49:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> ls_g4_pcie_probe() calls of_parse_phandle() to verify the presence of
> the "msi-parent" device node. of_parse_phandle() increments the reference
> count of the returned device_node.
>=20
> Because the return value was evaluated directly as a boolean condition,
> the acquired reference was never released, leaking the MSI controller node
> reference count on probe.
>=20
> Assign the resolved node to a local variable and call of_node_put() once
> the existence check is complete.
>=20
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027094427.1437=
33-1-vishalsatleit24@gmail.com?part=3D1

