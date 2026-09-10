Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807348EC81
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050944; cv=none; b=CMo2ZVdgxVohHd87LOs9AntJIcpprPuz0VGLWaSyUECZawlNY+1XrzxtuFRttc7zTVosiBvf5EJIfumbuN4ewffaQt9SvAomf1eEY/fWqeTTBMQk472cyKWSUS/DgWAoVxC5q3myawtDnh9HxKUwd3rhs5SegGXgevMIV2LRU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050944; c=relaxed/simple;
	bh=MaJzlvFK53m6oIcSS54X6kYmXaQEfYRKLZvPzUKFUGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ih9fdVFrXKZn/iLUwXhsizLVkOD2U4WsQmA4Db4Z4p1d84aXJ4x8W+F5lphsPCYQEVVyn6+ZYPGqtkz3xklvYd/LWBwtduF58+berV1k9d44TQy3iwe5CLGssZwVNMaVn6m1Vl7O2LgbQZaqWd5ARu6Ghy01CoILcSJaU+ooOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1mi01C+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1mi01C+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C411F000FF;
	Thu, 10 Sep 2026 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050943;
	bh=MaJzlvFK53m6oIcSS54X6kYmXaQEfYRKLZvPzUKFUGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1mi01C+bkhXrjxsdlJpjS7auX7shC6/82v3qbzFVpmYym54S6ys30V6rP0jiQ7tw
	 IblKGnQBAVwkSRXlIMcCqOFHG9yI3kKocK8EFOKya8VTdrGA9fotNi7ZlZUrrAdoTS
	 cwMsVgyLVjTlYC+sHR0jSDa/t9pq9AAUY4W+ajV5tHR2BVr0BOUdXE9CAMLSzpduqO
	 +WYrq+t9fll+/qarPGe7TXSme8LUm4VGwsJ837q2EhTb54ZusOhfKa2yUhGtka+2Dw
	 4S7r6QYNNZZ0vutRPzxjwnKdtckZckXvARB7Wl1GTECsIjZZMeX2I60YcYNIhrlu6G
	 kuDeT+7PAxpPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] iommu/amd: Refactor device probe and capability
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910142655.3281464-2-praan@google.com>
References: <20260910142655.3281464-1-praan@google.com>
 <20260910142655.3281464-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:35:42 +0000
Message-Id: <20260910143543.43C411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Restructure the device probe path to improve readability and prepare for
> cleaner error handling. Refactor check_device() into lookup_device to
> explicitly validate and return the amd_iommu ptr & devid. Refactor
> iommu_init_device() to return the allocated dev_data. Consolidate all
> PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> iommu_init_device_caps().
>=20
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142655.3281=
464-1-praan@google.com?part=3D1

