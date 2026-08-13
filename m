Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580634B43F
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663127; cv=none; b=FzIv7W6utK2hF1QNkB7xKJJBOY9Tp7dMj1p87izVZBy2HyBhZoXK1ak+nGdVuWVgkl4OLZy5faOZbdn7siySxX7rpSuxinYiM4Iw+EF9InumwUXeLzkQJJQxIGjfMMpqzqIgfG8mZJ/u+WCaX6eW2KxrXDK87Upz2rlyQ9I9WdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663127; c=relaxed/simple;
	bh=NxKeSDbuAxck5/C7pJs+rbR3pOBLE6pz6zcdY+DSfuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e2dwsBVYEM6RAWs+mq63DtTT9U3YstPow+4nlWO9HIqIY73cYx4BPEkDQtRHoO3kS25C/kqPl8Crletf68vxoQdHnxxYAjPTnO/wdsPq3Guj0jDGF9SYGAJwsht7Ax9FIp6M3VC20TrvoDIy/DbCMF93j/Vrx526rt0dz1suRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPGvQT04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPGvQT04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6321F000E9;
	Thu, 13 Aug 2026 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663126;
	bh=C31X8BftnPSNuglTsI6o65G63G70NGgRfDg4bypttNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MPGvQT04NJwJ214B3l+LD96ym+6VLhhZiNFhLlPmGt7zKHgVgOX+c3v91/7bafL3J
	 P4EXBw3iC0SZSDN+iXvPk9RAxBfakRdMbmnwqg5m27fmUUtxFGyw4U28c3gqhfzXJ4
	 7t87v/oZ5/DYpjo4A59GhVZrVd8GnD/+Zdlx9gSNMl0UQvx4v1szFVushkcu8oN7/l
	 bAeKRoOTi2c4adVZiLT8sehl4QaW7w1MEakBi3XnYs9vZRgNt7BWewUOqfaJNd3z0U
	 2tbgiXj4vBZonpZ77ejTI0fq2TWOhCgRdwe68mj9bPmly/LCxLZNO8PwljRb74XGeO
	 Rx7ONw63mGa6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/14] PCI: tegra194: Use DWC IP core version
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260324190755.1094879-12-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-12-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:18:45 +0000
Message-Id: <20260813231845.DC6321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Tegra194 PCIe driver uses custom version number to detect Tegra194 and
> Tegra234 IPs. With version detect logic added, version check results
> in mismatch warnings.
>=20
>   tegra194-pcie 14100000.pcie: Versions don't match (0000562a !=3D 353632=
2a)
>=20
> Use HW version numbers which matches to PORT_LOGIC.PCIE_VERSION_OFF in
> Tegra194 driver to avoid this kernel warnings.
>=20
> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324190755.1094=
879-1-mmaddireddy@nvidia.com?part=3D11

