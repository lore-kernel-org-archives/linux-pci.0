Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82133CEB5;
	Thu,  2 Jul 2026 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007680; cv=none; b=rV5fMaebaPSzgcnmssexIv8+SrDUG1z5KQi2OwUVN6UdnY3i9/HLKzZFWa1MqOYC134ySaSfcbLj8C49ztj7L2z6O5FDRrJLkJ37BNccV5kAwWIgDGAT3e60X5SzP26Cs6rLVxKBHG2JyMKJ6q0UnRoNuPEiqTBMh0ZNWKgAixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007680; c=relaxed/simple;
	bh=8DpRdJlKp0NLSVeG6yHqG2WxtfQ2nid5FhBc7YJdFuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AesqjjqDP6A4ShCK5QSO7b+pdAjc8o8TyHnX0EUzQaxDpABWPC/ezEfLkPXmKCbcQwrmuKnn9tMu+wTdgrl8apJ24adNePEsg8tAD1bk0GeneUJlnmAAfifUBZtkbpu6hFUlvWw/nPEJCkZQjFoWlRQliGhi8BYuy2oSuHAvCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgMJFmo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgMJFmo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834611F000E9;
	Thu,  2 Jul 2026 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007679;
	bh=8DpRdJlKp0NLSVeG6yHqG2WxtfQ2nid5FhBc7YJdFuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgMJFmo0PARjRUpeuMqgsWtc84hOQjvENFt2QlgyRsbkRdlI49Q0NWvR6k6BVoILE
	 j2j6zqTQq9wynsNK6REz5sM/HdSdvymbA6yQfSai9WEI333nUYoXduXcEsCLzl40X/
	 JsL7kGklixV+YoTNE71etnaLv1+BvdUYwhhfzwhHFuttajMqYlj+xnKU66cl34mBX4
	 ciXFSXBgXoqr2M92mofitAtR6RCyF1GDzcIFgh1prETw/UmDzVfKfoJxiP8AtwjQpI
	 I1zuyx/E1kQzO1HpU2+pt9SnYbrbmN0FwjmuoftGdzuE+i1iOx5Nge/n6NpgxPspWo
	 YQgJdx7YjBMVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] x86/events: Use sysfs_emit() for cpumask show
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, neil.armstrong@linaro.org, linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260702154725.185376-4-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-4-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:54:37 +0000
Message-Id: <20260702155438.834611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> These callbacks are sysfs show paths.
>=20
> Use sysfs_emit() and cpumask_pr_args() to emit the masks.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D3

