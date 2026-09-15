Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AE4B270B
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491378; cv=none; b=vBy3bwxszZItjpSjfVA4dof3qcISdu2Q6aCpJ8YDaq/Bvqbdi1+zLTMKN6WKD7B7IWzt2eekBJ6t6GEIZkpCsYYA2iy/eOmj0JOTGfeXjVmxh7gulKVuwZ9EWwIsPNtgfXq9HH46RJai/zjRzWhu4Crm1c29ddzrj68oKt4M/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491378; c=relaxed/simple;
	bh=6fBwk5FwZDxfcPBB2ejeM/3x9YjXTSdUdqoQjWaaha8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CYJgJv2oxO1QUd3V0N6xa103ovh5KVJuoniSpAZVjHGEYMR4axhu8h376dkvBMXq+nx686VlDQh1HsvPwjFdyhVz9z0W1fYFAxNtpFz5BXgQUQrVWrC28kmsu01uf7LxCctuo0rWAEr53BouYlcEc0iQ8lGtMoqPEmJAuAvGzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+Dvrn8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+Dvrn8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38051F000FF;
	Tue, 15 Sep 2026 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491376;
	bh=6fBwk5FwZDxfcPBB2ejeM/3x9YjXTSdUdqoQjWaaha8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+Dvrn8hLAqjgzzVMNrNGjCOPpADnxlCgQ0fJ1HCZKB4VDQEJRMue7xZGpBFpHNOH
	 5qHymYPqWIHEWJMcoHYGIeA9CViejvqUeqkTOu9sPz2rDa7TKP8cvvGrXn++JYS2s4
	 D9nS0LFXHEL8bDdZaJbmJa5m9HH3YiJK6hUx6pqUbdztLvKJxBydT/Z6pCqJDESnBi
	 bm+lkOYmUvkw1pAiSh1Iyx7t2TC2x4oaTTMc8hvrzgeoK4WwxzcSqSbPSojx+49Cnn
	 nBQhziUE1raSKRbcsbzW4UfUsfxaY2YM5b0S/mFkrzRp4W65oG3ZPgJGBb3EdzCDML
	 2RRpWtZ10KGnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/15] iommu/arm-smmu-v3: Allocate IOPF queue for
 ARM_SMMU_FEAT_PRI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <28b828e4e1368d95b57aa231abab2194f397aae5.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <28b828e4e1368d95b57aa231abab2194f397aae5.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:56:16 +0000
Message-Id: <20260915165616.B38051F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D12

