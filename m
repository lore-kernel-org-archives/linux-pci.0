Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDF43636E;
	Tue, 16 Jun 2026 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607201; cv=none; b=N3g2UIBSOpxwd8xC8/sbaeGQbc2vgb2z7ycMEK974wxW0G088HpU/AJOQT5ILG4n1FTk4MK9mIdCtMjXIeUayYReife60f1OwAcNLulcMZX1HyRTE4GwCkTEvIrLSa+Crq+VMCItnrt6KwEAdycoNxZrdcllvUYo6buCm+15aUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607201; c=relaxed/simple;
	bh=iuC7V15MJXHP6IZFrHa6J1haZ6Y9TFSunAwkNwnMo2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfjlQtepSZx9k14uG5wF4NFBVs5jVW0MwliWfPHogHTzBYqAAZQnmL9Hd7jPhmqyaoUlCuQ/1j/JBseZlJt1bwykPJ8jeJmRhTQjE84PPprk9g9iUWbZZrHjDLC0K9hhrgHKJVonluwRg9pGLO+WjrnkfTNBt/I5fh7uYwdt0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8cjBYG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8cjBYG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A91F000E9;
	Tue, 16 Jun 2026 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607199;
	bh=ZyqtTBXTCJpSSZy+X/1Ef+H6QGppWfNgSnGRrQTtLqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8cjBYG6y3dvmqbBpXmvHSBZn8QM8uCVwxSfhPpAm1qOictPnRaLNbAmaTSrJfuwI
	 vlaI0X9J3ih/zkbVhft/zg2tRpYB3qlWXvSJDftaPcw9P46n5gj49MvYFTpvsedpt0
	 PZpmKhPr+pBkzrr7lZbrt7yPWDbFzL2MB5PF+9LKacX/0mdxXYFg7KeI8/ap5BTHZo
	 4dYwWEjQmOppEXPtqr6D5tb8Gmf7Iz2dfMXn8OgoWtfOomVkDqqVjN7kdYcKpa4Ris
	 TKz2qH+NWnakVYGHAn3443iYuWme/bpxHPgaWtczNgmCyjPSFnd0vudDxJA4SIiY7h
	 oIZQE/s1UJpzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/12] PCI/TPH: Refactor pcie_enable_tph & add
 explicit requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260616104621.41915-5-fengchengwen@huawei.com>
References: <20260616104621.41915-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:53:18 +0000
Message-Id: <20260616105319.981A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor pcie_enable_tph implementation: extract core logic into static
> internal enable_tph() helper accepting explicit requester type.
>=20
> - Preserve original pcie_enable_tph() unchanged as auto wrapper; it
>   auto-selects EXT/standard TPH requester per device capability, existing
>   bnxt/mlx5 callers require zero modification.
> - Add exported pcie_enable_tph_explicit() with bool 'extended' parameter
>   for explicit STD/EXT selection, used by upcoming VFIO TPH support.
>=20
> Input validation for EXT_TPH availability is retained inside helper to
> reject invalid explicit EXT request if hardware does not support extended
> requester.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D4

