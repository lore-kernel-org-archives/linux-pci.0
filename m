Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98649E130
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083100; cv=none; b=hT/1rQrFvccJeIw8ifmJV3KVZufcEWKhY3ATdt0PVipzqqG/ctbOsgnfl8K+gWiq63+dmCcoHCD2w/eCHBIZq+U2BtYI/Sp39IlCzjadVp6uGi4vcl2jjhgEOg48DAJPe1VmJDJ5/GQf0QhRLYflnyvPOwkObCN84ivYMy0ISXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083100; c=relaxed/simple;
	bh=SUC1Shwe0th2gtUZWOFv60Bdal5lDswBPy8a95OoZMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D86wcY/0912eOIg0+iaUsFA0cp5S+hK7Xc9ubHpy9wmGcktRkAD/C0kcDHGNUGhJr5AGFzqPHk9F6YJ/9C8ttlMF8YtRA7yz4wy6OMcyYou4dZVniJPOgyUt45OWZ9HVBnWxEvUY9Be3KvFsaUJDJBUPzmUxmiKc4aqMr5Dk0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bktDqSlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bktDqSlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD14F1F000FF;
	Thu, 10 Sep 2026 23:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083099;
	bh=SUC1Shwe0th2gtUZWOFv60Bdal5lDswBPy8a95OoZMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bktDqSlYDhGmhGZLINJacKbBUbfS1xyP6883HmfeYKDwYQTsjkWdiTMtNH8Bdgjo2
	 mj8u+mSC3AHkRJfaVsyhiBmV8Qvnuzqm4UlBlokMNkegWEfmsOily5M0FvXZ7FjoO0
	 hSKQIwOUhyFGieHI87NPUFzwMborY+PzoW2+hsnNxWZ4Q1Pk8bQPujdcXaeA+j9s1X
	 +hR6+LGZgfoR6U4hYldDPHmgSMmZ3Fy+QE6/D61AoBdKeLiQQqacoM0Nh7xeeAWyvz
	 /7RgO4dIsut04wIW/0KEeR0QWGPBOpAMMToQTXwTc9Oxz56NB0FzuYAht6Fguk4h/R
	 +28M1XG37WZOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/15] iommu/arm-smmu-v3: Allocate IOPF queue for
 ARM_SMMU_FEAT_PRI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <c277db2589bf38ef5f251a58dcc87a22c751336e.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <c277db2589bf38ef5f251a58dcc87a22c751336e.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:31:38 +0000
Message-Id: <20260910233138.DD14F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> After the previous change drops the FEAT_SVA gate, arm_smmu_init_queues()
> allocates smmu->evtq.iopf when the SMMU advertises FEAT_STALLS. PRI suppo=
rt
> is being added on top of the IOPF infrastructure, so extend the allocation
> condition to cover SMMUs that advertise FEAT_PRI without FEAT_STALLS.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D12

