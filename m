Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80F2931FC;
	Tue,  1 Sep 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225153; cv=none; b=QK2TijUTf1SioYODfBgLgpbKZSqop8o+dpNvN7K2tyeJHaE2GBGZ6zDTRVS3yMLnl7gUWokljjTEm6QnNYh2cyjSSa4jCIACNAyFfFsxrSm91fjvNQHBv+epiM6a6gqCZwrs8Zk5l51cGnjOZB2ekje4Nqwwmssw37NVrMg/PIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225153; c=relaxed/simple;
	bh=GiLk8RHjsBdKguJDw2fpeaCRDwsk32x+XZnJ6bK8Sus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ncorEn6ttrqRE9k0JXTAJuavLdWXyKRJ1d9J4cWV4o7M6hhdh6zJNOgYnYJzWs+uT4m6TkX7egUN98a9nu5gacZcn6UNcowr4OYoQO1r/qJBPNa837gqch/s3gsYXY3wO+Q9X4sqFHSwvwiVsYvWd4p6kXv+wEBQHuoTd7nnMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDP9IG0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDP9IG0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0292A1F000E9;
	Tue,  1 Sep 2026 01:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225150;
	bh=GiLk8RHjsBdKguJDw2fpeaCRDwsk32x+XZnJ6bK8Sus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDP9IG0IkIFE3JDWHY2Ia8oP9SjDHiYpf6ZCfg89Mo2U81MR8A6uuyxDwz9D8L+G3
	 3cW06ohebixVvjBjr9poKeaA3juwBzBI4xdmalBP0muMoEECdWj67nmiKkJIH/TTon
	 BAbcL2hRujJU1U7C8DAdid2ZUKjW75KsSiTnHfVMIM04W3aept5d0ba9o4+izNenxq
	 7UBdCJHlYB86siGlCv7oTsBbgjxQwZa/EFstvp3QDWTtpaWKtrSssxWCd5qsGJUJCa
	 JjKcsl/t3VoiFF/fmWNVm+fBaIARYutNeKBOTJo+jQwlMCUeyMDdy4rR3cp7pbSxsZ
	 IVk3UlUSKwamA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/21] X.509: Parse Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-6-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:12:29 +0000
Message-Id: <20260901011230.0292A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming support for PCI device authentication with CMA-SPDM
> (PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
> in X.509 certificates.
>=20
> Store a pointer to the Subject Alternative Name upon parsing for
> consumption by CMA-SPDM.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D5

