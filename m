Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3B42E436
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663537; cv=none; b=hUoJSoA5ayRwVgHNMAuS1mA4aKItwnFQf7Vial9wB1MjhjBqbEulA03lyfYm8kNfN2xHohdhqOBMrLn3k5gHnhDUz2hqGfJJhE1WvIoMAez729U8Y+GMlJY4azjgBEU9JaH/Pj6XUm75a/LpryReXBFZ+GnoF+eXfs2oXB1G52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663537; c=relaxed/simple;
	bh=zVbOH6YOy9XlUtLJqFMbvDCi3mUzs4zRwc6TRQhFL78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A+cn66FXvh565VrXRgY8F0U5E/I4acQR3i1kGwnNmPkj37LmdX0g4r20c/NZE4SqXM5feA3GWeZHAV9vaFU1uXxvwwfamz3w3a6Zu4MIw1I6ZxKPgEaw3J8CUbZHr2D9jvdxMaIBqPxVOQi+Vm5rWMOLegmLOHWo1Yx8ZNWQeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZbI2HMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZbI2HMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB4D1F000FF;
	Tue, 29 Sep 2026 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663535;
	bh=zVbOH6YOy9XlUtLJqFMbvDCi3mUzs4zRwc6TRQhFL78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZbI2HMjNlO8JRPunXq46F5oZfrBeeD3ioplHwzKwk6tlqvERqTAzMN7jN1rUTqSq
	 WyWZYC8stb7Dm3zH2IqE+wSPmzDScRla6wr+xZwbx8dnAzR8lknbmOeMGDVvZVBXYC
	 ZZH1Vo+OfVo9epPE+Qw+858cEaFKkT1nYnknkZPBStfhi0Md/C5MNusCC0YgbEPlQq
	 xvkFu5nrqgt7UwjyC9quh3Ydg88xigH+06rz5DOqlQOy3IO1ixhFBhQYKcCdlE9BnP
	 cgyBJS+xy/7DfcnHGVD+AECkYyXwqkEqomlNXQc+R73MAE7LyzLHdHJZlumAB6cwHr
	 UC2kZQsHxXv3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/16] iommu/arm-smmu-v3: Enable pm_runtime and
 setup devlinks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-15-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-15-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:32:15 +0000
Message-Id: <20260929063215.AEB4D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Enable PM runtime for SMMUs having a power-domain during smmu probe.
> Add a devlink between the clients and SMMU device. The absence of a
> power domain effectively disables runtime power management.
>=20
> Additionally, handle runtime PM teardown in arm_smmu_disable_action()
> and skip MMIO accesses during teardown and shutdown if the SMMU is
> already runtime suspended, as translation is already disabled and the
> hardware is in a low-power state.
>=20
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D14

