Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC645FFB4;
	Wed, 23 Sep 2026 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194850; cv=none; b=UIrLmmDjRf5KTSgHv6L1ERFQoYoDXPDXCc7BkXyKLMIIElPsWmrx2lwY7/Y6wiSBT0rScYqjIno+K7sIbapru6YUcFFqnvs0RZ0U1zqxhFdFdCcK55E6HpSkpk+afPI7QCs7BRfzUS0EXuNr05ZmILgijJM8sZ6gl40WBWKWwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194850; c=relaxed/simple;
	bh=8+BfGJ3kzOsvub5ukg31gf46z51y9zELKbOmERLnPiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dLZ1bHLr923iwLAJBsFsjABiLIX/Hb6CEhN9v+ROj2SqvFe61CETDvBlFdOPpqA9efgQlhfH/fH1T+4K1IMWK51DPdvkHo7o4CIMny7UuAo0W6qXEM5gte3gHVqS0JhYHgl4BN0v7SMPQh/kSVaaFbt8vllzm4Ii1Ucwa0XMIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQPV6iOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQPV6iOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79D41F00898;
	Wed, 23 Sep 2026 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194845;
	bh=ocan8SPlp7SuG3loo+E/Zzwcvsu8ANnuBbY6VgPaV/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQPV6iOZtoEjCdh9AZXAZ9VpF026R7OkVJ5gmxbD4YMwCcGFLSNFUSPqxmieKt+zu
	 C3teW3j0n8MGD9TLEqn1TiuSjNJ1CFCmq2r3uFnfAYVHJp1UjVOGI1jY2Xqik9+ZJ/
	 uhVg3rl7sD4ZkskAltPruP+MUeetK3e9AggDpOGiuTf0lb/rGBNZHKL0Er2zVUXgIY
	 uScrNoLMyg6CIxq3izkoGVPp/hsNJJ8+EryDjX5PK3IgqOeCw+AsZBjN7E4tnmKOlv
	 1bTprKsK2rfSNJkTGHVdXpjZZmCjwfrVRfsoefvzAKEgdCOvpjdiJtwn/OPMzjHKm+
	 50CWcHZC4eVaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/17] iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR
 when CMD_SYNC times out
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:20:44 +0000
Message-Id: <20260923202044.C79D41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Once arm_smmu_cmdq_poll_until_sync() returns, arm_smmu_cmdq_issue_cmdlist=
()
> tests its CMD_SYNC slot in atc_sync_timeouts to decide whether there was =
an
> ATC_INV timeout.
>=20
> On the other hand, when that poll timed out, the GERROR ISR might have be=
en
> delayed past the poll deadline, so the atc_sync_timeouts test could miss =
an
> ATC_INV timeout, classifying it as a generic CMD_SYNC timeout and bypassi=
ng
> the per-device quarantine.
>=20
> Add two cmdq_err_handler impl functions:
>  - arm_smmu_cmdq_err_handler() reads SMMU GERROR/GERRORN.
>  - tegra241_vcmdq_handle_cmdq_err() reads VCMDQ GERROR/GERRORN.
>=20
> Co-clear any pending CMDQ_ERR in the issuer, when the polling on a CMD_SY=
NC
> times out. Each cmdq impl serializes the synchronous drain against its own
> IRQ handler with cmdq->cmdq_err_lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D11

