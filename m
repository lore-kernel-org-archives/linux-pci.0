Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BD311940
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861356; cv=none; b=o/YhKOEO63y+G8HVBsJ3cmuqRjlEGuXZQ2r0dLq4NegkKzJIiwWdDpBngSv0ySqv15e1VcGWGP4ZU3r34zjqezVWTE0MsbvVVJCUBsQpDEV+UcQnSRElRMWXkiT/YD9aZYOmu7oTC9+lEdDMHFoOdqrUhPqTU1yrFKc5J/8LLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861356; c=relaxed/simple;
	bh=B6LvXjbT7FKuwBKIaTYCglWoDAbKG4xY+ypId53r3eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IkfqmN5SzqXYbYTfy+b/kPjO0rPG4VGIVttLfh5OCjcxQYDv0poZvcb11C4Lu9M9UJI5VcV1s37a04fozJteE1do2o/ixtd245qUl3CMPWCyVgjEVarJ04G1YCZiLd/ttN949kwtiRNhhqHsE2vR12xUpSukZRhBRmLjx1QPObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKpqsERo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKpqsERo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC43C1F000E9;
	Fri, 19 Jun 2026 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861355;
	bh=EsAx2Zg4GeWGvTNcV55yfevhfK8y7cZKFL4Voz022WE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKpqsERo9If9Fk4r1mJY2ZQ3N9962lc6W1zgRGdkLjLDXWClS5DlAekbfXV779W+N
	 NuTCPQlWEpVwg+nOwydkH2HL9maAUar2uGZwX72PEjQdsrq7Jm/NPj+Y6h3xn5yHff
	 Ym1J8L/awcvhLjTF6XHeZ7SYF2Rwo+k6wa8G9NLbX+/aVJa/0UKB8ywgORM7JhWtb6
	 xSorgQ+B2UjanL1oC0G+6RrMLXCZ+KmLzFSRVpbj3HpdG6a7qPYKpXl+aLITp15RIU
	 LEbrGj6M+LvEPCEHFZNFiH1/Pbw07Vw6hrSpSZHH4rGEFCfEvGj1atCNyI8zxnXKhH
	 FrqDQUl4iTO1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 25/25] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-26-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-26-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:29:14 +0000
Message-Id: <20260619092914.CC43C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, __resource_resize_store() uses sysfs_remove_groups()
> and sysfs_create_groups() on pci_dev_resource_attr_groups to
> tear down and recreate the resourceN files after a BAR resize,
> so the updated BAR sizes are visible in sysfs.
>=20
> The resourceN files only exist on platforms that define
> HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE.  On platforms
> that define neither, pci_dev_resource_attr_groups is NULL and
> the sysfs_remove_groups() and sysfs_create_groups() calls in
> __resource_resize_store() become no-ops.
>=20
> Resizable BAR (ReBAR) is a PCI Express extended capability
> (PCI_EXT_CAP_ID_REBAR) that requires PCIe extended config
> space.  Every PCIe-capable architecture defines HAVE_PCI_MMAP
> or ARCH_GENERIC_PCI_MMAP_RESOURCE (via arch headers or the
> asm-generic/pci.h fallback).  Architectures without either
> only support conventional PCI and cannot have any ReBAR-capable
> devices.
>=20
> Thus, move the resize show and store helpers, the per-BAR attribute
> definitions, and the attribute group behind the existing #ifdef
> HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE guard, and fold the
> group reference in pci_dev_groups[] into the existing #if block.
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D25

