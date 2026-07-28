Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07883A9DB1
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242370; cv=none; b=pDIjo3FxBHyhz0Fl4PB+HCuJ0BByzg82sNmgSTWOlrU+5CaVArmqAiJvX9IsCR0Z0vae+tHAFwxeFdPG9wpgiZ5Rb3wpqq2Eaztn16M5WhrjyKfKvmWbf/to87V23ihkrTr8npPpzde/h2TXu0XKmS10aWDnwo21MB3Fgyu8QbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242370; c=relaxed/simple;
	bh=ZluXi28pKchnQq4wT8HkX0GrWKb0AideXSqOuFsKykw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htdXIaVbmkr/LeHxCDNSh5H8F1yJ52jAevOVa9f+7DDkV3OBFLKIWCuczwM3pxoU1FQt4QO6HXyJ1htexPxdZbt1GdIqWxcvh9JQ+fLcl1Ynw5apjKq7Xk9nHPtPuq57nv5hxgkqvbPKMD7CKb90bPjAst4l1hp9UH7fYN+bxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu8RKlVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu8RKlVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEBF1F000E9;
	Tue, 28 Jul 2026 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242369;
	bh=ZluXi28pKchnQq4wT8HkX0GrWKb0AideXSqOuFsKykw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nu8RKlVuw2fhTGCkVWMdAESg0cnUWdPCbEhf1WNUQZf5rSq+hCK8wfZ7OFjGjfDIn
	 whItcS4L1WA3t/pn+7uQbjjRZkswSENqtZdRtyQcJ1hEwW566YghjKAh7AxIsOLu+I
	 k8zIdRkzvhzEM6xyGfF63uOTfPwIbR6BMyW/rNkiYd+FsGGF73AkPQFVu3AAUQ8CO5
	 Fb/vQ8uUw4Mbe3P1HporsWPC5Uh7WwlFRNPkCqtyxkrd/1VVBlvvbgTKrOY5kz+Tcb
	 10BNgpqbk7xeXwxEnLn9dSVDViDMwYARGp0XcbzeE0HuxVTHXMM4gQj5kE8t4F/TAh
	 tx0IeoD+H0POw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Fix 64-bit type truncation in
 mtk_pcie_set_trans_table()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728122810.3475-1-sreekuttan2156239@gmail.com>
References: <20260728122810.3475-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 12:39:28 +0000
Message-Id: <20260728123929.3CEBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The variables cpu_addr, pci_addr, and remaining in
> mtk_pcie_set_trans_table() are of type resource_size_t, which is 64-bit
> on 64-bit architectures.
>=20
> Using 32-bit helpers fls(), ffs(), and BIT() causes 64-bit integer
> truncation when computing window sizes and address alignments above 4GB.
>=20
> Fix this by switching to fls64(), __ffs64(), and BIT_ULL(). Note that
> __ffs64() uses 0-based indexing, so the '- 1' offset is removed.
> Additionally, return -ENOMEM when translation tables are exhausted to
> prevent silent failure.
>=20
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728122810.3475=
-1-sreekuttan2156239@gmail.com?part=3D1

