Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F403195FA
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053260; cv=none; b=Sh2LG4ZYYQtCEl2FXus650cldh3zBsvAHnQ1CZD0Zxz0MUtQCg+8v46ZZ5sxdarhJdNnGESaxh8phPrcOBxwQal0UEmv/tOwy8NbUiXAUZn2rJspLfnTgWILaMnG9bvvdrY0i4B79n7164yeJKXx+Zt9n/90Gw76GPbRL12AVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053260; c=relaxed/simple;
	bh=mxB+SKmThnWahfizU3ccDeCURhjo2skJxWd5wCmec5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QBQev0pP78Lu6grHlE2KrVtrbYOkW+r2keVf3BmqIkgLvfx6QHilfMS0aQaWjHH7EkNj6/tfL9PvwY1g7JyEoN4ntRk1qb2N5V7pwQVDL9jTRxYZLXio5nufjpRkPg2qknZlCwFra8bYE8wD181IrZh04hUTAStsXWESmL5PW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIy2m0vL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIy2m0vL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2F21F00A3A;
	Fri,  3 Jul 2026 04:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053249;
	bh=mxB+SKmThnWahfizU3ccDeCURhjo2skJxWd5wCmec5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIy2m0vL9FaXBB7INqXPsIR6WiN1K/jGAsdISUTr7kyGt2WjMLYla6P4yPdfTWqCI
	 ck8UkYKXoSS2/vi2R+v/t43hz9PFdMsQzAhxxASxq3So6aF4vQSlKybD6ZJ6TkJeIw
	 3Nm75vr4ChakWiRa50EgJcRpnJnfa6/HL8OwcSflyVcu2Lb2F8ZSVYM6NhotCIRWAo
	 fZBtAms/nQptpSr4Y2eNvWq4kSh2N1P5iAAKdSnRHFeeotPzg1Nn+5ucnetsP6duDQ
	 Ny0feM5FCeuk+9vjSZzK/QrblpujWgWxm14R8rSeE1XL/lsa5MLCN0XpqWZBssUKDt
	 nXLpUUewu9Eiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/18] iommu/arm-smmu-v3: Add INV_TYPE_ATS_BROKEN to
 skip quarantined ATS masters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <18ebcb530ae161c5f4e37394ed1d69c5bf010667.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <18ebcb530ae161c5f4e37394ed1d69c5bf010667.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:34:08 +0000
Message-Id: <20260703043408.CE2F21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A subsequent change quarantines a master whose ATC invalidation timed out,
> marking its INV_TYPE_ATS / INV_TYPE_ATS_FULL entries in that domain's invs
> as broken. Clearing STE.EATS makes the SMMU reject the device's ATS but
> does not stop the driver from issuing ATC_INV, so without a marker those
> commands would keep timing out on that master.
>=20
> Add the INV_TYPE_ATS_BROKEN type. __arm_smmu_domain_inv_range() skips it =
in
> its switch without issuing commands. arm_smmu_inv_is_ats() recognizes it =
so
> the iter's batch-boundary logic places it next to other ATS group entries.
>=20
> The setter writes cur->type via WRITE_ONCE while the inv_range iter holds
> read_lock on invs->rwlock, so its loads of cur->type and next->type race
> with it. A new arm_smmu_inv_type() helper wraps the load in READ_ONCE, and
> the iter and arm_smmu_inv_cmp() read through it. cur->type is u8 so the
> access is already atomic; READ_ONCE annotates it for KCSAN and matches the
> [ ... ]
> anywhere.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D15

