Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF63368A2
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653239; cv=none; b=oeoIdWz5d1oU8IjDVSkvTdHogoUlvVOSfBfwVhcEtqsblt777twawE3pnCk8okjMzLZNp9C9bgTG2LQb3VYwFux4x4coV2tNgayrtw1Bo77rsAG5xXh88+kXHU3IGwiU4/Z9FdXWCvGr1W9jhkBY9Tszvwmubi7rYQu8kuKY32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653239; c=relaxed/simple;
	bh=Uafgq1BuAsrTcM1GTOT69VlAX7NTCPIz2erKoC8W658=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s1QtLVREjGdp6/FJHoB7CtBhE/b5HlO/kytWzWdnOZQnrtMyoh7ssU8bgf8Z5Mz2bheKFgj8Sd6tpivX6yAPWJsXQcxvnNeaC46Hxd06lOBxvTpSwVogBBkK15wl3c1SN7VQJczup8njW8Z8S7WuJHO34vUwwKgXeliQsYjXkUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZqYOPPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZqYOPPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BD41F00A3A;
	Tue, 21 Jul 2026 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653238;
	bh=Uafgq1BuAsrTcM1GTOT69VlAX7NTCPIz2erKoC8W658=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZqYOPPyLWqkeplNCdThYhSi6f5UrJ4f+cTHDQI7Pq28IYZ/S2+OKYW656sZaTnty
	 eJj3P0Da4MCVe2SI890/cNLY9BmT6AOFLWxdIg5uAQ1F+uhWDu/d0l/WCCvDyyvzNE
	 ZxjNEUvbhGlwX0G0WRzSUN2q+323GpVNvuXBaSoed0IUjgWc3aMAxeYC6eiP/eqa44
	 gNTaQk+P7KjZV50nH9WVUAc/aIJj+wiQbUmK0stgE3YfMJ/JX5a4LOJFz4251Xc/YY
	 DEDFXvXWleETG8nsjVe4lyuiucnv1ZFDZ5K3cwxyEBBkOm1r17uXwBEz5PVFyheAqX
	 tFL+JUGrRs/Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:00:37 +0000
Message-Id: <20260721170038.21BD41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add fixed size region types for these and add projection methods that
> project from `Bar0` into these. Update these registers to be registers on
> `PFalconRegisters` and `PFalcon2Registers` and not relative registers on
> `NovaRegisters`.
>=20
> The use sites are updated mechanically; calls to the projection methods a=
re
> not extracted in this commit.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D8

