Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF1443C21;
	Wed, 23 Sep 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195126; cv=none; b=UMrz09t2IXmwwJZeflqSlMQxdFnbRkzOV02mgfMz/KUnO5NXN+PxsGSmoz2iA6bj2tUMQcWRLkkrqYNdDZNsCEDAImDD4ZrQliPh9TpPi+h6j3D8mxk4grMUkiml9/97SU5WHU7vCyvKZHnhA3BWmjUv6GLjeRUsZtgVgKxqWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195126; c=relaxed/simple;
	bh=Z4e4hCwanUcRk8npqLByaUcM5fc2zXwXXUtAATR3EAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NZqcz6lZXVu5gUjfMDD7SfuScU6+nu9b4MU80MGCSXlJmzupSxG+6ygqHtSkPSdo1ktWJouT2AtMhTaZQPRmUP8NobxbYP3F03HbakYfwqva/SsTrlCrO2tdP5xnKqWQAM3KN+5VnSEXjn2aqIAtiSYTYSH0cXWVKhZn0/brokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9p9il7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9p9il7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1535E1F000FF;
	Wed, 23 Sep 2026 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195118;
	bh=Z4e4hCwanUcRk8npqLByaUcM5fc2zXwXXUtAATR3EAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9p9il7OoHGbeGpDN53LIOfcGsg0DV/fg8vqxUHWlC1grfWbJI9yIlShoTedQHncJ
	 IRtzKhDvBmXptnlXIv18GtHBSPFiAzTX/e+/Q9RJae+byFxIVmJgojz5YMv07RL5c+
	 3el511UtA2VzbZ4xJx52jnUH6L7fOpFHm2+H3zA0W27/UaOuso6krl7yTJ0zbS1gDo
	 kd4zaKvNqThOXndZKzWqcfLu4OyDowbk31DB2Bz+9aCWM0MCwu+2Zz3+CYxDvF+NHC
	 X9fvNOLFTeZpfkdYPjueHLhyf4thLOSl6isZU1gMi4LTJzhLzuh6/nQaMWfuhBspC2
	 3f1X7ohsuTjeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/17] iommu/arm-smmu-v3: Recheck CMDQ_ERR in
 tegra241_vintf0_handle_error()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <ad6d88de275100a5dbf2e78e796a8c88e2b5a879.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <ad6d88de275100a5dbf2e78e796a8c88e2b5a879.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:25:17 +0000
Message-Id: <20260923202518.1535E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A subsequent change will allow cmdq_err_handler to ack a pending CMDQ_ERR
> concurrently with tegra241_vintf0_handle_error(). Take cmdq_err_lock arou=
nd
> the gerror read and ack, and recheck (gerror ^ gerrorn) & GERROR_CMDQ_ERR
> before calling __arm_smmu_cmdq_skip_err() so a concurrent ack doesn't cau=
se
> us to skip_err on an already-handled error.
>=20
> arm_smmu_gerror_handler() already covers this via its existing early-exit
> on no-active-bits.
>=20
> tegra241_vcmdq_hw_deinit() acks the same GERROR/GERRORN pair unlocked, and
> the error IRQ is live from probe, so a latched-error ISR can race a VCMDQ
> deinit during a device reset. Take the lock around that ack as well. Since
> a user-owned VCMDQ never goes through arm_smmu_cmdq_init() yet does reach
> tegra241_vcmdq_hw_deinit(), initialize its cmdq_err_lock at allocation.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D10

