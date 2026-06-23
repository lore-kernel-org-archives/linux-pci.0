Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D030D3E7;
	Tue, 23 Jun 2026 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191264; cv=none; b=etYkj34jYZdBtSrFr+PDQmRt3YTosnECrSrINsFNP8fWE6TiSRuPrhURmUnp1Fv0KhqhMC3qtifzVqK2nLH4sINL4awpPJK3vXfb46F9yDpg9ZVpbncbQFpTkub4B6z6O+SE9xgx9TKM7ZfzZSTHpncWYqmoHBVicwG3+zTzfbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191264; c=relaxed/simple;
	bh=Fq7qp2ZfmxzK7rnFi9hhhC/G67YnvDjU4VdiasGxew8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LkCKtsvs0MQwjLpBRGbGvykAJhFXBozEzMzJ0FS06EKk+o48UPVP00K1BbhDSxdxgoP1fixBY+awEcUehT6SQMaNoENKLT01nheJSPOmfOjxwb1QBNCyLc8qJyJNYJq2jo0cK/3nUipF4ZNFVf+1CO1hcH3B/BN8hVvlDOCRR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APPHObDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APPHObDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437451F000E9;
	Tue, 23 Jun 2026 05:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191263;
	bh=6x1sXV9h/LCPQpsisErFLB56KdMvu99ngvV3FsLMVok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APPHObDTUq+It57qMYlq4JilU6NBcDbm5dzDCNV2LedJclyZRMrPKK14Kv8NV+Rap
	 a5a8rBxk5lSsNHGPODqAmod0JcOSJGiJy1RkVdBDFC55rnflLbMJDx37fURSOFhHKU
	 J6yWbUWr6BMnyHtjCpT4G6Vh67FIpT5h8ijCiZ7JvlfdS8I0pT2RKt0Ek3dF8r7d1N
	 DqPQN6VGQj7JJpuNNqg+ViTHnVb2T8Gc+BhWcf9PEcpAfBZNP5L/rNWMFtPxSObfz+
	 1aE/nwxw9pRtpkJsRJCvWWC00nSK4CgQWzWsaCqQzzfE2CfszLzk5abkbwyDEyn9G/
	 lAT7Enj+FAJEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/21] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-13-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-13-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:07:42 +0000
Message-Id: <20260623050743.437451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
> allows for measurement and authentication of PCIe devices.  It is
> based on the Security Protocol and Data Model specification (SPDM,
> https://www.dmtf.org/dsp/DSP0274).
>=20
> CMA-SPDM in turn forms the basis for Integrity and Data Encryption
> (IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
> transmitted over a CMA-SPDM session.
>=20
> As a first step, add support for authentication via a CMA TSM driver.
>=20
> This was previously discusd here:
> http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch
> [ ... ]
> Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Co-developed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D12

