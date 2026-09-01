Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798130DD22
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223392; cv=none; b=CHAJ20k4tdY93dSDBRpnND7pkXvUqohYOBalMfC995Km5vmXHB83zU5KfSB82E6glkwpGLs938F5iH588olnLmCt8aOTdcHELxdW18qjdr5yIMK03scpkNFvE5fV6WOXSsom1VcqBq9ZTGnqyqjg4SYrVEUJOECTcimKW8p/5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223392; c=relaxed/simple;
	bh=UfwcIcWrJKgXw+ue5lVxfUm6vBtHB0M3Kr3qKkPywcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dwVtrSOV08CY6rVHhomnM5+PU+iydTQWrs9BIOQwqEglO2ajKW0sOHXSuK6azMT0+IIGS+iLmgcwMBpQg7qRp/y9QkTiR+QHTAmB6mzHc9ha3Gmw3sMviJmB87QMVL71WtQ0eb+fjyPvUUuTJXYYRI3/YL0nwRhkdTp1w58zVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6f3Es2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6f3Es2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E5C1F000E9;
	Tue,  1 Sep 2026 00:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223390;
	bh=UfwcIcWrJKgXw+ue5lVxfUm6vBtHB0M3Kr3qKkPywcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6f3Es2bf5wSSRGIILhaUSGVlj5Np0M7nAFijRu012yFJ33XXcjPWUQc+gYS6Js0M
	 8VtQEP3S9M+lfufdNvpjQ2HqDCSzqTEPfMWtH2+Epgp9tyWnYJ9SQj3l0QyC6uRHH8
	 nEua+f+69Tdw2cfZpfzx9ebsX9ePyDAwN0cmTL/fOrhHe1Pe+3qQyS4QnVK85eXsOw
	 CIXBvjb3hkMC2AX35bG4QySI6dud9OM/xQLMEaidfFhilq8yrj9WF6MIYKPm7OBvYP
	 1bRYMYfIatZKpnTFhR8FYKm4nCGnutrPMwibqFgCL3oQUFRErKSjg5Na9FoAaEiPMz
	 +Rdbv6xbdEoAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] iommu/arm-smmu-v3: Allocate IOPF queue for
 ARM_SMMU_FEAT_PRI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <37a4e140ae26b1f58a08b9274937dcc9fa1e5e57.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <37a4e140ae26b1f58a08b9274937dcc9fa1e5e57.1788222486.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:43:10 +0000
Message-Id: <20260901004310.A8E5C1F000E9@smtp.kernel.org>
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
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D10

