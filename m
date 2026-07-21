Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65810F1
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599920; cv=none; b=KWcX47OoIf3gXkS6w4e1FwoJ0E9R7OSsCxj+rWMxV2T2C4YJBJBi4oguSzlT1T2wm0xPe/M+GQEHOWlibXTDLSuCx3/Dhjf3o53hDjqpHTcZi9KOABXrB0BoA08dGZDUoZy01gkh2NrZNUqA4Qz0mwKblM7jTbhz11J/QAVS3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599920; c=relaxed/simple;
	bh=L+DU3aY+3kZTktxH6q8hFR3GEkkvIsLtHTmBrYH67CE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HPk+lO/TikfmyMdRfbjmtOGnlRK26/ccSgAuX4ddASR3zu36kABcT3OyhNDTSU0wPbnsh/+9rPGb3n4Gp5+8W4LvtBhSwITCT+SQwzWuJcIGMzCDPFSFBjRoKnNxLPhxbQ69/df8NI44zXP4Ek8I//MKBQpvbehTrZdr5vApVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJsKY5gI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJsKY5gI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281EC1F000E9;
	Tue, 21 Jul 2026 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599919;
	bh=t1VVvyu3WGop/02MOH1y8+GQj9FAcDWc4AmwNCSh+cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJsKY5gI5j99e/YodLsiQCn/2kNHOnWlfV66sbEhN542GpbJvjFoSitQW0fGYYjHz
	 RizW+TR5lVhnIEBxfMfuzBxZKERKvzKP6nzIMHSygxSManTMqZRqYHGBKwMCCWa433
	 /FyvUMmANjLDD5xdb0RI+vSJY+A9lw6Q6oxhih3PkmawqpSR4Q6Knf5Lidz4NKmLSL
	 yZ0utXMn0gkpVyEwxgq2bsM+43+UKj+vCfxkhRP2qeGVp30ij/xV194OFfsDxE0+Dl
	 dbFK1XlMjZv42ig0H7baiN7wxosAHppqly/Hqd1ErrkrhwjJLby/PxLehAyYaOqjKy
	 qy5VA8BcVXxIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI/sysfs: Add legacy I/O and memory attribute
 macros
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721020427.1541197-4-kwilczynski@kernel.org>
References: <20260721020427.1541197-1-kwilczynski@kernel.org>
 <20260721020427.1541197-4-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 02:11:58 +0000
Message-Id: <20260721021159.281EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, the static binary attributes for the PCI legacy I/O port
> and ISA memory space files (legacy_io, legacy_io_sparse, legacy_mem and
> legacy_mem_sparse) are open-coded, with each definition repeating the
> same set of properties and callbacks.
>=20
> Thus, add two macros for declaring such attributes:
>=20
>   - pci_legacy_resource_io_attr(),  for legacy I/O port space (read/write)
>   - pci_legacy_resource_mem_attr(), for legacy memory space (mmap)
>=20
> Each macro takes the fixed attribute size as a parameter.
>=20
> Then, replace the open-coded definitions with the newly added macros.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721020427.1541=
197-1-kwilczynski@kernel.org?part=3D3

