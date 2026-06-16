Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1A3A48DF;
	Tue, 16 Jun 2026 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607122; cv=none; b=psDbMuOlq56BrollSJFEZssNFr4EKwTP8UaN2NMhxKQ9Vpxg48AgoEuGpjc2TV4LQvWT0VuzHshrE8PcZwdMN0/4Ypm4faS5byG+vLWCYtJth3sEMidYMkCv/foYougcER8XmLhfNBhaOWUfbZ0ZbW1qLx5jqlRuzA5gmWO4kjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607122; c=relaxed/simple;
	bh=kCxJHozeBBkjMlkZDkxCwq2V0LruQRN90/2nGWvzg1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gkUqqG7mRepjqAXVQxuI71nHg4oTidrfL5RFEUcafjsBgH2rw+sdAcFe7y92WJmTRfeGeZHtwIfaPJ2GrClZ44glPD5R/RknR2F5msF+6BWQ7XLDfzc75C8Y+E63vDpFkvhDAcGUN+6rhOyVo3stQPAOtbLsAH4mbezLPCpVrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/W5azxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/W5azxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084481F000E9;
	Tue, 16 Jun 2026 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607121;
	bh=kCxJHozeBBkjMlkZDkxCwq2V0LruQRN90/2nGWvzg1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/W5azxdyvw1/fPSQETvAw1rwKcN2Iy103S46Ub8zAnYtDpV2U+HWNGUMWB0L+79i
	 S8U2ZpT4AVAyxXvZjz/cco4PM8uRERtCzmGATRgAPJ9tNQLIh99lPrV0wflbcbMDgJ
	 2ZyH7zyeiKXCda6pyT4w3llP0TOxkEFJkQaQtzMdZHpe1WTho7hBhf/N2ICICPJKC6
	 VjSjJLqHyMp4XV+b0yQ2fKZVcb0GdcqlPPDQoPgA4AAGA0YbV5nI0nqnb4Iw+PM8A4
	 CCEQHYF1eipGOmT34EsB3bpb8uL8mFAEO35GuuaiJ2Rxhn7aSnvoDPcttBVfClO7x8
	 NdHV3rUnijWKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/12] PCI/TPH: Add pcie_tph_supported() helper to
 check TPH capability attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260616104621.41915-8-fengchengwen@huawei.com>
References: <20260616104621.41915-8-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:52:00 +0000
Message-Id: <20260616105201.084481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add new helper pcie_tph_supported() with want_ext parameter:
> - want_ext =3D false: Check if device has valid TPH capability;
> - want_ext =3D true: Check hardware Extended TPH support.
>=20
> This helper is prepared for follow-up VFIO TPH virtualization patches to
> uniformly query basic TPH existence and Extended TPH capability.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D7

