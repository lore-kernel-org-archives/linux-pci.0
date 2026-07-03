Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30F23393F
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052798; cv=none; b=ITcXZjsOvWyuwp+89YeVKXCpmq01Z0NqpMxyi7R3f4YyLqxcd5Bz7gLDlR3ttOB1esN0IEx2v4hPQ36qa/1PrQSxUrD5HuTXVvmgy+LsFeJ2nsURbGE9pEPTc0O3zRj85/xgnCB4oMxAa0O4zbPrvsjhabAD0G6PmOGtCxqOkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052798; c=relaxed/simple;
	bh=kShka91dMs/jD6rTHpxnyJduhZhggbPRAn1vQkQLG4I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBq/P8j6hafyxlZYhliTYwPcYoGLI8pdZQnfrNFQ2YI4BZoSKIBtVAhcHGQ8wrh3zqCmUcDmcvwPfWb/x4TszvIQsxtqfSiEbRiHyqSWfbptSyyqD9gOQM/mpjRl8PWcd6GSyIQS9A0DzrssWv1FKMY6t7ZT0RPBoKxyuO+gSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy051IKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy051IKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC001F000E9;
	Fri,  3 Jul 2026 04:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052787;
	bh=tnhu4Cpjg9vkF+CYDr985CakBzptRD3FVNUeVgYGU9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oy051IKZ1CeNGHnNnxToNmjwJCaA6GADvuKvMHdQZmRabe0eqyYNmJeT6PXtf3lk7
	 +jNWo8ngiNDpb0+wLbykb2kFtj6oywfKW2c1DBHRsfIlJCmAIcNkWLRIPnzZW6rrYQ
	 6RM+QCD14P12/1M2tHPJB/ZQX3549wGquLSoTZMvGZWJFnTSVa4+Lw1ptJK5U3CgAG
	 Pj5JLnzZrDjWKB3tNm7nG0gySM6k+iCIQT6oaVZ9Wd3zbCLMc7TrClyHmP1CI38nZ0
	 DMbw1Vd3Xq5UWEUYqrqoSoppiAe0SLHh2siOI9zyKj+cRvBYUkYP84DOCd9whMapsN
	 jY+zJIAs9DG8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/18] iommu/arm-smmu-v3: Add streams_lock for
 atomic-context SID->master lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3549540a84ca2fa0d6cb3e1ccad5ea787e55d1a2.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <3549540a84ca2fa0d6cb3e1ccad5ea787e55d1a2.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:26:26 +0000
Message-Id: <20260703042626.EBC001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A subsequent change will look up arm_smmu_master entries by SID from insi=
de
> arm_smmu_cmdq_batch_retry(), which runs with invs->rwlock read_lock held =
in
> IRQ-disabled context, and so cannot take the sleeping streams_mutex.
>=20
> Add a spinlock_t streams_lock that protects rb_root mutations alongside t=
he
> existing streams_mutex:
>  - atomic-context readers will hold the spinlock alone
>  - writers (insert/remove paths) take both
>=20
> A reader under the streams_lock uses all the streams of the found master,
> so the insertion has to be all-or-nothing: make arm_smmu_insert_master()
> initialize all the L2 strtabs first and then insert all the stream nodes =
in
> one critical section, making a master found via any single SID always ful=
ly
> initialized.
>=20
> Update the lockdep assertion in arm_smmu_find_master() to accept either of
> the locks so the helper is callable from both contexts.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D13

