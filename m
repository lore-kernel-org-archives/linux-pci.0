Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56530F92D
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082715; cv=none; b=qd4FS+eWfz5HFd1ZgU6v/4AExKy/oX466qTSylRm9/wKL54jeNHbn+PXUs4Y8r6Ku7CRGwwYTWf2czuYoqBeTv+3KBUNkPuDsWixPqX8Vl2V2k0R3UO8wZFu23r2szkVoo24Tbo09TzNmnHxiVFeBNGVgvo3rW3ubjgPH+E/oUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082715; c=relaxed/simple;
	bh=c0hk6RodijL+ObMKOEVvquqmz1zMkBn1BYahLTZ/OFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Px2oJKut8A4m46ZBUemxLQh8KGq3kS8p/CIne7v/lEjOB8pN36Bie8MjTPhQZCGk2Zd49cDnpvZ+d9qSsRuFxf4icWNBhnN/De83wqNLftCp8w9aTL4Z3DAO6EBlO5hSxKiiDrc0/bc34hpWhhsjjZCeUPghmNBjLs5ZRkdKvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmbF4oLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmbF4oLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D41F000FF;
	Thu, 10 Sep 2026 23:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082714;
	bh=c0hk6RodijL+ObMKOEVvquqmz1zMkBn1BYahLTZ/OFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AmbF4oLiRdUN8kU/dJAXByr1Ml12w5g2EBDzXTbS1KVMzQznwBUvRyHv7kdZ6YoyU
	 6lOZ4rIixRN1kKsCFyY6SDlRswYoUWQzR1ZMpdNSKieicBcB7xyNAhbDUv7BJ1WaoV
	 V+KMAnZE4A8IObslGqJTzCyUxTcGAJ0a/0Dd2mVewanEdkmQ0svV3mv9n4D7O3OLKy
	 OH6NAIHCQTUu70+mFyh+bQdLzLfkEWTrXq/WrWYNJZImpAJD2riOvfTD+mK57ghLz5
	 up9IB1Ft57ddjXMsNIMSFLk7MkM/kiDxxJE1HgRcykMWaaV6xAqdlUBtWW/5Hn2Kud
	 pKG0roPoCuNIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/15] PCI/ATS: Add PRI stubs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <d168f7a1951440a2ececd8c5c381056fa9b1e18a.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <d168f7a1951440a2ececd8c5c381056fa9b1e18a.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:25:13 +0000
Message-Id: <20260910232514.004D41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>=20
> The SMMUv3 driver, which may be built without CONFIG_PCI, will shortly ga=
in
> PRI support. Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove unused
> PRI and PASID stubs") to re-introduce the PRI stubs, avoiding more #ifdefs
> in the SMMU driver.
>=20
> Link: https://lore.kernel.org/iommu/20201112125519.3987595-8-jean-philipp=
e@linaro.org/
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [nicolinc: drop stale APIs]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D13

