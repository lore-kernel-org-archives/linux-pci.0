Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA073C98BE
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148675; cv=none; b=hbT9Ttbwv/3s+mMMBm07hkb23oOw6dzHMmVb1d24oBtnOc7/kZR0LNvfLPCZ3Mz/D0q3/KfLHPxG0P1pyvfQG91Zp8aw1pKa+8QLkuPdQb79QQ7VefzbsznVIP00z0YF+jOXlSElDwRmiygVXHuR6QeY2TSgUwnGqvmfQW5yTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148675; c=relaxed/simple;
	bh=hfwbAJu15i7D7Pk3J9r5KgWrQx0KV5BstM+TklpzCZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fip2w2Nu82q7Z743PArwcxd0i+x686WWW+8UulKH4vPT8YbDqVcj6UtvJmnY84+FZOHjVByRHpKZfm0YG6LV/D7nR5psVUknD30kxrUXNRPbpZ73epzbWgGSUDVtQQUM/YjERRHuKFk/Zs9z/8KHhiJu9zOesifyk3Z0yyWUda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwcgfFxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwcgfFxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C951F000E9;
	Wed, 15 Jul 2026 20:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148672;
	bh=3U9izP2pjJ8kZhbu5g7MLqU+JwJmB6epUJ0DcC712qU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwcgfFxqN9Y+HIePSvvsbqfVvDdh+bgH4b2jbgP7YZg2VdRNgBsgqZ9tWRZ/7SdhU
	 Sz7wznoB7vkeFu1cReQ/KEIaPm5IEi9eUcG3zpV3pfmcKcRyEo0Ok26ZQuXXwMjY2b
	 J/s/S0J5v/fkIET6sZ9fLaGZ65l5JaP5yclYusqzyYdseKF+btoyPE9FVfj4tyF9AO
	 CUrCKOORk45tIZQccrZbmJgzAVswRpqihHUKGZfrTAAaPkWgp3K9He1kcLeXrICTyW
	 jbzWVmoYh+4Hb/GgBTH7Hv/s9l9J85+3LGzPNUmW7OsD3OVVHZinTKs9R6CMjPgqUL
	 KsfHhP3CtYGlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/TPH: fold reserved completer encoding in
 get_rp_completer_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260715202409.3767494-1-zhipingz@meta.com>
References: <20260715202409.3767494-1-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 20:51:11 +0000
Message-Id: <20260715205112.29C951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> get_rp_completer_type() returns the Root Port's "TPH Completer
> Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
> 0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
> into the requester type:
>=20
> 	pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
>=20
> and later writes tph_req_type to the TPH Requester Enable field, which
> only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
> If a Root Port ever presents the reserved 0b10, that value could be
> written back to hardware, risking undefined behavior.
>=20
> Fold the reserved encoding into "not supported" so only the three
> defined values can propagate.
>=20
> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715202409.3767=
494-1-zhipingz@meta.com?part=3D1

