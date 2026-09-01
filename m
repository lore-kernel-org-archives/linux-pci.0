Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99465233955
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223713; cv=none; b=L2SRMaMVfj0Iosqf12VNYOlwG+rk6fZtrRrXrPD/WUkBwXpZufUo9mEIhl2Ky6QZf9xObePu6zZcuiyc86hIO9ZvbonVeEoO6RET8TQ4PxujXGKbOYSXe8WV6mb3qbuXfq2Yb0impx/gVD7W/v7duJkTbFPdsVW7HjFgzFq9XMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223713; c=relaxed/simple;
	bh=qderzRJmnGEKMR/5T/fanJ9dWBmbheKBev2qBaxmf4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NCHHXGYYg9/hlK9CaEWy26H8fm2CvkK4mUeFrL7Ot6e46btfhUlF5OGhkCNVtUxrONOiGGGV5IR8p3muXuasqPL/S3muIXSHsJOE0qYRbQm+J9WowgGkjjaCD+VNTcMDpcXhyeSJyG6e27eGJrqMCr/odARGi1UfaurCmNQ8Ni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgR5H6X7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgR5H6X7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1779D1F000E9;
	Tue,  1 Sep 2026 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223712;
	bh=qderzRJmnGEKMR/5T/fanJ9dWBmbheKBev2qBaxmf4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RgR5H6X7KDQ2QSEeIWroVTmPh+bFx7i8Y2jjCrP1n+QwOGAskLuWHJmwpJanXFtUo
	 D8m0afryxnTrx5lwMzckfivVnEuCUB80aTj6sKfOQHl7Cav0PZ9edFxxW2535A9ZRV
	 iapylBGwGqsUN1piXysqVogeMRjpKWufUMB+quQmZSHEfUkaCqbHoSIDv+THyNpxvf
	 6ATs7pZ02sJZymZlVNCsk/6qEJ5zmNFZVydc35UJV7Tnvsc6iY1DdYQ1sWpmn7G0YP
	 wOBPQX83l9LvramamTc8ZPpxdHjF6+STkDI8UFDLXF3/qnCgvVNEgEo/gGEuo35fPJ
	 T4JN3wUNQCBqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault
 events on domain detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:48:31 +0000
Message-Id: <20260901004832.1779D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a device is switching away from a domain, either through a detach or=
 a
> replace operation, in-flight stall events for the old domain might still =
be
> on the SMMU's hardware event queue or on the IOMMU core's IOPF queue. Thu=
s,
> if the IOMMU core swaps the device's attach_handle and frees the old doma=
in
> before those handlers complete, the IOPF work might hit use-after-free.
>=20
> Two queues need to be drained: the SMMU hardware event queue and the IOMMU
> core IOPF software workqueue. Start with the former: add a counting-based
> arm_smmu_drain_queue() helper, and poll the evtq on a domain detach, so a
> pending IRQ won't let the threaded handler run after the drain and queue a
> fault referencing the domain being freed. Its until_empty mode serves the
> suspend and runtime PM routines that would drain the CMDQ. Any timed-out
> drain fires a WARN_ON as well, since reaching the timeout would take some
> stuck consumer in any realistic case.
>=20
> [ ... ]
>=20
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domai=
n attach path")
> Cc: stable@vger.kernel.org # v6.16
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D3

