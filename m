Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AC4BA1D2
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490970; cv=none; b=SnlXDDk6D6BKVYR7wkuNAbrefZJ8bVOFVMlITHBWjFhROTlOLT/QJM815JOrlXVhPLdIjfN7rp8PNk4ZCC1l0blUHymTNFcFKVT4UEydJ0Qy905wDPZ0zAyUvhFEjPAZjyBqA8kAJ6Sosgij0XVScRVAL4YIXvXuw9QC1RlOmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490970; c=relaxed/simple;
	bh=MIw0u4Jew6Eue1uNKgnizLUKwbZ+GfGqut5ilwStvYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c8K/bY9MYBC2KR+SPLdDBromzNIsAsFGQmhhhTK3Fp5HPIGlFL5l07wQOuLIJlyxaFtK40trn8icTroPKCPExbAzpmxlsoCCJ5UAlp/sHk6Jc0gOaqvqc0URa9uD0JC3tskJHtGQOdqjcJ+w5h1qOsZACO0q0rv5OTqr+lxqoE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYF/vm1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYF/vm1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DC21F000FF;
	Tue, 15 Sep 2026 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789490969;
	bh=MIw0u4Jew6Eue1uNKgnizLUKwbZ+GfGqut5ilwStvYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HYF/vm1n9+PsJ+AOrXZEhFcqEmPkc7Hfe//pSo2HQuMC4/VSJh491kyodx2FfiLxz
	 lNtbVS5V0fmJCHChcSMtiN5cYLOQr+93YpxEQcV4lZRAK1bKEoWG7Mir1FhJmwc8wI
	 Dd76IsSRlkArDx1iMn1n9pfvRe7rfEc1wQ0nz4r5LwsqH1TgaoF5CsXRt2A9kzQ+mW
	 qtSHfY0LtbnHwp7oyNKG/RzZTfZDZAQJADEsq/DX1LighOHyZzJmIjznQ5GKrw3lv9
	 8ZJS4bi3UNOhAXX7hmZyxehOFfuWdL7p1erbktNbe8QgHCvArsWuhTHuT6SxjA3UHq
	 c9vAfPR8lDd5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/15] PCI/ATS: Export pci_enable_pri() and
 pci_reset_pri()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0eea03fe5d763738aa348c96c9dd18612e8b788f.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <0eea03fe5d763738aa348c96c9dd18612e8b788f.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:49:28 +0000
Message-Id: <20260915164928.E5DC21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>=20
> Export pci_enable_pri() and pci_reset_pri() so the SMMUv3 driver, which is
> tristate, can use them from its probe path when built as a module.
>=20
> Link: https://lore.kernel.org/iommu/20201112125519.3987595-9-jean-philipp=
e@linaro.org/
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [nicolinc: drop stale or already-exported APIs]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D14

