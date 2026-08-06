Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976931684BE
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015738; cv=none; b=DWfBsUBcnRxnNrHuC3bbawxlGBgNd+P5/IqE+NmfCWWSVDiYiJ2dRWcwMnG8Mnz/LKk4ekPXJB5aPxqcobb1tvRHWXiN8Sc3F4njGCYvEePCmmiWz0cXqyOaeAFETAP3uozNwxCzftJQiVopnulV4PrZXJ3xGve2/JaavpQROQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015738; c=relaxed/simple;
	bh=NXUjbKvUHfNOGm7SSOJ9TfDAUbghi/8B66+/9Re25MQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r7cU3l0ZXwZLaz+ukOjx6hd7Y7WMpgfTVnjt4BcbE8mW8JYzb90677UQBYaNEqnBvR3h9hVqIgXh4XMvEqgk2zBzbBhd+vxaK/NAyPgYthvOrE7paGEUywKUUjOiXdsfacvO3SsLwXlQAFWgoManIzUGcq1GaRSHaIf1oxV+mGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yqlp6IxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqlp6IxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522181F000E9;
	Thu,  6 Aug 2026 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015736;
	bh=NXUjbKvUHfNOGm7SSOJ9TfDAUbghi/8B66+/9Re25MQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yqlp6IxAJFd8MbGJ+UBSF3p/NQLTbPlnU5JGu1HROvrfyt9C6rS5gxigbh2efY5xJ
	 zcnB0j8MpUGzhWZq5+VHMeTgsJXSXmdQUjjcbFSCl4r1ZDHoLcLM4fw6XXMIZMhoDf
	 A0b5MhFwBmO05brQuMJ2eoa9Lu7iZgNEgeR+JHSJ83nCxvqQprrhdtwtGPNPeK4nbN
	 sOD/Jh42mHbdxQde7lLoU4pojiIK9AV30dSef183VACZmCop5264mjO3ZMUyckWB0M
	 SbM+i5UUxVVCPIrkomHTjH7N8wJHY8Tr9XC6KV1ZI2efWrA/kvwDQrI12cebUQmtQ+
	 qiZHx3sjWYnhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] PCI/P2PDMA: Document the Address Type
 assumption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-3-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-3-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:28:55 +0000
Message-Id: <20260806112856.522181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> P2PDMA selects a mapping from the ACS controls that govern Requests
> carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a Request
> carrying a Translated address directly to the peer whenever ACS Direct
> Translated P2P is enabled, regardless of P2P Request Redirect and P2P
> Egress Control.
>=20
> An ATS capable client can therefore reach the peer on the direct path
> whichever mapping is selected. Record that assumption.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D3

