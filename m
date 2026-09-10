Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8F23395D
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082912; cv=none; b=tI4/99zEQKiMfNYTCnfRrPcwnpxNNitAUlxV3MVNqJpp1E2MnZvgahts1EjEIt8B2VtyLta+JuDbmj43KLFsXdpyRGpxwYtS7USog57PltMAMfrBdZ0GddrnNyi97YtOjUyF+KCNuxphLPceaI89bHyyQYpyDvNhJ0NH0bQOGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082912; c=relaxed/simple;
	bh=rKryfX1J4pNjMbTsEMzkQnfABmegOuLkVyfs1IOLrrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sFLmxbCM156IIe+6WrnPVKthIwY2eexd1zzBgMCS9B30hmwk1hUuUcY776QL3fh4B2Z2ggHiJUsonkiPnR7RaM/YbvbYBKFySpxaWo8BLwEPKDHUD0oELgzVzX1R68e9nKUwUhR48xsom5nOuriwuz+wdDKwle5sHv4n21gr+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxzPdnpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxzPdnpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A151F000FF;
	Thu, 10 Sep 2026 23:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082911;
	bh=rKryfX1J4pNjMbTsEMzkQnfABmegOuLkVyfs1IOLrrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OxzPdnpL4VrCfsNOHK1agABpnNh043LuGhNVbWoP4Pm9FBDjaujCt/96EHiUb7D2y
	 aYgSp1Gp5dFpAaHabg4SerQSFmBiTELwwZLMWC/6vG9PS70VKW0OVtvmjJsOIMAelA
	 cOFJy45sLlccllWGjoIDmENDWnsC2QLdiIWj1h7HYmE+6cBSvd4XCvHLNjTJbQmBLS
	 zixxmfpbwH+IhyuLhz30mXZZK7dP2wd5e8UWHwkRI/udNLmwVY6ZqPoM0dbZHVDErx
	 CZc9wYYHr9vgI1+NXP4c0/ss0uqbuxkIPiFGO3bkqGiXiNEth5MCbfPcar0zKBeT8b
	 HV6qgcf0K11dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/15] iommu/arm-smmu-v3: Add
 arm_smmu_attach_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8594c8e42e846da3b87f96f1e196c143fe4d517a.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <8594c8e42e846da3b87f96f1e196c143fe4d517a.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:28:30 +0000
Message-Id: <20260910232831.25A151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The IOPF teardown is done in arm_smmu_remove_master_domain() when releasi=
ng
> the master_domain on detach, under the global arm_smmu_asid_lock mutex.
>=20
> A later change will add an IOPF workqueue flush to that teardown, which c=
an
> block on a user-faulting page-fault handler. Holding the arm_smmu_asid_lo=
ck
> across it would stall every unrelated attachment in the system.
>=20
> Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
> arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.
>=20
> No functional change: the old master_domain belongs to no other device, so
> freeing it outside the lock stays safe, still under iommu_group->mutex.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D2

