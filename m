Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224157;
	b=x/6C0GLogUOYSbmvY9KheoepJ+c4tFaGnhxwzq1RDMUPIQXAgqEq2JgKO4ANds5L4RnV
	 MSKryq5y51j3f+8WmRMnH0JBvJCv7aEI0VZyXWEJ3uR459frs97FPXZ6h0bP+bZy/LOJN
	 +ASWZDF9x000/79iiDMWtUKaRwa8SUY85hqPBlk0g9iDjfBCstJt7xaZgkVQMrQPkh4Jb
	 JBUK5n3/w8aV3FoEmCCUgsro21ng09NZZiEcffLbeAvheO02CeLjt4DWbXdFHNG75Rwg9
	 7iSDk6T1YSfz1TLAQNXyHFGcrZXgayFC3aH+zS9lIzHpbURtJIgUGulgPl8REsHohYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1wMVMxw6vg36Qsv88KC5sWddwK1Yg7QHaWbJBMcr+U0=;
	b=PCDBTSBo3qp1Iph4OVcGtLYKqoYNHgFM2OTpyMJ0T0GoxFYKErIguVnpuDJK3tcXMzPd
	 6Trw7+Jl1bsuOoVVpXtZtbhnhX2oXGuHJMHS+JJD36TMW7gE1F/XxNa43/1wy7aaalccC
	 2Mw+cpzDBAwJWZMGH/RUqxXTBJRFMuQdnyTystuRqWDqFIgWAitB7cZgihox5PG5MZVv0
	 H3B5LkxUsEnAv7gyQiPrvvDqr27+ji5AWAZIWF6/ZJCzObOWKJIfqmRDnKgirp1n5BXg3
	 A4PxSy+Juc73M61YU2BOTezaIH08MJzCMBfSRBGdknPn40iaksDFbxiO+uv0khsxOEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnY57a5B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D299606A321
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnY57a5B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE641F0089F;
	Mon,  9 Nov 2026 11:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224156;
	bh=1wMVMxw6vg36Qsv88KC5sWddwK1Yg7QHaWbJBMcr+U0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mnY57a5BPJS4xvUUgbhjISkNMyyWoBYzTt7DJHaNND2dvtqTK9mvAf1TQd0CleTGP
	 IAlAWMLN5k5iikjhcpbmGN8QeAd19LFjq8dpHxYsjf+rF/U7L3LRdxEodk8QBtGrpt
	 cFPKfewu+YnKWq6c+TDkl42xVyg/YSgh1FfpgYRuYDB7bRw00k3SbF8xunkqumyfA9
	 8/K3hVYlBmBI1h3HgihhFll8MUCyKjRHz/X14w63dv3XQv2imnRl1Z39Qx9w7fNgIS
	 Ujv0A4lkcHqLTo26MiT+gFEeq2wf/89BGT1BUNUTRQx4u0YdwC37zlq8LjbUV1g879
	 RMuJIGdHbn7Bg==
Message-ID: <sashiko-outbox-204877@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix pcim_iomap_regions() error path rollback and
 leak
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109113136.2295-1-lirongqing@baidu.com>
References: <20261109113136.2295-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:35:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> pcim_iomap_regions() has two problems in its error path.
>=20
> First, the rollback loop walks every bar index below the failing one
> and unmaps it, regardless of whether that bar is in the mask this call
> was asked to map. pcim_iounmap_region() matches devres entries by
> (type, bar) only, so it can release a mapping that an earlier
> pcim_iomap_region()/pcim_iomap_regions() call made. The driver is then
> left with an __iomem pointer that has been unmapped and a legacy table
> entry cleared. Restrict the rollback to bars in mask.
>=20
> Second, when pcim_add_mapping_to_legacy_table() fails, the current
> bar's mapping is not released: the rollback loop starts at --bar, so
> the failing bar itself is skipped, and the mapping stays registered
> until the driver detaches. Release it on this path as well.
>=20
> Fixes: bbaff68bf4a4 ("PCI: Add managed partial-BAR request and map infras=
tructure")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109113136.2295=
-1-lirongqing@baidu.com?part=3D1

